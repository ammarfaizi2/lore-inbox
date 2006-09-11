Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWIKFvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWIKFvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWIKFvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:51:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53679 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964880AbWIKFvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:51:16 -0400
Date: Mon, 11 Sep 2006 07:43:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjanv@infradead.org
Subject: Re: lockdep warning in check_flags()
Message-ID: <20060911054335.GC11269@elte.hu>
References: <20060908011317.6cb0495a.akpm@osdl.org> <20060909083523.GG1121@slug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909083523.GG1121@slug>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederik Deweerdt <deweerdt@free.fr> wrote:

> Lockdep issues the following warning:
> 
> [   16.835268] Freeing unused kernel memory: 260k freed
> [   16.842715] Write protecting the kernel read-only data: 432k
> [   17.796518] BUG: warning at kernel/lockdep.c:2359/check_flags()

this warning means that the "soft" and "hard" hardirqs-disabled state 
got out of sync: the irqtrace tracking code thinks that hardirqs are 
disabled, while in reality they are enabled. The thing to watch for are 
new "stii" instructions in entry.S (and other assembly code), without a 
matching TRACE_HARDIRQS_ON call. [Another, rarer possiblity is NMI code 
saving/restoring interrupts - do you have NMIs enabled? (are there any 
NMI counts in /proc/interrupts?)]

lockdep automatically generates a minimal trace of hardirqs-off 
state-setting:

> [   17.885839] irq event stamp: 8318
> [   17.892746] hardirqs last  enabled at (8317): [<c01032c8>] restore_nocheck+0x12/0x15
> [   17.906778] hardirqs last disabled at (8318): [<c0103203>] sysenter_past_esp+0x6c/0x99
> [   17.921481] softirqs last  enabled at (7128): [<c0123cd1>] __do_softirq+0xe9/0xfa
> [   17.936962] softirqs last disabled at (7121): [<c0123d3e>] do_softirq+0x5c/0x60

this means that the last registered 'hardirqs off' event was 
sysenter_past_esp, i.e. the normal sysenter syscall entry code - but 
nothing re-enabled hardirqs - which is weird, given that you ended up in 
sys_brk().

> I've replaced the DEBUG_LOCKS_WARN_ON by a BUG, and it appears that 
> the user space program calling sys_brk is hotplug.

(ok, i'll enhance the debug printout to include the process name and 
PID.)

	Ingo
