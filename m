Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269388AbUIIJea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269388AbUIIJea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269392AbUIIJea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:34:30 -0400
Received: from p5089E36A.dip.t-dialin.net ([80.137.227.106]:1540 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S269388AbUIIJe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:34:26 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Greg KH <greg@kroah.com>
Subject: Re: another oops, this time in 2.6.9-rc1-mm4
Date: Thu, 9 Sep 2004 11:34:22 +0200
User-Agent: KMail/1.7
References: <200409090107.05415.gene.heskett@verizon.net> <20040909063843.GB8352@kroah.com>
In-Reply-To: <20040909063843.GB8352@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eOCQBAbvDSe0YGo"
Message-Id: <200409091134.22299.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_eOCQBAbvDSe0YGo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 09 September 2004 08:38, Greg KH wrote:
> On Thu, Sep 09, 2004 at 01:07:05AM -0400, Gene Heskett wrote:
> > Greetings;
> >
> > I just had to reboot back to -mm2 after playing with some printer configs
> > in cups, although the test pages worked, so I'm not sure what this all
> > about, from var log/messages:
> >
> > Sep  8 23:13:42 coyote cups: cupsd -HUP succeeded
> > Sep  8 23:13:43 coyote kernel: usb_unlink_urb() is deprecated for
> > synchronous unlinks.  Use usb_kill_urb() Sep  8 23:13:43 coyote kernel:
> > Badness in usb_unlink_urb at drivers/usb/core/urb.c:456 Sep  8 23:13:44
> > coyote kernel:  [<c01048ce>] dump_stack+0x1e/0x20 Sep  8 23:13:44 coyote
> > kernel:  [<c0295f35>] usb_unlink_urb+0x85/0xa0 Sep  8 23:13:44 coyote
> > kernel:  [<c02a7447>] usblp_unlink_urbs+0x17/0x40 Sep  8 23:13:44 coyote
> > kernel:  [<c02a74a8>] usblp_release+0x38/0x60 Sep  8 23:13:44 coyote
> > kernel:  [<c01501ea>] __fput+0x12a/0x140
> > Sep  8 23:13:44 coyote kernel:  [<c014e8e7>] filp_close+0x57/0x80
> > Sep  8 23:13:44 coyote kernel:  [<c014e971>] sys_close+0x61/0x90
> > Sep  8 23:13:44 coyote kernel:  [<c010425d>] sysenter_past_esp+0x52/0x71
> >
> > repeat about 40-50 times before I rebooted cause it was very sluggish.
>
> It's not a oops, it's a message that the driver needs to be fixed up,
> and can be ignored safely (but sending a patch to fix the driver would
> be even nicer...)
>
> thanks,
>
> greg k-h
> -

Hi there Greg,
please be gentle, this is my first time :)
The situation looked trivial so I thought I should give it a try:

Regards,
Boris.

--Boundary-00=_eOCQBAbvDSe0YGo
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-usblp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-usblp.patch"

--- drivers/usb/class/usblp.c.orig	2004-09-09 11:22:56.000000000 +0200
+++ drivers/usb/class/usblp.c	2004-09-09 11:24:11.000000000 +0200
@@ -410,9 +410,9 @@ static void usblp_cleanup (struct usblp 
 
 static void usblp_unlink_urbs(struct usblp *usblp)
 {
-	usb_unlink_urb(usblp->writeurb);
+	usb_kill_urb(usblp->writeurb);
 	if (usblp->bidir)
-		usb_unlink_urb(usblp->readurb);
+		usb_kill_urb(usblp->readurb);
 }
 
 static int usblp_release(struct inode *inode, struct file *file)

--Boundary-00=_eOCQBAbvDSe0YGo--
