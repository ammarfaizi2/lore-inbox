Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271307AbTGWUnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271309AbTGWUnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:43:14 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:46230 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S271307AbTGWUnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:43:07 -0400
Subject: PATCH: 2.4.22-pre7 drivers/i2c/i2c-dev.c user/kernel bug and mem
	leak
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: frodol@dds.nl
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Jul 2003 13:58:03 -0700
Message-Id: <1058993883.31093.115.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user kernel bug was discovered by the Berkeley-developed static
analysis tool, CQual, developed by Jeff Foster, John Kodumal, and many
others.  The mem leak bug just happened to be in the wrong place at the
wrong time. :)

The user/kernel bug
-------------------

int i2cdev_ioctl (struct inode *inode, struct file *file, unsigned int cmd, 
                  unsigned long arg)
{

<snip>

        case I2C_RDWR:
		if (copy_from_user(&rdwr_arg, 
				   (struct i2c_rdwr_ioctl_data *)arg, 
				   sizeof(rdwr_arg)))
			return -EFAULT;

<snip>

		for( i=0; i<rdwr_arg.nmsgs; i++ )
		{

<snip>

			if(copy_from_user(rdwr_pa[i].buf,
				rdwr_arg.msgs[i].buf,
				rdwr_pa[i].len))
			{
			    	res = -EFAULT;
				break;
			}
		}

<snip>

After the first copy_from_user(), rdwr_arg.msgs is a pointer under user
control.  Thus evaluating the expression "rdwr_arg.msgs[i].buf" at the
bottom of the for-loop requires an unsafe dereference.

The mem leak
------------

int i2cdev_ioctl (struct inode *inode, struct file *file, unsigned int cmd, 
                  unsigned long arg)
{

<snip>

        case I2C_RDWR:

<snip>

		for( i=0; i<rdwr_arg.nmsgs; i++ )
		{

<snip>

			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
			if(rdwr_pa[i].buf == NULL)
			{
				res = -ENOMEM;
				break;
			}
			if(copy_from_user(rdwr_pa[i].buf,
				rdwr_arg.msgs[i].buf,
				rdwr_pa[i].len))
			{
			    	res = -EFAULT;
				break;
			}
		}
		if (res < 0) {
			int j;
			for (j = 0; j < i; ++j)
				kfree(rdwr_pa[j].buf);
			kfree(rdwr_pa);
			return res;
		}

<snip>

Notice the for-loop may exit with rdwr_pa[i].buf allocated if the
copy_from_user() fails.  The cleanup code doesn't handle this case. 
Thus a malicious user could make the kernel lose up to 8KB per ioctl.

The following patch fixes both bugs.  There's a couple of lines with
changed whitespace, but I think the changes make it more consistent (and
fixing them would be a hassle).  Thanks for looking into this, and sorry
if I got anything wrong.

Best,
Rob

--- drivers/i2c/i2c-dev.c.orig	Tue Jul 22 11:26:28 2003
+++ drivers/i2c/i2c-dev.c	Wed Jul 23 12:55:57 2003
@@ -219,6 +219,7 @@
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
 	struct i2c_msg *rdwr_pa;
+	struct i2c_msg *tmp_pa;
 	int i,datasize,res;
 	unsigned long funcs;
 
@@ -265,10 +266,21 @@
 
 		if (rdwr_pa == NULL) return -ENOMEM;
 
+		tmp_pa = (struct i2c_msg *)
+			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), 
+			GFP_KERNEL);
+
+		if (tmp_pa == NULL)
+		{
+			kfree(rdwr_pa);
+			return -ENOMEM;
+		}
+
 		res = 0;
 		for( i=0; i<rdwr_arg.nmsgs; i++ )
 		{
-		    	if(copy_from_user(&(rdwr_pa[i]),
+			rdwr_pa[i].buf = NULL;
+			if(copy_from_user(&tmp_pa[i],
 					&(rdwr_arg.msgs[i]),
 					sizeof(rdwr_pa[i])))
 			{
@@ -276,10 +288,13 @@
 				break;
 			}
 			/* Limit the size of the message to a sane amount */
-			if (rdwr_pa[i].len > 8192) {
+			if (tmp_pa[i].len > 8192) {
 				res = -EINVAL;
 				break;
 			}
+			rdwr_pa[i].addr = tmp_pa[i].addr;
+			rdwr_pa[i].flags = tmp_pa[i].flags;
+			rdwr_pa[i].len = tmp_pa[i].len;
 			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
 			if(rdwr_pa[i].buf == NULL)
 			{
@@ -287,18 +302,20 @@
 				break;
 			}
 			if(copy_from_user(rdwr_pa[i].buf,
-				rdwr_arg.msgs[i].buf,
+				tmp_pa[i].buf,
 				rdwr_pa[i].len))
 			{
-			    	res = -EFAULT;
+				res = -EFAULT;
 				break;
 			}
 		}
 		if (res < 0) {
 			int j;
-			for (j = 0; j < i; ++j)
-				kfree(rdwr_pa[j].buf);
+			for (j = 0; j <= i; ++j)
+				if (rdwr_pa[j].buf)
+					kfree(rdwr_pa[j].buf);
 			kfree(rdwr_pa);
+			kfree(tmp_pa);
 			return res;
 		}
 		if (!res) 
@@ -312,7 +329,7 @@
 			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD))
 			{
 				if(copy_to_user(
-					rdwr_arg.msgs[i].buf,
+					tmp_pa[i].buf,
 					rdwr_pa[i].buf,
 					rdwr_pa[i].len))
 				{
@@ -322,6 +339,7 @@
 			kfree(rdwr_pa[i].buf);
 		}
 		kfree(rdwr_pa);
+		kfree(tmp_pa);
 		return res;
 
 	case I2C_SMBUS:

