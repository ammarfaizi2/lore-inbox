Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUFJEDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUFJEDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 00:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUFJEDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 00:03:12 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:52639 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S264430AbUFJEDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 00:03:07 -0400
Subject: Re: PATCH: 2.6.7-rc3 drivers/message/i2o/i2o_config.c: user/kernel
	pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Markus.Lidel@shadowconnect.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040610013734.GZ12308@parcelfarce.linux.theplanet.co.uk>
References: <1086822062.32052.129.camel@dooby.cs.berkeley.edu> 
	<20040610013734.GZ12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 21:03:04 -0700
Message-Id: <1086840185.32058.351.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 18:37, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Wed, Jun 09, 2004 at 04:01:02PM -0700, Robert T. Johnson wrote:
> > QUESTION: Does ioctl_passthru mean arg is a kernel pointer?  If so, then
> > disregard this bug report.
> 
> No - we have ->ioctl [== cfg_ioctl()] -> ioctl_passthru() chain in there,
> so at the very least it can get arbitrary pointers straight from userland.

Thanks.

> > +	if (copy_from_user(&cmd, (void *)arg, sizeof(cmd)))
> > +	  return -EFAULT;
> 
> Fix the indentation, please.

Whoops.  Thanks.  Done.

> > -	memset(&msg, 0, MSG_FRAME_SIZE*4);
> > +	memset(msg, 0, MSG_FRAME_SIZE*4);
> > -		memset(&msg, 0, MSG_FRAME_SIZE*4);
> > +		memset(msg, 0, MSG_FRAME_SIZE*4);

These fix false positives in cqual -- it's picky about conversions
between arrays and pointers.  I left them out of the revised patch, but
if I submitted a patch for a bunch of little things like this, would it
be accepted?  I described some scenarios in an old email where &array
can cause problems:
http://lkml.org/lkml/2004/2/23/233
The bug I just found in ipmi_devintf.c is probably an example of exactly
this kind of problem.

Best,
Rob

--- linux-2.6.7-rc3-full/drivers/message/i2o/i2o_config.c.orig	Wed Jun  9 12:14:08 2004
+++ linux-2.6.7-rc3-full/drivers/message/i2o/i2o_config.c	Wed Jun  9 20:53:01 2004
@@ -842,10 +842,10 @@ static int ioctl_evt_get(unsigned long a
 
 static int ioctl_passthru(unsigned long arg)
 {
-	struct i2o_cmd_passthru *cmd = (struct i2o_cmd_passthru *) arg;
+	struct i2o_cmd_passthru cmd;
 	struct i2o_controller *c;
 	u32 msg[MSG_FRAME_SIZE];
-	u32 *user_msg = (u32*)cmd->msg;
+	u32 *user_msg;
 	u32 *reply = NULL;
 	u32 *user_reply = NULL;
 	u32 size = 0;
@@ -858,7 +858,12 @@ static int ioctl_passthru(unsigned long 
 	u32 i = 0;
 	ulong p = 0;
 
-	c = i2o_find_controller(cmd->iop);
+	if (copy_from_user(&cmd, (void *)arg, sizeof(cmd)))
+		return -EFAULT;
+
+	user_msg = cmd.msg;
+
+	c = i2o_find_controller(cmd.iop);
 	if(!c)
                 return -ENXIO;
 

