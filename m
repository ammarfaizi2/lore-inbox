Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131535AbRAOVge>; Mon, 15 Jan 2001 16:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbRAOVgZ>; Mon, 15 Jan 2001 16:36:25 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:38605 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131535AbRAOVgF>; Mon, 15 Jan 2001 16:36:05 -0500
Date: Mon, 15 Jan 2001 22:34:48 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hugh Dickins <hugh@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386/setup.c cpuinfo notsc
In-Reply-To: <Pine.LNX.4.21.0101152017450.1032-100000@localhost.localdomain>
Message-ID: <Pine.GSO.3.96.1010115222714.16619a-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, Hugh Dickins wrote:

> That's how "notsc" used to behave, but since 2.4.0-test11
> "notsc" has left "tsc" in /proc/cpuinfo.  setup.c has a bogus
> "#ifdef CONFIG_TSC" which should be "#ifndef CONFIG_X86_TSC".

 Confirmed.

> HPA, Maciej and I discussed that around 5 Dec 2000; but HPA
> was of Andrea's persuasion, that we should not mask caps out
> of (real CPU entries in) /proc/cpuinfo, so we made no change.

 The conclusion was to add something like common_cpu_data, which would be
independent from boot_cpu_data.

> In discussion we found a more worrying error in the SMP case:
> boot_cpu_data is supposed to be left with those x86_capabilities
> common to all CPUs, but the code to do so was unaware that
> boot_cpu_data is overwritten in booting each CPU.  Even if all
> CPUs have the same features, I imagine the Linux-defined ones
> (CXMMX, K6_MTRR, CYRIX_ARR, CENTAUR_MCR) were unintentionally
> masked out of the final boot_cpu_data.

 It's not supposed.  Another struct should be added.  Boot_cpu_data is
expected to be used during an early SMP boot only.  That's the original
semantics and it should be preserved, I think.  The SMP code relies on it.

> The patch below fixes both those issues, and also clears
> "pse" from /proc/cpuinfo in the same way if "mem=nopentium".
> Tempted to rename "tsc_disable" to "disable_x86_tsc", but resisted.

 Good spotting.

> I think there are still anomalies in the Cyrix and Centaur TSC
> handling - shouldn't dodgy_tsc() check Centaur too?  shouldn't
> we set X86_CR4_TSD wherever we clear X86_FEATURE_TSC? - but I
> don't have those CPUs to test, I'm wary of disabling TSC since
> finding RH7.0 installed on i686 needs rdtsc to run /sbin/init,
> and even if they are wrong then "notsc" corrects the situation:
> not 2.4.1 material.

 Yep, that needs glibc or whatever introduces rdtsc to be fixed.

 Thanks for the patch -- I'll see how to fit it within my point of view.
I'm somewhat time-constrained these days, but I might be able to spend an
hour or so on coding and testing this issue tonight.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
