Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268209AbUHFR2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268209AbUHFR2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268219AbUHFR0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:26:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:58345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268195AbUHFRVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:21:55 -0400
Date: Fri, 6 Aug 2004 10:16:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: Possible dcache BUG
In-Reply-To: <20040806073739.GA6617@elte.hu>
Message-ID: <Pine.LNX.4.58.0408061006400.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <200408042216.12215.gene.heskett@verizon.net> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
 <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org> <20040805180634.GA26732@elte.hu>
 <Pine.LNX.4.58.0408051144520.24588@ppc970.osdl.org> <20040806073739.GA6617@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Aug 2004, Ingo Molnar wrote:
> 
> last night i ran another overnight test: 2.6.8-rc3-vanilla with
> CONFIG_PREEMPT enabled and no other changes. I've also reduced the CPU's
> clock speed by 5% to reduce the chance of hw problems. The crash below
> triggered after roughly 12 hours of runtime. I've also attached the full
> disassembly of __d_lookup(). The crash happens in hlist_for_each():
> 
>  c01632f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
>  c01632f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,1),%edi
>  c0163300:	8b 03                	mov    (%ebx),%eax <==== [*]
> 
> the crashing instruction is preceeded by two prefetch instructions (the
> disassembly has the alternate-insn NOP).

That's not right.

The prefetchnta instruction is three or four bytes long (four if it uses 
the ebp register that needs the "0(ebp)" modrm format).

We use a NOP4 for space in there, and the things you point to are a 
NOP6+NOP7 pair.

Your two nop's are the ones gcc has inserted in order to start the loop at 
a 16-byte boundary (ie c0163300 is the top of the loop). The nop that gets 
replaced by a prefetch is the instruction _after_ the one that faulted for 
you:

	8b 03                   mov    (%ebx),%eax
	8d 74 26 00             lea    0x0(%esi,1),%esi

I think.

> to me this crash seems to imply prefetch.

I don't think it's obvious yet. It's close to the prefetch, but it's the 
instruction just before. Which in an OoO CPU doesn't necessarily mean 
much, of course - or it could be that the prefetch caused some trouble 
last time around the loop and we only see it now.

Or it could be totally prefetch-unrelated. I do find the prefetch thing 
intriguing, though.

		Linus
