Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbUJZMBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUJZMBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 08:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbUJZMBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 08:01:43 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:8150 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262240AbUJZMBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 08:01:39 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 26 Oct 2004 13:38:35 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Hunold <hunold@convergence.de>, Meelis Roos <mroos@linux.ee>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: Serious stability issues with 2.6.10-rc1 - more info
Message-ID: <20041026113835.GB11239@bytesex>
References: <20041026035104.7d805289.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026035104.7d805289.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then I tried SysRq-T to capture the task list. dmesg in yet another
> terminal was the last command that worked before the complete hang where
> only sysrq-b worked. But I got the sysrq-t ouput to disk, maybe it is of
> some help (tvtime and ps are the last ones but here is the full dmesg).
> 
> This shows that the first thing that happened was an oops in
> dma_free_coherent:

> Unable to handle kernel paging request at virtual address 08e1c5a0
> EIP:    0060:[dma_free_coherent+41/96]    Not tainted VLI
>  [pg0+407638071/1069536256] btcx_riscmem_free+0x37/0x80 [btcx_risc]

Hmm, btcx_riscmem_free does nothing but calling pci_free_consistent with
the values recorded at pci_alloc_consistent time, thats something which
really shouldn't fail ...

memory corruption?

>  [pg0+407770590/1069536256] videobuf_dma_pci_unmap+0x2e/0x80 [video_buf]
>  [pg0+407989509/1069536256] bttv_dma_free+0x55/0x80 [bttv]
>  [pg0+407775739/1069536256] videobuf_vm_close+0x8b/0xc0 [video_buf]
>  [remove_vm_struct+90/96] remove_vm_struct+0x5a/0x60
>  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
>  [do_munmap+246/320] do_munmap+0xf6/0x140
>  [sys_munmap+64/112] sys_munmap+0x40/0x70
>  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71

> tvtime        D C02E482C     0  5895   4655                     (NOTLB)
> d1b31d80 00200082 00000000 c02e482c d1b31d84 c01296bb 7ac8f240 000f45d5 
>        0001b207 7ac8f240 000f45d5 c0b58040 c0b5819c d68c1b6c d1b31d90 c0b58040 
>        0000000b c02972f5 00200082 d68c1b70 cee95ed4 d68c1b70 c0b58040 00000001 
> Call Trace:
>  [autoremove_wake_function+27/80] autoremove_wake_function+0x1b/0x50
>  [rwsem_down_read_failed+117/352] rwsem_down_read_failed+0x75/0x160
>  [.text.lock.exit+107/261] .text.lock.exit+0x6b/0x105
>  [printk+23/32] printk+0x17/0x20
>  [die+317/320] die+0x13d/0x140
>  [do_page_fault+0/1434] do_page_fault+0x0/0x59a
>  [do_page_fault+0/1434] do_page_fault+0x0/0x59a
>  [do_page_fault+682/1434] do_page_fault+0x2aa/0x59a
>  [mark_page_accessed+40/48] mark_page_accessed+0x28/0x30
>  [filemap_nopage+364/688] filemap_nopage+0x16c/0x2b0
>  [do_no_page+334/496] do_no_page+0x14e/0x1f0
>  [zap_pte_range+314/560] zap_pte_range+0x13a/0x230
>  [do_page_fault+0/1434] do_page_fault+0x0/0x59a
>  [error_code+45/56] error_code+0x2d/0x38
>  [dma_free_coherent+41/96] dma_free_coherent+0x29/0x60
>  [pg0+407638071/1069536256] btcx_riscmem_free+0x37/0x80 [btcx_risc]
>  [pg0+407770590/1069536256] videobuf_dma_pci_unmap+0x2e/0x80 [video_buf]
>  [pg0+407989509/1069536256] bttv_dma_free+0x55/0x80 [bttv]
>  [pg0+407775739/1069536256] videobuf_vm_close+0x8b/0xc0 [video_buf]
>  [remove_vm_struct+90/96] remove_vm_struct+0x5a/0x60
>  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
>  [do_munmap+246/320] do_munmap+0xf6/0x140
>  [sys_munmap+64/112] sys_munmap+0x40/0x70
>  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71

Same trace as above, just a bit deeper on the stack.  Looks like the
kernel didn't even manage to kill tvtime after the oops because it
couldn't get some lock (process list?) ...

> ps            D C02E8740     0  6010   4657                     (NOTLB)
> cee95ec4 00200086 cdd81878 c02e8740 fffffff4 cdd818e0 5d6adac0 000f45de 
>        00000000 5d6adac0 000f45de c61cc5d0 c61cc72c d68c1b6c cee95ed4 c61cc5d0 
>        cdd82000 c02972f5 00000000 d68c1b70 d68c1b70 d1b31d90 c61cc5d0 00000001 
> Call Trace:
>  [rwsem_down_read_failed+117/352] rwsem_down_read_failed+0x75/0x160
>  [.text.lock.ptrace+7/79] .text.lock.ptrace+0x7/0x4f
>  [proc_pid_cmdline+96/256] proc_pid_cmdline+0x60/0x100

probably the same lock ps needs.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
