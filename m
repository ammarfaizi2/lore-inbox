Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUITPPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUITPPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUITPPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:15:38 -0400
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:63963 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S266680AbUITPPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:15:19 -0400
Date: Mon, 20 Sep 2004 11:14:53 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@lazuli.engin.umich.edu
To: Hugh Dickins <hugh@veritas.com>
cc: Stefan Hornburg <kernel@linuxia.de>, andrea@novell.com,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at mm/prio_tree.c:538
In-Reply-To: <Pine.LNX.4.44.0409201343170.16315-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.58.0409201053290.13166@lazuli.engin.umich.edu>
References: <Pine.LNX.4.44.0409201343170.16315-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Sep 2004, Hugh Dickins wrote:

> On Mon, 20 Sep 2004, Stefan Hornburg wrote:
> >
> > on one of my machines the kernel is oopsing every so often with
> > the following message:
> >
> > Sep 19 18:59:19 www2 kernel: ------------[ cut here ]------------
> > Sep 19 18:59:19 www2 kernel: kernel BUG at mm/prio_tree.c:538!
>
> That is worrying, we've not seen any such problem before.  You mention it
> happens with several kernels, so it doesn't feel like random corruption.

Few months ago Andrea got a similar report. But, he tagged that
as a hardware problem.

I am inclined to claim this report as a memory problem, but then
I may be fooling myself. The BUG_ONs in the vma_prio_tree_add are
very redundant and I would like to remove it but for the rare
reports like this.

If you see the call trace, vma_prio_tree_insert called
vma_prio_tree_add because prio_tree_insert returned a tree node
that is not equal to currently inserted &vma->shared.

If we poke into prio_tree_insert, such a tree node is returned
if and only if (r_index == radix_index && h_index == heap_index).
Therefore, we just checked the indices to be equal. However, this
bug report claims that the indices are not equal.

The only chance I see for this to happen: we are changing vm_start,
vm_end, vm_pgoff of a vma that is already in an i_mmap tree
without holding the corresponding i_mmap_lock. The last time I
did an audit, all such changes were inside the i_mmap_lock.
I will look again tonight.

Rajesh

> Would you mind mailing me and Rajesh (not the list) the output
> of "objdump -rd mm/prio_tree.o" from your kernel build tree,
> to help us make sense of what's shown in the registers here?
>
> Though I very much doubt that will shed enough light: we'll probably
> need to add printks to dump out the vmas involved when this happens.
> Would running such a debug kernel build on this machine be possible?
>
> Thanks,
> Hugh
>
> > Sep 19 18:59:19 www2 kernel: invalid operand: 0000 [#1]
> > Sep 19 18:59:19 www2 kernel: SMP
> > Sep 19 18:59:19 www2 kernel: Modules linked in: dm_mod
> > Sep 19 18:59:19 www2 kernel: CPU:    0
> > Sep 19 18:59:19 www2 kernel: EIP:    0060:[vma_prio_tree_add+21/160]    Not tainted
> > Sep 19 18:59:19 www2 kernel: EFLAGS: 00010206   (2.6.8.1)
> > Sep 19 18:59:19 www2 kernel: EIP is at vma_prio_tree_add+0x15/0xa0
> > Sep 19 18:59:19 www2 kernel: eax: d8e2b5b8   ebx: d5298f90   ecx: 00000000   edx: 0000000a
> > Sep 19 18:59:19 www2 kernel: esi: d8e2b5b8   edi: 00000000   ebp: 0fa9b000   esp: d8e91ef0
> > Sep 19 18:59:19 www2 kernel: ds: 007b   es: 007b   ss: 0068
> > Sep 19 18:59:19 www2 kernel: Process cfserver (pid: 1317, threadinfo=d8e91000 task=d7fb4650)
> > Sep 19 18:59:20 www2 kernel: Stack: d5298fb8 d5298f90 00000000 c0135b19 d5298f90 d8e2b5b8 d6004bf4 d6fa68ac
> > Sep 19 18:59:20 www2 kernel:        c013ed0f d5298f90 ded2be58 d6fa68ac d6fa6900 d5298f90 0fa9b000 bd7fed90
> > Sep 19 18:59:20 www2 kernel:        00000000 00000000 def6a780 ded2be58 ded2be38 00000000 df84e300 c013fdf4
> > Sep 19 18:59:20 www2 kernel: Call Trace:
> > Sep 19 18:59:20 www2 kernel:  [vma_prio_tree_insert+37/44] vma_prio_tree_insert+0x25/0x2c
> > Sep 19 18:59:20 www2 kernel:  [vma_adjust+363/808] vma_adjust+0x16b/0x328
> > Sep 19 18:59:20 www2 kernel:  [split_vma+252/264] split_vma+0xfc/0x108
> > Sep 19 18:59:20 www2 kernel:  [do_munmap+126/280] do_munmap+0x7e/0x118
> > Sep 19 18:59:20 www2 kernel:  [sys_munmap+56/88] sys_munmap+0x38/0x58
> > Sep 19 18:59:20 www2 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> > Sep 19 18:59:20 www2 kernel: Code: 0f 0b 1a 02 9f 51 35 c0 8b 43 04 8b 7b 08 29 c7 89 f8 c1 e8
> >
> > This happens with 2.6.8.1 as well as with earlier kernels.
> > This is a Quad-Xeon-Box from Dell (SMP kernel).
> > I've no idea what is causing these failures and didn't found anything useful
> > by searching. Therefore I would be grateful for any help.
>
>
