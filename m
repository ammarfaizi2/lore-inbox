Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUG3Hl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUG3Hl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 03:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267647AbUG3Hl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 03:41:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62674 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267651AbUG3Hlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 03:41:55 -0400
Date: Fri, 30 Jul 2004 08:44:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Scott Wood <scott@timesys.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
Message-ID: <20040730064431.GA17777@elte.hu>
References: <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <1091141622.30033.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091141622.30033.3.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> After running jackd with L2 all night, the only repeated XRUN was this
> one:
> 
> ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
>  [<c01066a7>] dump_stack+0x17/0x20
>  [<de93d54b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
>  [<de979211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
>  [<c01078d7>] handle_IRQ_event+0x47/0x90
>  [<c0107e93>] do_IRQ+0xe3/0x1b0
>  [<c0106268>] common_interrupt+0x18/0x20
>  [<c0146771>] add_to_swap+0x21/0xc0
>  [<c0139446>] shrink_list+0x156/0x4b0
>  [<c01398ed>] shrink_cache+0x14d/0x370
>  [<c013a118>] shrink_zone+0xa8/0xf0
>  [<c013a4ee>] balance_pgdat+0x1be/0x220
>  [<c013a5f9>] kswapd+0xa9/0xb0
>  [<c0104395>] kernel_thread_helper+0x5/0x10
> 
> This produced a few ~2ms XRUNs.  The shrink_zone -> shrink_cache ->
> shrink_list is a recurring motif.
> 
> Is this addressed in M2?

not yet. I havent seen this latency yet, nor are there any immediately
clear clues in the xrun logs you sent. (it would still be nice to check
out -M2, to see whether with all those configurability changes it
matches the latencies of L2+your-irq.c-hack.)

shrink_list() itself is preemptable once every iteration so that
function alone shouldnt be able to generate a 2msec latency.

a strong suspect is add_to_swap(), it could be looping. Could you do a
'echo m > /proc/sysrq-trigger' and send me the results? In particular
are there any significant 'race' counts in the 'Swap cache:' stats?

the other possible suspect is get_swap_page() - it's called from
add_to_swap() and has the potential to introduce latencies (it does
bitmap scans, etc.) - but it never shows up in your xrun logs, which is
a bit weird.

(could you perhaps also try wli's latency printing patch? That prints
out latencies closer to where they really happen.)

plus it seems the latency is related to certain VM activities - you
still cannot name any particular reproducer workload - it just happens
occasionally, right?

	Ingo
