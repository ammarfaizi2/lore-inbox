Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132565AbQLQLuh>; Sun, 17 Dec 2000 06:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132580AbQLQLuS>; Sun, 17 Dec 2000 06:50:18 -0500
Received: from [62.172.234.2] ([62.172.234.2]:1833 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S132565AbQLQLuJ>;
	Sun, 17 Dec 2000 06:50:09 -0500
Date: Sun, 17 Dec 2000 11:21:51 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: for Alan Cox [patch-2.2.19-pre2] more fixes to microcode driver
 (fwd)
Message-ID: <Pine.LNX.4.21.0012171119470.4428-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, please ignore this one _if_ you have already received it today.

---------- Forwarded message ----------
Date: Sun, 17 Dec 2000 10:53:49 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [patch-2.2.19-pre2] more fixes to microcode driver

Hi Alan,

I backported two bugfixes from 2.4 and also fixed an existing bug in
microcode_init. Tested both as module and static on 2.2.19-pre2.

Regards,
Tigran

diff -urN -X dontdiff linux/arch/i386/kernel/microcode.c ucode-2.2/arch/i386/kernel/microcode.c
--- linux/arch/i386/kernel/microcode.c	Sun Dec 17 09:18:32 2000
+++ ucode-2.2/arch/i386/kernel/microcode.c	Sun Dec 17 09:27:36 2000
@@ -33,6 +33,8 @@
  *		Messages for error cases (non intel & no suitable microcode).
  *	1.06	07 Dec 2000, Tigran Aivazian <tigran@veritas.com>
  *		Pentium 4 support + backported fixes from 2.4
+ *	1.07	13 Dec 2000, Tigran Aivazian <tigran@veritas.com>
+ *		More bugfixes backported from 2.4
  */
 
 #include <linux/init.h>
@@ -47,7 +49,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 
-#define MICROCODE_VERSION 	"1.06"
+#define MICROCODE_VERSION 	"1.07"
 
 MODULE_DESCRIPTION("Intel CPU (IA-32) microcode update driver");
 MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
@@ -87,13 +89,10 @@
 
 int __init microcode_init(void)
 {
-	int error = 0;
-
 	if (misc_register(&microcode_dev) < 0) {
-		printk(KERN_WARNING 
-			"microcode: can't misc_register on minor=%d\n",
+		printk(KERN_ERR "microcode: can't misc_register on minor=%d\n",
 			MICROCODE_MINOR);
-		error = 1;
+		return -EINVAL;
 	}
 	printk(KERN_INFO "IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
 			MICROCODE_VERSION);
@@ -234,18 +233,21 @@
 
 static ssize_t microcode_read(struct file *file, char *buf, size_t len, loff_t *ppos)
 {
-	if (*ppos >= mc_fsize)
-		return 0;
+	ssize_t err = 0;
+
 	down(&microcode_sem);
+	if (*ppos >= mc_fsize)
+		goto out;
 	if (*ppos + len > mc_fsize)
 		len = mc_fsize - *ppos;
-	if (copy_to_user(buf, mc_applied + *ppos, len)) {
-		up(&microcode_sem);
-		return -EFAULT;
-	}
+	err = -EFAULT;
+	if (copy_to_user(buf, mc_applied + *ppos, len))
+		goto out;
 	*ppos += len;
+	err = len;
+out:
 	up(&microcode_sem);
-	return len;
+	return err;
 }
 
 static ssize_t microcode_write(struct file *file, const char *buf, size_t len, loff_t *ppos)
@@ -300,11 +302,12 @@
 		case MICROCODE_IOCFREE:
 			down(&microcode_sem);
 			if (mc_applied) {
+				int bytes = smp_num_cpus * sizeof(struct microcode);
+
 				memset(mc_applied, 0, mc_fsize);
 				kfree(mc_applied);
 				mc_applied = NULL;
-				printk(KERN_WARNING 
-					"microcode: freed %d bytes\n", mc_fsize);
+				printk(KERN_WARNING "microcode: freed %d bytes\n", bytes);
 				mc_fsize = 0;
 				up(&microcode_sem);
 				return 0;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
