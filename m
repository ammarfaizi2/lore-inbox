Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbTJNU51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbTJNU51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:57:27 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.36.229]:59625 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S262531AbTJNU5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:57:14 -0400
Date: Tue, 14 Oct 2003 15:57:09 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@iguana.domsch.com
To: greg@kroah.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][BUGFIX] edd.c raw_data file shouldn't hexdump
In-Reply-To: <Pine.LNX.4.44.0310141546370.16018-100000@iguana.domsch.com>
Message-ID: <Pine.LNX.4.44.0310141556200.16087-100000@iguana.domsch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1337.8.1, 2003-10-12 00:08:51-05:00, Matt_Domsch@dell.com
  EDD: reads to raw_data return binary data, not hexdump
  
  by request of gregkh
  other minor cleanups


 edd.c |  182 ++++++++++--------------------------------------------------------
 1 files changed, 29 insertions(+), 153 deletions(-)


diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Tue Oct 14 15:49:37 2003
+++ b/arch/i386/kernel/edd.c	Tue Oct 14 15:49:37 2003
@@ -13,6 +13,10 @@
  * made in setup.S, copied to safe structures in setup.c,
  * and presents it in sysfs.
  *
+ * Please see http://domsch.com/linux/edd30/results.html for
+ * the list of BIOSs which have been reported to implement EDD.
+ * If you don't see yours listed, please send a report as described there.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License v2.0 as published by
  * the Free Software Foundation
@@ -55,7 +59,7 @@
 MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
 
-#define EDD_VERSION "0.09 2003-Jan-22"
+#define EDD_VERSION "0.10 2003-Oct-11"
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://domsch.com/linux/edd30/results.html"
 
@@ -75,8 +79,6 @@
 /* forward declarations */
 static int edd_dev_is_type(struct edd_device *edev, const char *type);
 static struct pci_dev *edd_get_pci_dev(struct edd_device *edev);
-static struct scsi_device *edd_find_matching_scsi_device(struct edd_device *edev);
-static int kernel_has_scsi(void);
 
 static struct edd_device *edd_devices[EDDMAXNR];
 
@@ -118,41 +120,6 @@
 	.show = edd_attr_show,
 };
 
-static int
-edd_dump_raw_data(char *b, int count, void *data, int length)
-{
-	char *orig_b = b;
-	char hexbuf[80], ascbuf[20], *h, *a, c;
-	unsigned char *p = data;
-	unsigned long column = 0;
-	int length_printed = 0, d;
-	const char maxcolumn = 16;
-	while (length_printed < length && count > 0) {
-		h = hexbuf;
-		a = ascbuf;
-		for (column = 0;
-		     column < maxcolumn && length_printed < length; column++) {
-			h += sprintf(h, "%02x ", (unsigned char) *p);
-			if (!isprint(*p))
-				c = '.';
-			else
-				c = *p;
-			a += sprintf(a, "%c", c);
-			p++;
-			length_printed++;
-		}
-		/* pad out the line */
-		for (; column < maxcolumn; column++) {
-			h += sprintf(h, "   ");
-			a += sprintf(a, " ");
-		}
-		d = snprintf(b, count, "%s\t%s\n", hexbuf, ascbuf);
-		b += d;
-		count -= d;
-	}
-	return (b - orig_b);
-}
-
 static ssize_t
 edd_show_host_bus(struct edd_device *edev, char *buf)
 {
@@ -161,7 +128,7 @@
 	int i;
 
 	if (!edev || !info || !buf) {
-		return 0;
+		return -EINVAL;
 	}
 
 	for (i = 0; i < 4; i++) {
@@ -205,7 +172,7 @@
 	int i;
 
 	if (!edev || !info || !buf) {
-		return 0;
+		return -EINVAL;
 	}
 
 	for (i = 0; i < 8; i++) {
@@ -255,105 +222,28 @@
 }
 
 /**
- * edd_show_raw_data() - unparses EDD information, returned to user-space
+ * edd_show_raw_data() - copies raw data to buffer for userspace to parse
  *
- * Returns: number of bytes written, or 0 on failure
+ * Returns: number of bytes written, or -EINVAL on failure
  */
 static ssize_t
 edd_show_raw_data(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info = edd_dev_get_info(edev);
-	int i, warn_padding = 0, nonzero_path = 0,
-		len = sizeof (*info) - 4, found_pci=0;
-	uint8_t checksum = 0, c = 0;
-	char *p = buf;
-	struct pci_dev *pci_dev=NULL;
-	struct scsi_device *sd;
+	ssize_t len = sizeof (*info) - 4;
 	if (!edev || !info || !buf) {
-		return 0;
+		return -EINVAL;
 	}
 
 	if (!(info->params.key == 0xBEDD || info->params.key == 0xDDBE))
 		len = info->params.length;
 
-	p += snprintf(p, left, "int13 fn48 returned data:\n\n");
-	p += edd_dump_raw_data(p, left, ((char *) info) + 4, len);
-
-	/* Spec violation.  Adaptec AIC7899 returns 0xDDBE
-	   here, when it should be 0xBEDD.
-	 */
-	p += snprintf(p, left, "\n");
-	if (info->params.key == 0xDDBE) {
-		p += snprintf(p, left,
-			     "Warning: Spec violation.  Key should be 0xBEDD, is 0xDDBE\n");
-	}
+	/* In case of buggy BIOSs */
+	if (len > (sizeof(*info) - 4))
+		len = sizeof(*info) - 4;
 
-	if (!(info->params.key == 0xBEDD || info->params.key == 0xDDBE)) {
-		goto out;
-	}
-
-	for (i = 30; i <= 73; i++) {
-		c = *(((uint8_t *) info) + i + 4);
-		if (c)
-			nonzero_path++;
-		checksum += c;
-	}
-
-	if (checksum) {
-		p += snprintf(p, left,
-			     "Warning: Spec violation.  Device Path checksum invalid.\n");
-	}
-
-	if (!nonzero_path) {
-		p += snprintf(p, left, "Error: Spec violation.  Empty device path.\n");
-		goto out;
-	}
-
-	for (i = 0; i < 4; i++) {
-		if (!isprint(info->params.host_bus_type[i])) {
-			warn_padding++;
-		}
-	}
-	for (i = 0; i < 8; i++) {
-		if (!isprint(info->params.interface_type[i])) {
-			warn_padding++;
-		}
-	}
-
-	if (warn_padding) {
-		p += snprintf(p, left,
-			     "Warning: Spec violation.  Padding should be 0x20.\n");
-	}
-
-	if (edd_dev_is_type(edev, "PCI")) {
-		pci_dev = edd_get_pci_dev(edev);
-		if (!pci_dev) {
-			p += snprintf(p, left, "Error: BIOS says this is a PCI device, but the OS doesn't know\n");
-			p += snprintf(p, left, "  about a PCI device at %02x:%02x.%d\n",
-				     info->params.interface_path.pci.bus,
-				     info->params.interface_path.pci.slot,
-				     info->params.interface_path.pci.function);
-		}
-		else {
-			found_pci++;
-		}
-	}
-
-	if (found_pci && kernel_has_scsi() && edd_dev_is_type(edev, "SCSI")) {
-		sd = edd_find_matching_scsi_device(edev);
-		if (!sd) {
-			p += snprintf(p, left, "Error: BIOS says this is a SCSI device, but\n");
-			p += snprintf(p, left, "  the OS doesn't know about this SCSI device.\n");
-			p += snprintf(p, left, "  Do you have it's driver module loaded?\n");
-		}
-	}
-
-out:
-	p += snprintf(p, left, "\nPlease check %s\n", REPORT_URL);
-	p += snprintf(p, left, "to see if this device has been reported.  If not,\n");
-	p += snprintf(p, left, "please send the information requested there.\n");
-
-	return (p - buf);
+	memcpy(buf, ((char *)info) + 4, len);
+	return len;
 }
 
 static ssize_t
@@ -362,7 +252,7 @@
 	struct edd_info *info = edd_dev_get_info(edev);
 	char *p = buf;
 	if (!edev || !info || !buf) {
-		return 0;
+		return -EINVAL;
 	}
 
 	p += snprintf(p, left, "0x%02x\n", info->version);
@@ -375,7 +265,7 @@
 	struct edd_info *info = edd_dev_get_info(edev);
 	char *p = buf;
 	if (!edev || !info || !buf) {
-		return 0;
+		return -EINVAL;
 	}
 
 	if (info->interface_support & EDD_EXT_FIXED_DISK_ACCESS) {
@@ -399,7 +289,7 @@
 	struct edd_info *info = edd_dev_get_info(edev);
 	char *p = buf;
 	if (!edev || !info || !buf) {
-		return 0;
+		return -EINVAL;
 	}
 
 	if (info->params.info_flags & EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT)
@@ -427,7 +317,7 @@
 	struct edd_info *info = edd_dev_get_info(edev);
 	char *p = buf;
 	if (!edev || !info || !buf) {
-		return 0;
+		return -EINVAL;
 	}
 
 	p += snprintf(p, left, "0x%x\n", info->params.num_default_cylinders);
@@ -440,7 +330,7 @@
 	struct edd_info *info = edd_dev_get_info(edev);
 	char *p = buf;
 	if (!edev || !info || !buf) {
-		return 0;
+		return -EINVAL;
 	}
 
 	p += snprintf(p, left, "0x%x\n", info->params.num_default_heads);
@@ -453,7 +343,7 @@
 	struct edd_info *info = edd_dev_get_info(edev);
 	char *p = buf;
 	if (!edev || !info || !buf) {
-		return 0;
+		return -EINVAL;
 	}
 
 	p += snprintf(p, left, "0x%x\n", info->params.sectors_per_track);
@@ -466,7 +356,7 @@
 	struct edd_info *info = edd_dev_get_info(edev);
 	char *p = buf;
 	if (!edev || !info || !buf) {
-		return 0;
+		return -EINVAL;
 	}
 
 	p += snprintf(p, left, "0x%llx\n", info->params.number_of_sectors);
@@ -489,7 +379,7 @@
 {
 	struct edd_info *info = edd_dev_get_info(edev);
 	if (!edev || !info)
-		return 0;
+		return -EINVAL;
 	return info->params.num_default_cylinders > 0;
 }
 
@@ -498,7 +388,7 @@
 {
 	struct edd_info *info = edd_dev_get_info(edev);
 	if (!edev || !info)
-		return 0;
+		return -EINVAL;
 	return info->params.num_default_heads > 0;
 }
 
@@ -507,7 +397,7 @@
 {
 	struct edd_info *info = edd_dev_get_info(edev);
 	if (!edev || !info)
-		return 0;
+		return -EINVAL;
 	return info->params.sectors_per_track > 0;
 }
 
@@ -739,22 +629,7 @@
 	return rc;
 }
 
-static int kernel_has_scsi(void)
-{
-	return 1;
-}
-
 #else
-static int kernel_has_scsi(void)
-{
-	return 0;
-}
-
-static struct scsi_device *
-edd_find_matching_scsi_device(struct edd_device *edev)
-{
-	return NULL;
-}
 static int
 edd_create_symlink_to_scsidev(struct edd_device *edev)
 {
@@ -776,11 +651,11 @@
 	int i;
 
 	for (i = 0; (attr = edd_attrs[i]) && !error; i++) {
-		if (!attr->test || 
+		if (!attr->test ||
 		    (attr->test && attr->test(edev)))
 			error = sysfs_create_file(&edev->kobj,&attr->attr);
 	}
-	
+
 	if (!error) {
 		edd_create_symlink_to_pcidev(edev);
 		edd_create_symlink_to_scsidev(edev);
@@ -820,6 +695,7 @@
 
 	printk(KERN_INFO "BIOS EDD facility v%s, %d devices found\n",
 	       EDD_VERSION, eddnr);
+	printk(KERN_INFO "Please report your BIOS at %s\n", REPORT_URL);
 
 	if (!eddnr) {
 		printk(KERN_INFO "EDD information not available.\n");

===================================================================


This BitKeeper patch contains the following changesets:
1.1337.8.1
## Wrapped with gzip_uu ##


M'XL( &%AC#\  \U6;6_;-A#^;/V*6XIA3AI+I%XM%RG:U-EFM$L"=^VG @8M
M4980B=)(*JD'__@=J21]@3J@0S_,-GS6W>GAO3QWUA-XI[A<3/Y@6F^6;:.R
MTGD"O[=*+R8YKVLW:QM4K-L6%5[9-MQK<NOF;6\\GN=>78G^X\QWHQE>.>A[
MS716PBV7:C&A;O"HT?N.+R;KB]_>O7FY=IRS,WA5,K'C;[F&LS-'M_*6U;EZ
MP719M\+5D@G5<,U,"(='UX-/B(_OB"8!B>(#C4F8'#*:4\I"RG/BA_,X_(1F
M0G9;E==N*W=?P@244.('?A30 PGCE#A+H"X-@L2=NQ1(X%'B41\(69#Y(J(S
M$BT(@<]*]>*A1/"4PHPXY_!CLWCE9'"Q7"Y <I8K! ?)[C8YTPPUNI<"MI5@
M<@]&=0JBU5#RCWG?='@C?K9[]/NKYTI#6\!.\MU-B>I6EUQ"4XE60E9S)OI.
M.:\AC*/0N?[4%6?VG2_'(8PXST<K=& 2.5,%\]B[X5+PVI#'S6PA*"&I3V@0
MA0<:^4EX2.,X38HBV;(\*!*6?2^BZ2P6E\0^/82A'_J6;N/^AGL_/.#O10P0
M+Z#SB(3A@<S3=#Y0<?XE">.%_^\D]%.8T2CXW_%P/9"0YX:1 PU=5)^C ^K,
MJJA:8?V:]A8UO1"<Y_BCZ$6FT::@D_RV:GM5[R%C=6UL$E-^C*/M===KQ!AH
M?5=6FJN.91R*ZB-7:+B/=':QNGS_\@VT @I6&2!5MG<6U'A=RTIH].U:J:'A
M2K$=!Z;A]<7Z<K.Z_/4*:G[+:\A[=-Q!)2IM1L>2[ IF\LY^<!:NO\&W_S!5
M*QI!Z, )7..P*@Z*<RBU[A:>-^QBT]1A$9LS N))KOI:*[?430U%*\W-./10
M5\,J.%]=O56F2+B72W;+8<NYN,\:*X(-KIJNY@W'6F#C77/_JH!]VT/>BE^T
M#0&OI+*0/#^%[B$VD0-[*"!3D'.5R6IK4''K< /E+*,Y4&=EOY_DO*@$-\=L
MWE^LWZZN+N&(N)2 F8O95:9GE!XYRV0.OK.D/H4@0AF'!F$0D\F7O7WF+'UB
M3QC$F'V(8!"8')9M8WBP>2#4]!AFD+5=Q94AF66VJ<NV+PI<GEA3Z/&?<Z 8
MZCLF%4?<F%A<*Q!W;0]6"Q!]L\7[L/;;/3(3[F2E-1>G@$!?4;*7%BB&&($2
M:A)0JOJ;;S1R3\ 9F L$FIY4HFA-G*')* GLR5:,99RD0(W#/(7 F7C84(&L
MQY:9F/K=;G_/BA//F52(;LYZ#M/AL,_..CY&^,\#^2J.E$*,D0=1C V;-+S)
MNOT4RW8*TVE6,@DGQX/_4PA/34;'SYR'</$*(8(X,JD,8B25(+'-&\2(/22^
ML0]BS![8)@UBS![:4@YBS(ZI&;L58_8XM78KQNSI$%_ZC?@B0NUX6#%FIS;^
M08S8D]"'R BL#S[4)(D-9Q 3V]N?\.]#SIYK\V1P.)CALAD/XH.SFOLVM,XL
MPYOII]UW=+^![L?;; #+&K,A?U8?Q-$IK"^NK]9_;MZMWV!?'Q_^LI)G-ZIO
1SJ(@W?*$A\X_X>7RR'H*    
 

