Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131026AbQLGT7O>; Thu, 7 Dec 2000 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131066AbQLGT7C>; Thu, 7 Dec 2000 14:59:02 -0500
Received: from [62.172.234.2] ([62.172.234.2]:9520 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S131033AbQLGT6w>;
	Thu, 7 Dec 2000 14:58:52 -0500
Date: Thu, 7 Dec 2000 19:28:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] setup.c notsc Re: Microsecond accuracy
In-Reply-To: <Pine.GSO.3.96.1001207165626.21086F-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.21.0012071856280.1138-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Maciej W. Rozycki wrote:

> On 7 Dec 2000, H. Peter Anvin wrote:
> 
> > Unfortunately the most important instance of the in-kernel flag -- the
> > global one in the somewhat misnamed boot_cpu_data.x86_features --
> > isn't actually readable in the /proc/cpuinfo file.  It is perfectly
> > possible (e.g. the "notsc" option) for ALL the CPUs to report this
> > capability, but the global capability to still be off.
> 
>  Hmm, I recall I implemented and explicitly verified switching the
> /proc/cpuinfo "tsc" flag (as well as the userland access to the TSC) off
> when I wrote the code to handle the "notsc" option.  Has it changed since
> then?  I recall you modified the code a bit -- I looked at the changes
> then but I was pretty confident the semantics was preserved.

The present situation is inconsistent: "notsc" removes cpuinfo's
"tsc" flag in the UP case (when cpu_data[0] is boot_cpu_data), but
not in the SMP case.  I don't believe HPA's recent mods affected that
behaviour, but it is made consistent (cleared in SMP case too) by the
patch I sent him a couple of days ago, below updated for test12-pre7...

I didn't test userland access to the TSC, but my reading of the code
was that prior to this patch, it would be disallowed on the boot cpu,
but still allowed on auxiliaries - because disable_tsc set X86_CR4_TSD
if cpu_has_tsc, but initing boot cpu forces cpu_has_tsc to !cpu_has_tsc.

My patch description was:
identify_cpu() re-evaluates x86_capability, which left cpu_has_tsc true
(and cpu MHz shown as 0.000) in non-SMP "notsc" case: #ifdef CONFIG_TSC
was bogus.  And set X86_CR4_TSD here when testing this cpu's capability,
not where cpu_init() tests cpu_has_tsc (boot_cpu's adjusted capability).

I have removed the "FIX-HPA" comment line: of course, that's none of my
business, but if you approve the patch I imagine you'd want that to go too
(I agree it's a bit ugly there, but safest to disable cpu_has_tsc soonest).

Hugh

--- test12-pre7/arch/i386/kernel/setup.c	Thu Dec  7 17:25:55 2000
+++ linux/arch/i386/kernel/setup.c	Thu Dec  7 17:56:35 2000
@@ -1999,10 +1999,14 @@
 	 * we do "generic changes."
 	 */
 
+#ifndef CONFIG_X86_TSC
 	/* TSC disabled? */
-#ifdef CONFIG_TSC
-	if ( tsc_disable )
-		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
+	if ( test_bit(X86_FEATURE_TSC, &c->x86_capability) ) {
+		if (tsc_disable || !cpu_has_tsc) {
+			clear_bit(X86_FEATURE_TSC, &c->x86_capability);
+			set_in_cr4(X86_CR4_TSD);
+		}
+	}
 #endif
 
 	/* Disable the PN if appropriate */
@@ -2218,9 +2222,7 @@
 #ifndef CONFIG_X86_TSC
 	if (tsc_disable && cpu_has_tsc) {
 		printk("Disabling TSC...\n");
-		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
 		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
-		set_in_cr4(X86_CR4_TSD);
 	}
 #endif
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
