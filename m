Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277755AbRJIPP6>; Tue, 9 Oct 2001 11:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277768AbRJIPPt>; Tue, 9 Oct 2001 11:15:49 -0400
Received: from hermes.toad.net ([162.33.130.251]:24991 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S277755AbRJIPPj>;
	Tue, 9 Oct 2001 11:15:39 -0400
Subject: [PATCH] bootflag.c cleanup and fix (only)
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Oct 2001 11:15:32 -0400
Message-Id: <1002640541.741.16.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I'll drop the proposal to modify bootflag.c so that
it refrains from setting the PnP-OS flag by default.  I'll
solve that problem by giving the user runtime control over
the flag.  (In the meantime I have the workaround of using
setpnp to switch on my devices.  But that's ugly, and won't
help people who can't use setpnp.)

In preparation for those changes, here's a patch that just
cleans up bootflag.c a bit.  It also clears the BOOTING
bootflag which it is supposed to do but does not necessarily
do ATM.  

Note that in theory, if the BOOTING flag is not cleared,
then the next time the BIOS runs it will think that the
last boot failed and it will set the DIAG bit to 1 and
run diagnostics.  (This is what the spec says, anyway.)

If there is some reason why the BOOTING flag is not cleared in
the current code (... to work around some BIOS bug, for
example ...) please let me know!

--
Thomas

The patch:
--- linux-2.4.10-ac10/arch/i386/kernel/bootflag.c	Sun Oct  7 14:38:05 2001
+++ linux-2.4.10-ac10-fix/arch/i386/kernel/bootflag.c	Tue Oct  9 10:59:24 2001
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
@@ -120,25 +130,16 @@
 {
 	u8 v = sbf_read();
 	if(!sbf_value_valid(v))
-		v = 0;
+		printk(KERN_WARNING "SBF: Simple boot flag value 0x%x read from CMOS RAM was invalid\n",v);
+	v &= ~SBF_RESERVED;
+	v &= ~SBF_BOOTING;
+	v &= ~SBF_DIAG;
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
@@ -237,7 +238,7 @@
 		if(sbf_struct_valid(rp))
 		{
 			/* Found the BOOT table and processed it */
-			printk(KERN_INFO "Simple Boot Flag extension found and enabled.\n");
+			printk(KERN_INFO "SBF: Simple Boot Flag extension found and enabled.\n");
 		}
 		iounmap((void *)rp);
 	}

