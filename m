Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWAXVNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWAXVNV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWAXVNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:13:20 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:14095 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750713AbWAXVNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:13:20 -0500
Date: Tue, 24 Jan 2006 22:13:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chris Lightfoot <chris@ex-parrot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel freeze on 2.4.32, apparently in cached_lookup
Message-ID: <20060124211311.GV7142@w.ods.org>
References: <tQjo3cDibk0S.MeaWngl+j1QiYR1U5+Ih3w@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tQjo3cDibk0S.MeaWngl+j1QiYR1U5+Ih3w@sphinx.mythic-beasts.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 24, 2006 at 05:49:28PM +0000, Chris Lightfoot wrote:
> I have a Pentium 4 machine running stock kernel 2.4.32
> with ext3 on LVM on software RAID-1. HIMEM is enabled and
> the machine has 3GB of RAM. Various details of the machine
> and kernel as here:
> 
> http://ex-parrot.com/~chris/tmp/20060124/caesious-.config
> http://ex-parrot.com/~chris/tmp/20060124/caesious-cpuinfo
> http://ex-parrot.com/~chris/tmp/20060124/caesious-lsmod
> http://ex-parrot.com/~chris/tmp/20060124/caesious-lspci
> 
> Occasionally -- often when running updatedb or another
> disk-heavy cron job, but sometimes during normal use of
> the machine -- the machine freezes up almost entirely
> (mouse pointer stops working, ditto VC switching, no
> console output if on the text console, SSH sessions
> freeze, but network packet forwarding and NAT still work).
> There's no output on the VGA console and the machine
> doesn't respond to Ctrl-Alt-Sysrq, but does respond to
> break+... on the serial console. That gives sysrq-p output
> like this, from the most recent freeze:
> 
> SysRq : Show Regs
> Pid: 30641, comm:             updatedb
> EIP: 0010:d_lookup+63/110 CPU: 0 EFLAGS: 00000287    Tainted: P
> EAX: c8632710 EBX: c8632700 ECX: 00000012 EDX: 13fe1842
> ESI: d373b000 EDI: 0003ffff EBP: ea93bedc DS: 0018 ES: 0018
> CR0: 8005003b CR2: 080a4094 CR3: 2965b000 CR4: 000006d0
> Call Trace: cached_lookup+11/50 link_path_walk+63b/900 vfs_permission+79/120 path_lookup+1e/30 __user_walk+2b/50 sys_lstat64+17/70 system_call+33/38
> 
> -- repeating sysrq+p suggests that the kernel is stuck in 
> d_lookup:
> 
> http://ex-parrot.com/~chris/tmp/20060124/caesious-regs-symbols
> 
> There's no oops or other message logged.
> 
> (I'm running a uniprocessor kernel -- the SMP kernel also
> freezes under similar circumstances, and I wanted to
> eliminate the SMP code as a source of problems.)
> 
> Does this look like a known problem? If not, what should I
> do next to track down the problem? In particular, what
> other information should I try to collect next time it
> freezes?

It seems a little weird. I've never seen such a case yet, but
found a few ones looking like yours, but there is nothing
common between them (various FS, +/- highmem, ...) and all
of them only report oops or panics. No interesting response
anyway.

What seems strange in your report is that the kernel freezes.
The only part in cached_lookup() which could freeze IMHO is
when it calls d_lookup(), but for this, you should have a
closed loop instead of a linked list. It could happen with
some memory corruption, but you would get far more oopses
and panics than freezes. For this reason, I believe you
might have some random problem on your filesystem. Could
you run a full fsck on it ?

If it does not find anything, probably that a night-long
memtest will give us some indications.

> (Please cc replies to me if possible....)

Regards,
Willy

