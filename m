Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLGVTS>; Thu, 7 Dec 2000 16:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLGVTI>; Thu, 7 Dec 2000 16:19:08 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:23527 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129226AbQLGVS6>; Thu, 7 Dec 2000 16:18:58 -0500
Date: Thu, 7 Dec 2000 21:48:14 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] setup.c notsc Re: Microsecond accuracy
In-Reply-To: <Pine.LNX.4.21.0012071856280.1138-100000@localhost.localdomain>
Message-ID: <Pine.GSO.3.96.1001207204019.8897B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Hugh Dickins wrote:

> The present situation is inconsistent: "notsc" removes cpuinfo's
> "tsc" flag in the UP case (when cpu_data[0] is boot_cpu_data), but
> not in the SMP case.  I don't believe HPA's recent mods affected that
> behaviour, but it is made consistent (cleared in SMP case too) by the
> patch I sent him a couple of days ago, below updated for test12-pre7...

 My original code was specifically tested on a SMP system -- having no
suitable system I wrote it mainly to make sure TSC-less SMP systems (i.e. 
486 ones) run fine.  If it doesn't work as expected anymore, then an error
slipped in somehow since then. 

> I didn't test userland access to the TSC, but my reading of the code
> was that prior to this patch, it would be disallowed on the boot cpu,
> but still allowed on auxiliaries - because disable_tsc set X86_CR4_TSD
> if cpu_has_tsc, but initing boot cpu forces cpu_has_tsc to !cpu_has_tsc.

 Note that identify_cpu() rereads feature flags, so everything should be
fine.

> I have removed the "FIX-HPA" comment line: of course, that's none of my
> business, but if you approve the patch I imagine you'd want that to go too
> (I agree it's a bit ugly there, but safest to disable cpu_has_tsc soonest).

 It might probably be done in identify_cpu() but do we want to fiddle with
cr4 there?

 Well, it appears an error slipped in, indeed.  The following change is
the key one.  Everything should be fine once it's changed. 

 Peter would you accept the patch (see below)? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -up --recursive --new-file linux-2.4.0-test11.macro/arch/i386/kernel/setup.c linux-2.4.0-test11/arch/i386/kernel/setup.c
--- linux-2.4.0-test11.macro/arch/i386/kernel/setup.c	Mon Nov 20 07:03:47 2000
+++ linux-2.4.0-test11/arch/i386/kernel/setup.c	Thu Dec  7 20:43:24 2000
@@ -1959,7 +1959,7 @@ void __init identify_cpu(struct cpuinfo_
 	 */
 
 	/* TSC disabled? */
-#ifdef CONFIG_TSC
+#ifndef CONFIG_X86_TSC
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
 #endif

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
