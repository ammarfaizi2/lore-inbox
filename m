Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270790AbUJUR54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270790AbUJUR54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270781AbUJUR5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:57:45 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:24786 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S270774AbUJURyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:54:51 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16759.63466.507400.649099@thebsh.namesys.com>
Date: Thu, 21 Oct 2004 21:54:50 +0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
In-Reply-To: <20041021164018.GA11560@elte.hu>
References: <20041014143131.GA20258@elte.hu>
	<20041014234202.GA26207@elte.hu>
	<20041015102633.GA20132@elte.hu>
	<20041016153344.GA16766@elte.hu>
	<20041018145008.GA25707@elte.hu>
	<20041019124605.GA28896@elte.hu>
	<20041019180059.GA23113@elte.hu>
	<20041020094508.GA29080@elte.hu>
	<20041021132717.GA29153@elte.hu>
	<4177FAB0.6090406@spymac.com>
	<20041021164018.GA11560@elte.hu>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > * Gunther Persoons <gunther_persoons@spymac.com> wrote:
 > 
 > > The kernel booted now with my firewire card plugged in. However when i
 > > try to mount my reiser4 partition i get following error
 > > 
 > > BUG: semaphore recursion deadlock detected!
 > > .. current task mount/10514 is already holding ccb5bb4c.
 > 
 > > [<c0344760>] down_write+0x103/0x1a6 (48)
 > > [<d0b26a08>] kcond_wait+0xaa/0xac [reiser4] (36)
 > > [<d0b280b0>] start_ktxnmgrd+0x98/0x9a [reiser4] (36)
 > > [<d0b33716>] reiser4_fill_super+0x3b/0x71 [reiser4] (28)
 > > [<d0b2d569>] reiser4_get_sb+0x2f/0x33 [reiser4] (68)
 > > [<c016061a>] do_kern_mount+0x4f/0xc0 (4)
 > > [<c0175945>] do_new_mount+0x9c/0xe1 (36)
 > > [<c0175feb>] do_mount+0x145/0x194 (44)
 > > [<c0176459>] sys_mount+0x9f/0xe0 (32)
 > > [<c01060b1>] sysenter_past_esp+0x52/0x71 (44)
 > 
 > reiser4 has some pretty ugly locking abstraction called kcond, i took a

It's fairly standard condition variable.

 > look but it doesnt seem simple to convert it. Reiserfs should really use
 > a normal Linux waitqueue and nothing more...

Why? Condition variable is very well known and widely used concept. In
the area of their applicability (where predicate whose change is waited
upon is protected by a single lock) they provide clean and easily
recognizable synchronization device.

Real problem in this case is failure of "semaphore deadlock detection"
to cope with perfectly legal semaphore usage (down() by thread T1, up()
by thread T2). As one possible solution kcond can be re-written on top
of beloved "normal Linux waitqueue".

Nikita.
 
 > 
 > 	Ingo

