Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbTLHFRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 00:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbTLHFRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 00:17:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:10980 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265343AbTLHFRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 00:17:48 -0500
Date: Sun, 7 Dec 2003 21:17:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rafal Skoczylas <nils@secprog.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.test11 bug
In-Reply-To: <20031208034631.GA14081@secprog.org>
Message-ID: <Pine.LNX.4.58.0312072100250.13236@home.osdl.org>
References: <20031208034631.GA14081@secprog.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, Rafal Skoczylas wrote:
>
> --- But sometimes it get things like this:
>
> Unable to handle kernel paging request at virtual address 5a85fb5c
>  printing eip:
> c011e6c4
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[remove_wait_queue+36/112]    Not tainted
> EFLAGS: 00010002
> EIP is at remove_wait_queue+0x24/0x70
> eax: defb4000   ebx: da85fb58   ecx: 5a85fb58   edx: db0468b0
> esi: db0468bc   edi: 00000292   ebp: defb5fa0   esp: defb5f58
> Trace:
>  [poll_freewait+36/80] poll_freewait+0x24/0x50
>  [sys_poll+581/656] sys_poll+0x245/0x290
>  [__pollwait+0/208] __pollwait+0x0/0xd0
>  [syscall_call+7/11] syscall_call+0x7/0xb

Ahh.. Btw, this looks like a single-bit error.

In particular, this is "list_del()" in remove_wait_queue(), and it's
list_del() on a list that usually only has a single entry (ie a wait
queue). In particular, it's the "prev->next = next" part, where "prev" is
5a85fb58 and next is da85fb58.

Now, with a single entry, prev and next _should_ be the same (they both
point to the head). And they are - except for a single bit error. The
difference is the high bit of the word. Interesting.

You get an oops because that 5a85fb58 _should_ be da85fb58. Notice?

> If there is any important information missing, feel free to ask.

It could be bad memory. We even know the address that is bad: it's
(%esi+4), ie bit 31 of the word at physical address 0x1b0468f0.

However, if you don't see random SIGSEGV's while compiling etc issues, it
doesnt' sound like flaky RAM.

I'm wondering if there is some bit operation out there somewhere with a
wild pointer?

Rafal - how consistent is the second form of the oops? Have you seen that
trace more than once? Might it actually be "poll()" itself that has some
bad behaviour?

			Linus
