Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbUJXPpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbUJXPpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUJXPpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:45:18 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:57867 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261525AbUJXPoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:44:14 -0400
Date: Sun, 24 Oct 2004 16:44:09 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "mobil@wodkahexe.de" <mobil@wodkahexe.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
In-Reply-To: <16751.54873.668167.981073@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.58L.0410241615350.14448@blysk.ds.pg.gda.pl>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
 <Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
 <16750.23132.41441.649851@alkaid.it.uu.se> <Pine.LNX.4.58L.0410142225160.25607@blysk.ds.pg.gda.pl>
 <16751.54873.668167.981073@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Mikael Pettersson wrote:

>  > @@ -667,7 +667,7 @@ static int __init detect_init_APIC (void
>  >  	u32 h, l, features;
>  >  	extern void get_cpu_vendor(struct cpuinfo_x86*);
>  >  
>  > -	/* Disabled by DMI scan or kernel option? */
>  > +	/* Disabled by kernel option? */
>  >  	if (enable_local_apic < 0)
>  >  		return -1;
>  >  
> 
> DMI scan may still be relevant. Previously we used it to
> override the default force-enable policy. Now we may still
> need it to force-disable the lapic on systems that boot with
> it enabled but malfunction if it's used. (I don't know of
> any, but given BIOS history, they aren't impossible.)

 We don't disable APIC right now, so this may only become true once it's
done (e.g. disable_local_APIC() is called from here).

> So the comment doesn't need to change.

 I don't think keeping an inaccurate comment is good.  Simply add it back 
if it becomes relevant.

>  > @@ -692,15 +691,20 @@ static int __init detect_init_APIC (void
>  >  
>  >  	if (!cpu_has_apic) {
>  >  		/*
>  > -		 * Over-ride BIOS and try to enable LAPIC
>  > -		 * only if "lapic" specified
>  > +		 * Over-ride BIOS and try to enable the local
>  > +		 * APIC only if "lapic" specified.
>  >  		 */
>  > -		if (enable_local_apic != 1)
>  > -			goto no_apic;
>  > +		if (enable_local_apic <= 0) {
>  > +			printk("Not enabling local APIC "
>  > +			       "because of frequent BIOS bugs\n");
>  > +			printk("You can enable it with \"lapic\"\n");
>  > +			return -1;
> 
> I agree with Alan that accusing the BIOS of being buggy is unwarranted.

 I disagree.  If the firmware performs any actions on hardware without
asking the OS for permission, it *must* be prepared for it to be in any
possible state and handle it correctly, including any transitional states
(as it does respect spinlocks).  Otherwise it's buggy.

 Alan, referring to your statement: it's like stating we must only use the
text mode of the display adapter, because that's the state it's left in by
the firmware and it may not expect any other state.

> The text should just state the obvious:
> 
> The local APIC was disabled by the BIOS.
> You can enable it with "lapic".

 I don't insist on any particular message though -- the following one
should hopefully suit you as more neutral (but you risk questions: "Why
doesn't Linux enable the APIC anymore?").

>  >  		/*
>  >  		 * Some BIOSes disable the local APIC in the
>  >  		 * APIC_BASE MSR. This can only be done in
>  > -		 * software for Intel P6 and AMD K7 (Model > 1).
>  > +		 * software for Intel P6, Intel P4 and AMD K7
>  > +		 * (Model > 1).
> 
> To implicitly include P4 and K8, just change this to:
> Intel P6 and later, and AMD K7 (Model > 1) and later

 Done.

 Here's a new patch, updated for the 2.6.9 release.

  Maciej

patch-2.6.9-lapic-7
diff -up --recursive --new-file linux-2.6.9.macro/arch/i386/kernel/apic.c linux-2.6.9/arch/i386/kernel/apic.c
--- linux-2.6.9.macro/arch/i386/kernel/apic.c	2004-10-12 23:57:01.000000000 +0000
+++ linux-2.6.9/arch/i386/kernel/apic.c	2004-10-24 00:30:29.000000000 +0000
@@ -667,7 +667,7 @@ static int __init detect_init_APIC (void
 	u32 h, l, features;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
-	/* Disabled by DMI scan or kernel option? */
+	/* Disabled by kernel option? */
 	if (enable_local_apic < 0)
 		return -1;
 
@@ -681,8 +681,7 @@ static int __init detect_init_APIC (void
 			break;
 		goto no_apic;
 	case X86_VENDOR_INTEL:
-		if (boot_cpu_data.x86 == 6 ||
-		    (boot_cpu_data.x86 == 15 && (cpu_has_apic || enable_local_apic > 0)) ||
+		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 			break;
 		goto no_apic;
@@ -692,15 +691,20 @@ static int __init detect_init_APIC (void
 
 	if (!cpu_has_apic) {
 		/*
-		 * Over-ride BIOS and try to enable LAPIC
-		 * only if "lapic" specified
+		 * Over-ride BIOS and try to enable the local
+		 * APIC only if "lapic" specified.
 		 */
-		if (enable_local_apic != 1)
-			goto no_apic;
+		if (enable_local_apic <= 0) {
+			apic_printk(APIC_VERBOSE,
+				    "Local APIC disabled by BIOS -- "
+				    "you can enable it with \"lapic\"\n");
+			return -1;
+		}
 		/*
 		 * Some BIOSes disable the local APIC in the
 		 * APIC_BASE MSR. This can only be done in
-		 * software for Intel P6 and AMD K7 (Model > 1).
+		 * software for Intel P6 or later and AMD K7
+		 * (Model > 1) or later.
 		 */
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
