Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276503AbRJGRyu>; Sun, 7 Oct 2001 13:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276505AbRJGRyl>; Sun, 7 Oct 2001 13:54:41 -0400
Received: from hermes.toad.net ([162.33.130.251]:41941 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276503AbRJGRyZ>;
	Sun, 7 Oct 2001 13:54:25 -0400
Subject: Re: Linux should not set the "PnP OS" boot flag
From: Thomas Hood <jdthood@mail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15qEkj-0005uw-00@the-village.bc.nu>
In-Reply-To: <E15qEkj-0005uw-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 07 Oct 2001 13:54:19 -0400
Message-Id: <1002477264.1004.9.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a slightly neater version of the patch which gives control
over the DIAG bit also.  We'd need config options for "CONFIG_SBF_DIAG"
and "CONFIG_SBF_PNPOS".

I'd like to say in defense of this patch that the more conservative
thing to do _by default_ is to let the PnP BIOS configure devices
before Linux boots.  The cost SFAIK is only time.  The cost of leaving
devices unconfigured is, for some people, oopses.

--
Thomas

The patch:
--- linux-2.4.10-ac7/arch/i386/kernel/bootflag.c	Fri Oct  5 14:57:10 2001
+++ linux-2.4.10-ac7-fix/arch/i386/kernel/bootflag.c	Sun Oct  7 13:45:41 2001
@@ -15,6 +15,13 @@
 
 #include <linux/mc146818rtc.h>
 
+
+#define SBF_RESERVED (0x78)
+#define SBF_PNPOS    (1<<0)
+#define SBF_BOOTING  (1<<1)
+#define SBF_DIAG     (1<<2)
+#define SBF_PARITY   (1<<7)
+
 struct sbf_boot
 {
 	u8 sbf_signature[4];
@@ -59,7 +66,7 @@
 		return 0;
 
 	if (sb.sbf_len == 39)
-		printk (KERN_WARNING "ACPI BOOT descriptor is wrong length (%d)\n",
+		printk (KERN_WARNING "SBF: ACPI BOOT descriptor is wrong length (%d)\n",
 			sb.sbf_len);
 
 	sbf_port = sb.sbf_cmos;	/* Save CMOS port */
@@ -81,61 +88,65 @@
 
 static void __init sbf_write(u8 v)
 {
+	unsigned long flags;
+
 	if(sbf_port != -1)
 	{
-		v &= ~(1<<7);
+		v &= ~SBF_PARITY;
 		if(!parity(v))
-			v|=1<<7;
+			v|=SBF_PARITY;  /* Make parity odd */
 			
-		spin_lock(&rtc_lock);
+		printk(KERN_INFO "SBF: Setting boot flags 0x%x\n",v);
+
+		spin_lock_irqsave(&rtc_lock, flags);
 		CMOS_WRITE(v, sbf_port);
-		spin_unlock(&rtc_lock);
+		spin_unlock_irqrestore(&rtc_lock, flags);
 	}
 }
 
 static u8 __init sbf_read(void)
 {
 	u8 v;
+	unsigned long flags;
+
 	if(sbf_port == -1)
 		return 0;
-	spin_lock(&rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 	v = CMOS_READ(sbf_port);
-	spin_unlock(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 	return v;
 }
 
 static int __init sbf_value_valid(u8 v)
 {
-	if(v&0x78)		/* Reserved bits */
+	if(v&SBF_RESERVED)    /* Reserved bits should be 0 */
 		return 0;
 	if(!parity(v))
 		return 0;
 	return 1;
 }
 
-
 static void __init sbf_bootup(void)
 {
 	u8 v = sbf_read();
 	if(!sbf_value_valid(v))
-		v = 0;
-#if defined(CONFIG_PNPBIOS)
-	/* Tell the BIOS to fast init as we are a PnP OS */
-	v |= (1<<0);	/* Set PNPOS flag */
+		printk(KERN_WARNING "SBF: Simple boot flag value 0x%x read from CMOS RAM was invalid\n",v);
+
+	v &= ~SBF_RESERVED;
+	v &= ~SBF_BOOTING;
+#if defined(CONFIG_SBF_DIAG)
+	v |= SBF_DIAG;
+#else
+	v &= ~SBF_DIAG;
+#endif
+#if defined(CONFIG_SBF_PNPOS)
+	v |= SBF_PNPOS;
+#else
+	v &= ~SBF_PNPOS;
 #endif
-	sbf_write(v);
-}
 
-#ifdef NOT_USED
-void linux_booted_ok(void)
-{
-	u8 v = sbf_read();
-	if(!sbf_value_valid(v))
-		return;
-	v &= ~(1<<1);	/* Clear BOOTING flag */
 	sbf_write(v);
 }
-#endif /* NOT_USED */
 
 static int __init sbf_init(void)
 {
@@ -235,7 +246,7 @@
 		if(sbf_struct_valid(rp))
 		{
 			/* Found the BOOT table and processed it */
-			printk(KERN_INFO "Simple Boot Flag extension found and enabled.\n");
+			printk(KERN_INFO "SBF: Simple Boot Flag extension found and enabled.\n");
 		}
 		iounmap((void *)rp);
 	}

