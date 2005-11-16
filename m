Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965222AbVKPDuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbVKPDuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbVKPDuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:50:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:26782 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965222AbVKPDuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:50:23 -0500
To: torvalds@osdl.org
Subject: [PATCH 1/8] isaectomy: toshiba.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EcEJS-0007dd-7b@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 16 Nov 2005 03:50:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1132110323 -0500

switch from isa_read...() to ioremap() and read...()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 drivers/char/toshiba.c |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

0bb582c17832859733b3dd6d408f64234cccf860
diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
--- a/drivers/char/toshiba.c
+++ b/drivers/char/toshiba.c
@@ -355,14 +355,14 @@ static void tosh_set_fn_port(void)
 /*
  * Get the machine identification number of the current model
  */
-static int tosh_get_machine_id(void)
+static int tosh_get_machine_id(void __iomem *bios)
 {
 	int id;
 	SMMRegisters regs;
 	unsigned short bx,cx;
 	unsigned long address;
 
-	id = (0x100*(int) isa_readb(0xffffe))+((int) isa_readb(0xffffa));
+	id = (0x100*(int) readb(bios+0xfffe))+((int) readb(bios+0xfffa));
 
 	/* do we have a SCTTable machine identication number on our hands */
 
@@ -388,12 +388,12 @@ static int tosh_get_machine_id(void)
 
 		/* now twiddle with our pointer a bit */
 
-		address = 0x000f0000+bx;
-		cx = isa_readw(address);
-		address = 0x000f0009+bx+cx;
-		cx = isa_readw(address);
-		address = 0x000f000a+cx;
-		cx = isa_readw(address);
+		address = bx;
+		cx = readw(bios + address);
+		address = 9+bx+cx;
+		cx = readw(bios + address);
+		address = 0xa+cx;
+		cx = readw(bios + address);
 
 		/* now construct our machine identification number */
 
@@ -416,13 +416,18 @@ static int tosh_probe(void)
 	int i,major,minor,day,year,month,flag;
 	unsigned char signature[7] = { 0x54,0x4f,0x53,0x48,0x49,0x42,0x41 };
 	SMMRegisters regs;
+	void __iomem *bios = ioremap(0xf0000, 0x10000);
+
+	if (!bios)
+		return -ENOMEM;
 
 	/* extra sanity check for the string "TOSHIBA" in the BIOS because
 	   some machines that are not Toshiba's pass the next test */
 
 	for (i=0;i<7;i++) {
-		if (isa_readb(0xfe010+i)!=signature[i]) {
+		if (readb(bios+0xe010+i)!=signature[i]) {
 			printk("toshiba: not a supported Toshiba laptop\n");
+			iounmap(bios);
 			return -ENODEV;
 		}
 	}
@@ -438,6 +443,7 @@ static int tosh_probe(void)
 
 	if ((flag==1) || ((regs.eax & 0xff00)==0x8600)) {
 		printk("toshiba: not a supported Toshiba laptop\n");
+		iounmap(bios);
 		return -ENODEV;
 	}
 
@@ -447,19 +453,19 @@ static int tosh_probe(void)
 
 	/* next get the machine ID of the current laptop */
 
-	tosh_id = tosh_get_machine_id();
+	tosh_id = tosh_get_machine_id(bios);
 
 	/* get the BIOS version */
 
-	major = isa_readb(0xfe009)-'0';
-	minor = ((isa_readb(0xfe00b)-'0')*10)+(isa_readb(0xfe00c)-'0');
+	major = readb(bios+0xe009)-'0';
+	minor = ((readb(bios+0xe00b)-'0')*10)+(readb(bios+0xe00c)-'0');
 	tosh_bios = (major*0x100)+minor;
 
 	/* get the BIOS date */
 
-	day = ((isa_readb(0xffff5)-'0')*10)+(isa_readb(0xffff6)-'0');
-	month = ((isa_readb(0xffff8)-'0')*10)+(isa_readb(0xffff9)-'0');
-	year = ((isa_readb(0xffffb)-'0')*10)+(isa_readb(0xffffc)-'0');
+	day = ((readb(bios+0xfff5)-'0')*10)+(readb(bios+0xfff6)-'0');
+	month = ((readb(bios+0xfff8)-'0')*10)+(readb(bios+0xfff9)-'0');
+	year = ((readb(bios+0xfffb)-'0')*10)+(readb(bios+0xfffc)-'0');
 	tosh_date = (((year-90) & 0x1f)<<10) | ((month & 0xf)<<6)
 		| ((day & 0x1f)<<1);
 
@@ -476,6 +482,8 @@ static int tosh_probe(void)
 	if ((tosh_id==0xfccb) || (tosh_id==0xfccc))
 		tosh_fan = 1;
 
+	iounmap(bios);
+
 	return 0;
 }
 

