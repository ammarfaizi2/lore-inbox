Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTH1BR3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 21:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbTH1BR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 21:17:29 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:6814 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S263620AbTH1BRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 21:17:25 -0400
Subject: Re: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       sensors@Stimpy.netroedge.com, vsu@altlinux.ru
In-Reply-To: <20030815211329.GB4920@kroah.com>
References: <20030803192312.68762d3c.khali@linux-fr.org>
	<20030804193212.11786d06.vsu@altlinux.ru>
	<20030805103240.02221bed.khali@linux-fr.org>
	<20030805210704.GA5452@kroah.com>
	<20030806100702.78298ffe.khali@linux-fr.org>
	<1060886657.1006.7121.camel@dooby.cs.berkeley.edu>
	<20030814190954.GA2492@kroah.com>
	<1060912895.1006.7160.camel@dooby.cs.berkeley.edu> 
	<20030815211329.GB4920@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 27 Aug 2003 18:17:19 -0700
Message-Id: <1062033440.16799.22.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 14:13, Greg KH wrote:
> Hm, I had already applied your patch, so this one doesn't apply.  Care
> to re-do it against 2.6.0-test4 whenever that comes out?

Here's the patch against 2.6.0-test4.  Just to remind everyone, this
patch doesn't fix any bugs (they're already fixed in 2.6.0-test3), it
just makes the code pass our static analysis tool, cqual, without
generating a warning.  Since finding and fixing these bugs is so tricky,
it seems worthwhile to have code which can be automatically verified to
be bug-free (at least w.r.t. user/kernel pointers).  That's what this
patch is about.  Let me know if you have any questions or comments. 
Thanks for everyone's help.

Best,
Rob

P.S. cqual is on its way -- we're working on documentation and
integrating it into the kernel build process.


--- drivers/i2c/i2c-dev.c.orig	Wed Aug 27 18:04:31 2003
+++ drivers/i2c/i2c-dev.c	Wed Aug 27 17:51:23 2003
@@ -181,7 +181,7 @@
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
 	struct i2c_msg *rdwr_pa;
-	u8 **data_ptrs;
+	struct i2c_msg *tmp_pa;
 	int i,datasize,res;
 	unsigned long funcs;
 
@@ -226,40 +226,44 @@
 		if (rdwr_arg.nmsgs > 42)
 			return -EINVAL;
 		
-		rdwr_pa = (struct i2c_msg *)
+		tmp_pa = (struct i2c_msg *)
 			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), 
 			GFP_KERNEL);
 
-		if (rdwr_pa == NULL) return -ENOMEM;
+		if (tmp_pa == NULL) return -ENOMEM;
 
-		if (copy_from_user(rdwr_pa, rdwr_arg.msgs,
+		if (copy_from_user(tmp_pa, rdwr_arg.msgs,
 				   rdwr_arg.nmsgs * sizeof(struct i2c_msg))) {
-			kfree(rdwr_pa);
+			kfree(tmp_pa);
 			return -EFAULT;
 		}
 
-		data_ptrs = (u8 **) kmalloc(rdwr_arg.nmsgs * sizeof(u8 *),
-					    GFP_KERNEL);
-		if (data_ptrs == NULL) {
-			kfree(rdwr_pa);
+		rdwr_pa = (struct i2c_msg *)
+			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), 
+			GFP_KERNEL);
+
+		if (rdwr_pa == NULL) {
+			kfree(tmp_pa);
 			return -ENOMEM;
 		}
 
 		res = 0;
 		for( i=0; i<rdwr_arg.nmsgs; i++ ) {
+			rdwr_pa[i].addr = tmp_pa[i].addr;
+			rdwr_pa[i].flags = tmp_pa[i].flags;
+			rdwr_pa[i].len = tmp_pa[i].len;
 			/* Limit the size of the message to a sane amount */
 			if (rdwr_pa[i].len > 8192) {
 				res = -EINVAL;
 				break;
 			}
-			data_ptrs[i] = rdwr_pa[i].buf;
 			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
 			if(rdwr_pa[i].buf == NULL) {
 				res = -ENOMEM;
 				break;
 			}
 			if(copy_from_user(rdwr_pa[i].buf,
-				data_ptrs[i],
+				tmp_pa[i].buf,
 				rdwr_pa[i].len)) {
 					++i; /* Needs to be kfreed too */
 					res = -EFAULT;
@@ -270,8 +274,8 @@
 			int j;
 			for (j = 0; j < i; ++j)
 				kfree(rdwr_pa[j].buf);
-			kfree(data_ptrs);
 			kfree(rdwr_pa);
+			kfree(tmp_pa);
 			return res;
 		}
 
@@ -281,7 +285,7 @@
 		while(i-- > 0) {
 			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD)) {
 				if(copy_to_user(
-					data_ptrs[i],
+					tmp_pa[i].buf,
 					rdwr_pa[i].buf,
 					rdwr_pa[i].len)) {
 					res = -EFAULT;
@@ -289,8 +293,8 @@
 			}
 			kfree(rdwr_pa[i].buf);
 		}
-		kfree(data_ptrs);
 		kfree(rdwr_pa);
+		kfree(tmp_pa);
 		return res;
 
 	case I2C_SMBUS:

