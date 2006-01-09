Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWAIPuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWAIPuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWAIPuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:50:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26517 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964840AbWAIPuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:50:09 -0500
Date: Mon, 9 Jan 2006 10:49:57 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: vm related lock up in 2.6.15
Message-ID: <20060109154957.GA9766@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20060109021230.GA23750@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109021230.GA23750@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 09:12:30PM -0500, Dave Jones wrote:
 > Ugh. I booted, ran fetchmail, and after picking up ~1000 mails,
 > this happened..
 > 
 > [ 1862.015381] ----------- [cut here ] --------- [please bite here ] ---------
 > [ 1862.036284] Kernel BUG at mm/swap.c:215
 > [ 1862.047770] invalid operand: 0000 [1] SMP
 > [ 1862.060059] last sysfs file: /block/hdc/removable
 > [ 1862.074153] CPU 2
 > [ 1862.080169] Modules linked in: loop radeon drm nfsd exportfs lockd nfs_acl ipv6 parport_pc lp parport autofs4 rfcomm l2cap bluetooth sunrpc ub video button battery ac ehci_hcdd
 > [ 1862.238941] Pid: 19748, comm: bash Not tainted 2.6.15-1.1826.2.4_FC5 #1
 > [ 1862.258786] RIP: 0010:[<ffffffff8016f1f2>] <ffffffff8016f1f2>{release_pages+111}
 > [ 1862.280467] RSP: 0018:ffff81001755fb98  EFLAGS: 00010046
 > [ 1862.296909] RAX: 0000000000000003 RBX: ffff8100014d4de0 RCX: ffff81000000ba80
 > [ 1862.318312] RDX: 0000000000000003 RSI: 0000000000000010 RDI: ffff81000000c400
 > [ 1862.339715] RBP: ffff81000000ba80 R08: 0000000000000004 R09: 0000000000000246
 > [ 1862.361117] R10: 000000000000000a R11: ffff810001e160c0 R12: ffff810002218720
 > [ 1862.382523] R13: 0000000000000005 R14: 0000000000000010 R15: 0000000000000010
 > [ 1862.403914] FS:  0000000000000000(0000) GS:ffffffff805ce100(0000) knlGS:0000000000000000
 > [ 1862.428178] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
 > [ 1862.445400] CR2: 0000000000516dc4 CR3: 000000000499b000 CR4: 00000000000006e0
 > [ 1862.466806] Process bash (pid: 19748, threadinfo ffff81001755e000, task ffff810036cda050)
 > [ 1862.491335] Stack: 0000000000000002 0000000000000000 ffff8100016f5ca0 ffff810001373758
 > [ 1862.514863]        ffff810002163970 ffff81000154f168 ffff810001943968 00007fffff8cd000
 > [ 1862.538910]        ffff81001755fc90 ffff8100039a27f8
 > [ 1862.554081] Call Trace:<ffffffff8017d8bc>{free_pages_and_swap_cache+115} <ffffffff801778cd>{exit_mmap+190}
 > [ 1862.583146]        <ffffffff8013709a>{mmput+37} <ffffffff8019123e>{flush_old_exec+2303}
 > [ 1862.607213]        <ffffffff801875d3>{vfs_read+305} <ffffffff801b211e>{load_elf_binary+0}
 > [ 1862.631826]        <ffffffff801b2585>{load_elf_binary+1127} <ffffffff80168c3b>{__alloc_pages+117}
 > [ 1862.658533]        <ffffffff8014e3d7>{autoremove_wake_function+0} <ffffffff801b211e>{load_elf_binary+0}
 > [ 1862.686777]        <ffffffff80190375>{search_binary_handler+177} <ffffffff801922c8>{do_execve+396}
 > [ 1862.713724]        <ffffffff8010fa50>{tracesys+209} <ffffffff8010e573>{sys_execve+54}
 > [ 1862.737257]        <ffffffff8010fcfe>{stub_execve+106}
 > [ 1862.753522]
 > [ 1862.753523] Code: 0f 0b 68 a4 ea 36 80 c2 d7 00 f0 83 43 08 ff 0f 98 c0 84 c0
 
Linus,
 Turns out this was your BUG_ON(page_count(p) <= page_mapcount(p));
addition to putpage_test_zero, which I added a few days ago and promptly
forgot about.

Triggering this isn't too difficult it seems :-/

		Dave
