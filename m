Return-Path: <linux-kernel-owner+w=401wt.eu-S1161312AbWLPSGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbWLPSGs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbWLPSGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:06:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60022 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161312AbWLPSGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:06:47 -0500
Date: Sat, 16 Dec 2006 10:06:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@yamamaya.is-a-geek.org, Andi Kleen <ak@suse.de>,
       Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work (was: Linux 2.6.20-rc1)
In-Reply-To: <20061216174536.GA2753@melchior.yamamaya.is-a-geek.org>
Message-ID: <Pine.LNX.4.64.0612160955370.3557@woody.osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <20061216174536.GA2753@melchior.yamamaya.is-a-geek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2006, Tobias Diedrich wrote:
> 
> 2.6.20-rc1 won't boot with the error message "IO-APIC + timer
> doesn't work! Try using the 'noapic' kernel parameter".
> However, IO-APIC seems to work just fine with 2.6.19-rc6 and I'd
> rather like to continue using it. :)

Can you try "git bisect" on this?

It's really easy: since you know that v2.6.20-rc1 doesn't work, and 
v2.6.19-rc6 _does_ work, just get the current kernel git tree, and then do

	git bisect start
	git bisect good v2.6.19-rc6
	git bisect bad v2.6.20-rc1

and it will pick a kernel for you to try. Just compile that, boot with it, 
and if it works, say "git bisect good" (and if it doesn't work, just do 
"git bisect bad" instead). It will give you a new kernel, and in a few 
tries you'll have been able to narrow down exactly where it breaks (ok, 
more than "a few" - there's 3728 commits in that range, so it's more like 
"twelve reboots later").

That said, it's likely one of not a lot of commits that are broken, as 
shown by

	git log v2.6.19-rc6..v2.6.20-rc1 arch/x86_64/kernel/io_apic.c

and it's *probably* commit b0268726: "[PATCH] x86-64: Try multiple timer 
variants in check_timer"

But a few other people also added to the Cc in case they have ideas.

			Linus

*** snip snip, left the most relevant info here
***
*** others: please look up the post on linux-kernel
*** for config info if you care

> http://tdiedrich.de/~ranma/2.6.20-rc1-oops.jpg
> (netconsole is configured but doesn't work for some reason, haven't
> looked into that so far)
> [...]
> ENABLING IO-APIC IRQs
> ..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 disabled(3) .. failed
> ..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 enabled(7)APIC error on CPU0: 04(40)
>  .. failed
> ..TIMER: trying IO-APIC=0 PIN=2 fallback with 8259 IRQ0 disabled(3) .. failed
> ...trying to set up timer as Virtual Wire IRQ... failed.
> ...trying to set up timer as ExtINT IRQ... failed :(.
> Kernel panic - not syncing: IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter
> 
> The board is an ASUS M2N SLI Deluxe (Athlon64/nforce).
