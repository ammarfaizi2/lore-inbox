Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277879AbRJKCk1>; Wed, 10 Oct 2001 22:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277811AbRJKCkS>; Wed, 10 Oct 2001 22:40:18 -0400
Received: from hermes.toad.net ([162.33.130.251]:44510 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S277879AbRJKCkD>;
	Wed, 10 Oct 2001 22:40:03 -0400
Subject: [PATCH] 2.4.10-ac11 bootflag.c cleanup
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 10 Oct 2001 22:39:43 -0400
Message-Id: <1002767986.7435.52.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a new version of the bootflag.c patch which ONLY
cleans up the code by adding some macros and such, but
doesn't change what it does ... except for one thing: it
doesn't clear the register entirely if the previous value
is invalid, but instead prints a warning message and clears
the _reserved_ bits, leaving the DIAG and BOOTING flags
alone.

It has been explained to me that we don't want to clear the
BOOTING flag here; we are going to wait for the whole boot
process to complete, and then clear it.

If I want to fiddle with the SBFlags I'll do it via /dev/nvram,
as Alan suggested.  Dave Jones is preparing a utility to allow
that.

--
Thomas

The patch:
--- linux-2.4.10-ac11/arch/i386/kernel/bootflag.c	Wed Oct 10 22:08:50 2001
+++ linux-2.4.10-ac11-fix/arch/i386/kernel/bootflag.c	Wed Oct 10 22:29:38 2001
@@ -15,6 +15,14 @@
 
 #include <linux/mc146818rtc.h>
 
+
+#define SBF_RESERVED (0x78)
+#define SBF_PNPOS    (1<<0)
+#define SBF_BOOTING  (1<<1)
+#define SBF_DIAG     (1<<2)
+#define SBF_PARITY   (1<<7)
+
+
 struct sbf_boot
 {
 	u8 sbf_signature[4];
@@ -59,7 +67,7 @@
 		return 0;
 
 	if (sb.sbf_len == 39)
-		printk (KERN_WARNING "ACPI BOOT descriptor is wrong length (%d)\n",
+		printk (KERN_WARNING "SBF: ACPI BOOT descriptor is wrong length (%d)\n",
 			sb.sbf_len);
 
 	sbf_port = sb.sbf_cmos;	/* Save CMOS port */
@@ -84,10 +92,12 @@
 	unsigned long flags;
 	if(sbf_port != -1)
 	{
-		v &= ~(1<<7);
+		v &= ~SBF_PARITY;
 		if(!parity(v))
-			v|=1<<7;
-			
+			v|=SBF_PARITY;
+
+		printk(KERN_INFO "SBF: Setting boot flags 0x%x\n",v);
+
 		spin_lock_irqsave(&rtc_lock, flags);
 		CMOS_WRITE(v, sbf_port);
 		spin_unlock_irqrestore(&rtc_lock, flags);
@@ -108,7 +118,7 @@
 
 static int __init sbf_value_valid(u8 v)
 {
-	if(v&0x78)		/* Reserved bits */
+	if(v&SBF_RESERVED)		/* Reserved bits */
 		return 0;
 	if(!parity(v))
 		return 0;
@@ -120,25 +130,14 @@
 {
 	u8 v = sbf_read();
 	if(!sbf_value_valid(v))
-		v = 0;
+		printk(KERN_WARNING "SBF: Simple boot flag value 0x%x read from CMOS RAM was invalid\n",v);
+	v &= ~SBF_RESERVED;
 #if defined(CONFIG_PNPBIOS)
-	/* Tell the BIOS to fast init as we are a PnP OS */
-	v |= (1<<0);	/* Set PNPOS flag */
+	v |= SBF_PNPOS;
 #endif
 	sbf_write(v);
 }
 
-#ifdef NOT_USED
-void linux_booted_ok(void)
-{
-	u8 v = sbf_read();
-	if(!sbf_value_valid(v))
-		return;
-	v &= ~(1<<1);	/* Clear BOOTING flag */
-	sbf_write(v);
-}
-#endif /* NOT_USED */
-
 static int __init sbf_init(void)
 {
 	unsigned int i;
@@ -237,7 +236,7 @@
 		if(sbf_struct_valid(rp))
 		{
 			/* Found the BOOT table and processed it */
-			printk(KERN_INFO "Simple Boot Flag extension found and enabled.\n");
+			printk(KERN_INFO "SBF: Simple Boot Flag extension found and enabled.\n");
 		}
 		iounmap((void *)rp);
 	}

