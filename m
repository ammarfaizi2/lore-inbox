Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270753AbTHOSgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270754AbTHOSfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:35:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:51588 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270753AbTHOSdH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:33:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1060972405413@kroah.com>
Subject: Re: [PATCH] i2c driver changes 2.6.0-test3
In-Reply-To: <10609724051936@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:33:25 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1123.18.2, 2003/08/11 14:36:29-07:00, khali@linux-fr.org

[PATCH] i2c: user/kernel bug and memory leak in i2c-dev


 drivers/i2c/i2c-dev.c |   41 ++++++++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 15 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Fri Aug 15 11:27:09 2003
+++ b/drivers/i2c/i2c-dev.c	Fri Aug 15 11:27:09 2003
@@ -181,6 +181,7 @@
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
 	struct i2c_msg *rdwr_pa;
+	u8 **data_ptrs;
 	int i,datasize,res;
 	unsigned long funcs;
 
@@ -214,7 +215,7 @@
 		return (copy_to_user((unsigned long __user *)arg, &funcs,
 		                     sizeof(unsigned long)))?-EFAULT:0;
 
-        case I2C_RDWR:
+	case I2C_RDWR:
 		if (copy_from_user(&rdwr_arg, 
 				   (struct i2c_rdwr_ioctl_data __user *)arg, 
 				   sizeof(rdwr_arg)))
@@ -231,28 +232,37 @@
 
 		if (rdwr_pa == NULL) return -ENOMEM;
 
+		if (copy_from_user(rdwr_pa, rdwr_arg.msgs,
+				   rdwr_arg.nmsgs * sizeof(struct i2c_msg))) {
+			kfree(rdwr_pa);
+			return -EFAULT;
+		}
+
+		data_ptrs = (u8 **) kmalloc(rdwr_arg.nmsgs * sizeof(u8 *),
+					    GFP_KERNEL);
+		if (data_ptrs == NULL) {
+			kfree(rdwr_pa);
+			return -ENOMEM;
+		}
+
 		res = 0;
 		for( i=0; i<rdwr_arg.nmsgs; i++ ) {
-		    	if(copy_from_user(&(rdwr_pa[i]),
-					&(rdwr_arg.msgs[i]),
-					sizeof(rdwr_pa[i]))) {
-			        res = -EFAULT;
-				break;
-			}
 			/* Limit the size of the message to a sane amount */
 			if (rdwr_pa[i].len > 8192) {
 				res = -EINVAL;
 				break;
 			}
+			data_ptrs[i] = rdwr_pa[i].buf;
 			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
 			if(rdwr_pa[i].buf == NULL) {
 				res = -ENOMEM;
 				break;
 			}
 			if(copy_from_user(rdwr_pa[i].buf,
-				rdwr_arg.msgs[i].buf,
+				data_ptrs[i],
 				rdwr_pa[i].len)) {
-			    	res = -EFAULT;
+					++i; /* Needs to be kfreed too */
+					res = -EFAULT;
 				break;
 			}
 		}
@@ -260,18 +270,18 @@
 			int j;
 			for (j = 0; j < i; ++j)
 				kfree(rdwr_pa[j].buf);
+			kfree(data_ptrs);
 			kfree(rdwr_pa);
 			return res;
 		}
-		if (!res) {
-			res = i2c_transfer(client->adapter,
-				rdwr_pa,
-				rdwr_arg.nmsgs);
-		}
+
+		res = i2c_transfer(client->adapter,
+			rdwr_pa,
+			rdwr_arg.nmsgs);
 		while(i-- > 0) {
 			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD)) {
 				if(copy_to_user(
-					rdwr_arg.msgs[i].buf,
+					data_ptrs[i],
 					rdwr_pa[i].buf,
 					rdwr_pa[i].len)) {
 					res = -EFAULT;
@@ -279,6 +289,7 @@
 			}
 			kfree(rdwr_pa[i].buf);
 		}
+		kfree(data_ptrs);
 		kfree(rdwr_pa);
 		return res;
 

