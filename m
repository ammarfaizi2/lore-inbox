Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131485AbRAOUuA>; Mon, 15 Jan 2001 15:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRAOUtu>; Mon, 15 Jan 2001 15:49:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:55824 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131401AbRAOUt3>; Mon, 15 Jan 2001 15:49:29 -0500
Message-ID: <3A636231.B892D7D2@transmeta.com>
Date: Mon, 15 Jan 2001 12:48:49 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386/setup.c cpuinfo notsc
In-Reply-To: <Pine.LNX.4.21.0101152017450.1032-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> That's how "notsc" used to behave, but since 2.4.0-test11
> "notsc" has left "tsc" in /proc/cpuinfo.  setup.c has a bogus
> "#ifdef CONFIG_TSC" which should be "#ifndef CONFIG_X86_TSC".
> 
> HPA, Maciej and I discussed that around 5 Dec 2000; but HPA
> was of Andrea's persuasion, that we should not mask caps out
> of (real CPU entries in) /proc/cpuinfo, so we made no change.
> 
> In discussion we found a more worrying error in the SMP case:
> boot_cpu_data is supposed to be left with those x86_capabilities
> common to all CPUs, but the code to do so was unaware that
> boot_cpu_data is overwritten in booting each CPU.  Even if all
> CPUs have the same features, I imagine the Linux-defined ones
> (CXMMX, K6_MTRR, CYRIX_ARR, CENTAUR_MCR) were unintentionally
> masked out of the final boot_cpu_data.
> 
> The patch below fixes both those issues, and also clears
> "pse" from /proc/cpuinfo in the same way if "mem=nopentium".
> Tempted to rename "tsc_disable" to "disable_x86_tsc", but resisted.
> 
> I think there are still anomalies in the Cyrix and Centaur TSC
> handling - shouldn't dodgy_tsc() check Centaur too?  shouldn't
> we set X86_CR4_TSD wherever we clear X86_FEATURE_TSC? - but I
> don't have those CPUs to test, I'm wary of disabling TSC since
> finding RH7.0 installed on i686 needs rdtsc to run /sbin/init,
> and even if they are wrong then "notsc" corrects the situation:
> not 2.4.1 material.
> 

I would personally prefer to export the global flags separately from the
per-CPU flags.  Not only is it more correct, it would help catch these
kinds of bugs!!!

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
