Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275637AbTHOCBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 22:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275640AbTHOCBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 22:01:43 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:38369 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S275637AbTHOCBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 22:01:39 -0400
Subject: Re: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       sensors@Stimpy.netroedge.com, vsu@altlinux.ru
In-Reply-To: <20030814190954.GA2492@kroah.com>
References: <20030803192312.68762d3c.khali@linux-fr.org>
	<20030804193212.11786d06.vsu@altlinux.ru>
	<20030805103240.02221bed.khali@linux-fr.org>
	<20030805210704.GA5452@kroah.com>
	<20030806100702.78298ffe.khali@linux-fr.org>
	<1060886657.1006.7121.camel@dooby.cs.berkeley.edu> 
	<20030814190954.GA2492@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 14 Aug 2003 19:01:34 -0700
Message-Id: <1060912895.1006.7160.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-14 at 12:09, Greg KH wrote:
> Hm, much like Linus's sparse does already?  :)

Yes, but cqual needs fewer annotations (see below).

> His checker missed the 2.6 version of this, for some reason, I haven't
> taken the time to figure out why.

Currently, sparse silently ignores missing annotations.  Since i2c-dev.c
is not extensively annotated, it missed this bug.  Cqual requires _very_
few annotations (we use about 200 for the whole kernel -- almost all of
them on sys_* functions).  Cqual can use additional annotations, but
they're not required.

Also, cqual is more flexible than sparse.  For example, i2c-dev.c wants
to use some i2c_msg structures to hold user bufs, and some to hold
kernel bufs.  cqual handles this automatically, but sparse cannot at
all.  To get i2c-dev.c to work with sparse, you'd need to declare two
new types, "struct kernel_i2c_msg" and "struct user_i2c_msg", and change
every instance of i2c_msg to be one or the other.  You'd also end up
manually copying fields between them in the ioctl.  So I think the patch
I'm submitting with this email is not only required to pass cqual, but
sparse, too.

> How is cqual going to handle all of the tty drivers which can have a
> pointer be either a userspace pointer, or a kernel pointer depending on
> the value of another paramater in a function?

I think all these functions should be changed to take two pointers, only
one of which is allowed to be non-NULL.  Then the flag can go away.  I
hope to submit a patch to this effect in the future.  I think sparse
can't check these either, unless you insert casts between user/kernel. 
But inserting casts loses the benefits of the automatic verification,
since the casts could be wrong.

> If you want to change the kernel to user interface like this, I suggest
> you do this for 2.6 first, let's not disturb that interface during the
> 2.4 stable kernel series.
> 
> Want to re-do this patch against 2.6.0-test3?

Ok.  Here's a patch against 2.6.0-test3.  I didn't add the md
substructure to i2c_msg, since it would require changing lots of files
throughout the kernel.  If you think that's an important change, I'll do
it.  Otherwise, the patch is the same idea as before.

Oh, yeah.  This patch also fixes the mem leak, and includes the
single-copy_from_user optimization you guys talked about earlier, since
those haven't been merged into mainline linux yet.

> Actually, why not just create a i2cfs for stuff like this and get rid of
> the ioctl crap all together...  Almost no one uses this (as is evident
> by a lack of 64 bit translation layer logic), and ioctls are a giant
> pain (as evidenced by the need for the 64 bit translation layer.)   It
> also forces users to program in languages that allow ioctls.

This sounds like a good idea, but my concern is just to get a kernel
that can be verified to have no user/kernel bugs.

> Oh, this should be discussed on lkml too, not just the sensors mailing
> list.

Done.  Thanks again for all your help.

Best,
Rob

--- drivers/i2c/i2c-dev.c.orig	Thu Aug 14 18:23:25 2003
+++ drivers/i2c/i2c-dev.c	Thu Aug 14 17:55:33 2003
@@ -180,6 +180,7 @@
 	struct i2c_rdwr_ioctl_data rdwr_arg;
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
+	struct i2c_msg *tmp_pa;
 	struct i2c_msg *rdwr_pa;
 	int i,datasize,res;
 	unsigned long funcs;
@@ -224,34 +225,47 @@
 		 * be sent at once */
 		if (rdwr_arg.nmsgs > 42)
 			return -EINVAL;
+
+		tmp_pa = (struct i2c_msg *)
+			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), 
+			GFP_KERNEL);
+
+		if (tmp_pa == NULL) return -ENOMEM;
+
+		if(copy_from_user(tmp_pa, rdwr_arg.msgs,
+				  rdwr_arg.nmsgs * sizeof(struct i2c_msg))) {
+			kfree(tmp_pa);
+			res = -EFAULT;
+		}
 		
 		rdwr_pa = (struct i2c_msg *)
 			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), 
 			GFP_KERNEL);
 
-		if (rdwr_pa == NULL) return -ENOMEM;
+		if (rdwr_pa == NULL) {
+			kfree(tmp_pa);
+			return -ENOMEM;
+		}
 
 		res = 0;
 		for( i=0; i<rdwr_arg.nmsgs; i++ ) {
-		    	if(copy_from_user(&(rdwr_pa[i]),
-					&(rdwr_arg.msgs[i]),
-					sizeof(rdwr_pa[i]))) {
-			        res = -EFAULT;
-				break;
-			}
 			/* Limit the size of the message to a sane amount */
-			if (rdwr_pa[i].len > 8192) {
+			if (tmp_pa[i].len > 8192) {
 				res = -EINVAL;
 				break;
 			}
+			rdwr_pa[i].addr = tmp_pa[i].addr;
+			rdwr_pa[i].flags = tmp_pa[i].flags;
+			rdwr_pa[i].len = tmp_pa[i].flags;
 			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
 			if(rdwr_pa[i].buf == NULL) {
 				res = -ENOMEM;
 				break;
 			}
 			if(copy_from_user(rdwr_pa[i].buf,
-				rdwr_arg.msgs[i].buf,
+				tmp_pa[i].buf,
 				rdwr_pa[i].len)) {
+				++i; /* Needs to be kfreed too */
 			    	res = -EFAULT;
 				break;
 			}
@@ -261,6 +275,7 @@
 			for (j = 0; j < i; ++j)
 				kfree(rdwr_pa[j].buf);
 			kfree(rdwr_pa);
+			kfree(tmp_pa);
 			return res;
 		}
 		if (!res) {
@@ -271,7 +286,7 @@
 		while(i-- > 0) {
 			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD)) {
 				if(copy_to_user(
-					rdwr_arg.msgs[i].buf,
+					tmp_pa[i].buf,
 					rdwr_pa[i].buf,
 					rdwr_pa[i].len)) {
 					res = -EFAULT;
@@ -280,6 +295,7 @@
 			kfree(rdwr_pa[i].buf);
 		}
 		kfree(rdwr_pa);
+		kfree(tmp_pa);
 		return res;
 
 	case I2C_SMBUS:

