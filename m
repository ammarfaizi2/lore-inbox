Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286468AbRL0Sx2>; Thu, 27 Dec 2001 13:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286472AbRL0SxT>; Thu, 27 Dec 2001 13:53:19 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:58373 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S286468AbRL0SxF>; Thu, 27 Dec 2001 13:53:05 -0500
Date: Thu, 27 Dec 2001 19:52:35 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre1
Message-ID: <20011227195235.A31639@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <Pine.LNX.4.21.0112261510230.9875-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.21.0112261510230.9875-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2001 at 03:11:44PM -0200, Marcelo Tosatti wrote:

> Hi, 
> 
> So here it goes the first pre of 2.4.18 series: Pretty big patch with 3
> arch updates. 
> 
> Nothing critical to the core, though.
> 
> 
> pre1:
[...]
> - sonypi update					(Stelian Pop)
[...]

The patch isn't present in -pre1, however. I attach it again, in
case it's more convenient for you.

Stelian.


diff -uNr --exclude-from=dontdiff linux-2.4.17.orig/Documentation/sonypi.txt linux-2.4.17/Documentation/sonypi.txt
--- linux-2.4.17.orig/Documentation/sonypi.txt	Wed Dec 26 10:33:53 2001
+++ linux-2.4.17/Documentation/sonypi.txt	Tue Dec 18 13:11:40 2001
@@ -25,7 +25,8 @@
 can be downloaded at: <http://www.alcove-labs.org/en/software/sonypi/>
 
 This driver supports also some ioctl commands for setting the LCD screen
-brightness (some more commands may be added in the future).
+brightness and querying the batteries charge information (some more 
+commands may be added in the future).
 
 This driver can also be used to set the camera controls on Picturebook series
 (brightness, contrast etc), and is used by the video4linux driver for the 
diff -uNr --exclude-from=dontdiff linux-2.4.17.orig/drivers/char/sonypi.c linux-2.4.17/drivers/char/sonypi.c
--- linux-2.4.17.orig/drivers/char/sonypi.c	Wed Dec 26 10:33:57 2001
+++ linux-2.4.17/drivers/char/sonypi.c	Tue Dec 18 13:11:40 2001
@@ -109,25 +109,29 @@
         return result;
 }
 
-static void sonypi_ecrset(u16 addr, u16 value) {
+static void sonypi_ecrset(u8 addr, u8 value) {
 
-	wait_on_command(1, inw_p(SONYPI_CST_IOPORT) & 3);
-	outw_p(0x81, SONYPI_CST_IOPORT);
-	wait_on_command(0, inw_p(SONYPI_CST_IOPORT) & 2);
-	outw_p(addr, SONYPI_DATA_IOPORT);
-	wait_on_command(0, inw_p(SONYPI_CST_IOPORT) & 2);
-	outw_p(value, SONYPI_DATA_IOPORT);
-	wait_on_command(0, inw_p(SONYPI_CST_IOPORT) & 2);
-}
-
-static u16 sonypi_ecrget(u16 addr) {
-
-	wait_on_command(1, inw_p(SONYPI_CST_IOPORT) & 3);
-	outw_p(0x80, SONYPI_CST_IOPORT);
-	wait_on_command(0, inw_p(SONYPI_CST_IOPORT) & 2);
-	outw_p(addr, SONYPI_DATA_IOPORT);
-	wait_on_command(0, inw_p(SONYPI_CST_IOPORT) & 2);
-	return inw_p(SONYPI_DATA_IOPORT);
+	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3);
+	outb_p(0x81, SONYPI_CST_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2);
+	outb_p(addr, SONYPI_DATA_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2);
+	outb_p(value, SONYPI_DATA_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2);
+}
+
+static u8 sonypi_ecrget(u8 addr) {
+
+	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3);
+	outb_p(0x80, SONYPI_CST_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2);
+	outb_p(addr, SONYPI_DATA_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2);
+	return inb_p(SONYPI_DATA_IOPORT);
+}
+
+static u16 sonypi_ecrget16(u8 addr) {
+	return sonypi_ecrget(addr) | (sonypi_ecrget(addr + 1) << 8);
 }
 
 /* Initializes the device - this comes from the AML code in the ACPI bios */
@@ -510,24 +514,60 @@
 static int sonypi_misc_ioctl(struct inode *ip, struct file *fp, 
 			     unsigned int cmd, unsigned long arg) {
 	int ret = 0;
-	u8 val;
+	u8 val8;
+	u16 val16;
 
 	down(&sonypi_device.lock);
 	switch (cmd) {
-		case SONYPI_IOCGBRT:
-			val = sonypi_ecrget(0x96) & 0xff;
-			if (copy_to_user((u8 *)arg, &val, sizeof(val))) {
-				ret = -EFAULT;
-				goto out;
-			}
-			break;
-		case SONYPI_IOCSBRT:
-			if (copy_from_user(&val, (u8 *)arg, sizeof(val))) {
-				ret = -EFAULT;
-				goto out;
-			}
-			sonypi_ecrset(0x96, val);
-			break;
+	case SONYPI_IOCGBRT:
+		val8 = sonypi_ecrget(0x96);
+		if (copy_to_user((u8 *)arg, &val8, sizeof(val8))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		break;
+	case SONYPI_IOCSBRT:
+		if (copy_from_user(&val8, (u8 *)arg, sizeof(val8))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		sonypi_ecrset(0x96, val8);
+		break;
+	case SONYPI_IOCGBAT1CAP:
+		val16 = sonypi_ecrget16(0xb2);
+		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		break;
+	case SONYPI_IOCGBAT1REM:
+		val16 = sonypi_ecrget16(0xa2);
+		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		break;
+	case SONYPI_IOCGBAT2CAP:
+		val16 = sonypi_ecrget16(0xba);
+		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		break;
+	case SONYPI_IOCGBAT2REM:
+		val16 = sonypi_ecrget16(0xaa);
+		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		break;
+	case SONYPI_IOCGBATFLAGS:
+		val8 = sonypi_ecrget(0x81) & 0x07;
+		if (copy_to_user((u8 *)arg, &val8, sizeof(val8))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
diff -uNr --exclude-from=dontdiff linux-2.4.17.orig/drivers/char/sonypi.h linux-2.4.17/drivers/char/sonypi.h
--- linux-2.4.17.orig/drivers/char/sonypi.h	Wed Dec 26 10:33:57 2001
+++ linux-2.4.17/drivers/char/sonypi.h	Fri Dec 21 15:35:37 2001
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	1
-#define SONYPI_DRIVER_MINORVERSION	8
+#define SONYPI_DRIVER_MINORVERSION	9
 
 #include <linux/types.h>
 #include <linux/pci.h>
diff -uNr --exclude-from=dontdiff linux-2.4.17.orig/include/linux/sonypi.h linux-2.4.17/include/linux/sonypi.h
--- linux-2.4.17.orig/include/linux/sonypi.h	Thu Oct 11 20:17:22 2001
+++ linux-2.4.17/include/linux/sonypi.h	Fri Dec 21 15:35:37 2001
@@ -75,9 +75,21 @@
 #define SONYPI_EVENT_LID_OPENED			37
 
 
-/* brightness etc. ioctls */
-#define SONYPI_IOCGBRT	_IOR('v', 0, __u8)
-#define SONYPI_IOCSBRT	_IOW('v', 0, __u8)
+/* get/set brightness */
+#define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
+#define SONYPI_IOCSBRT		_IOW('v', 0, __u8)
+
+/* get battery full capacity/remaining capacity */
+#define SONYPI_IOCGBAT1CAP	_IOR('v', 2, __u16)
+#define SONYPI_IOCGBAT1REM	_IOR('v', 3, __u16)
+#define SONYPI_IOCGBAT2CAP	_IOR('v', 4, __u16)
+#define SONYPI_IOCGBAT2REM	_IOR('v', 5, __u16)
+
+/* get battery flags: battery1/battery2/ac adapter present */
+#define SONYPI_BFLAGS_B1	0x01
+#define SONYPI_BFLAGS_B2	0x02
+#define SONYPI_BFLAGS_AC	0x04
+#define SONYPI_IOCGBATFLAGS	_IOR('v', 7, __u8)
 
 #ifdef __KERNEL__
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
