Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVLISza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVLISza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVLISza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:55:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45487 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751115AbVLISz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:55:29 -0500
Date: Fri, 9 Dec 2005 13:55:21 -0500
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: 2.6.15rc5git1 cfq related spinlock bad magic
Message-ID: <20051209185521.GC7473@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org, zaitcev@redhat.com
References: <20051208045048.GC24356@redhat.com> <20051209104150.GF26185@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209104150.GF26185@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 11:41:50AM +0100, Jens Axboe wrote:
 > On Wed, Dec 07 2005, Dave Jones wrote:
 > > Just as I shutdown my desktop, this popped out..
 > > 
 > > [311578.273186] BUG: spinlock bad magic on CPU#1, pdflush/30788 (Not tainted)
 > > [311578.293858] general protection fault: 0000 [1] SMP
 > > [311578.308773] CPU 1
 > > [311578.315046] Modules linked in: loop vfat fat radeon drm nfsd exportfs lockd nfs_acl ipv6 lp autofs4 rfcomm l2cap bluetooth suDec  6 03:05:39 nwo kernel: [311578.480129] Pid: 30788, comm: pdflush Not tainted 2.6.14-1.1735_FC5 #1
 > > [311578.499972] RIP: 0010:[<ffffffff8021f8bd>] <ffffffff8021f8bd>{spin_bug+138}
 > > [311578.520605] RSP: 0018:ffff8100307f1e68  EFLAGS: 00010082
 > > [311578.537316] RAX: 00000000c4be8326 RBX: e6491e0e0968bacd RCX: ffffffff804661d8
 > > [311578.558988] RDX: 0000000000000001 RSI: 0000000000000092 RDI: ffffffff804661c0
 > > [311578.580658] RBP: ffff810039fc2000 R08: 0000000000000002 R09: 0000000000000000
 > > [311578.602317] R10: 0000000000000000 R11: ffff810002aec808 R12: ffffffff8039e204
 > > [311578.623985] R13: ffff81003b2e7c48 R14: 0000000000000000 R15: ffffffff80152c90
 > > [311578.645643] FS:  0000000000000000(0000) GS:ffffffff805fd080(0000) knlGS:0000000000000000
 > > [311578.670184] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
 > > [311578.687672] CR2: 00002aaaaabe5093 CR3: 000000003d3f7000 CR4: 00000000000006e0
 > > [311578.709338] Process pdflush (pid: 30788, threadinfo ffff8100307f0000, task ffff81003dbc6780)
 > > [311578.734914] Stack: ffff810039fc2000 ffff81003edaa8b0 ffff8100031a00d0 ffffffff8021fbdb
 > > [311578.758699]        ffff81003c480630 ffffffff802174a4 ffff81003edaa8b0 ffff810004764928
 > > [311578.783015]        0000000000000286 ffffffff80217527
 > > [311578.798449] Call Trace:<ffffffff8021fbdb>{_raw_spin_lock+25} <ffffffff802174a4>{cfq_exit_single_io_context+85}
 > > [311578.828782]        <ffffffff80217527>{cfq_exit_io_context+33} <ffffffff8020d07d>{exit_io_context+137}
 > > [311578.856762]        <ffffffff8013f937>{do_exit+183} <ffffffff80152c90>{keventd_create_kthread+0}
 > > [311578.883192]        <ffffffff80110c25>{child_rip+15} <ffffffff80152c90>{keventd_create_kthread+0}
 > > [311578.909852]        <ffffffff80152d86>{kthread+0} <ffffffff80110c16>{child_rip+0}
 > > [311578.932353]
 > > [311578.939431]
 > > [311578.939432] Code: 44 8b 83 1c 01 00 00 48 8d 8b f8 02 00 00 8b 55 04 41 89 c1
 > > 
 > > 
 > > Haven't managed to reproduce it since, but this came up a few weeks
 > > ago, just before we released Fedora Core 5 test1  (We defaulted to
 > > a different elevator for that test release just in case it blew up
 > > during installation), since flipping it back on, it's behaved, until now.
 > 
 > Hmm nasty, the queue was already gone when the task exited, this should
 > not happen since the task io context holds a reference to it. We had
 > this bug before, because SCSI didn't honor the life time rules of the
 > lock inside the queue, but I fixed that long ago.

 > What types of devices do you use on this machine? Not just statically,
 > but also any devices you may have inserted/removed during the uptime of
 > that machine.

There was likely a usb memory key, and a 5-in-1 card reader plugged in
at the time. Possibly a usb hard disk too.

Hmm, I may have also been experimenting at the time with Pete Zaitcev's
ub driver. Pete, could ub have been doing something bad here?
Actually, looking at the Fedora kernel changelogs, the cfq oopses we
saw started happening shortly after we enabled ub there too.

		Dave

