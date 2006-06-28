Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWF1VFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWF1VFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWF1VFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:05:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:20894 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751222AbWF1VFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:05:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=mgieRQeVCvvSjGYTVnU2dRp5XtJE+zIKhYk+cyyTg3Wwl6AVQF1Avwz7tuXZypCtBoCLl5eegYbnwupvkZn741Sq4lZP1KmkwBAg2xJykSSEYQMnXDF1obxIi7Xzd03euHEHnytlokfEYGfv+hjPlHFQTISlTsKI2Y+TrLApLDY=
Date: Thu, 29 Jun 2006 01:05:24 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: grep /proc/slabinfo + rm -rf => lockup
Message-ID: <20060628210523.GA7555@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steps to reproduce:

VT1: while true; do grep xfs /proc/slabinfo; done
VT2: rm -rf linux-vanilla
	or
     extracting full Linux source from git repo

Trying this at home completely hoses my box in a second (even SysRq
doesn't work).

Version numbers: 2.6.17-dfd8317d3340f03bc06eba6b58f0ec0861da4a13 -- OK
		 2.6.17-f36f44de721db44b4c2944133c3c5c2e06f633f0 -- BAD

It seems that grep-slabinfo step is a uber-trigger because I could swear
tree was unpacked, compiled and removed quite a few times while I was foolishly
running -f36f44.

Filesystem is reiserfs (rw,noatime,notail)
IO scheduler is CFQ.
--------------------------------------------------------------------------------
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0141475
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore
CPU:    0
EIP:    0060:[<c0141475>]    Not tainted VLI
EFLAGS: 00010012   (2.6.17-a39727f212426b9d5f9267b3318a2afaf9922d3b #1) 
EIP is at s_show+0x9d/0x203
eax: c02aebbb   ebx: 00000000   ecx: 00000000   edx: defe7a01
esi: defedac0   edi: c02aebbb   ebp: defe7ac0   esp: da99df24
ds: 007b   es: 007b   ss: 0068
Process grep (pid: 7688, ti=da99d000 task=def83030 task.ti=da99d000)
Stack: 00000000 00000000 00000000 00000000 00000010 00000104 de657480 c02e011c 
       de657480 defe7ac0 00007000 c015d4b6 00000d62 00000000 0805cfe3 dea04900 
       00000044 00000000 00000043 00000000 c02e1d00 0805cfe3 dea04900 da99dfa4 
Call Trace:
 [<c015d4b6>] seq_read+0x187/0x24e
 [<c01430db>] vfs_read+0x7a/0xc5
 [<c0143320>] sys_read+0x3c/0x62
 [<c0102573>] syscall_call+0x7/0xb
Code: c3 74 26 8b 4d 1c 39 4b 10 0f 95 c2 31 c0 85 ff 0f 94 c0 85 c2 b8 7a eb 2a c0 0f 45 f8 01 4c 24 14 ff 44 24 10 8b 1b eb cd 8b 1e <8b> 03 0f 18 00 90 39 f3 74 3c 8b 4b 10 3b 4d 1c 0f 94 c2 31 c0 
EIP: [<c0141475>] s_show+0x9d/0x203 SS:ESP 0068:da99df24
 <6>note: grep[7688] exited with preempt_count 1
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0140a53
*pde = 00000000
Oops: 0002 [#2]
PREEMPT 
Modules linked in: snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd uhci_hcd usbcore
CPU:    0
EIP:    0060:[<c0140a53>]    Not tainted VLI
EFLAGS: 00010046   (2.6.17-a39727f212426b9d5f9267b3318a2afaf9922d3b #1) 
EIP is at cache_alloc_refill+0xd0/0x179
eax: 00000000   ebx: 0000003b   ecx: 00000000   edx: defedac0
esi: deab2000   edi: defedac0   ebp: defe6e00   esp: dee12e94
ds: 007b   es: 007b   ss: 0068
Process rm (pid: 7687, ti=dee12000 task=c1482540 task.ti=dee12000)
Stack: 00000000 000000d0 defe7ac0 defe7ac0 00000287 c17ef000 ffffff9c c0140c8b 
       dee12f40 00000003 c0143bb0 00000000 00000000 00000000 00000000 dee12f40 
       c17ef000 c014f39f dee12f40 ffffff9c c17ef000 ffffff9c c014f40a dee12f40 
Call Trace:
 [<c0140c8b>] kmem_cache_alloc+0x26/0x2f
 [<c0143bb0>] get_empty_filp+0x4f/0xf2
 [<c014f39f>] __path_lookup_intent_open+0x13/0x6f
 [<c014f40a>] path_lookup_open+0xf/0x13
 [<c014fa00>] open_namei+0x7a/0x566
 [<c0142789>] do_filp_open+0x1c/0x31
 [<c0155ae1>] dput+0x1a/0x15a
 [<c0150447>] do_rmdir+0xab/0xb4
 [<c01428c8>] get_unused_fd+0x4e/0xae
 [<c01429eb>] do_sys_open+0x34/0x65
 [<c0142a32>] sys_open+0x16/0x18
 [<c0102573>] syscall_call+0x7/0xb
Code: 8b 5d 00 31 c9 89 f2 8d 43 01 89 45 00 8b 44 24 08 e8 75 fd ff ff 89 44 9d 10 8b 54 24 08 8b 42 1c 39 46 10 72 d1 8b 56 04 8b 06 <89> 50 04 89 02 c7 46 04 00 02 20 00 83 7e 14 ff c7 06 00 01 10 
EIP: [<c0140a53>] cache_alloc_refill+0xd0/0x179 SS:ESP 0068:dee12e94
 <6>note: rm[7687] exited with preempt_count 1

