Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbULJLNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbULJLNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 06:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbULJLNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 06:13:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18340 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261176AbULJLNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 06:13:11 -0500
Date: Fri, 10 Dec 2004 12:11:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
Message-ID: <20041210111105.GB6855@elte.hu>
References: <32950.192.168.1.5.1102529664.squirrel@192.168.1.5> <1102532625.25841.327.camel@localhost.localdomain> <32788.192.168.1.5.1102541960.squirrel@192.168.1.5> <1102543904.25841.356.camel@localhost.localdomain> <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu> <1102602829.25841.393.camel@localhost.localdomain> <1102619992.3882.9.camel@localhost.localdomain> <20041209221021.GF14194@elte.hu> <1102659089.3236.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102659089.3236.11.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Second, my ethernet doesn't work, and it really seems to be some kind
> of interrupt trouble.  It sends out ARPs but doesn't see them come
> back, and it also doesn't seem to know that it sent them out. I get
> the following:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, tx_status 00 status e601.
>   diagnostics: net 0ccc media 8880 dma 0000003a fifo 0000
> eth0: Interrupt posted but not delivered -- IRQ blocked by another
> device?
>   Flags; bus-master 1, dirty 33(1) current 33(1)
>   Transmit list 00000000 vs. f75012a0.
>   0: @f7501200  length 80000043 status 8c010043
>   1: @f75012a0  length 8000007a status 0c01007a
>   2: @f7501340  length 8000002a status 0001002a
>   3: @f75013e0  length 80000098 status 0c010098
>   4: @f7501480  length 8000002a status 0001002a
>   5: @f7501520  length 8000002a status 0001002a
>   6: @f75015c0  length 8000002a status 0001002a
>   7: @f7501660  length 8000002a status 0001002a
>   8: @f7501700  length 80000043 status 0c010043
>   9: @f75017a0  length 80000043 status 0c010043
>   10: @f7501840  length 8000004f status 0c01004f
>   11: @f75018e0  length 8000004f status 0c01004f
>   12: @f7501980  length 80000043 status 0c010043
>   13: @f7501a20  length 8000007a status 0c01007a
>   14: @f7501ac0  length 80000098 status 0c010098
>   15: @f7501b60  length 8000002a status 8001002a 
> 
> I have a (from lspci) 
> 0000:02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
> [Tornado] (rev 78)
> 
> 
> I can look into this further to see what the problem is. One funny
> note, on the vanilla kernel, my eth0 is at interrupt 177, but on the
> rt patched kernel its swapped with the sound card and is at interrupt
> 169. Well it's getting too late for me now (its 1am my time (01:00 for
> you European folks ;-) , and I need to get up at 6:30 am). Tomorrow,
> I'll hack on it some more.

yeah, please check this - you are the first one to report this issue.

A good first step would be to go switch to a non-PREEMPT_RT preemption
model (but to keep the -RT codebase) and see whether the breakage is
related to that. If the breakage goes away with say PREEMPT_DESKTOP then
i'd suggest to enable PREEMPT_HARDIRQS and PREEMPT_SOFTIRQS (but keep
PREEMPT_DESKTOP) - do these alone trigger the breakage? E.g. there was
an obscure timing bug in the floppy driver that only triggered with
PREEMPT_HARDIRQS enabled. So it's not out of question that there's some
other driver bug/race in hiding. The other possibility is some generic
-RT kernel breakage - like the SLAB issue was.

	Ingo
