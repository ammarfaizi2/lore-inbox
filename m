Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262953AbSJGJZg>; Mon, 7 Oct 2002 05:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262955AbSJGJZg>; Mon, 7 Oct 2002 05:25:36 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:60421 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id <S262953AbSJGJZc>; Mon, 7 Oct 2002 05:25:32 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.2] i386/dmi_scan updates v.2
From: Jean Delvare <khali@linux-fr.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 7 Oct 2002 11:32:48 CEST
Reply-To: Jean Delvare <khali@linux-fr.org>
X-Priority: 3 (Normal)
X-Originating-Ip: [172.181.24.115]
X-Mailer: Webmail Nerim (NOCC v0.9.5)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <20021007093110.2D68062E3C@mallaury.noc.nerim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I made the changes Alan asked for to my patch for i386/dmi_scan.

This patch applies to the Linux 2.2 tree and has been built against
2.2.22. I will port it to 2.4 and 2.5 once accepted for 2.2.

Features:
 - Ensure that dmi_string always return a null-terminated string.
 - Fix an off-by-one error causing the last entry of the DMI table
   not to be decoded.
 - Stop skipping DMI entries when type is less than those of the
   previous entry.
 - Ensure we don't run off the table in dmi_table. Call dmi_decode only
   if the whole entry (formated area and strings) fits in the table.
 - Verify the DMI entry point structure checksum.
 - Start looking for the DMI entry point from 0xF0000, not 0xE0000.
 - Fix an off-by-one error causing the last address scanned to be
   0x100000, not 0xFFFF0 as it should.
 - Do not display the DMI version if it would be 0.0.
 - Remove now senseless tests in dump (debug) code.

Other changes are simple cleanups and should be straightforward to
understand.

Some numbers:
  source code: +216 bytes
  binary w/o debug: +108 bytes
  binary w/ debug: -44 bytes

All comments are of course welcome.

--- linux-2.2.22/arch/i386/kernel/dmi_scan.c.orig	Sun Mar 25 18:37:29 2001
+++ linux-2.2.22/arch/i386/kernel/dmi_scan.c	Mon Oct  7 09:23:22 2002
@@ -15,9 +15,11 @@
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
 	u8 *bp=(u8 *)dm;
+	if(!s)
+		return "";
 	bp+=dm->length;
 	s--;
-	while(s>0)
+	while(s>0 && *bp)
 	{
 		bp+=strlen(bp);
 		bp++;
@@ -31,24 +33,26 @@
 	u8 *buf;
 	struct dmi_header *dm;
 	u8 *data;
-	int i=1;
-	int last = 0;		
+	int i=0;
 		
 	buf = ioremap(base, len);
 	if(buf==NULL)
 		return -1;
 
 	data = buf;
-	while(i<num && (data-buf) < len)
+	while(i<num && data-buf+sizeof(struct dmi_header)<=len)
 	{
 		dm=(struct dmi_header *)data;
-		if(dm->type < last)
-			break;
-		last = dm->type;
-		decode(dm);		
+		/*
+		 *  We want to know the total length (formated area and strings)
+		 *  before decoding to make sure we won't run off the table in
+		 *  dmi_decode or dmi_string
+		 */
 		data+=dm->length;
-		while(*data || data[1])
+		while(data-buf<len-1 && (data[0] || data[1]))
 			data++;
+		if(data-buf<len-1)
+			decode(dm);
 		data+=2;
 		i++;
 	}
@@ -57,33 +61,48 @@
 }
 
 
+inline int __init dmi_checksum(u8 *buf)
+{
+	u8 sum=0;
+	int a;
+	
+	for(a=0; a<15; a++)
+		sum+=buf[a];
+	return (sum==0);
+}
+
 int __init dmi_iterate(void (*decode)(struct dmi_header *))
 {
-	unsigned char buf[20];
-	long fp=0xE0000L;
-	fp -= 16;
+	u8 buf[15];
+	u32 fp=0xF0000;
 	
 	while( fp < 0xFFFFF)
 	{
-		fp+=16;
-		memcpy_fromio(buf, fp, 20);
-		if(memcmp(buf, "_DMI_", 5)==0)
+		memcpy_fromio(buf, fp, 15);
+		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
 		{
 			u16 num=buf[13]<<8|buf[12];
 			u16 len=buf[7]<<8|buf[6];
 			u32 base=buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8];
 #ifdef DUMP_DMI
-			printk(KERN_INFO "DMI %d.%d present.\n",
-				buf[14]>>4, buf[14]&0x0F);
+			/*
+			 * DMI version 0.0 means that the real version is taken from
+			 * the SMBIOS version, which we don't know at this point.
+			 */
+			if(buf[14]!=0)
+				printk(KERN_INFO "DMI %u.%u present.\n",
+					buf[14]>>4, buf[14]&0x0F);
+			else
+				printk(KERN_INFO "DMI present.\n");
 			printk(KERN_INFO "%d structures occupying %d bytes.\n",
-				buf[13]<<8|buf[12],
-				buf[7]<<8|buf[6]);
+				num, len);
 			printk(KERN_INFO "DMI table at 0x%08X.\n",
-				buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8]);
+				base);
 #endif				
 			if(dmi_table(base,len, num, decode)==0)
 				return 0;
 		}
+		fp+=16;
 	}
 	return -1;
 }
@@ -98,21 +117,17 @@
 static void __init dmi_decode(struct dmi_header *dm)
 {
 	u8 *data = (u8 *)dm;
-	char *p;
 	
 	switch(dm->type)
 	{
 		case  0:		
 #ifdef DUMP_DMI
-			p=dmi_string(dm,data[4]);
-			if(*p && *p!=' ')
-			{
-				printk("BIOS Vendor: %s\n", p);
-				printk("BIOS Version: %s\n", 
-					dmi_string(dm, data[5]));
-				printk("BIOS Release: %s\n",
-					dmi_string(dm, data[8]));
-			}
+			printk("BIOS Vendor: %s\n",
+				dmi_string(dm, data[4]));
+			printk("BIOS Version: %s\n", 
+				dmi_string(dm, data[5]));
+			printk("BIOS Release: %s\n",
+				dmi_string(dm, data[8]));
 #endif				
 			/*
 			 *  Check for clue free BIOS implementations who use
@@ -142,35 +157,22 @@
 			break;
 #ifdef DUMP_DMI
 		case 1:
-			p=dmi_string(dm,data[4]);
-
-			if(*p && *p!=' ')
-			{
-				printk("System Vendor: %s.\n",p);
-				printk("Product Name: %s.\n",
-					dmi_string(dm, data[5]));
-				printk("Version %s.\n",
-					dmi_string(dm, data[6]));
-				printk("Serial Number %s.\n",
-					dmi_string(dm, data[7]));
-			}
+			printk("System Vendor: %s\n",
+				dmi_string(dm, data[4]));
+			printk("Product Name: %s\n",
+				dmi_string(dm, data[5]));
+			printk("Version: %s\n",
+				dmi_string(dm, data[6]));
+			printk("Serial Number: %s\n",
+				dmi_string(dm, data[7]));
 			break;
 		case 2:
-			p=dmi_string(dm,data[4]);
-
-			if(*p && *p!=' ')
-			{
-				printk("Board Vendor: %s.\n",p);
-				printk("Board Name: %s.\n",
+			printk("Board Vendor: %s\n",
+				dmi_string(dm, data[4]));
+			printk("Board Name: %s\n",
 				dmi_string(dm, data[5]));
-				printk("Board Version: %s.\n",
-					dmi_string(dm, data[6]));
-			}
-			break;
-		case 3:
-			p=dmi_string(dm,data[8]);
-			if(*p && *p!=' ')
-				printk("Asset Tag: %s.\n", p);
+			printk("Board Version: %s\n",
+				dmi_string(dm, data[6]));
 			break;
 #endif			
 	}


___________________________________
Webmail Nerim, http://www.nerim.net/


