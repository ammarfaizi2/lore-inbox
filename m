Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVATVJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVATVJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVATVJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:09:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:53700 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261945AbVATVJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:09:17 -0500
Date: Thu, 20 Jan 2005 13:08:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, cryst@golden.net,
       torvalds@osdl.org, Matt_Domsch@dell.com
Subject: Re: Something very strange on x86_64 2.6.X kernels
Message-Id: <20050120130848.14a92990.akpm@osdl.org>
In-Reply-To: <41F01A50.1040109@cosmosbay.com>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
	<20050120162807.GA3174@stusta.de>
	<20050120164829.GG450@wotan.suse.de>
	<41F01A50.1040109@cosmosbay.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Hi Andi
> 
> I have very strange coredumps happening on a big 64bits program.
> 
> Some background :
> - This program is multi-threaded
> - Machine is a dual Opteron 248 machine, 12GB ram.
> - Kernel 2.6.6  (tried 2.6.10 too but problems too)
> - The program uses hugetlb pages.
> - The program uses prefetchnta
> - The program uses about 8GB of ram.
> 
> After numerous differents core dumps of this program, and gdb debugging 
> I found :
> 
> Every time the crash occurs when one thread is using some ram located at 
> virtual address 0xffffe6xx

What does "using" mean?  Is the program executing from that location?

> When examining the core image, the data saved on this page seems correct 
> (ie countains coherent user data). But one register (%rbx) is usually 
> corrupted and contains a small value (like 0x3c)
> 
> The last instruction using this register is :
> 	prefetchnta 0x18(,%rbx,4)
> 
> 
> Examining linux sources, I found that 0xffffe000 is 'special' (ia 32 
> vsyscall) and 0xffffe600 is about sigreturn subsection of this special area.
> 
> Is it possible some vm trick just kicks in and corrupts my true 64bits 
> program ?
> 

Interesting.  IIRC, opterons will very occasionally (and incorrectly) take
a fault when performing a prefetch against a dud pointer.  The kernel will
fix that up.  At a guess, I'd say tha the fixup code isn't doing the right
thing when the faulting EIP is in the vsyscall page.
