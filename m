Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVLACTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVLACTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 21:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVLACTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 21:19:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1702 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751354AbVLACTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 21:19:41 -0500
Date: Thu, 1 Dec 2005 03:19:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, zippel@linux-m68k.org,
       george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
Message-ID: <20051201021943.GA23838@elte.hu>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <20051130164105.40e103d4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130164105.40e103d4.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > this patch series is a refactored version of the ktimer-subsystem patch.
> 
>  25 files changed, 3364 insertions(+), 1827 deletions(-)
> 
> allnoconfig, before:
> 
>    text    data     bss     dec     hex filename
>  764888  157221   53748  975857   ee3f1 vmlinux
> 
> after:
> 
>    text    data     bss     dec     hex filename
>  766712  157741   53748  978201   eed19 vmlinux
> 
> Remind me what we gained for this?

well, for 1824 bytes of code [*] and 520 bytes of data you got a new, 
clean timer subsystem, which is per-clock tree based and hres-timers 
ready. It also doesnt scan all active timers linearly and fixes them up 
whenever NTP decides to mend the clock a bit. It also has no jiffy 
dependencies and has nsec resolution with timeouts of up to 292 years, 
to the nanosec. It has no subjiffies, no HZ, no tradeoffs.

note that ktimer.o itself is larger than 1824 bytes:

 size kernel/ktimer.o
   text    data     bss     dec     hex filename
   3912     100       0    4012     fac kernel/ktimer.o

so it has already offset roughly half of its size.

we can (and will) try to improve it further, but if anyone desires to 
get it for free, that's probably not possible. (only 'probable' because 
we have not converted posix-cpu-timers yet, another ktimer conversion 
candidate with code reduction potential)

it had to be a new set of APIs, which all take text space. We'll try to 
shave off some more .text, but miracles are not expected.

	Ingo

[*] if you enable CONFIG_KTIME_SCALAR, then on x86 we get denser
    ktime_t code. We keep it off by default to give the union
    representation testing (the scalar representation is the more
    trivial case). It should shave off another 300 bytes from your
    kernel's size. We'll probably enable KTIME_SCALAR on x86 later on.
