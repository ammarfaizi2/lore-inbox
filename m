Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUFEEeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUFEEeH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 00:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUFEEeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 00:34:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:2251 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264560AbUFEEeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 00:34:03 -0400
Date: Fri, 4 Jun 2004 21:33:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: msync() oops in 2.6.7-rc2-bk1
Message-Id: <20040604213315.7060e7da.akpm@osdl.org>
In-Reply-To: <c9pvrd$v39$1@news.cistron.nl>
References: <c9pvrd$v39$1@news.cistron.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
>
> I'm running a news server. The innd process uses mmap()s for several
> files and uses msync() to force synchronization to disk every so
> often. Suddenly, an msync() causes an oops (and innd SEGVs). This
> is after the box has been up and running for 3 days:
> 
> # uname -a
> Linux enterprise 2.6.7-rc2-bk1 #1 Mon May 31 15:03:52 CEST 2004 i686 GNU/Linux
> 
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 printing eip:
> c0149120
> *pde = 00000000
> Oops: 0002 [#5]
> Modules linked in: e100 mii
> CPU:    0
> EIP:    0060:[<c0149120>]    Not tainted
> EFLAGS: 00010213   (2.6.7-rc2-bk1)
> EIP is at __set_page_dirty_buffers+0x20/0xb0
> eax: 00000000   ebx: f77a1e7c   ecx: c15706e0   edx: eba5a83c
> esi: 5ccfb000   edi: 00000000   ebp: 5d000000   esp: f44b5efc
> ds: 007b   es: 007b   ss: 0068
> Process innd (pid: 10936, threadinfo=f44b5000 task=d0eb2c70)
> Stack: f77a1de4 00000004 00000000 c4af23ec c013143e c15706e0 c013da1c 5ccfb000
>        c4af23f0 c013db0f c4af23ec f7101900 5ccfb000 00000001 5cc00000 ce8b25d0
>        00000000 5d000000 c013dbc3 ce8b25cc 5cc00000 5d000000 f7101900 00000001
> Call Trace:
>  [<c013143e>] set_page_dirty+0x3e/0x50
>  [<c013da1c>] filemap_sync_pte+0x5c/0x80
>  [<c013db0f>] filemap_sync_pte_range+0xcf/0xf0
>  [<c013dbc3>] filemap_sync+0x93/0x100
>  [<c013dc96>] msync_interval+0x66/0xf0
>  [<c013de37>] sys_msync+0x117/0x123
>  [<c0103c7b>] syscall_call+0x7/0xb
> 
> Code: 0f ba 28 01 8b 40 08 39 d0 75 f5 0f ba 29 04 19 c0 85 c0 75

You have a page which has PG_private set, but page->private is NULL.  And
the machine is non-SMP, non-preempt, yes?

I'd be wondering whether that machine has flipped a bit in page->flags,
frankly.  How old is it?

Was the mmap of a regular file or of a block device?
