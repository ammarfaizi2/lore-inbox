Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSLBAOs>; Sun, 1 Dec 2002 19:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSLBAOs>; Sun, 1 Dec 2002 19:14:48 -0500
Received: from [195.223.140.107] ([195.223.140.107]:49326 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S262875AbSLBAOq>;
	Sun, 1 Dec 2002 19:14:46 -0500
Date: Mon, 2 Dec 2002 01:21:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nuno Monteiro <nuno@itsari.org>
Cc: linux-kernel@vger.kernel.org, jmarcet@pobox.com, andrew@sol-1.demon.co.uk,
       jamagallon@able.es, khromy@lnuxlab.ath.cx, conman@kolivas.net
Subject: Re: Exaggerated swap usage
Message-ID: <20021202002108.GQ28164@dualathlon.random>
References: <20021130182345.GA21410@lnuxlab.ath.cx> <20021130184317.GH28164@dualathlon.random> <20021201075921.GC2483@jerry.marcet.dyndns.org> <20021201103643.GL28164@dualathlon.random> <20021201143713.GA871@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021201143713.GA871@hobbes.itsari.int>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 02:37:13PM +0000, Nuno Monteiro wrote:
> Pid: 2, comm:              keventd
> EIP: 0010:[<c0142ae3>] CPU: 0 EFLAGS: 00000206    Not tainted
> EAX: c10ec45c EBX: 00000033 ECX: c11f8838 EDX: 40000000
> ESI: c2fed680 EDI: c10ec400 EBP: 00000033 DS: 0018 ES: 0018
[..]
> >>EIP; c0142ae3 <try_to_sync_unused_inodes+1f/1f8>   <=====
> 
> >>EAX; c10ec45c <_end+e521e4/13c9de8>
> >>ECX; c11f8838 <_end+f5e5c0/13c9de8>
> >>ESI; c2fed680 <[sb].data.end+a7ffd/25a9dd>
> >>EDI; c10ec400 <_end+e52188/13c9de8>
> 
> Trace; c0117114 <__run_task_queue+4c/60>
> Trace; c011e0e9 <context_thread+11d/19c>
> Trace; c010588c <kernel_thread+28/38>

ok, now it's clear what the problem is. there are inuse-dirty inodes
that triggers a deadlock in the schedule-capable
try_to_sync_unused_inodes of 2.4.20rc2aa1 (that avoided me to backout an
otherwise corrupt lowlatency fix). It can trigger only in UP,
in SMP the other cpu can always run kupdate that will flush all dirty
inodes, so it would lockup one cpu as worse for 2.5 sec, this is
probably why I couldn't reproduce it, I assume all of you reproducing
the deadlock were running on an UP machine (doesn't matter if the kernel
was compiled for SMP or not).

Can you give a spin to this untested incremental fix?

--- 2.4.20rc2aa1/fs/inode.c.~1~	2002-11-27 10:04:43.000000000 +0100
+++ 2.4.20rc2aa1/fs/inode.c	2002-12-02 01:09:05.000000000 +0100
@@ -459,13 +459,16 @@ static void try_to_sync_unused_inodes(vo
 {
 	struct super_block * sb;
 	int nr_inodes = inodes_stat.nr_unused;
+	int global_pass = 0, local_pass;
 
  restart:
 	spin_lock(&sb_lock);
+	local_pass = 0;
 	sb = sb_entry(super_blocks.next);
 	while (nr_inodes && sb != sb_entry(&super_blocks)) {
-		if (list_empty(&sb->s_dirty)) {
+		if (local_pass < global_pass || list_empty(&sb->s_dirty)) {
 			sb = sb_entry(sb->s_list.next);
+			local_pass++;
 			continue;
 		}
 		sb->s_count++;
@@ -474,6 +477,7 @@ static void try_to_sync_unused_inodes(vo
 		if (sb->s_root)
 			nr_inodes = try_to_sync_unused_list(&sb->s_dirty, nr_inodes);
 		drop_super(sb);
+		global_pass = local_pass + 1;
 		goto restart;
 	}
 	spin_unlock(&sb_lock);

thanks,

Andrea
