Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264308AbUFHWdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUFHWdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 18:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUFHWdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 18:33:39 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51693
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264308AbUFHWdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 18:33:35 -0400
Date: Wed, 9 Jun 2004 00:33:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: downgrade_write replacement in remap_file_pages
Message-ID: <20040608223331.GM18083@dualathlon.random>
References: <20040608154438.GK18083@dualathlon.random> <20586.1086714308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20586.1086714308@redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 06:05:08PM +0100, David Howells wrote:
> 
> > Apparently downgrade_write deadlocks the kernel in the mmap_sem
> > under load.
> 
> Which implementation of rwsems is your kernel using? The spinlock-based one or
> the XADD based one? Have you tried the other version?

stock 2.6 rwsem implementation compiled for PII (I still have tons of
patches to forward port from 2.4-aa, if I would port my rwsem to 2.6 I
would have never noticed this race)

> Have you more than 32767 processes?

no, there should be around 10k processes, sure not more than 20k.

> Do you have any stack traces?

yes:

strace:

open("/proc/6022/stat", O_RDONLY)       = 6
read(6, 

SYSRQ+T

 [<c01fa365>] rwsem_down_read_failed+0x85/0x121
 [<c01a0da9>] .text.lock.array+0x49/0xd0
 [<c01e4412>] avc_has_perm+0x62/0x78
 [<c01e5ba3>] inode_has_perm+0x53/0x90
 [<c019d3b1>] proc_info_read+0x51/0x150
 [<c016ada1>] vfs_read+0xe1/0x130
 [<c016b001>] sys_read+0x91/0xf0

it's the down_read in proc_pid_stat. the workload running at the same
time is heavy remap_file_pages. They're processes so the only race
happens against the /proc filesystem and that's why it hangs there.
Somehow downgrade_write in remap_file_pages races with down_read in
/proc. My patch workarounds the deadlock by not calling downgrade_write,
but I posted it to l-k because my code is better anyways since there's
no good reason to ever call down_write in the fast path (and if we don't
start down_write we don't need downgrade_write anymore). The only thing
bitten by downgrade_write left is xfs.

You can imagine which is the critical apps that triggers this deadlock,
not many apps are using remap_file_pages in production yet, and very few
are going to call it in a flood.

I agree with Andrew the limit of 32k processes needs fixing, but nobody
noticed yet with any real app, so it's a low prio matter.
