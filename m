Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276135AbRJHMkr>; Mon, 8 Oct 2001 08:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276824AbRJHMki>; Mon, 8 Oct 2001 08:40:38 -0400
Received: from hermes.toad.net ([162.33.130.251]:54754 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276135AbRJHMkX>;
	Mon, 8 Oct 2001 08:40:23 -0400
Subject: Re: Linux should not set the "PnP OS" boot flag
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 08 Oct 2001 08:40:21 -0400
Message-Id: <1002544823.953.16.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry if this is a repeat ... a lot of my mail is getting
bounced back today for some reason.  This message hasn't 
turned up in the archives, so I'm resending.  // Thomas )

Alan Cox wrote:
> Would it not be better to tackle the job head on ? If the pnpbios scan
> as it walks the devices configured them would that do the job ?

Well, we could do the equivalent of a "setpnp xy on" on each device,
I suppose.  That just copies the "boot" config to the "current"
config.  That would suffice for me.  I don't know if it would
suffice for other people.  It wouldn't work for those Vaios and
Inspirons that have been causing problems, though.

I have a suspicion that those Phoenix BIOSes that oops when
"current" configuration is accessed are oopsing because
the BIOS hasn't initialized the "current" configuration ...
because the PnP-OS bit is set.  I've asked Stelian to test
this hypothesis; no word back yet.

In any case, though, I think the decision as to whether or not
to bypass PnP BIOS configuration _next time_ should be left up
to the user.  The user may want to boot Windows 3.1 next, or
some other non-PnP OS.  Same goes for skipping BIOS diagnostics.

As for the "Booting" flag, you're right, it should be cleared
by us.  SFAICT the current code fails to do this.  That needs
to be fixed.

So here's a new bootflag.c patch, now against 2.4.10-ac8.
(It defines some nice macros for the flags, etc.
Until CONFIG_SBF_DIAG and CONFIG_SBF_PNPOS are defined
somewhere, the default will be not to set the DIAG flag
and not to set the PnP-OS flag.  I still think a /proc
interface to these makes the most sense, but I haven't
implemented that yet.

--
Thomas

The patch:
--- linux-2.4.10-ac8/arch/i386/kernel/bootflag.c	Sun Oct  7 14:38:05 2001
+++ linux-2.4.10-ac8-fix/arch/i386/kernel/bootflag.c	Sun Oct  7 15:01:45 2001
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
@@ -120,24 +130,22 @@
 {
 	u8 v = sbf_read();
 	if(!sbf_value_valid(v))
-		v = 0;
-#if defined(CONFIG_PNPBIOS)
-	/* Tell the BIOS to fast init as we are a PnP OS */
-	v |= (1<<0);	/* Set PNPOS flag */
-#endif
-	sbf_write(v);
-}
+		printk(KERN_WARNING "SBF: Simple boot flag value 0x%x read from CMOS RAM was invalid\n",v);
 
-#ifdef NOT_USED
-void linux_booted_ok(void)
-{
-	u8 v = sbf_read();
-	if(!sbf_value_valid(v))
-		return;
-	v &= ~(1<<1);	/* Clear BOOTING flag */
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
+#endif
 	sbf_write(v);
 }
-#endif /* NOT_USED */
 
 static int __init sbf_init(void)
 {
@@ -237,7 +245,7 @@
 		if(sbf_struct_valid(rp))
 		{
 			/* Found the BOOT table and processed it */
-			printk(KERN_INFO "Simple Boot Flag extension found and enabled.\n");
+			printk(KERN_INFO "SBF: Simple Boot Flag extension found and enabled.\n");
 		}
 		iounmap((void *)rp);
 	}

