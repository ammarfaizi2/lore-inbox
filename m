Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTKVHri (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 02:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTKVHri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 02:47:38 -0500
Received: from relay-3v.club-internet.fr ([194.158.96.114]:53704 "EHLO
	relay-3v.club-internet.fr") by vger.kernel.org with ESMTP
	id S262114AbTKVHrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 02:47:35 -0500
From: pinotj@club-internet.fr
To: torvalds@osdl.org
Cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Sat, 22 Nov 2003 08:47:34 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1069487254.8717.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Summary: Oops reproductible when heavy load, bug in mm/slab.c
>
>Do you have CONFIG_PREEMPT on, and if so, does it go away if you compile
>without PREEMPT? We have at least one other bug that seems to be dependent
>on CONFIG_PREEMPT.
>
>		Linus

Yes, I have CONFIG_PREEMPT=y in my .config
I will try without next time.

Here is the result about what asked Manfred.
In my logs, I found:
---
Nov 21 05:46:48 gegenux kernel: slab: double free detected in cache 'buffer_head', objp c4c8e3d8, objnr 10, slabp c4c8e000,
Nov 21 05:46:49 gegenux kernel: slab: double free detected in cache 'buffer_head', objp c9a582ac, objnr 5, slabp c9a58000,
Nov 21 07:01:50 gegenux kernel: slab: double free detected in cache 'pte_chain', objp c18a6600, objnr 10, slabp c18a6000,
---

So the objnr can be different but it's in the same oops (look the time). The slabp always finish by 0xXXXXX000.

I compiled again with the patch you gave.
First compilation (kernel) no freeze, simple error of `as` but I got this in the logs:
---
slab error in cache_free_debugcheck(): cache `bio': double free, or memory outside object was overwritten
Call Trace:
 [kmem_cache_free+687/912] kmem_cache_free+0x2af/0x390
 [<c015b8cf>] kmem_cache_free+0x2af/0x390
 [mempool_free+224/544] mempool_free+0xe0/0x220
 [<c01535d0>] mempool_free+0xe0/0x220
 [mempool_free+224/544] mempool_free+0xe0/0x220
 [<c01535d0>] mempool_free+0xe0/0x220
 [kernel_map_pages+40/144] kernel_map_pages+0x28/0x90
 [<c0122bd8>] kernel_map_pages+0x28/0x90
 [bio_destructor+57/96] bio_destructor+0x39/0x60
 [<c01816f9>] bio_destructor+0x39/0x60
 [bio_put+41/64] bio_put+0x29/0x40
 [<c01818e9>] bio_put+0x29/0x40
 [end_bio_bh_io_sync+56/64] end_bio_bh_io_sync+0x38/0x40
 [<c0180e18>] end_bio_bh_io_sync+0x38/0x40
 [bio_endio+77/128] bio_endio+0x4d/0x80
--cut--
[background_writeout+0/176] background_writeout+0x0/0xb0
 [<c01568a0>] background_writeout+0x0/0xb0
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
 [<c01092a9>] kernel_thread_helper+0x5/0xc

c6fd7870: redzone 1: 0x170fc2a5, redzone 2: 0x160fc2a5.
---
System looks OK, I tried a second compilation just after and this time I got an oops:
---
slab: double free detected in cache 'buffer_head', objp cc3f9798, objnr 26, slabp cc3f9000, s_mem cc3f9180 bufctl f7ffffff.

mm/slab.c:1777: spin_lock(mm/slab.c:cffed844) already locked by mm/slab.c/1994
---cut---
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at mm/slab.c:1956!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[free_block+363/784]    Not tainted
EIP:    0060:[<c015ad6b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010092
eax: 0000007f   ebx: 0000000a   ecx: c06973dc   edx: c05712f8
esi: cc3f9000   edi: cc3f9018   ebp: cf821c68   esp: cf821c34
ds: 007b   es: 007b   ss: 0068
Stack: c0504d00 c05058fd cc3f9798 0000001a cc3f9000 cc3f9180 f7ffffff 0000001a
       cc3f9798 0000000b cffdef08 c3bb8180 00000010 cf821ca0 c015afea cffed800
       cffdef08 00000010 cf821ce8 c010cabc 80010c00 cd37e000 cffee730 00000010
Call Trace:
 [<c015afea>] cache_flusharray+0xda/0x2b0
 [<c010cabc>] common_interrupt+0x18/0x20
 [<c015b7cd>] kmem_cache_free+0x1ad/0x39
---cut---

You can find the complete log here:
http://cercle-daejeon.homelinux.org/oops-log.txt

Hope this will help...

Jerome


