Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSJET3j>; Sat, 5 Oct 2002 15:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbSJET3i>; Sat, 5 Oct 2002 15:29:38 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:46349 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id <S262457AbSJET3d>; Sat, 5 Oct 2002 15:29:33 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.2] i386/dmi_scan updates
From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 5 Oct 2002 21:36:49 CEST
Reply-To: Jean Delvare <khali@linux-fr.org>
X-Priority: 3 (Normal)
X-Originating-Ip: [172.183.206.145]
X-Mailer: Webmail Nerim (NOCC v0.9.5)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <20021005193506.641E162D05@mallaury.noc.nerim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have been working on Alan's userspace program "dmidecode" recently, and made some fixes to it. It happens that this userspace program shares some code with linux/arch/i386/dmi_scan.c, so I thought it would be a good idea to backport the changes that apply to the linux kernel tree. I have been writing patches for Linux 2.2, 2.4 and 2.5.

This specific patch applies to the Linux 2.2 tree and has been built against 2.2.22.

Main changes:
 - Stop skipping DMI entries when type is less than those of the
   previous entry. I could see no reason for doing this.
 - Verify the DMI entry point structure checksum.
 - Start looking for the DMI entry point from 0xF0000, not 0xE0000.
 - Fix an off-by-one error causing the last address scanned being
   0x100000, not 0xFFFF0 as it should.
 - Do not display the DMI version if it would be 0.0.
 - Remove senseless tests in dump (debug) code.

Other changes are simple cleanups and should be straightforward to understand.

All comments are of course welcome.

--- linux-2.2.22/arch/i386/kernel/dmi_scan.c.orig	Sun Mar 25 18:37:29 2001
+++ linux-2.2.22/arch/i386/kernel/dmi_scan.c	Wed Oct  2 14:43:22 2002
@@ -32,7 +32,6 @@
 	struct dmi_header *dm;
 	u8 *data;
 	int i=1;
-	int last = 0;		
 		
 	buf = ioremap(base, len);
 	if(buf==NULL)
@@ -42,9 +41,6 @@
 	while(i<num && (data-buf) < len)
 	{
 		dm=(struct dmi_header *)data;
-		if(dm->type < last)
-			break;
-		last = dm->type;
 		decode(dm);		
 		data+=dm->length;
 		while(*data || data[1])
@@ -57,33 +53,48 @@
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
@@ -98,21 +109,17 @@
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
@@ -142,35 +149,22 @@
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


