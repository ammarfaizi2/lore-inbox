Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUE1MAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUE1MAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUE1MAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:00:24 -0400
Received: from mail.donpac.ru ([80.254.111.2]:37556 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262208AbUE1Lzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:55:33 -0400
Subject: [PATCH 2/13] 2.6.7-rc1-mm1, Codingstyle and whitespace cleanups
In-Reply-To: <10857453263122@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:55:30 +0400
Message-Id: <10857453302190@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

various coding style and whitespace cleanups.

diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:26:44 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:27:02 2004
@@ -22,9 +22,9 @@ int es7000_plat = 0;
 
 struct dmi_header
 {
-	u8	type;
-	u8	length;
-	u16	handle;
+	u8 type;
+	u8 length;
+	u16 handle;
 };
 
 #undef DMI_DEBUG
@@ -37,15 +37,14 @@ struct dmi_header
 
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
+
+	while (s > 0 && *bp) {
+		bp += strlen(bp) + 1;
 		s--;
 	}
 	return bp;
@@ -58,13 +57,12 @@ static char * __init dmi_string(struct d
  
 static int __init dmi_table(u32 base, int len, int num, void (*decode)(struct dmi_header *))
 {
-	u8 *buf;
+	u8 *buf, *data;
 	struct dmi_header *dm;
-	u8 *data;
-	int i=0;
+	int i = 0;
 		
 	buf = bt_ioremap(base, len);
-	if(buf==NULL)
+	if (buf == NULL)
 		return -1;
 
 	data = buf;
@@ -74,20 +72,19 @@ static int __init dmi_table(u32 base, in
  	 *	OR we run off the end of the table (also happens)
  	 */
  
-	while(i<num && data-buf+sizeof(struct dmi_header)<=len)
-	{
-		dm=(struct dmi_header *)data;
+	while ((i < num) && ((data-buf + sizeof(struct dmi_header)) <= len)) {
+		dm = (struct dmi_header *) data;
 		/*
 		 *  We want to know the total length (formated area and strings)
 		 *  before decoding to make sure we won't run off the table in
 		 *  dmi_decode or dmi_string
 		 */
-		data+=dm->length;
-		while(data-buf<len-1 && (data[0] || data[1]))
+		data += dm->length;
+		while (((data - buf) < (len - 1)) && (data[0] || data[1]))
 			data++;
-		if(data-buf<len-1)
+		if ((data - buf) < (len - 1))
 			decode(dm);
-		data+=2;
+		data += 2;
 		i++;
 	}
 	bt_iounmap(buf, len);
@@ -95,47 +92,46 @@ static int __init dmi_table(u32 base, in
 }
 
 
-inline static int __init dmi_checksum(u8 *buf)
+static inline int dmi_checksum(u8 *buf)
 {
-	u8 sum=0;
-	int a;
-	
-	for(a=0; a<15; a++)
-		sum+=buf[a];
-	return (sum==0);
+	u8 sum = 0;
+	int a = 16;
+
+	for ( ; --a; )
+		sum += *buf++;
+
+	return sum == 0;
 }
 
 static int __init dmi_iterate(void (*decode)(struct dmi_header *))
 {
 	u8 buf[15];
-	u32 fp=0xF0000;
+	u32 fp = 0xF0000;
 
-	while (fp < 0xFFFFF)
-	{
+	while (fp < 0xFFFFF) {
 		isa_memcpy_fromio(buf, fp, 15);
-		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
-		{
-			u16 num=buf[13]<<8|buf[12];
-			u16 len=buf[7]<<8|buf[6];
-			u32 base=buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8];
+		if ((memcmp(buf, "_DMI_", 5) == 0) && dmi_checksum(buf)) {
+			u16 len = readw(buf + 6);
+			u32 base = readl(buf + 8);
+			u16 num = readw(buf + 12);
 
 			/*
 			 * DMI version 0.0 means that the real version is taken from
 			 * the SMBIOS version, which we don't know at this point.
 			 */
-			if(buf[14]!=0)
+			if (buf[14] != 0)
 				printk(KERN_INFO "DMI %d.%d present.\n",
-					buf[14]>>4, buf[14]&0x0F);
+					buf[14] >> 4, buf[14] & 0x0F);
 			else
 				printk(KERN_INFO "DMI present.\n");
 			dmi_printk((KERN_INFO "%d structures occupying %d bytes.\n",
 				num, len));
 			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n",
 				base));
-			if(dmi_table(base,len, num, decode)==0)
+			if (!dmi_table(base, len, num, decode))
 				return 0;
 		}
-		fp+=16;
+		fp += 16;
 	}
 	return -1;
 }
@@ -150,12 +146,13 @@ static void __init dmi_save_ident(struct
 {
 	char *d = (char*)dm;
 	char *p = dmi_string(dm, d[string]);
-	if(p==NULL || *p == 0)
+
+	if (!p || !*p)
 		return;
 	if (dmi_ident[slot])
 		return;
-	dmi_ident[slot] = alloc_bootmem(strlen(p)+1);
-	if(dmi_ident[slot])
+	dmi_ident[slot] = alloc_bootmem(strlen(p) + 1);
+	if (dmi_ident[slot])
 		strcpy(dmi_ident[slot], p);
 	else
 		printk(KERN_ERR "dmi_save_ident: out of memory.\n");
@@ -1054,25 +1051,23 @@ static __init void dmi_check_blacklist(v
 #ifdef	CONFIG_ACPI_BOOT
 #define	ACPI_BLACKLIST_CUTOFF_YEAR	2001
 
-	if (dmi_ident[DMI_BIOS_DATE]) { 
-		char *s = strrchr(dmi_ident[DMI_BIOS_DATE], '/'); 
-		if (s) { 
-			int year, disable = 0;
-			s++; 
-			year = simple_strtoul(s,NULL,0); 
-			if (year >= 1000) 
-				disable = year < ACPI_BLACKLIST_CUTOFF_YEAR; 
+	if (dmi_ident[DMI_BIOS_DATE]) {
+		char *s = strrchr(dmi_ident[DMI_BIOS_DATE], '/');
+		if (s) {
+			int disable = 0, year = simple_strtoul(++s, NULL, 0);
+
+			if (year >= 1000)
+				disable = year < ACPI_BLACKLIST_CUTOFF_YEAR;
 			else if (year < 1 || (year > 90 && year <= 99))
-				disable = 1; 
-			if (disable && !acpi_force) { 
+				disable = 1;
+			if (disable && !acpi_force) {
 				printk(KERN_NOTICE "ACPI disabled because your bios is from %s and too old\n", s);
 				printk(KERN_NOTICE "You can enable it with acpi=force\n");
 				disable_acpi();
-			} 
+			}
 		}
 	}
 #endif
-
 	dmi_check_system(dmi_blacklist);
 }
 
@@ -1132,8 +1127,7 @@ static void __init dmi_decode(struct dmi
 
 void __init dmi_scan_machine(void)
 {
-	int err = dmi_iterate(dmi_decode);
-	if(err == 0)
+	if (!dmi_iterate(dmi_decode))
 		dmi_check_blacklist();
 	else
 		printk(KERN_INFO "DMI not present.\n");

