Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbULHJDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbULHJDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 04:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbULHJDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 04:03:31 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:24044 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261155AbULHJDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 04:03:11 -0500
Message-ID: <41B6C34B.7030700@dgreaves.com>
Date: Wed, 08 Dec 2004 09:03:07 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: phil@dier.us, linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
References: <20041122130622.27edf3e6.phil@dier.us>	<20041122161725.21adb932.akpm@osdl.org>	<20041124094549.4c51d6d5.phil@dier.us>	<20041124151234.714f30d4.akpm@osdl.org>	<41A9B693.30905@dgreaves.com> <20041128102751.2dac71f7.akpm@osdl.org>
In-Reply-To: <20041128102751.2dac71f7.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>David Greaves <david@dgreaves.com> wrote:
>  
>
>>...
>>I have a system that's running 2.6.10rc2
>>It has libata sata_promise + sata_sil drives in an md raid5 array that's 
>>used by lvm2 and then xfs; then exported via nfs.
>>I saw this thread, upgraded to 2.6.10rc2 and I'm posting this in case 
>>it's related (it's hard to tell)
>>
>>This oops happened whilst the box was quiet
>>
>>Hopefully relevant config bits:
>>Single processor
>>echo 16384 > /proc/sys/vm/min_free_kbytes
>>CONFIG_4KSTACKS=n
>>I've done a memtest.
>>I haven't applied the inode patch - I'm usually writing a single 1-3Gb 
>>files whilst reading another.
>>
>>Can I help by providing anything else?
>>
>>Nov 28 09:05:03 cu kernel: Unable to handle kernel paging request at 
>>virtual address 00100104
>>    
>>
>
>That's the list_del() poisoning pattern.
>  
>
<snip old log>

>It appears that the dentry cache's slab freelists have become corrupted. 
>Odd, because everyone uses that code a lot.  I'd suggest that you enable
>CONFIG_DEBUG_SLAB, see if that catches anything.
>  
>
Thanks for the reply Andrew.

I did as you suggested and it's been fine until I got this last night.

Dec  8 06:50:04 cu kernel: slab: Internal list corruption detected in 
cache 'vm_area_struct'(41), slabp cfedd000(13). Hexdump:
Dec  8 06:50:04 cu kernel:
Dec  8 06:50:04 cu kernel: 000: 00 01 10 00 00 02 20 00 6c 00 00 00 6c 
d0 ed cf
Dec  8 06:50:04 cu kernel: 010: 0d 00 00 00 11 00 14 08 1a 00 fe ff 0a 
00 06 00
Dec  8 06:50:04 cu kernel: 020: fe ff fe ff 02 00 fe ff 22 00 21 00 18 
00 27 00
Dec  8 06:50:04 cu kernel: 030: ff ff fe ff fe ff 03 00 00 00 19 00 03 
00 fe ff
Dec  8 06:50:04 cu kernel: 040: fe ff 08 00 fe ff fe ff 1c 00 10 00 15 
00 fe ff
Dec  8 06:50:04 cu kernel: 050: 25 00 12 00 fe ff
Dec  8 06:50:04 cu kernel: ------------[ cut here ]------------
Dec  8 06:50:04 cu kernel: kernel BUG at mm/slab.c:1947!
Dec  8 06:50:04 cu kernel: invalid operand: 0000 [#1]
Dec  8 06:50:04 cu kernel: Modules linked in: nfs af_packet ipv6 e100 
mii usblp uhci_hcd usbcore nfsd exportfs lockd sunrpc sk98lin unix
Dec  8 06:50:04 cu kernel: CPU:    0
Dec  8 06:50:04 cu kernel: EIP:    0060:[check_slabp+180/240]    Not 
tainted VLI
Dec  8 06:50:04 cu kernel: EFLAGS: 00010092   (2.6.10-rc2cu-041128-02)
Dec  8 06:50:04 cu kernel: EIP is at check_slabp+0xb4/0xf0
Dec  8 06:50:04 cu kernel: eax: 00000001   ebx: 00000056   ecx: 
00000082   edx: 0000898d
Dec  8 06:50:04 cu kernel: esi: cfedd000   edi: dffe9960   ebp: 
cfedd018   esp: c1f3bca8
Dec  8 06:50:04 cu kernel: ds: 007b   es: 007b   ss: 0068
Dec  8 06:50:04 cu kernel: Process munin-node (pid: 6456, 
threadinfo=c1f3a000 task=c32dea00)
Dec  8 06:50:04 cu kernel: Stack: c0352d03 000000ff 00000029 cfedd000 
0000000d cfedd000 0000001b cfedda8c
Dec  8 06:50:04 cu kernel:        c013aa19 dffe9960 cfedd000 00000000 
dffe996c dffe997c 0000000c 00000010
Dec  8 06:50:04 cu kernel:        dffe9960 c094ba2c dffea728 c013ab2b 
dffe9960 dffe65e8 00000010 dffe65e8
Dec  8 06:50:04 cu kernel: Call Trace:
Dec  8 06:50:04 cu kernel:  [free_block+153/336] free_block+0x99/0x150
Dec  8 06:50:04 cu kernel:  [cache_flusharray+91/304] 
cache_flusharray+0x5b/0x130
Dec  8 06:50:04 cu kernel:  [kmem_cache_free+122/128] 
kmem_cache_free+0x7a/0x80
Dec  8 06:50:04 cu kernel:  [remove_vm_struct+94/128] 
remove_vm_struct+0x5e/0x80
Dec  8 06:50:04 cu kernel:  [remove_vm_struct+94/128] 
remove_vm_struct+0x5e/0x80
Dec  8 06:50:04 cu kernel:  [exit_mmap+284/320] exit_mmap+0x11c/0x140
Dec  8 06:50:04 cu kernel:  [mmput+44/128] mmput+0x2c/0x80
Dec  8 06:50:04 cu kernel:  [exec_mmap+121/240] exec_mmap+0x79/0xf0
Dec  8 06:50:04 cu kernel:  [flush_old_exec+202/1616] 
flush_old_exec+0xca/0x650
Dec  8 06:50:04 cu kernel:  [kernel_read+80/96] kernel_read+0x50/0x60
Dec  8 06:50:04 cu kernel:  [load_elf_binary+827/3184] 
load_elf_binary+0x33b/0xc70
Dec  8 06:50:04 cu kernel:  [get_empty_filp+70/208] get_empty_filp+0x46/0xd0
Dec  8 06:50:04 cu kernel:  [autoremove_wake_function+0/96] 
autoremove_wake_function+0x0/0x60
Dec  8 06:50:04 cu kernel:  [kernel_read+80/96] kernel_read+0x50/0x60
Dec  8 06:50:04 cu kernel:  [search_binary_handler+93/432] 
search_binary_handler+0x5d/0x1b0
Dec  8 06:50:04 cu kernel:  [load_script+520/576] load_script+0x208/0x240
Dec  8 06:50:04 cu kernel:  [__alloc_pages+458/864] 
__alloc_pages+0x1ca/0x360
Dec  8 06:50:04 cu kernel:  [copy_from_user+66/128] copy_from_user+0x42/0x80
Dec  8 06:50:04 cu kernel:  [copy_strings+392/512] copy_strings+0x188/0x200
Dec  8 06:50:04 cu kernel:  [search_binary_handler+93/432] 
search_binary_handler+0x5d/0x1b0
Dec  8 06:50:04 cu kernel:  [do_execve+409/528] do_execve+0x199/0x210
Dec  8 06:50:04 cu kernel:  [sys_execve+66/128] sys_execve+0x42/0x80
Dec  8 06:50:04 cu kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec  8 06:50:04 cu kernel: Code: b6 04 33 43 c7 04 24 94 59 34 c0 89 44 
24 04 e8 23 d7 fd ff 8b 47 3c 8d 44 00 04 39 c3 72 db c7 04 24 03 2d 35 
c0 e8 0c d7 fd ff <0f> 0b 9b 07 1e 58 34 c0 83 c4 14 5b 5e 5f c3 89 5c 
24 04 c7 04

Additional info:
when the machine started I got three:
  swapper: page allocation failure. order:1, mode:0x20
before I could:
  echo 16384 > /proc/sys/vm/min_free_kbytes

Anything else you'd like me to try?

David

