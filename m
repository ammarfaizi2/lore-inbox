Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136649AbREGTzY>; Mon, 7 May 2001 15:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136652AbREGTzF>; Mon, 7 May 2001 15:55:05 -0400
Received: from [64.64.109.142] ([64.64.109.142]:52236 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S136649AbREGTzC>; Mon, 7 May 2001 15:55:02 -0400
Message-ID: <3AF6FD69.5654B88B@didntduck.org>
Date: Mon, 07 May 2001 15:54:17 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <Pine.LNX.4.21.0105071003330.12733-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 7 May 2001, Alan Cox wrote:
> >
> > That is nice. I hadn't thought about doing it that way. It still has the problem
> > if %cr2 is corrupted by a vmalloc fault but it cleans up my other code paths
> > nicely.
> 
> See about "corruption" in previous email. It doesn't exist.
> 
> For better debugging, we should probably walk the whole init_mm page table
> tree when we take the fault, so this patch does that too: it
> unconditionally copies the init_mm page table entries into the current
> page table, while at the same time checking that they exist (including the
> very last level that we didn't use to check at all).
> 
> This means that if you access one page past a vmalloc'ed area, you will
> get a nice oops instead of endless page faults that will fix up the page
> tables with mappings that already exist.

This patch will still cause the user process to seg fault: The error
code on the stack will not match the address in %cr2.

	user fault (cr2=useraddr, error_code=5 or 7)
	interrupt
		vmalloc fault (cr2=vmallocaddr, error_code=0 or 2)
			handle vmalloc fault
			iret
		iret
	handle user fault (cr2=vmallocaddr, error_code=5 or 7)

We then fall down to find_vma() which will fail and then send SIGSEGV to
the user process.

--

				Brian Gerst
