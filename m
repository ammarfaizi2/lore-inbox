Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUCXU0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUCXU0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:26:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:4829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261728AbUCXU0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:26:03 -0500
Date: Wed, 24 Mar 2004 12:28:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: matthias.andree@gmx.de, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 SMP - BUG at page_alloc.c:105
Message-Id: <20040324122806.4015d3d6.akpm@osdl.org>
In-Reply-To: <20040324205811.GB6572@logos.cnet>
References: <20040324205811.GB6572@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> 
> The backtrace is odd to me. 
> 
> set_page_dirty() does not call __free_pages_ok() directly or indirectly.
> 

I'd suspect that's just gunk on the stack and that zap_pte_range() freed an
anonymous page which had a non-null ->mapping.  It could be a hardware bug.
Without seeing the actual value of page->mapping it's hard to know.

It would be good to backport the bad_page() debug code so we get a bit more
info when this sort of thing happens.



> ---
> 
> Hi,
> 
> I found this in the logs of a Dual Athlon MP machine (Tyan board)
> running 2.4.25-SMP:
> 
> kernel BUG at page_alloc.c:105! 
> invalid operand: 0000 
> CPU:    0 
> EIP: 0010:[__free_pages_ok+80/704]    Not tainted 
> EFLAGS: 00010286 
> eax: c0333674   ebx: c1b2d720   ecx: 00000000   edx: f22f7a84 
> esi: 00000001   edi: 00000000   ebp: 00000001   esp: f6901e3c 
> ds: 0018   es: 0018   ss: 0018 
> Process svscan (pid: 1348, stackpage=f6901000) 
> Stack: c033364c f741cbc0 f22f7a84 00000001 0804c000 c0133ea6 f22f79c0 00000004  
>        00000001 00000001 0804c000 00000001 c01308fa c1b2d720 f68e3080 0804b000  
>        00001000 0844b000 c03ac4e0 00000001 0804c000 f68e3084 f42baa40 f7212440  
> Call Trace: [set_page_dirty+166/176] [zap_page_range+330/400] [exit_mmap+221/352] \
> [mmput+88/176] [do_exit+259/800]   [sig_exit+195/208] [dequeue_signal+95/192] \
> [do_signal+448/694] [schedule_timeout+94/176] [process_timeout+0/96] \
> [sys_nanosleep+232/448]   [do_page_fault+0/1347] [signal_return+20/24] 
> 
> Other than this BUG (that took down the machine hard, I was lucky to log
> across the network), there appear to be no relevant logs shortly before
> this crash.
