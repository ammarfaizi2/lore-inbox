Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263724AbTCUSXZ>; Fri, 21 Mar 2003 13:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263719AbTCUSWb>; Fri, 21 Mar 2003 13:22:31 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47491
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263713AbTCUSU5>; Fri, 21 Mar 2003 13:20:57 -0500
Date: Fri, 21 Mar 2003 19:36:12 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211936.h2LJaCK7025824@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix proc handling in sis, siimageand slc90e66
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/siimage.c linux-2.5.65-ac2/drivers/ide/pci/siimage.c
--- linux-2.5.65/drivers/ide/pci/siimage.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/siimage.c	2003-03-06 23:35:51.000000000 +0000
@@ -55,6 +55,7 @@
 static int siimage_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
+	int len;
 	u16 i;
 
 	p += sprintf(p, "\n");
@@ -62,7 +63,11 @@
 		struct pci_dev *dev	= siimage_devs[i];
 		p = print_siimage_get_info(p, dev, i);
 	}
-	return p-buffer;	/* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 
 #endif	/* defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS) */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/sis5513.c linux-2.5.65-ac2/drivers/ide/pci/sis5513.c
--- linux-2.5.65/drivers/ide/pci/sis5513.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/sis5513.c	2003-03-06 23:35:34.000000000 +0000
@@ -424,6 +424,7 @@
 static int sis_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
+	int len;
 	u8 reg;
 	u16 reg2, reg3;
 
@@ -494,7 +495,10 @@
 	p = get_masters_info(p);
 	p = get_slaves_info(p);
 
-	return p-buffer;
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS) */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/slc90e66.c linux-2.5.65-ac2/drivers/ide/pci/slc90e66.c
--- linux-2.5.65/drivers/ide/pci/slc90e66.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/pci/slc90e66.c	2003-03-06 23:34:56.000000000 +0000
@@ -34,8 +34,9 @@
 static int slc90e66_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
+	int len;
 	unsigned long bibma = pci_resource_start(bmide_dev, 4);
-        u16 reg40 = 0, psitre = 0, reg42 = 0, ssitre = 0;
+	u16 reg40 = 0, psitre = 0, reg42 = 0, ssitre = 0;
 	u8  c0 = 0, c1 = 0;
 	u8  reg44 = 0, reg47 = 0, reg48 = 0, reg4a = 0, reg4b = 0;
 
@@ -110,7 +111,11 @@
  *	FIXME.... Add configuration junk data....blah blah......
  */
 
-	return p-buffer;	 /* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_SLC90E66_TIMINGS) && defined(CONFIG_PROC_FS) */
 
