Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVENMt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVENMt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 08:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVENMsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 08:48:23 -0400
Received: from mail.donpac.ru ([80.254.111.2]:7075 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S262757AbVENMo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 08:44:57 -0400
Subject: [PATCH 2.6.12-rc4-mm1 3/3] DMI code spring cleanup
In-Reply-To: <11160746964048@donpac.ru>
Date: Sat, 14 May 2005 16:44:56 +0400
Message-Id: <11160746963933@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whitespace and CodingStyle cleanup. No functionality changes.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |  163 ++++++++++++++++++--------------------------
 1 files changed, 70 insertions(+), 93 deletions(-)

diff -urdpNX dontdiff linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.12-rc4-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/dmi_scan.c	2005-05-04 15:54:52.000000000 +0400
+++ linux-2.6.12-rc4-mm1/arch/i386/kernel/dmi_scan.c	2005-05-04 15:59:08.000000000 +0400
@@ -1,22 +1,15 @@
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/acpi.h>
-#include <asm/io.h>
-#include <linux/pm.h>
-#include <asm/system.h>
 #include <linux/dmi.h>
 #include <linux/bootmem.h>
 
 
-struct dmi_header
-{
-	u8	type;
-	u8	length;
-	u16	handle;
+struct dmi_header {
+	u8 type;
+	u8 length;
+	u16 handle;
 };
 
 #undef DMI_DEBUG
@@ -29,15 +22,13 @@ struct dmi_header
 
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
-	u8 *bp=(u8 *)dm;
-	bp+=dm->length;
-	if(!s)
+	u8 *bp = ((u8 *) dm) + dm->length;
+
+	if (!s)
 		return "";
 	s--;
-	while(s>0 && *bp)
-	{
-		bp+=strlen(bp);
-		bp++;
+	while (s > 0 && *bp) {
+		bp += strlen(bp) + 1;
 		s--;
 	}
 	return bp;
@@ -47,16 +38,14 @@ static char * __init dmi_string(struct d
  *	We have to be cautious here. We have seen BIOSes with DMI pointers
  *	pointing to completely the wrong place for example
  */
- 
-static int __init dmi_table(u32 base, int len, int num, void (*decode)(struct dmi_header *))
+static int __init dmi_table(u32 base, int len, int num,
+			    void (*decode)(struct dmi_header *))
 {
-	u8 *buf;
-	struct dmi_header *dm;
-	u8 *data;
-	int i=0;
+	u8 *buf, *data;
+	int i = 0;
 		
 	buf = bt_ioremap(base, len);
-	if(buf==NULL)
+	if (buf == NULL)
 		return -1;
 
 	data = buf;
@@ -65,36 +54,34 @@ static int __init dmi_table(u32 base, in
  	 *	Stop when we see all the items the table claimed to have
  	 *	OR we run off the end of the table (also happens)
  	 */
- 
-	while(i<num && data-buf+sizeof(struct dmi_header)<=len)
-	{
-		dm=(struct dmi_header *)data;
+	while ((i < num) && (data - buf + sizeof(struct dmi_header)) <= len) {
+		struct dmi_header *dm = (struct dmi_header *)data;
 		/*
 		 *  We want to know the total length (formated area and strings)
 		 *  before decoding to make sure we won't run off the table in
 		 *  dmi_decode or dmi_string
 		 */
-		data+=dm->length;
-		while(data-buf<len-1 && (data[0] || data[1]))
+		data += dm->length;
+		while ((data - buf < len - 1) && (data[0] || data[1]))
 			data++;
-		if(data-buf<len-1)
+		if (data - buf < len - 1)
 			decode(dm);
-		data+=2;
+		data += 2;
 		i++;
 	}
 	bt_iounmap(buf, len);
 	return 0;
 }
 
-
-inline static int __init dmi_checksum(u8 *buf)
+static int __init dmi_checksum(u8 *buf)
 {
-	u8 sum=0;
+	u8 sum = 0;
 	int a;
 	
-	for(a=0; a<15; a++)
-		sum+=buf[a];
-	return (sum==0);
+	for (a = 0; a < 15; a++)
+		sum += buf[a];
+
+	return sum == 0;
 }
 
 static int __init dmi_iterate(void (*decode)(struct dmi_header *))
@@ -110,28 +97,30 @@ static int __init dmi_iterate(void (*dec
 	p = ioremap(0xF0000, 0x10000);
 	if (p == NULL)
 		return -1;
+
 	for (q = p; q < p + 0x10000; q += 16) {
 		memcpy_fromio(buf, q, 15);
-		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
-		{
-			u16 num=buf[13]<<8|buf[12];
-			u16 len=buf[7]<<8|buf[6];
-			u32 base=buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8];
+		if ((memcmp(buf, "_DMI_", 5) == 0) && dmi_checksum(buf)) {
+			u16 num = (buf[13] << 8) | buf[12];
+			u16 len = (buf[7] << 8) | buf[6];
+			u32 base = (buf[11] << 24) | (buf[10] << 16) |
+				   (buf[9] << 8) | buf[8];
 
 			/*
 			 * DMI version 0.0 means that the real version is taken from
 			 * the SMBIOS version, which we don't know at this point.
 			 */
-			if(buf[14]!=0)
+			if (buf[14] != 0)
 				printk(KERN_INFO "DMI %d.%d present.\n",
-					buf[14]>>4, buf[14]&0x0F);
+					buf[14] >> 4, buf[14] & 0xF);
 			else
 				printk(KERN_INFO "DMI present.\n");
+
 			dmi_printk((KERN_INFO "%d structures occupying %d bytes.\n",
 				num, len));
-			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n",
-				base));
-			if(dmi_table(base,len, num, decode)==0)
+			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n", base));
+
+			if (dmi_table(base,len, num, decode) == 0)
 				return 0;
 		}
 	}
@@ -143,16 +132,17 @@ static char *dmi_ident[DMI_STRING_MAX];
 /*
  *	Save a DMI string
  */
- 
 static void __init dmi_save_ident(struct dmi_header *dm, int slot, int string)
 {
 	char *d = (char*)dm;
 	char *p = dmi_string(dm, d[string]);
-	if(p==NULL || *p == 0)
+
+	if (p == NULL || *p == 0)
 		return;
 	if (dmi_ident[slot])
 		return;
-	dmi_ident[slot] = alloc_bootmem(strlen(p)+1);
+
+	dmi_ident[slot] = alloc_bootmem(strlen(p) + 1);
 	if(dmi_ident[slot])
 		strcpy(dmi_ident[slot], p);
 	else
@@ -166,48 +156,35 @@ static void __init dmi_save_ident(struct
  */
 static void __init dmi_decode(struct dmi_header *dm)
 {
-#ifdef DMI_DEBUG
-	u8 *data = (u8 *)dm;
-#endif
+	u8 *data __attribute__((__unused__)) = (u8 *)dm;
 	
-	switch(dm->type)
-	{
-		case  0:
-			dmi_printk(("BIOS Vendor: %s\n",
-				dmi_string(dm, data[4])));
-			dmi_save_ident(dm, DMI_BIOS_VENDOR, 4);
-			dmi_printk(("BIOS Version: %s\n", 
-				dmi_string(dm, data[5])));
-			dmi_save_ident(dm, DMI_BIOS_VERSION, 5);
-			dmi_printk(("BIOS Release: %s\n",
-				dmi_string(dm, data[8])));
-			dmi_save_ident(dm, DMI_BIOS_DATE, 8);
-			break;
-		case 1:
-			dmi_printk(("System Vendor: %s\n",
-				dmi_string(dm, data[4])));
-			dmi_save_ident(dm, DMI_SYS_VENDOR, 4);
-			dmi_printk(("Product Name: %s\n",
-				dmi_string(dm, data[5])));
-			dmi_save_ident(dm, DMI_PRODUCT_NAME, 5);
-			dmi_printk(("Version: %s\n",
-				dmi_string(dm, data[6])));
-			dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
-			dmi_printk(("Serial Number: %s\n",
-				dmi_string(dm, data[7])));
-			dmi_save_ident(dm, DMI_PRODUCT_SERIAL, 7);
-			break;
-		case 2:
-			dmi_printk(("Board Vendor: %s\n",
-				dmi_string(dm, data[4])));
-			dmi_save_ident(dm, DMI_BOARD_VENDOR, 4);
-			dmi_printk(("Board Name: %s\n",
-				dmi_string(dm, data[5])));
-			dmi_save_ident(dm, DMI_BOARD_NAME, 5);
-			dmi_printk(("Board Version: %s\n",
-				dmi_string(dm, data[6])));
-			dmi_save_ident(dm, DMI_BOARD_VERSION, 6);
-			break;
+	switch(dm->type) {
+	case  0:
+		dmi_printk(("BIOS Vendor: %s\n", dmi_string(dm, data[4])));
+		dmi_save_ident(dm, DMI_BIOS_VENDOR, 4);
+		dmi_printk(("BIOS Version: %s\n", dmi_string(dm, data[5])));
+		dmi_save_ident(dm, DMI_BIOS_VERSION, 5);
+		dmi_printk(("BIOS Release: %s\n", dmi_string(dm, data[8])));
+		dmi_save_ident(dm, DMI_BIOS_DATE, 8);
+		break;
+	case 1:
+		dmi_printk(("System Vendor: %s\n", dmi_string(dm, data[4])));
+		dmi_save_ident(dm, DMI_SYS_VENDOR, 4);
+		dmi_printk(("Product Name: %s\n", dmi_string(dm, data[5])));
+		dmi_save_ident(dm, DMI_PRODUCT_NAME, 5);
+		dmi_printk(("Version: %s\n", dmi_string(dm, data[6])));
+		dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
+		dmi_printk(("Serial Number: %s\n", dmi_string(dm, data[7])));
+		dmi_save_ident(dm, DMI_PRODUCT_SERIAL, 7);
+		break;
+	case 2:
+		dmi_printk(("Board Vendor: %s\n", dmi_string(dm, data[4])));
+		dmi_save_ident(dm, DMI_BOARD_VENDOR, 4);
+		dmi_printk(("Board Name: %s\n", dmi_string(dm, data[5])));
+		dmi_save_ident(dm, DMI_BOARD_NAME, 5);
+		dmi_printk(("Board Version: %s\n", dmi_string(dm, data[6])));
+		dmi_save_ident(dm, DMI_BOARD_VERSION, 6);
+		break;
 	}
 }
 

