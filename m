Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbTIIWul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTIIWul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:50:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:23455 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264828AbTIIWuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:50:17 -0400
Date: Tue, 9 Sep 2003 15:48:33 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] fix build of cosa
Message-Id: <20030909154833.0797ca6e.shemminger@osdl.org>
In-Reply-To: <3F5DC247.794DD843@eyal.emu.id.au>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
	<3F5DC247.794DD843@eyal.emu.id.au>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cosa driver definition of ioctl's either conflicts or was not picked
up in the last round of _IOR redefinition (on 2.6.0-test5).

The following makes it build, have no idea if it still works
on real hardware.

diff -Nru a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c	Tue Sep  9 15:45:31 2003
+++ b/drivers/net/wan/cosa.c	Tue Sep  9 15:45:31 2003
@@ -326,11 +326,11 @@
 /* Ioctls */
 static int cosa_start(struct cosa_data *cosa, int address);
 static int cosa_reset(struct cosa_data *cosa);
-static int cosa_download(struct cosa_data *cosa, struct cosa_download *d);
-static int cosa_readmem(struct cosa_data *cosa, struct cosa_download *d);
+static int cosa_download(struct cosa_data *cosa, unsigned long a);
+static int cosa_readmem(struct cosa_data *cosa, unsigned long a);
 
 /* COSA/SRP ROM monitor */
-static int download(struct cosa_data *cosa, char *data, int addr, int len);
+static int download(struct cosa_data *cosa, const char *data, int addr, int len);
 static int startmicrocode(struct cosa_data *cosa, int address);
 static int readmem(struct cosa_data *cosa, char *data, int addr, int len);
 static int cosa_reset_and_read_id(struct cosa_data *cosa, char *id);
@@ -1033,11 +1033,10 @@
 }
 
 /* High-level function to download data into COSA memory. Calls download() */
-static inline int cosa_download(struct cosa_data *cosa, struct cosa_download *d)
+static inline int cosa_download(struct cosa_data *cosa, unsigned long arg)
 {
+	struct cosa_download d;
 	int i;
-	int addr, len;
-	char *code;
 
 	if (cosa->usage > 1)
 		printk(KERN_INFO "%s: WARNING: download of microcode requested with cosa->usage > 1 (%d). Odd things may happen.\n",
@@ -1047,38 +1046,36 @@
 			cosa->name, cosa->firmware_status);
 		return -EPERM;
 	}
-
-	if (verify_area(VERIFY_READ, d, sizeof(*d)) ||
-	    __get_user(addr, &(d->addr)) ||
-	    __get_user(len, &(d->len)) ||
-	    __get_user(code, &(d->code)))
+	
+	if (copy_from_user(&d, (void __user *) arg, sizeof(d)))
 		return -EFAULT;
 
-	if (addr < 0 || addr > COSA_MAX_FIRMWARE_SIZE)
+	if (d.addr < 0 || d.addr > COSA_MAX_FIRMWARE_SIZE)
 		return -EINVAL;
-	if (len < 0 || len > COSA_MAX_FIRMWARE_SIZE)
+	if (d.len < 0 || d.len > COSA_MAX_FIRMWARE_SIZE)
 		return -EINVAL;
 
+
 	/* If something fails, force the user to reset the card */
 	cosa->firmware_status &= ~(COSA_FW_RESET|COSA_FW_DOWNLOAD);
 
-	if ((i=download(cosa, code, len, addr)) < 0) {
+	i = download(cosa, d.code, d.len, d.addr);
+	if (i < 0) {
 		printk(KERN_NOTICE "cosa%d: microcode download failed: %d\n",
 			cosa->num, i);
 		return -EIO;
 	}
 	printk(KERN_INFO "cosa%d: downloading microcode - 0x%04x bytes at 0x%04x\n",
-		cosa->num, len, addr);
+		cosa->num, d.len, d.addr);
 	cosa->firmware_status |= COSA_FW_RESET|COSA_FW_DOWNLOAD;
 	return 0;
 }
 
 /* High-level function to read COSA memory. Calls readmem() */
-static inline int cosa_readmem(struct cosa_data *cosa, struct cosa_download *d)
+static inline int cosa_readmem(struct cosa_data *cosa, unsigned long arg)
 {
+	struct cosa_download d;
 	int i;
-	int addr, len;
-	char *code;
 
 	if (cosa->usage > 1)
 		printk(KERN_INFO "cosa%d: WARNING: readmem requested with "
@@ -1090,22 +1087,20 @@
 		return -EPERM;
 	}
 
-	if (verify_area(VERIFY_READ, d, sizeof(*d)) ||
-	    __get_user(addr, &(d->addr)) ||
-	    __get_user(len, &(d->len)) ||
-	    __get_user(code, &(d->code)))
+	if (copy_from_user(&d, (void __user *) arg, sizeof(d)))
 		return -EFAULT;
 
 	/* If something fails, force the user to reset the card */
 	cosa->firmware_status &= ~COSA_FW_RESET;
 
-	if ((i=readmem(cosa, code, len, addr)) < 0) {
+	i = readmem(cosa, d.code, d.len, d.addr);
+	if (i < 0) {
 		printk(KERN_NOTICE "cosa%d: reading memory failed: %d\n",
 			cosa->num, i);
 		return -EIO;
 	}
 	printk(KERN_INFO "cosa%d: reading card memory - 0x%04x bytes at 0x%04x\n",
-		cosa->num, len, addr);
+		cosa->num, d.len, d.addr);
 	cosa->firmware_status |= COSA_FW_RESET;
 	return 0;
 }
@@ -1171,11 +1166,12 @@
 	case COSAIODOWNLD:	/* Download the firmware */
 		if (!capable(CAP_SYS_RAWIO))
 			return -EACCES;
-		return cosa_download(cosa, (struct cosa_download *)arg);
+		
+		return cosa_download(cosa, arg);
 	case COSAIORMEM:
 		if (!capable(CAP_SYS_RAWIO))
 			return -EACCES;
-		return cosa_readmem(cosa, (struct cosa_download *)arg);
+		return cosa_readmem(cosa, arg);
 	case COSAIORTYPE:
 		return cosa_gettype(cosa, (char *)arg);
 	case COSAIORIDSTR:
@@ -1405,7 +1401,7 @@
  * by a single space. Monitor has to reply with a space. Now the download
  * begins. After the download monitor replies with "\r\n." (CR LF dot).
  */
-static int download(struct cosa_data *cosa, char *microcode, int length, int address)
+static int download(struct cosa_data *cosa, const char *microcode, int length, int address)
 {
 	int i;
 
diff -Nru a/drivers/net/wan/cosa.h b/drivers/net/wan/cosa.h
--- a/drivers/net/wan/cosa.h	Tue Sep  9 15:45:31 2003
+++ b/drivers/net/wan/cosa.h	Tue Sep  9 15:45:31 2003
@@ -73,19 +73,19 @@
 #define COSAIORSET	_IO('C',0xf0)
 
 /* Start microcode at given address */
-#define COSAIOSTRT	_IOW('C',0xf1,sizeof(int))
+#define COSAIOSTRT	_IOW('C',0xf1, int)
 
 /* Read the block from the device memory */
-#define COSAIORMEM	_IOR('C',0xf2,sizeof(struct cosa_download *))
+#define COSAIORMEM	_IOWR('C',0xf2, struct cosa_download)
 
 /* Write the block to the device memory (i.e. download the microcode) */
-#define COSAIODOWNLD	_IOW('C',0xf2,sizeof(struct cosa_download *))
+#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download)
 
 /* Read the device type (one of "srp", "cosa", and "cosa8" for now) */
-#define COSAIORTYPE	_IOR('C',0xf3,sizeof(char *))
+#define COSAIORTYPE	_IOR('C',0xf3, char *)
 
 /* Read the device identification string */
-#define COSAIORIDSTR	_IOR('C',0xf4,sizeof(char *))
+#define COSAIORIDSTR	_IOR('C',0xf4, char *)
 /* Maximum length of the identification string. */
 #define COSA_MAX_ID_STRING 128
 
@@ -100,7 +100,7 @@
 #define COSAIONRCHANS	_IO('C',0xf8)
 
 /* Set the driver for the bus-master operations */
-#define COSAIOBMSET	_IOW('C', 0xf9, sizeof(unsigned short))
+#define COSAIOBMSET	_IOW('C', 0xf9, unsigned short)
 
 #define COSA_BM_OFF	0	/* Bus-mastering off - use ISA DMA (default) */
 #define COSA_BM_ON	1	/* Bus-mastering on - faster but untested */
