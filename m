Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWHEAbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWHEAbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 20:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWHEAbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 20:31:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11957 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422672AbWHEAbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 20:31:48 -0400
Date: Fri, 4 Aug 2006 20:31:42 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060805003142.GH18792@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	LKML <linux-kernel@vger.kernel.org>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com> <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org> <20060804222400.GC18792@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804222400.GC18792@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 06:24:00PM -0400, Dave Jones wrote:
 >  > DaveJ, any ideas?
 > 
 > So I'm at a loss to explain why this made this bug suddenly appear, but
 > I don't think this is anything new.   Fixing it however...
 > I'm looking at it, but I don't see anything obvious yet.
 
Ok, debugging this is getting ridiculous.  I dug out a core duo,
built a kernel and watched it spontaneously reboot before it even got to init.
Digging out a serial cable yielded this gem:


Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1020104k/1047108k available (2082k kernel code, 26324k reserved, 1107k data, 240k init, 129604k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
swapper/0 is trying to acquire lock:
 (cpu_bitmask_lock){--..}, at: [<c0304e9c>] mutex_lock+0x21/0x24

but task is already holding lock:
 (cpu_bitmask_lock){--..}, at: [<c0304e9c>] mutex_lock+0x21/0x24

other info that might help us debug this:
1 lock held by swapper/0:
 #0:  (cpu_bitmask_lock){--..}, at: [<c0304e9c>] mutex_lock+0x21/0x24

stack backtrace:
 [<c0104edc>] show_trace_log_lvl+0x58/0x152
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013ae05>] __lock_acquire+0x74f/0x96d
 [<c013b566>] lock_acquire+0x4b/0x6d
 [<c0304d35>] __mutex_lock_slowpath+0xb0/0x1f6
 [<c0304e9c>] mutex_lock+0x21/0x24
 [<c013e8d4>] lock_cpu_hotplug+0x4a/0x4c
 [<c016bed3>] kmem_cache_create+0x61/0x577
 [<c04af5a1>] kmem_cache_init+0x177/0x38c
 [<c049c5f3>] start_kernel+0x221/0x3b3
 [<c0100210>] 0xc0100210
DWARF2 unwinder stuck at 0xc0100210
Leftover inexact backtrace:
 =======================
 =======================
 =======================
bad: scheduling from the idle thread!
 [<c0104edc>] show_trace_log_lvl+0x58/0x152
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c03035a6>] schedule+0xa6/0x9d3
 [<c0304d95>] __mutex_lock_slowpath+0x110/0x1f6
 [<c0304e9c>] mutex_lock+0x21/0x24
 [<c013e8d4>] lock_cpu_hotplug+0x4a/0x4c
 [<c016bed3>] kmem_cache_create+0x61/0x577
 [<c04af5a1>] kmem_cache_init+0x177/0x38c
 [<c049c5f3>] start_kernel+0x221/0x3b3
 [<c0100210>] 0xc0100210
DWARF2 unwinder stuck at 0xc0100210
Leftover inexact backtrace:
 =======================
 =======================
 =======================

<Insert reboot here>

Waaaay before cpufreq even enters the picture.

Sigh.

		Dave

-- 
http://www.codemonkey.org.uk
