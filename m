Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWE3T4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWE3T4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWE3T4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:56:00 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:19859 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932452AbWE3Tz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:55:59 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Arjan van de Ven <arjan@linux.intel.com>
To: akpm@osdl.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0605301139l2b4895d0mbecffb422fb2c0cf@mail.gmail.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605301139l2b4895d0mbecffb422fb2c0cf@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 May 2006 21:55:46 +0200
Message-Id: <1149018946.3636.107.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 20:39 +0200, Michal Piotrowski wrote:
> Hi,
> 
> On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> >
> 
> I get this on 2.6.17-rc5-mm1 + hot fixes + Arjan's net/ipv4/igmp.c patch.

since Andrew asked how to read this stuff.....
> 
> May 30 20:25:56 ltg01-fedora kernel:
> May 30 20:25:56 ltg01-fedora kernel:
> =====================================================
> May 30 20:25:56 ltg01-fedora kernel: [ BUG: possible circular locking
> deadlock detected! ]

this message means basically an AB-BA deadlock is found

> May 30 20:25:56 ltg01-fedora kernel:
> -----------------------------------------------------
> May 30 20:25:56 ltg01-fedora kernel: umount/2322 is trying to acquire lock:
> May 30 20:25:56 ltg01-fedora kernel:  (sb_security_lock){--..}, at:
> [<c01d6400>] selinux_sb_free_security+0x17/0x4e
> May 30 20:25:56 ltg01-fedora kernel:
> May 30 20:25:56 ltg01-fedora kernel: but task is already holding lock:
> May 30 20:25:56 ltg01-fedora kernel:  (sb_lock){--..}, at:

we're holding "sb_lock" already, and are trying to get sb_security_lock

> [<c0178a89>] put_super+0x10/0x24
> May 30 20:25:56 ltg01-fedora kernel:
> May 30 20:25:56 ltg01-fedora kernel: which lock already depends on the new lock,

... but there was an observed code sequence before which was the other
way around ...
> May 30 20:25:56 ltg01-fedora kernel: which could lead to circular deadlocks!

yes.

> May 30 20:25:56 ltg01-fedora kernel:
> May 30 20:25:56 ltg01-fedora kernel: the existing dependency chain (in
> reverse order) is:

now it's going to print the previously observed behavior (backwards),
and give a backtrace of where that was acquired
> May 30 20:25:56 ltg01-fedora kernel:
> May 30 20:25:56 ltg01-fedora kernel: -> #1 (sb_lock){--..}:

since it prints backwards, this is the latest of the 2 locks taken in
the old situaion

> May 30 20:25:56 ltg01-fedora kernel:        [<c0139a56>]
> lockdep_acquire+0x69/0x82
> May 30 20:25:56 ltg01-fedora kernel:        [<c02f2171>] _spin_lock+0x21/0x2f
> May 30 20:25:56 ltg01-fedora kernel:        [<c01d72de>]
> selinux_complete_init+0x45/0xda

and it was in selinux_complete_init

for some reason the #0 is not being printed here (it normally is), which
would give a simliar backtrace. In this case it was ok,
selinux_complete_init was the sole guilty party.
 
> May 30 20:25:56 ltg01-fedora kernel:
> May 30 20:25:56 ltg01-fedora kernel: other info that might help us debug this:
> May 30 20:25:56 ltg01-fedora kernel:
now it's going to print all the locks we own currently, and where those
were taken; not just the ones that are part of the deadlock (that was
printed before)

> May 30 20:25:56 ltg01-fedora kernel: 1 locks held by umount/2322:
> May 30 20:25:56 ltg01-fedora kernel:  #0:  (sb_lock){--..}, at:
> [<c0178a89>] put_super+0x10/0x24

ok so in put_super we took sb_lock. [*]

> May 30 20:25:56 ltg01-fedora kernel:
> May 30 20:25:56 ltg01-fedora kernel: stack backtrace:
> May 30 20:25:56 ltg01-fedora kernel:  [<c0103e52>] show_trace_log_lvl+0x4b/0xf4
> May 30 20:25:56 ltg01-fedora kernel:  [<c01044b3>] show_trace+0xd/0x10
> May 30 20:25:56 ltg01-fedora kernel:  [<c010457b>] dump_stack+0x19/0x1b
> May 30 20:25:56 ltg01-fedora kernel:  [<c0138bd6>]
> print_circular_bug_tail+0x59/0x64
> May 30 20:25:56 ltg01-fedora kernel:  [<c0139429>] __lockdep_acquire+0x848/0xa39
> May 30 20:25:56 ltg01-fedora kernel:  [<c0139a56>] lockdep_acquire+0x69/0x82
> May 30 20:25:56 ltg01-fedora kernel:  [<c02f2171>] _spin_lock+0x21/0x2f

these are just the lockdep printing stuff

> May 30 20:25:56 ltg01-fedora kernel:  [<c01d6400>]
> selinux_sb_free_security+0x17/0x4e

but here it gets interesting; this is the function that triggered the
final deadlock message (well we knew that already from the first line of
the message), which gets called from

> May 30 20:25:56 ltg01-fedora kernel:  [<c0178a68>] __put_super+0x24/0x35
which gets called from

> May 30 20:25:56 ltg01-fedora kernel:  [<c0178a90>] put_super+0x17/0x24

... but wait we know this one already from where I put [*], so we're now
done. put_super takes sb_lock, then calls __put_super which calls
selinux_sb_free_security which takes sb_security lock.

>From the old pattern we knew the opposite order in
selinux_complete_init(), and we have our AB-BA deadlock


> May 30 20:25:56 ltg01-fedora kernel:  [<c01793a3>] deactivate_super+0xa3/0xad
> May 30 20:25:56 ltg01-fedora kernel:  [<c018e010>] mntput_no_expire+0x52/0x85
> May 30 20:25:56 ltg01-fedora kernel:  [<c017fcb0>]
> path_release_on_umount+0x15/0x18
> May 30 20:25:56 ltg01-fedora kernel:  [<c018f535>] sys_umount+0x292/0x2aa

well we also now know that it came from a sys_umount; that might help
chasing stuff down if it's more fuzzy than this example


