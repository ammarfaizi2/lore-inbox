Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276451AbRJGRKY>; Sun, 7 Oct 2001 13:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276452AbRJGRKO>; Sun, 7 Oct 2001 13:10:14 -0400
Received: from hermes.toad.net ([162.33.130.251]:5326 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276451AbRJGRKG>;
	Sun, 7 Oct 2001 13:10:06 -0400
Subject: Re: Linux should not set the "PnP OS" boot flag
From: Thomas Hood <jdthood@mail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15qEkj-0005uw-00@the-village.bc.nu>
In-Reply-To: <E15qEkj-0005uw-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 07 Oct 2001 13:10:00 -0400
Message-Id: <1002474604.831.134.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-10-07 at 10:18, Alan Cox wrote:
> > Yes (if you mean: clears the "Booting" flag).  This is a different
> > flag from the PnP-OS flag.  The PnP-OS flag is bit 0; the "Booting"
> > flag is bit 1.  So this is a separate issue.
> 
> Its very much the same issue. Only a marked successful PnP boot counts
> for anything

Well, the SBF spec treats the two bits as totally separate.
The PnP-OS bit controls PnP BIOS device configuration.
The Booting and Diag bits control whether or not POSTs are run:

------------------------------------------------------------------
BOOT register structure
-----------------------
0 PNPOS -- Indicates that a Plug-and-Play capable OS is installed on the
system.  The system BIOS must check the state of this bit during its
initialization.  If this bit is not set, the system BIOS must assume a
legacy operating system and configure the resources of all devices it
controls.  If the bit is set, the system BIOS must assume a Plug and
Play operating system and only configure devices required for boot as
per the PC98 specification.
1 BOOTING -- Indicates whether or not the previous boot was not
completed.  The system BIOS must check the state of this flag at the
beginning of POST.  If this bit is set, the system BIOS will set DIAG to
1 to inform itself and other components to run a full diagnostic suite.
If this bit is not set, DIAG will be cleared to inform components to
skip all tests and to begin loading the boot sector as soon as possible.
This bit is set by the system BIOS at the earliest possible moment of
POST. This bit is cleared by the OS after it has completed its boot
procedure.
2 DIAG -- Indicates whether or not to run diagnostics.  This bit is set
based on the state of BOOTING at the beginning of POST, or by the
operating system during the previous boot.  If set at the beginning of
POST, this bit must remain set to allow the operating system to request
diagnostic boots.  If set during POST, the system BIOS, option ROMs, and
operating systems should run diagnostic tests.  If not set, these
components must not run diagnostic tests and should boot the machine as
quickly as possible.
3-6 Reserved -- Reserved.  Must be 0.
7 PARITY -- A parity bit used to check used to verify the integrity of
this register.  This bit should be set with ODD parity based on the
contents of the rest of the register.  If the system BIOS detects that
the PARITY bit is not set correctly, it must assume the register is
corrupted.
------------------------------------------------------------------

> > But look at the code (following).  The code DOES NOT clear the "Booting"
> > flag.  It ONLY sets the PnP-OS flag.  Not only that: when it does so
> > it fails to change bit 7 in order to preserve odd parity, as the spec
> > requires.
> 
> sbf_write computes parity

oh.  ;)

I append the patch that shows the sort of thing that I think needs
to be done.  (This patch includes the change from spin_lock to 
spin_lock_irqsave.)  The patch would need to be accompanied by the
addition of stuff to allow the user to define CONFIG_PNPOS.

Cheers,
Thomas

The patch:
--- linux-2.4.10-ac7/arch/i386/kernel/bootflag.c	Fri Oct  5 14:57:10 2001
+++ linux-2.4.10-ac7-fix/arch/i386/kernel/bootflag.c	Sun Oct  7 13:07:03 2001
@@ -59,7 +59,7 @@
 		return 0;
 
 	if (sb.sbf_len == 39)
-		printk (KERN_WARNING "ACPI BOOT descriptor is wrong length (%d)\n",
+		printk (KERN_WARNING "SBF: ACPI BOOT descriptor is wrong length (%d)\n",
 			sb.sbf_len);
 
 	sbf_port = sb.sbf_cmos;	/* Save CMOS port */
@@ -81,32 +81,38 @@
 
 static void __init sbf_write(u8 v)
 {
+	unsigned long flags;
+
 	if(sbf_port != -1)
 	{
 		v &= ~(1<<7);
 		if(!parity(v))
 			v|=1<<7;
 			
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
+	if(v&0x78)      /* Reserved bits should be 0 */
 		return 0;
 	if(!parity(v))
 		return 0;
@@ -118,24 +124,18 @@
 {
 	u8 v = sbf_read();
 	if(!sbf_value_valid(v))
-		v = 0;
-#if defined(CONFIG_PNPBIOS)
+		printk(KERN_WARNING "SBF: Simple boot flag value read from CMOS RAM 0x%x is invalid\n",v);
+
+	v &= ~0x78;     /* Clear reserved bits 3-6 */
+	v &= ~(1<<1);	/* Clear BOOTING flag */
+	v &= ~(1<<2);	/* Clear DIAG flag */
+#if defined(CONFIG_PNPOS)
 	/* Tell the BIOS to fast init as we are a PnP OS */
 	v |= (1<<0);	/* Set PNPOS flag */
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
@@ -235,7 +235,7 @@
 		if(sbf_struct_valid(rp))
 		{
 			/* Found the BOOT table and processed it */
-			printk(KERN_INFO "Simple Boot Flag extension found and enabled.\n");
+			printk(KERN_INFO "SBF: Simple Boot Flag extension found and enabled.\n");
 		}
 		iounmap((void *)rp);
 	}

