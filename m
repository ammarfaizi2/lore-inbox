Return-Path: <linux-kernel-owner+w=401wt.eu-S1760324AbWLJHUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760324AbWLJHUK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 02:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760333AbWLJHUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 02:20:10 -0500
Received: from gw.goop.org ([64.81.55.164]:50232 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760335AbWLJHUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 02:20:08 -0500
Message-ID: <457BB527.9020202@goop.org>
Date: Sat, 09 Dec 2006 23:20:07 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: walt <w41ter@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: commit 66e10a44d724f1464b5e8b5a3eae1e2cbbc2cca6
References: <457B4A16.7010508@gmail.com> <457B60C3.2060004@goop.org> <457B6E92.8070003@gmail.com>
In-Reply-To: <457B6E92.8070003@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> Jeremy Fitzhardinge wrote:
>   
>> walt wrote:
>>     
>>> Hi gang,
>>>
>>> Commit 66e10a44d724f1464b5e8b5a3eae1e2cbbc2cca6 (Fix places
>>> where using %gs changes the usermode ABI) is causing trouble
>>> for me.
>>>
>>> I discovered this by accident only because I routinely run my
>>> alpha-test version of the newsreader 'pan' in gdb:
>>>       
>
>   
>> Could you try to get a clean copy of the whole oops message?  The
>> extract you included in your mail cuts off just before the interesting part.	
>>     
>
> Aha -- I didn't realize that it was an oops until I got your email.
> Syslog yields this:
>   

(For future reference, try not to line-wrap kernel output.)

> Dec  9 15:20:41 k2 kernel: kernel BUG at fs/buffer.c:1233!
>   

This is pretty strange.  The bug is in the depths of the filesystem
code, and its complaining about the interrupts being in an unexpected
state.  I'm not sure how this could be related to the PDA changes.  In
general, the PDA stuff either works, or it explodes horribly very early.

The fact that you're seeing it while debugging is interesting, but I
don't have a good explanation for these symptoms.

Is this an SMP/HT/multicore system?

> Dec  9 15:20:41 k2 kernel: invalid opcode: 0000 [#1]
> Dec  9 15:20:41 k2 kernel: PREEMPT
> Dec  9 15:20:41 k2 kernel: Modules linked in: ipv6 snd_pcm_oss
> snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq usb_storage u
> sbhid snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm snd_timer
> snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device tg3 ehc
> i_hcd uhci_hcd i2c_viapro via_agp agpgart ohci1394 ieee1394 usbcore
> i2c_core snd
> Dec  9 15:20:41 k2 kernel: CPU:    0
> Dec  9 15:20:41 k2 kernel: EIP:    0060:[__find_get_block+18/334]    Not
> tainted VLI
> Dec  9 15:20:41 k2 kernel: EIP:    0060:[<c01630c7>]    Not tainted VLI
> Dec  9 15:20:41 k2 kernel: EFLAGS: 00010046   (2.6.19-g200d018e #276)
> Dec  9 15:20:41 k2 kernel: EIP is at __find_get_block+0x12/0x14e
>   
> Dec  9 15:20:41 k2 kernel: eax: 00000086   ebx: 00000003   ecx: 00001000
>   edx: 00035450
> Dec  9 15:20:41 k2 kernel: esi: 00000000   edi: 00035450   ebp: dffe9ba0
>   esp: d5c5bc18
> Dec  9 15:20:41 k2 kernel: ds: 007b   es: 007b   ss: 0068
> Dec  9 15:20:41 k2 kernel: Process pan (pid: 6921, ti=d5c5a000
> task=d662c550 task.ti=d5c5a000)
> Dec  9 15:20:41 k2 kernel: Stack: 00000000 00000000 61696c61 00736573
> 00000000 b7ea447c 65687465 dfea4990
> Dec  9 15:20:41 k2 kernel:        00000003 00000000 00001000 00000000
> c0163219 dfe9db6c c01346f9 00035450
> Dec  9 15:20:41 k2 kernel:        dffe9ba0 00000003 00000000 df4515e0
> 00000000 c017d7f6 00000001 d5c5bc88
> Dec  9 15:20:41 k2 kernel: Call Trace:
> Dec  9 15:20:41 k2 kernel:  [__getblk+22/465] __getblk+0x16/0x1d1
> Dec  9 15:20:41 k2 kernel:  [<c0163219>] __getblk+0x16/0x1d1
> Dec  9 15:20:41 k2 kernel:  [__do_page_cache_readahead+126/507]
> __do_page_cache_readahead+0x7e/0x1fb
> Dec  9 15:20:41 k2 kernel:  [<c01346f9>]
> __do_page_cache_readahead+0x7e/0x1fb
> Dec  9 15:20:41 k2 kernel:  [ext3_getblk+237/550] ext3_getblk+0xed/0x226
> Dec  9 15:20:41 k2 kernel:  [<c017d7f6>] ext3_getblk+0xed/0x226
> Dec  9 15:20:41 k2 kernel:  [blockable_page_cache_readahead+76/159]
> blockable_page_cache_readahead+0x4c/0x9f
> Dec  9 15:20:41 k2 kernel:  [<c01348c2>]
> blockable_page_cache_readahead+0x4c/0x9f
> syDec  9 15:20:41 k2 kernel:  [ext3_find_entry+846/1415]
> ext3_find_entry+0x34e/0x587
> Dec  9 15:20:41 k2 kernel:  [<c01816f4>] ext3_find_entry+0x34e/0x587
> Dec  9 15:20:42 k2 kernel:  [file_read_actor+117/215]
> file_read_actor+0x75/0xd7
> Dec  9 15:20:42 k2 kernel:  [<c012edd1>] file_read_actor+0x75/0xd7
> Dec  9 15:20:42 k2 kernel:  [mmx_clear_page+36/120] mmx_clear_page+0x24/0x78
> Dec  9 15:20:42 k2 kernel:  [<c01d6894>] mmx_clear_page+0x24/0x78
> Dec  9 15:20:42 k2 kernel:  [get_page_from_freelist+595/754]
> get_page_from_freelist+0x253/0x2f2
> Dec  9 15:20:42 k2 kernel:  [<c0132f05>] get_page_from_freelist+0x253/0x2f2
> Dec  9 15:20:42 k2 kernel:  [ext3_lookup+39/203] ext3_lookup+0x27/0xcb
> Dec  9 15:20:42 k2 kernel:  [<c0182c98>] ext3_lookup+0x27/0xcb
> Dec  9 15:20:42 k2 kernel:  [d_alloc+29/420] d_alloc+0x1d/0x1a4
> Dec  9 15:20:42 k2 kernel:  [<c0156600>] d_alloc+0x1d/0x1a4
> Dec  9 15:20:42 k2 kernel:  [do_lookup+163/320] do_lookup+0xa3/0x140
> Dec  9 15:20:42 k2 kernel:  [<c014e00d>] do_lookup+0xa3/0x140
> Dec  9 15:20:42 k2 kernel:  [__link_path_walk+1983/3032]
> __link_path_walk+0x7bf/0xbd8
> Dec  9 15:20:42 k2 kernel:  [<c014f809>] __link_path_walk+0x7bf/0xbd8
> Dec  9 15:20:42 k2 kernel:  [__d_lookup+172/297] __d_lookup+0xac/0x129
> Dec  9 15:20:42 k2 kernel:  [<c01563d8>] __d_lookup+0xac/0x129
> Dec  9 15:20:42 k2 kernel:  [link_path_walk+66/175] link_path_walk+0x42/0xaf
> Dec  9 15:20:42 k2 kernel:  [<c014fc64>] link_path_walk+0x42/0xaf
> Dec  9 15:20:42 k2 kernel:  [do_mmap_pgoff+1323/1676]
> do_mmap_pgoff+0x52b/0x68c
> Dec  9 15:20:42 k2 kernel:  [<c013cc03>] do_mmap_pgoff+0x52b/0x68c
> Dec  9 15:20:42 k2 kernel:  [get_unused_fd+77/190] get_unused_fd+0x4d/0xbe
> Dec  9 15:20:42 k2 kernel:  [<c0146994>] get_unused_fd+0x4d/0xbe
> Dec  9 15:20:42 k2 kernel:  [do_path_lookup+421/448]
> do_path_lookup+0x1a5/0x1c0
> Dec  9 15:20:42 k2 kernel:  [<c014ff9b>] do_path_lookup+0x1a5/0x1c0
> Dec  9 15:20:42 k2 kernel:  [get_empty_filp+83/235] get_empty_filp+0x53/0xeb
> Dec  9 15:20:42 k2 kernel:  [<c0149040>] get_empty_filp+0x53/0xeb
> Dec  9 15:20:42 k2 kernel:  [__path_lookup_intent_open+69/117]
> __path_lookup_intent_open+0x45/0x75
> Dec  9 15:20:42 k2 kernel:  [<c01508f2>] __path_lookup_intent_open+0x45/0x75
> Dec  9 15:20:42 k2 kernel:  [path_lookup_open+32/37]
> path_lookup_open+0x20/0x25Dec  9 15:20:42 k2 kernel:  [<c0150996>]
> path_lookup_open+0x20/0x25
> Dec  9 15:20:42 k2 kernel:  [open_namei+110/1347] open_namei+0x6e/0x543
> Dec  9 15:20:42 k2 kernel:  [<c0150a7d>] open_namei+0x6e/0x543
> Dec  9 15:20:42 k2 kernel:  [find_get_page+21/69] find_get_page+0x15/0x45
> Dec  9 15:20:42 k2 kernel:  [<c012ee48>] find_get_page+0x15/0x45
> Dec  9 15:20:42 k2 kernel:  [rb_insert_color+140/173]
> rb_insert_color+0x8c/0xad
> Dec  9 15:20:42 k2 kernel:  [<c01d4ad8>] rb_insert_color+0x8c/0xad
> Dec  9 15:20:42 k2 kernel:  [do_filp_open+37/57] do_filp_open+0x25/0x39
> Dec  9 15:20:42 k2 kernel:  [<c0146bfb>] do_filp_open+0x25/0x39
> Dec  9 15:20:42 k2 kernel:  [do_mmap_pgoff+1323/1676]
> do_mmap_pgoff+0x52b/0x68c
> Dec  9 15:20:42 k2 kernel:  [<c013cc03>] do_mmap_pgoff+0x52b/0x68c
> Dec  9 15:20:42 k2 kernel:  [get_unused_fd+77/190] get_unused_fd+0x4d/0xbe
> Dec  9 15:20:42 k2 kernel:  [<c0146994>] get_unused_fd+0x4d/0xbe
> Dec  9 15:20:42 k2 kernel:  [do_sys_open+66/195] do_sys_open+0x42/0xc3
> Dec  9 15:20:42 k2 kernel:  [<c0146c51>] do_sys_open+0x42/0xc3
> Dec  9 15:20:42 k2 kernel:  [sys_open+28/30] sys_open+0x1c/0x1e
> Dec  9 15:20:42 k2 kernel:  [<c0146d0b>] sys_open+0x1c/0x1e
> Dec  9 15:20:42 k2 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Dec  9 15:20:42 k2 kernel:  [<c0102914>] syscall_call+0x7/0xb
> Dec  9 15:20:42 k2 kernel:  =======================
> Dec  9 15:20:42 k2 kernel: Code: 89 e0 25 00 e0 ff ff ff 48 14 8b 40 08
> a8 08 74 05 e8 a7 61 16 00 5b 5e c3 55 89 c5 57 89 d7 56
> 53 83 ec 20 9c 58 f6 c4 02 75 04 <0f> 0b eb fe 89 e0 25 00 e0 ff ff ff
> 40 14 31 f6 b8 fc ff ff ff
> Dec  9 15:20:42 k2 kernel: EIP: [__find_get_block+18/334]
> __find_get_block+0x12/0x14e SS:ESP 0068:d5c5bc18
> Dec  9 15:20:42 k2 kernel: EIP: [<c01630c7>] __find_get_block+0x12/0x14e
> SS:ESP 0068:d5c5bc18
> Dec  9 15:24:39 k2 gconfd (wa1ter-6818): Exiting
>
> I'm always pleased to try patches or diagnostic steps of any kind, so
> please let me know what information you might need and how to obtain
> it.  I'm not a professional programmer -- just an enthusiastic amateur.
>
> Thanks for supporting open source!
>
>   

    J
