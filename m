Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSJETe3>; Sat, 5 Oct 2002 15:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262467AbSJETe3>; Sat, 5 Oct 2002 15:34:29 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:50957 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id <S262464AbSJETeU>; Sat, 5 Oct 2002 15:34:20 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] i386/dmi_scan updates
From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 5 Oct 2002 21:41:36 CEST
Reply-To: Jean Delvare <khali@linux-fr.org>
X-Priority: 3 (Normal)
X-Originating-Ip: [172.183.206.145]
X-Mailer: Webmail Nerim (NOCC v0.9.5)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <20021005193954.10DDB62D08@mallaury.noc.nerim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have been working on Alan's userspace program "dmidecode" recently, and made some fixes to it. It happens that this userspace program shares some code with linux/arch/i386/dmi_scan.c, so I thought it would be a good idea to backport the changes that apply to the linux kernel tree. I have been writing patches for Linux 2.2, 2.4 and 2.5.

This specific patch applies to the Linux 2.5 tree and has been built against 2.5.40.

Main changes:
 - Verify the DMI entry point structure checksum.
 - Start looking for the DMI entry point from 0xF0000, not 0xE0000.
 - Fix an off-by-one error causing the last address scanned being
   0x100000, not 0xFFFF0 as it should.
 - Do not display the DMI version if it would be 0.0.
 - Remove senseless tests in dump (debug) code.

Other changes are simple cleanups and should be straightforward to understand.

All comments are of course welcome.

--- linux-2.5.40/arch/i386/kernel/dmi_scan.c.orig	Sun Sep 22 06:25:06 2002
+++ linux-2.5.40/arch/i386/kernel/dmi_scan.c	Thu Oct  3 22:58:07 2002
@@ -59,7 +59,7 @@
 	data = buf;
 
 	/*
- 	 *	Stop when we see al the items the table claimed to have
+ 	 *	Stop when we see all the items the table claimed to have
  	 *	OR we run off the end of the table (also happens)
  	 */
  
@@ -89,11 +89,20 @@
 }
 
 
+inline static int __init dmi_checksum(u8 *buf)
+{
+	u8 sum=0;
+	int a;
+	
+	for(a=0; a<15; a++)
+		sum+=buf[a];
+	return (sum==0);
+}
+
 static int __init dmi_iterate(void (*decode)(struct dmi_header *))
 {
-	unsigned char buf[20];
-	long fp=0xE0000L;
-	fp -= 16;
+	u8 buf[15];
+	u32 fp=0xF0000;
 
 #ifdef CONFIG_SIMNOW
 	/*
@@ -105,24 +114,30 @@
  	
 	while( fp < 0xFFFFF)
 	{
-		fp+=16;
-		isa_memcpy_fromio(buf, fp, 20);
-		if(memcmp(buf, "_DMI_", 5)==0)
+		isa_memcpy_fromio(buf, fp, 15);
+		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
 		{
 			u16 num=buf[13]<<8|buf[12];
 			u16 len=buf[7]<<8|buf[6];
 			u32 base=buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8];
 
-			dmi_printk((KERN_INFO "DMI %d.%d present.\n",
-				buf[14]>>4, buf[14]&0x0F));
+			/*
+			 * DMI version 0.0 means that the real version is taken from
+			 * the SMBIOS version, which we don't know at this point.
+			 */
+			if(buf[14]!=0)
+				dmi_printk((KERN_INFO "DMI %d.%d present.\n",
+					buf[14]>>4, buf[14]&0x0F));
+			else
+				dmi_printk((KERN_INFO "DMI present.\n"));
 			dmi_printk((KERN_INFO "%d structures occupying %d bytes.\n",
-				buf[13]<<8|buf[12],
-				buf[7]<<8|buf[6]));
+				num, len));
 			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n",
-				buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8]));
+				base));
 			if(dmi_table(base,len, num, decode)==0)
 				return 0;
 		}
+		fp+=16;
 	}
 	return -1;
 }
@@ -800,59 +815,43 @@
 static void __init dmi_decode(struct dmi_header *dm)
 {
 	u8 *data = (u8 *)dm;
-	char *p;
 	
 	switch(dm->type)
 	{
 		case  0:
-			p=dmi_string(dm,data[4]);
-			if(*p)
-			{
-				dmi_printk(("BIOS Vendor: %s\n", p));
-				dmi_save_ident(dm, DMI_BIOS_VENDOR, 4);
-				dmi_printk(("BIOS Version: %s\n", 
-					dmi_string(dm, data[5])));
-				dmi_save_ident(dm, DMI_BIOS_VERSION, 5);
-				dmi_printk(("BIOS Release: %s\n",
-					dmi_string(dm, data[8])));
-				dmi_save_ident(dm, DMI_BIOS_DATE, 8);
-			}
+			dmi_printk(("BIOS Vendor: %s\n",
+				dmi_string(dm, data[4])));
+			dmi_save_ident(dm, DMI_BIOS_VENDOR, 4);
+			dmi_printk(("BIOS Version: %s\n", 
+				dmi_string(dm, data[5])));
+			dmi_save_ident(dm, DMI_BIOS_VERSION, 5);
+			dmi_printk(("BIOS Release: %s\n",
+				dmi_string(dm, data[8])));
+			dmi_save_ident(dm, DMI_BIOS_DATE, 8);
 			break;
-			
 		case 1:
-			p=dmi_string(dm,data[4]);
-			if(*p)
-			{
-				dmi_printk(("System Vendor: %s.\n",p));
-				dmi_save_ident(dm, DMI_SYS_VENDOR, 4);
-				dmi_printk(("Product Name: %s.\n",
-					dmi_string(dm, data[5])));
-				dmi_save_ident(dm, DMI_PRODUCT_NAME, 5);
-				dmi_printk(("Version %s.\n",
-					dmi_string(dm, data[6])));
-				dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
-				dmi_printk(("Serial Number %s.\n",
-					dmi_string(dm, data[7])));
-			}
+			dmi_printk(("System Vendor: %s\n",
+				dmi_string(dm, data[4])));
+			dmi_save_ident(dm, DMI_SYS_VENDOR, 4);
+			dmi_printk(("Product Name: %s\n",
+				dmi_string(dm, data[5])));
+			dmi_save_ident(dm, DMI_PRODUCT_NAME, 5);
+			dmi_printk(("Version: %s\n",
+				dmi_string(dm, data[6])));
+			dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
+			dmi_printk(("Serial Number: %s\n",
+				dmi_string(dm, data[7])));
 			break;
 		case 2:
-			p=dmi_string(dm,data[4]);
-			if(*p)
-			{
-				dmi_printk(("Board Vendor: %s.\n",p));
-				dmi_save_ident(dm, DMI_BOARD_VENDOR, 4);
-				dmi_printk(("Board Name: %s.\n",
-					dmi_string(dm, data[5])));
-				dmi_save_ident(dm, DMI_BOARD_NAME, 5);
-				dmi_printk(("Board Version: %s.\n",
-					dmi_string(dm, data[6])));
-				dmi_save_ident(dm, DMI_BOARD_VERSION, 6);
-			}
-			break;
-		case 3:
-			p=dmi_string(dm,data[8]);
-			if(*p && *p!=' ')
-				dmi_printk(("Asset Tag: %s.\n", p));
+			dmi_printk(("Board Vendor: %s\n",
+				dmi_string(dm, data[4])));
+			dmi_save_ident(dm, DMI_BOARD_VENDOR, 4);
+			dmi_printk(("Board Name: %s\n",
+				dmi_string(dm, data[5])));
+			dmi_save_ident(dm, DMI_BOARD_NAME, 5);
+			dmi_printk(("Board Version: %s\n",
+				dmi_string(dm, data[6])));
+			dmi_save_ident(dm, DMI_BOARD_VERSION, 6);
 			break;
 	}
 }


___________________________________
Webmail Nerim, http://www.nerim.net/


