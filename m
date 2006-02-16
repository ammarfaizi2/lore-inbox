Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWBPTTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWBPTTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWBPTTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:19:10 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:46526 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932553AbWBPTTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:19:08 -0500
Date: Thu, 16 Feb 2006 21:19:43 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: lru_list_lock in 2.4.x
Message-ID: <20060216191942.GA21616@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is it possible (under 2.4.27) that lru_list_lock gets locked somewhere 
and never released?

I'm asking that because I've hit a situation where kswapd spinlocks forever 
in inode_has_buffers() and the other cpu (this is an SMP system) spinned 
on inode_lock (which was locked by kswapd before it started spinning on 
lru_list_lock).

Normally you wouldn't be able to get a stack-dump in this scenario (without 
NMI) but since I got KDB patch in, here it is:

[1]kdb> btc
btc: cpu status: Currently on cpu 1
Available cpus: 0, 1
Stack traceback for pid 1587
0xb3d78000     1587     1586  1    0   R  0xb3d78280  manager
ESP        EIP        Function (args)
0xb3d79f00 0x8015ba8e .text.lock.inode+0x197
                               kernel .text 0x80100000 0x8015b8f7 0x8015bb30
0xb3d79f00 0x8015afd7 new_inode+0x17 (0x88f36400, 0x1, 0x2)
                               kernel .text 0x80100000 0x8015afc0 0x8015b030
0xb3d79f0c 0x8026931c sock_alloc+0x1c (0x0, 0x0, 0x0, 0x0, 0x20)
                               kernel .text 0x80100000 0x80269300 0x802693d0
0xb3d79f20 0x80269ec6 sock_create+0x86 (0x2, 0x1, 0x0, 0xb3d79f70, 0x1)
                               kernel .text 0x80100000 0x80269e40 0x80269f80
0xb3d79f60 0x80269fa9 sys_socket+0x29 (0x2, 0x1, 0x0, 0xb3d79fa8, 0x7f7ffaa4)
                               kernel .text 0x80100000 0x80269f80 0x80269fe0
0xb3d79f80 0x8026ae5d sys_socketcall+0x6d (0x1, 0x7f7ffa2c, 0x102df26c, 0x80d4bf0, 0x80d4cf0)
                               kernel .text 0x80100000 0x8026adf0 0x8026b030
0xb3d79fc4 0x80109213 system_call+0x33
                               kernel .text 0x80100000 0x801091e0 0x80109218
Stack traceback for pid 5
0xbff48000        5        1  1    1   R  0xbff48280 *kswapd
ESP        EIP        Function (args)
[1]more>
Only 'q' or 'Q' are processed at more prompt, input ignored
0xbff49ef8 0x80144bdb inode_has_buffers+0xb (0xa04c1d80, 0x8, 0xb7757508, 0xa03ceb88, 0x0)
                               kernel .text 0x80100000 0x80144bd0 0x80144c10
0xbff49efc 0x8015aeb8 prune_icache+0xa8 (0x1e)
                               kernel .text 0x80100000 0x8015ae10 0x8015af10
0xbff49f20 0x8015af37 shrink_icache_memory+0x27 (0x6, 0x1d0, 0xbff48000, 0xffffffff, 0x78ce)
                               kernel .text 0x80100000 0x8015af10 0x8015af50
0xbff49f2c 0x80139ebd shrink_cache+0x18d (0xbff49f84, 0x1d0, 0x3c, 0x20)
                               kernel .text 0x80100000 0x80139d30 0x8013a150
0xbff49f5c 0x8013a309 shrink_caches+0x49 (0xbff49f84, 0x8a5c8000, 0x0, 0x803cd4bc, 0x0)
                               kernel .text 0x80100000 0x8013a2c0 0x8013a320
0xbff49f74 0x8013a382 try_to_free_pages_zone+0x62 (0x803cd4bc, 0x0, 0x803cd3e0, 0x0, 
0xbff48251)
                               kernel .text 0x80100000 0x8013a320 0x8013a410
0xbff49f9c 0x8013a54c kswapd_balance_pgdat+0x6c (0x803cd3e0, 0xbff48000, 0xbff49fd0)
                               kernel .text 0x80100000 0x8013a4e0 0x8013a590
0xbff49fb8 0x8013a5b8 kswapd_balance+0x28 (0x803d9700, 0x0, 0xbff48000, 0x0, 0x0)
                               kernel .text 0x80100000 0x8013a590 0x8013a5d0
0xbff49fcc 0x8013a70d kswapd+0x9d
                               kernel .text 0x80100000 0x8013a670 0x8013a727
0xbff49ff4 0x8010763e arch_kernel_thread+0x2e
                               kernel .text 0x80100000 0x80107610 0x80107650


Thanks,

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
