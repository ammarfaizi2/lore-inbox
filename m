Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUFEKfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUFEKfX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 06:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUFEKfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 06:35:23 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:14720 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S262007AbUFEKfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 06:35:08 -0400
Date: Sat, 5 Jun 2004 12:35:01 +0200
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: msync() oops in 2.6.7-rc2-bk1
Message-ID: <20040605103501.GC28548@drinkel.cistron.nl>
References: <c9pvrd$v39$1@news.cistron.nl> <20040604213315.7060e7da.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040604213315.7060e7da.akpm@osdl.org> (from akpm@osdl.org on Sat, Jun 05, 2004 at 06:33:15 +0200)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jun 2004 06:33:15, Andrew Morton wrote:
> "Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
> >
> > I'm running a news server. The innd process uses mmap()s for several
> > files and uses msync() to force synchronization to disk every so
> > often. Suddenly, an msync() causes an oops (and innd SEGVs). This
> > is after the box has been up and running for 3 days:
> > 
> > # uname -a
> > Linux enterprise 2.6.7-rc2-bk1 #1 Mon May 31 15:03:52 CEST 2004 i686 GNU/Linux
> > 
> >  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 printing eip:
> > c0149120
> > *pde = 00000000
> > Oops: 0002 [#5]
> > Modules linked in: e100 mii
> > CPU:    0
> > EIP:    0060:[<c0149120>]    Not tainted
> > EFLAGS: 00010213   (2.6.7-rc2-bk1)
> > EIP is at __set_page_dirty_buffers+0x20/0xb0
> > eax: 00000000   ebx: f77a1e7c   ecx: c15706e0   edx: eba5a83c
> > esi: 5ccfb000   edi: 00000000   ebp: 5d000000   esp: f44b5efc
> > ds: 007b   es: 007b   ss: 0068
> > Process innd (pid: 10936, threadinfo=f44b5000 task=d0eb2c70)
> > Stack: f77a1de4 00000004 00000000 c4af23ec c013143e c15706e0 c013da1c 5ccfb000
> >        c4af23f0 c013db0f c4af23ec f7101900 5ccfb000 00000001 5cc00000 ce8b25d0
> >        00000000 5d000000 c013dbc3 ce8b25cc 5cc00000 5d000000 f7101900 00000001
> > Call Trace:
> >  [<c013143e>] set_page_dirty+0x3e/0x50
> >  [<c013da1c>] filemap_sync_pte+0x5c/0x80
> >  [<c013db0f>] filemap_sync_pte_range+0xcf/0xf0
> >  [<c013dbc3>] filemap_sync+0x93/0x100
> >  [<c013dc96>] msync_interval+0x66/0xf0
> >  [<c013de37>] sys_msync+0x117/0x123
> >  [<c0103c7b>] syscall_call+0x7/0xb
> > 
> > Code: 0f ba 28 01 8b 40 08 39 d0 75 f5 0f ba 29 04 19 c0 85 c0 75
> 
> You have a page which has PG_private set, but page->private is NULL.  And
> the machine is non-SMP, non-preempt, yes?

Indeed.

> I'd be wondering whether that machine has flipped a bit in page->flags,
> frankly.  How old is it?

It's an Athlon XP 2000+ from september 2002, 1 GB RAM.

> Was the mmap of a regular file or of a block device?

I'm not sure. My collegue was stracing the process when it happended
for the 3rd time but didn't save the output to a file.

I now see that just after 2.6.7-rc2-bk was booted it oopsed too-
a different oops. Perhaps that corrupted something.

Oops: 0002 [#1]
Modules linked in: e100 mii
CPU:    0
EIP:    0060:[drop_buffers+84/144]    Not tainted
EFLAGS: 00010207   (2.6.7-rc2-bk1)
EIP is at drop_buffers+0x54/0x90
eax: b552e000   ebx: eba5a834   ecx: eba5a80c   edx: 01000406
esi: eba5addc   edi: eba5a26c   ebp: c15af680   esp: c198cd18
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 9, threadinfo=c198c000 task=c19a65d0)
Stack: 00000001 c15af680 c15af680 00000000 c198ce1c c014b917 c15af680 c198cd38
       00000000 f7bff63c c15af680 c01361e3 c15af680 000000d0 c198c000 00000001
       0000001b 00000000 c198cd60 c198cd60 00000000 00000000 00000000 00000020
Call Trace:
 [try_to_free_buffers+55/144] try_to_free_buffers+0x37/0x90
 [shrink_list+835/1072] shrink_list+0x343/0x430
 [shrink_cache+331/768] shrink_cache+0x14b/0x300
 [balance_pgdat+462/608] balance_pgdat+0x1ce/0x260
 [kswapd+279/304] kswapd+0x117/0x130
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [kswapd+0/304] kswapd+0x0/0x130
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
Code: 89 42 04 89 10 89 5b 04 89 59 28 39 fe 89 f1 75 df 8b 44 24

But it might indeed be a case of flakey hardware. Re-examining the
history of this machine I see that it has spontaneously rebooted
before. What I'll do is this - it's now running 2.6.6 vanilla. I'll
see what it does over the weekend. After the weekend I'll boot
2.6.7-rcX-bkY and see what it does with that. If I can reproduce
this problem reliably or can find a pattern in it myself, I'll
let you know.

I think I'll boot 2.6.7-rcX-bkY at the same time on a known-good
machine that has a comparable load.

Mike.
