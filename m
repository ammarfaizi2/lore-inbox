Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288791AbSAEMS2>; Sat, 5 Jan 2002 07:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288793AbSAEMSS>; Sat, 5 Jan 2002 07:18:18 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:17896 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288791AbSAEMSG>; Sat, 5 Jan 2002 07:18:06 -0500
Date: Sat, 5 Jan 2002 04:18:05 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: eokerson@quicknet.net, linux-kernel@vger.kernel.org
Subject: linux-2.5.2-pre8/drivers/telephony kdev_t compilation fixes
Message-ID: <20020105041805.A24306@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Here is a patch to make linux-2.5.2-pre8/drivers/telephony
compile.  It changes some MINOR() calls to minor().  gcc-3.0.2
also identified two places that could produce undefined behavior
under the C standard, so I fixed those too.

	I only know that this code compiles.  I don't know that it
works.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="telephony.diff"

diff -u -r linux-2.5.2-pre8/drivers/telephony/ixj.c linux/drivers/telephony/ixj.c
--- linux-2.5.2-pre8/drivers/telephony/ixj.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/telephony/ixj.c	Sat Jan  5 04:09:23 2002
@@ -274,8 +274,8 @@
 
 #include "ixj.h"
 
-#define TYPE(dev) (MINOR(dev) >> 4)
-#define NUM(dev) (MINOR(dev) & 0xf)
+#define TYPE(dev) (minor(dev) >> 4)
+#define NUM(dev) (minor(dev) & 0xf)
 
 static int ixjdebug;
 static int hertz = HZ;
@@ -2805,8 +2835,10 @@
 		0xD6, 0xD6, 0xD7, 0xD7, 0xD4, 0xD4, 0xD5, 0xD5
 	};
 
-	while (len--)
-		*buff++ = table_ulaw2alaw[*(unsigned char *)buff];
+	while (len--) {
+		*buff = table_ulaw2alaw[*(unsigned char *)buff];
+		buff++;
+	}
 }
 
 static void alaw2ulaw(unsigned char *buff, unsigned long len)
@@ -2847,8 +2879,10 @@
 		0xCF, 0xCF, 0xCE, 0xCE, 0xD2, 0xD3, 0xD0, 0xD1
 	};
 
-        while (len--)
-                *buff++ = table_alaw2ulaw[*(unsigned char *)buff];
+        while (len--) {
+                *buff = table_alaw2ulaw[*(unsigned char *)buff];
+		buff++;
+	}
 }
 
 static ssize_t ixj_read(struct file * file_p, char *buf, size_t length, loff_t * ppos)
@@ -6202,7 +6236,7 @@
 	IXJ_FILTER_RAW jfr;
 
 	unsigned int raise, mant;
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int index = minor(inode->i_rdev);
 	int board = NUM(inode->i_rdev);
 
 	IXJ *j = get_ixj(NUM(inode->i_rdev));
@@ -6218,8 +6252,8 @@
 		schedule_timeout(1);
 	}
 	if (ixjdebug & 0x0040)
-		printk("phone%d ioctl, cmd: 0x%x, arg: 0x%lx\n", minor, cmd, arg);
-	if (minor >= IXJMAX) {
+		printk("phone%d ioctl, cmd: 0x%x, arg: 0x%lx\n", index, cmd, arg);
+	if (index >= IXJMAX) {
 		clear_bit(board, &j->busyflags);
 		return -ENODEV;
 	}
@@ -6746,7 +6780,7 @@
 		break;
 	}
 	if (ixjdebug & 0x0040)
-		printk("phone%d ioctl end, cmd: 0x%x, arg: 0x%lx\n", minor, cmd, arg);
+		printk("phone%d ioctl end, cmd: 0x%x, arg: 0x%lx\n", index, cmd, arg);
 	clear_bit(board, &j->busyflags);
 	return retval;
 }
diff -u -r linux-2.5.2-pre8/drivers/telephony/phonedev.c linux/drivers/telephony/phonedev.c
--- linux-2.5.2-pre8/drivers/telephony/phonedev.c	Fri Sep  7 09:28:37 2001
+++ linux/drivers/telephony/phonedev.c	Sat Jan  5 04:09:23 2002
@@ -46,26 +46,26 @@
 
 static int phone_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int index = minor(inode->i_rdev);
 	int err = 0;
 	struct phone_device *p;
 	struct file_operations *old_fops, *new_fops = NULL;
 
-	if (minor >= PHONE_NUM_DEVICES)
+	if (index >= PHONE_NUM_DEVICES)
 		return -ENODEV;
 
 	down(&phone_lock);
-	p = phone_device[minor];
+	p = phone_device[index];
 	if (p)
 		new_fops = fops_get(p->f_op);
 	if (!new_fops) {
 		char modname[32];
 
 		up(&phone_lock);
-		sprintf(modname, "char-major-%d-%d", PHONE_MAJOR, minor);
+		sprintf(modname, "char-major-%d-%d", PHONE_MAJOR, index);
 		request_module(modname);
 		down(&phone_lock);
-		p = phone_device[minor];
+		p = phone_device[index];
 		if (p == NULL || (new_fops = fops_get(p->f_op)) == NULL)
 		{
 			err=-ENODEV;

--45Z9DzgjV8m4Oswq--
