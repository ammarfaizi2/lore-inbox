Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUAFAJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266046AbUAFAJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:09:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:9879 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266049AbUAFAIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:08:40 -0500
Date: Mon, 5 Jan 2004 16:08:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: mremap() bug IMHO not in 2.2 
In-Reply-To: <200401052358.i05NwWIe010594@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0401051604550.5970@home.osdl.org>
References: <20040105145421.GC2247@rdlg.net> <Pine.LNX.4.58L.0401051323520.1188@logos.cnet>
 <20040105181053.6560e1e3.grundig@teleline.es> <20040105182607.GB2093@pasky.ji.cz>
 <20040105225508.GM2093@pasky.ji.cz>            <Pine.LNX.4.58.0401051532510.5737@home.osdl.org>
 <200401052358.i05NwWIe010594@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004 Valdis.Kletnieks@vt.edu wrote:
>
> On Mon, 05 Jan 2004 15:36:41 PST, Linus Torvalds said:
> 
> > So yes, it creates some confusion in the VM layer, but it all seems 
> > benign. It's clearly a bug, but where does the security problem come in?
> 
> Just guessing, but would a zero-length vma be rounded up to a page, and
> thus give the attacker scribble permission on a page he shouldn't have had?

Almost certainly not.

It's more likely that one of the two functions that walk through _all_ the 
vma's (fork() and exit()) simply knows that a vma can never be 
zero-length, and uses a

	addr = vma->vm_start;
	do {
		...
		addr += PAGE_SIZE;
	} while (addr < vma->vm_end);

kind of loop - which means that either fork() or exit() would copy or 
release one page too many. 

The only page that should matter is likely the one at 0xC0000000, where 
there can be extra complications from the fact that we use 4MB pages for 
the kernel, so when fork/exit tries to walk the page table, it would get 
bogus results.

Still, I'd expect that to lead to a triple fault (and thus a reboot) 
rather than any elevation of privileges..

Interesting, in any case. Good catch from whoever found it.

		Linus
