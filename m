Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTKRQhf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 11:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTKRQhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 11:37:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:31960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263692AbTKRQhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 11:37:33 -0500
Date: Tue, 18 Nov 2003 08:37:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <Pine.LNX.4.53.0311181113150.11537@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0311180830050.18739-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Nov 2003, Zwane Mwaikambo wrote:
> 
> Here are diffs from the do_sys_vm86 only.

Ok. Much more readable.

And there is something very suspicious there.

The code with and without the printk() looks _identical_ apart from some 
trivial label renumbering, and the added

	pushl   $.LC6
	call    printk
	.. asm ..
	popl %esi

which all looks fine (esi is dead at that point, so the compiler is just
using a "popl" as a shorter form of "addl $4,%esp").

Btw, you seem to compile with debugging, which makes the assembly 
language pretty much unreadable and accounts for most of the 
differences: the line numbers change. If you compile a kernel where the 
line numbers don't change (by commenting _out_ the printk rather than 
removing the whole line), your diff would be more readable.

Anyway, there are _zero_ differences.

Just for fun, try this: move the "printk()" to _below_ the "asm"  
statement. It will never actually get executed, but if it's an issue of
some subtle code or data placement things (cache lines etc), maybe that
also hides the oops, since all the same code and data will be generated, 
just not run...

		Linus

