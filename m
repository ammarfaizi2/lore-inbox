Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUFJTLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUFJTLX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUFJTLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:11:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:16309 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262391AbUFJTLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:11:13 -0400
Date: Thu, 10 Jun 2004 12:10:04 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk, sensors@stimpy.netroedge.com
Cc: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610191004.GA1661@kroah.com>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610165821.GB32577@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 09:58:21AM -0700, Greg KH wrote:
> On Thu, Jun 10, 2004 at 05:49:03AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > bugs in drivers/usb/core/devio.c:proc_control() even though that
> > > function has been annotated (this is not the first time cqual has found
> > > bugs in code audited by sparse).   I didn't write any annotations in any
> > 
> > sparse gives warnings on lines 272, 293, 561, 581, 976, 979, 982, 989, 992.
> 
> Ick, sorry, I haven't run sparse on the usb tree in a while, I'll do
> that today and fix it all up.

And to be complete, here's a patch to clean up the warnings in the
drivers/i2c tree.  I've also applied it to my trees.

thanks,

greg k-h


# I2C: sparse cleanups for drivers/i2c/*
# 
# Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Thu Jun 10 12:09:08 2004
+++ b/drivers/i2c/chips/it87.c	Thu Jun 10 12:09:08 2004
@@ -170,8 +170,11 @@
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
-	while ((val >>= 1))
+	val >>= 1;
+	while (val) {
 		answer++;
+		val >>= 1;
+	}
 	return answer;
 }
 #define DIV_FROM_REG(val) (1 << (val))
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Thu Jun 10 12:09:08 2004
+++ b/drivers/i2c/i2c-dev.c	Thu Jun 10 12:09:08 2004
@@ -181,7 +181,7 @@
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
 	struct i2c_msg *rdwr_pa;
-	u8 **data_ptrs;
+	u8 __user **data_ptrs;
 	int i,datasize,res;
 	unsigned long funcs;
 
@@ -238,8 +238,7 @@
 			return -EFAULT;
 		}
 
-		data_ptrs = (u8 **) kmalloc(rdwr_arg.nmsgs * sizeof(u8 *),
-					    GFP_KERNEL);
+		data_ptrs = kmalloc(rdwr_arg.nmsgs * sizeof(u8 __user *), GFP_KERNEL);
 		if (data_ptrs == NULL) {
 			kfree(rdwr_pa);
 			return -ENOMEM;
@@ -252,7 +251,7 @@
 				res = -EINVAL;
 				break;
 			}
-			data_ptrs[i] = rdwr_pa[i].buf;
+			data_ptrs[i] = (u8 __user *)rdwr_pa[i].buf;
 			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
 			if(rdwr_pa[i].buf == NULL) {
 				res = -ENOMEM;
