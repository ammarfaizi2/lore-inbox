Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265693AbUEZQws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUEZQws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 12:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbUEZQws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 12:52:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:64977 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265693AbUEZQwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:52:06 -0400
Date: Wed, 26 May 2004 09:51:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Bug 2773] New: kernel panic under medium load
In-Reply-To: <390810000.1085582148@[10.10.2.4]>
Message-ID: <Pine.LNX.4.58.0405260918161.1770@ppc970.osdl.org>
References: <390810000.1085582148@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm..

Interesting. The code is

		cmpl   $0x63,0x18(%eax)
		jg     <__alloc_pages+xx>
		mov    0x8(%ebx),%eax
		shr    %eax
		sub    %eax,%ecx
	__alloc_pages+xx:
		mov    (%edx),%eax
		cmp    %ecx,%eax

where %eax is 0x00004000.

Now, that would look like a pointer that _should_ be zero, but with a 
single-bit error. But that's not so. The pointer in question is "p", which 
should have been initialized "current". The code is

	if (rt_task(p))
		min -= z->pages_low >> 1;

and 0x63 is just (MAX_RT_PRIO-1). So it's just doing a

	if ((p)->prio < MAX_RT_PRIO)
		min -= z->pages_low >> 1;

and "p" is seriously corrupt.

My first reaction was that this looks like a thread-info corruption,
possibly due to a stack overflow that just overwrote the thread-info (and
thus the "current" pointer). HOWEVER, looking closer, I note that the oops
report gets it right and says

	Process mlnet (pid: 16251, threadinfo=c6e92000 task=ddd1d6b0)

and that the stack dump (which contains the stack value of "p") agrees:  
the value of "p" on the stack is at 20(%esp) (if your compiler agrees with
mine, and it seems to), and that is indeed dumped as the correct value
"ddd1d6b0". Also %esp is 0xc6e93d38, which is not even _close_ to the end 
of stack, and shows that you're not running with the 4kB stack anyway.

So "p" _was_ correct at some point, and the only incorrect value is in 
fact the register value in %eax.

Now, to make it more interesting, at least for me, the instruction 
_immediately_ preceding the "cmp" that oopsed is in fact:

	movl    20(%esp), %ecx

(for my config, %ecx is the register that contains the value of "p", we
seem to have different register allocation, either because of compiler 
differences or because of config changes).

What happens for you before? Can you do a "make mm/page_alloc.s" and post 
the result (well, just __alloc_pages, not the rest).

(Btw, I hate web interfaces, but feel free to update bugzilla for me)

		Linus

---
On Wed, 26 May 2004, Martin J. Bligh wrote:
>
> http://bugme.osdl.org/show_bug.cgi?id=2773
> 
>            Summary: kernel panic under medium load
>     Kernel Version: 2.6.6 unpatched
>             Status: NEW
>           Severity: normal
>              Owner: akpm@digeo.com
>          Submitter: bug-kernel@leroutier.net
> 
> 
> Distribution:
> Gentoo x86
> 
> Hardware Environment:
> P4 Celeron
> 0000:00:00.0 Host bridge: VIA Technologies, Inc. P4M266 Host Bridge
> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
> 0000:00:05.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
> 0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 80)
> 0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 80)
> 0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 80)
> 0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
> 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
> 0000:00:11.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
> VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
> 0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
> 0000:01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8 KM266/KL266]
> 
> Software Environment:
> mldonkey 2.5.21 (the app that triggers the bug at each time)
> 
> Problem Description:
> 
> Unable to handle kernel paging request at virtual address 00004018
>  printing eip:
> c012c41c
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c012c41c>]    Not tainted
> EFLAGS: 00010206   (2.6.6)
> EIP is at __alloc_pages+0x5e/0x2d4
> eax: 00004000   ebx: 00000000   ecx: 00000153   edx: c02ed5e4
> esi: 00000001   edi: c02ed84c   ebp: c6e93d6c   esp: c6e93d38
> ds: 007b   es: 007b   ss: 0068
> Process mlnet (pid: 16251, threadinfo=c6e92000 task=ddd1d6b0)
> Stack: c6e93d6c c015615c d261120c bfffc684 00000001 ddd1d6b0 00000010 00000000
>        000000d2 00006006 00000000 00006006 00000000 c6e93e54 c012a4a8 d26112a4
>        00006006 00000000 00000000 0001c26f c6e93d88 00000001 cfb344c8 00000020
> Call Trace:
>  [<c015615c>] inode_update_time+0x9c/0xd0
>  [<c012a4a8>] generic_file_aio_write_nolock+0x2bf/0xaa6
>  [<c012e785>] page_cache_readahead+0x1a2/0x1fd
>  [<c012924a>] file_read_actor+0x0/0xda
>  [<c01294b3>] __generic_file_aio_read+0x18f/0x1be
>  [<c012924a>] file_read_actor+0x0/0xda
>  [<c012ad8b>] generic_file_aio_write+0x6b/0x88
>  [<c0170457>] ext3_file_write+0x3f/0xb8
>  [<c01409cd>] do_sync_write+0x89/0xb4
>  [<c011b0e1>] update_wall_time+0xf/0x3a
>  [<c0111a05>] scheduler_tick+0x1f/0x506
>  [<c0117cae>] __do_softirq+0x82/0x84
>  [<c011b263>] update_process_times+0x46/0x50
>  [<c011b0e1>] update_wall_time+0xf/0x3a
>  [<c011b4df>] do_timer+0xdf/0xe4
>  [<c0140944>] do_sync_write+0x0/0xb4
>  [<c0140a99>] vfs_write+0xa1/0x10c
>  [<c0140ba0>] sys_write+0x3f/0x5d
>  [<c0103cf3>] syscall_call+0x7/0xb
> 
> Code: 83 78 18 63 7f 07 8b 42 08 d1 e8 29 c1 8b 02 39 c8 73 0c 8b
> 
> Steps to reproduce:
> 
> run mlnet (multi-network exe of mldonkey, a P2P app) with a load > 1MB/s (in & out)
> 
> preempt is off
> 
> would attach .config on request
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
