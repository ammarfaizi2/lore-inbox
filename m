Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274908AbTHFIHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 04:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274920AbTHFIHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 04:07:00 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:30479 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S274908AbTHFIGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 04:06:50 -0400
Date: Wed, 6 Aug 2003 10:07:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org,
       vsu@altlinux.ru, rtjohnso@eecs.berkeley.edu, greg@kroah.com
Subject: Re: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-Id: <20030806100702.78298ffe.khali@linux-fr.org>
In-Reply-To: <20030805210704.GA5452@kroah.com>
References: <20030803192312.68762d3c.khali@linux-fr.org>
	<20030804193212.11786d06.vsu@altlinux.ru>
	<20030805103240.02221bed.khali@linux-fr.org>
	<20030805210704.GA5452@kroah.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo,

Greg> Patch looks good, want to send it to Marcelo, or do you want me
Greg> to?

Here I do, speaking in the name of the I2C & LM Sensors development team
:)

A patch to i2c-dev follows, built against 2.4.22-pre10, which brings
the following changes:

* Fix a user/kernel bug discovered by Robert T. Johnson.
  Patch by Sergey Vlasov.
* Fix a memory leak discovered by Robert T. Johnson.
  Patch by Sergey Vlasov and me.
* Two code optimizations/cleanups.
  Patches by Sergey Vlaslov and me, respectively.
* Bonus: two lines with changed whitespace, but you don't care.
  Patches by me and Robert T. Johnson, respectively.

These changes should also be made to i2c-CVS and Linux 2.6's i2c
subsystem. I will commit the changes to i2c-CVS while Greg KH will
submit a modified patch to Linus.

The final patch was tested by me (compiles and runs with no apparent
drawback) and approved by Sergey Vlaslov and Greg KH.
Please apply.

Thanks,
Jean


--- 2.4/drivers/i2c/i2c-dev.c	Tue Jul 15 12:23:49 2003
+++ 2.4/drivers/i2c/i2c-dev.c	Wed Aug  6 09:36:54 2003
@@ -219,6 +219,7 @@
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
 	struct i2c_msg *rdwr_pa;
+	u8 **data_ptrs;
 	int i,datasize,res;
 	unsigned long funcs;
 
@@ -248,7 +249,7 @@
 		return (copy_to_user((unsigned long *)arg,&funcs,
 		                     sizeof(unsigned long)))?-EFAULT:0;
 
-        case I2C_RDWR:
+	case I2C_RDWR:
 		if (copy_from_user(&rdwr_arg, 
 				   (struct i2c_rdwr_ioctl_data *)arg, 
 				   sizeof(rdwr_arg)))
@@ -265,21 +266,28 @@
 
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
 		for( i=0; i<rdwr_arg.nmsgs; i++ )
 		{
-		    	if(copy_from_user(&(rdwr_pa[i]),
-					&(rdwr_arg.msgs[i]),
-					sizeof(rdwr_pa[i])))
-			{
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
 			if(rdwr_pa[i].buf == NULL)
 			{
@@ -287,10 +295,11 @@
 				break;
 			}
 			if(copy_from_user(rdwr_pa[i].buf,
-				rdwr_arg.msgs[i].buf,
+				data_ptrs[i],
 				rdwr_pa[i].len))
 			{
-			    	res = -EFAULT;
+				++i; /* Needs to be kfreed too */
+				res = -EFAULT;
 				break;
 			}
 		}
@@ -298,21 +307,20 @@
 			int j;
 			for (j = 0; j < i; ++j)
 				kfree(rdwr_pa[j].buf);
+			kfree(data_ptrs);
 			kfree(rdwr_pa);
 			return res;
 		}
-		if (!res) 
-		{
-			res = i2c_transfer(client->adapter,
-				rdwr_pa,
-				rdwr_arg.nmsgs);
-		}
+
+		res = i2c_transfer(client->adapter,
+			rdwr_pa,
+			rdwr_arg.nmsgs);
 		while(i-- > 0)
 		{
 			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD))
 			{
 				if(copy_to_user(
-					rdwr_arg.msgs[i].buf,
+					data_ptrs[i],
 					rdwr_pa[i].buf,
 					rdwr_pa[i].len))
 				{
@@ -321,6 +329,7 @@
 			}
 			kfree(rdwr_pa[i].buf);
 		}
+		kfree(data_ptrs);
 		kfree(rdwr_pa);
 		return res;
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
