Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWFAHKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWFAHKE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 03:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWFAHKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 03:10:03 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32956 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750715AbWFAHKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 03:10:00 -0400
Date: Thu, 1 Jun 2006 09:10:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org, apw@shadowen.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060601071018.GA21718@elte.hu>
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org> <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447E0A49.4050105@mbligh.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> >>>EIP is at check_deadlock+0x15/0xe0

i took your config and ran a few tests. Your kernel crashed here:

BUG: unable to handle kernel paging request at virtual address 22222232
CPU:    1
EIP:    0060:[<c012b6eb>]    Not tainted VLI
EFLAGS: 00010002   (2.6.17-rc5-mm1-autokern1 #1)
EIP is at check_deadlock+0x15/0xe0
eax: 22222222   ebx: 00000001   ecx: d4996000   edx: 00000001
esi: d686f550   edi: 22222222   ebp: 22222222   esp: d5bdfec8
ds: 007b   es: 007b   ss: 0068
Process mkdir09 (pid: 18867, threadinfo=d5bdf000 task=d5c0e000)
Stack: 00000000 d686f550 d3960568 22222222 c012b77b d3960568 d5bdf000 d5bdff00
       d5c0e000 c012b922 d5bdff48 d3960568 00000246 c02d50de d5bdff00 d5bdff00
       11111111 11111111 d5bdff00 ffffff9c d5bdff48 00000000 d5bdff48 ffffffef

which is:

(gdb) list *0xc012a26e
0xc012a26e is in check_deadlock (kernel/mutex-debug.c:98).
93              struct task_struct *task;
94
95              if (!debug_locks)
96                      return 0;
97
98              ti = lock->owner;
99              if (!ti)
100                     return 0;
101
102             task = ti->task;
(gdb)

i.e. "lock" was 0x22222222. I have not changed this particular deadlock 
detection code for some time and it's been stable for many weeks. (the 
changes in -mm1 were in another area of mutex-debug.c, and even those 
mostly removed code and didnt add new logic)

the stack looks weird:

Stack: 00000000 d686f550 d3960568 22222222 c012b77b d3960568 d5bdf000 d5bdff00
       d5c0e000 c012b922 d5bdff48 d3960568 00000246 c02d50de d5bdff00 d5bdff00
       11111111 11111111 d5bdff00 ffffff9c d5bdff48 00000000 d5bdff48 ffffffef

where does the 0x11111111 and the 0x22222222 come from? It doesnt ring 
any bells in terms of kernel-internal magic or poison values. My 
impression is that there's some other badness going on (some sort of 
memory corruption) and the mutex debugging code just got caught up in 
the crossfire.

	Ingo
