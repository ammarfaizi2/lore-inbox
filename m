Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbUKDUbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUKDUbR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbUKDUaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:30:55 -0500
Received: from av4-1-sn3.vrr.skanova.net ([81.228.9.111]:58534 "EHLO
	av4-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262424AbUKDU0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:26:54 -0500
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.6.10-rc1 bttv oops in btcx_riscmem_free
References: <41839BFC.1070302@eyal.emu.id.au> <m3wtx86s07.fsf@telia.com>
	<20041104112953.GB4633@bytesex>
From: Peter Osterlund <petero2@telia.com>
Date: 04 Nov 2004 21:26:08 +0100
In-Reply-To: <20041104112953.GB4633@bytesex>
Message-ID: <m3bredbbtr.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> writes:

> > I have similar problems using 2.6.10-rc1-bk8. Often when I exit
> > tvtime, I get "unable to handle kernel paging request" or "unable to
> > handle kernel NULL pointer", see below.
> 
> Any more hints how to trigger that?  I can't reproduce that on my
> machines, neither with xawtv nor tvtime.

If I run

        while true ; do tvtime ; done

and hit 'q' repeatedly to stop tvtime, I always get the oops sooner or
later. Usually <= 10 iterations are needed, but not always. It appears
to be a race condition.

> Any change when setting the triton=1 or vsfx=1 insmod options (probably
> not, but who knows ...)?

I tried triton1=1 and vsfx=1, but I still get the oops.

> > Oct 30 14:12:55 p4 kernel: Call Trace:
> > Oct 30 14:12:55 p4 kernel:  [<f8a3203d>] btcx_riscmem_free+0x3d/0x84 [btcx_risc]
> > Oct 30 14:12:55 p4 kernel:  [<f8d2fb35>] bttv_dma_free+0x74/0x9f [bttv]
> 
> Hmm, I somehow miss either buffer_release or vbi_buffer_release here.
> Do you have KALLSYMS enabled?  Does tvtime use video only or vbi as
> well?

Yes I have KALLSYMS enabled. I don't know why the backtrace is
incomplete, but I added printk's and saw that it's buffer_release()
that calls bttv_dma_free(). According to strace, tvtime doesn't open
any /dev/vbi* device.

> Can you try to enable debug=1 for the video-buf module?

vbuf: reqbufs: bufs=4, size=0xcb000 [812 pages total]
vbuf: mmap setup: 4 buffers, 831488 bytes each
vbuf: mmap eab9d520: b7cac000-b7d77000 pgoff 00000000 bufs 0-0
vbuf: mmap f10449e0: b7be1000-b7cac000 pgoff 000000cb bufs 1-1
vbuf: mmap f10443e0: b7b16000-b7be1000 pgoff 00000196 bufs 2-2
vbuf: mmap f1044c40: b7a4b000-b7b16000 pgoff 00000261 bufs 3-3
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: munmap eab9d520
vbuf: munmap f10449e0
vbuf: munmap f10443e0
vbuf: munmap f1044c40
vbuf: reqbufs: bufs=4, size=0xcb000 [812 pages total]
vbuf: mmap setup: 4 buffers, 831488 bytes each
vbuf: mmap f1044c40: b7cac000-b7d77000 pgoff 00000000 bufs 0-0
vbuf: mmap f10443e0: b7be1000-b7cac000 pgoff 000000cb bufs 1-1
vbuf: mmap f10449e0: b7b16000-b7be1000 pgoff 00000196 bufs 2-2
vbuf: mmap eab9d520: b7a4b000-b7b16000 pgoff 00000261 bufs 3-3
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: munmap f1044c40
vbuf: munmap f10443e0
vbuf: munmap f10449e0
vbuf: munmap eab9d520
vbuf: reqbufs: bufs=4, size=0xcb000 [812 pages total]
vbuf: mmap setup: 4 buffers, 831488 bytes each
vbuf: mmap eab9d520: b7cac000-b7d77000 pgoff 00000000 bufs 0-0
vbuf: mmap f10449e0: b7be1000-b7cac000 pgoff 000000cb bufs 1-1
vbuf: mmap f10443e0: b7b16000-b7be1000 pgoff 00000196 bufs 2-2
vbuf: mmap f1044c40: b7a4b000-b7b16000 pgoff 00000261 bufs 3-3
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: init user [0xb7cac000+0xcb000 => 203 pages]
vbuf: init user [0xb7be1000+0xcb000 => 203 pages]
vbuf: init user [0xb7b16000+0xcb000 => 203 pages]
vbuf: init user [0xb7a4b000+0xcb000 => 203 pages]
vbuf: munmap eab9d520
Unable to handle kernel paging request at virtual address 00ffffff
 printing eip:
c010a237
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: bttv video_buf tuner tda9887 msp3400 firmware_class v4l2_common btcx_risc videodev snd_mixer_oss snd_emu10k1 snd_rawmidi snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore radeon nfsd exportfs lockd parport_pc lp parport autofs4 sunrpc ipt_MASQUERADE iptable_nat ipt_LOG ipt_limit ipt_state ipt_REJECT iptable_filter ip_tables dm_mod sd_mod usb_storage uhci_hcd ehci_hcd rtc
CPU:    0
EIP:    0060:[<c010a237>]    Not tainted VLI
EFLAGS: 00210206   (2.6.10-rc1-bk8) 
EIP is at dma_free_coherent+0x30/0x67
eax: 00000000   ebx: e9ca5000   ecx: e9ca5000   edx: 00000000
esi: 00ffffff   edi: e6e30c34   ebp: eb7fb080   esp: e9db5ee4
ds: 007b   es: 007b   ss: 0068
Process tvtime (pid: 4992, threadinfo=e9db4000 task=e8d96a60)
Stack: ea990680 e6e30b80 f8a3203d ea9906c4 00000c38 e9ca5000 29ca5000 e6e30ba4 
       eaaacb80 f8d3ab35 ea990680 e6e30c34 00000000 00000000 eab9d520 ee3c84bc 
       f8afbc55 eaaacb80 e6e30b80 00035000 eb7fb080 e9db4000 e9db4000 eaaac980 
Call Trace:
 [<f8a3203d>] btcx_riscmem_free+0x3d/0x84 [btcx_risc]
 [<f8d3ab35>] bttv_dma_free+0x74/0x9f [bttv]
 [<f8afbc55>] videobuf_vm_close+0x97/0xc9 [video_buf]
 [<c014348b>] remove_vm_struct+0x8e/0x97
 [<c0144c85>] unmap_vma_list+0x1c/0x28
 [<c0145008>] do_munmap+0x142/0x17f
 [<c0145089>] sys_munmap+0x44/0x64
 [<c010400f>] syscall_call+0x7/0xb
Code: 44 24 0c 8b 54 24 10 8b 5c 24 14 85 c0 74 06 8b b0 b8 00 00 00 8d 42 ff ba ff ff ff ff c1 e8 0b 83 c2 01 d1 e8 75 f9 85 f6 74 13 <8b> 0e 39 cb 72 0d 8b 46 08 c1 e0 0c 8d 04 08 39 c3 72 09 89 d8 
 
-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
