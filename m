Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263205AbUEQXvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUEQXvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUEQXvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:51:47 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16791
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262547AbUEQXuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:50:50 -0400
Date: Tue, 18 May 2004 01:50:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: steiner@sgi.com, paulmck@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040517235048.GJ3044@dualathlon.random>
References: <20040501120805.GA7767@sgi.com> <20040502182811.GA1244@us.ibm.com> <20040503184006.GA10721@sgi.com> <20040507205048.GB1246@us.ibm.com> <20040507220654.GA32208@sgi.com> <20040507163235.11cd94ce.akpm@osdl.org> <20040517211834.GI3044@dualathlon.random> <20040517144228.7172d681.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517144228.7172d681.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 02:42:28PM -0700, Andrew Morton wrote:
> This issue has gone all quiet.  Is anyone doing aything?

dunno

> Sounds sensible.  Could you please send out the patch?

this is the 2.4 version but problem is this logic will now work fine on
UP or small SMP, but it will be very detrimental on the 256-way, so we
may want to address the dcache-rcu problem first? (my wild guess is that
renames are less frequent than unlinks).

diff -urNp 2.4.19pre9/fs/dcache.c neg-dentry-ref/fs/dcache.c
--- 2.4.19pre9/fs/dcache.c	Wed May 29 02:12:36 2002
+++ neg-dentry-ref/fs/dcache.c	Wed May 29 04:19:13 2002
@@ -806,6 +806,7 @@ out:
  
 void d_delete(struct dentry * dentry)
 {
+#ifdef DENTRY_WASTE_RAM
 	/*
 	 * Are we the only user?
 	 */
@@ -815,6 +816,7 @@ void d_delete(struct dentry * dentry)
 		return;
 	}
 	spin_unlock(&dcache_lock);
+#endif
 
 	/*
 	 * If not, just drop the dentry and let dput
diff -urNp 2.4.19pre9/fs/namei.c neg-dentry-ref/fs/namei.c
--- 2.4.19pre9/fs/namei.c	Wed May 29 02:12:36 2002
+++ neg-dentry-ref/fs/namei.c	Wed May 29 04:20:45 2002
@@ -1042,6 +1042,10 @@ do_last:
 		error = vfs_create(dir->d_inode, dentry,
 				   mode & ~current->fs->umask);
 		up(&dir->d_inode->i_sem);
+#ifndef DENTRY_WASTE_RAM
+		if (error)
+			d_drop(dentry);
+#endif
 		dput(nd->dentry);
 		nd->dentry = dentry;
 		if (error)

> If the writer wants synchronous-removal semantics, yes.
> 
> The problem here and, I believe, in the route cache is in finding a balance
> between the amount of storage and the frequency of RCU callback runs.

RCU is by design an asynchronous-removal. The problem is the "latency"
of this asynchronous-removal, so the time between the request-of-freeing
and the effective release of the memory. Jack's patch increases the
latency of reaching a quiescent point a lot (this is fine as far as he
has enough memory) and reduces the overhead. He partically removed
completely the contention on the spinlock, so the cpu will not waste any
time spinning and trashing the cacheline everywhere.

The problem is that there is a "max latency" we can allow under any
certain workload, before throttling on rcu (normally inside the VM due
memory exaustion, or like in the routing cache case throttling by losing
incoming packets). So again, for not-frequent writer, rcu is fine and
Jack's approch is fine too and it solves the contention problem
completely. For frequent writer like the dcache, rcu is much more
problematic, and here we're even ignoring the fact that on all machines
calling rcu for the writer is more expensive than taking a write_lock,
so if there's no reader to optimize, there's nearly no point to use RCU.
This even ignoring the fact current rcu implementation will spin on the
spinlock (but we could change that like Jack did).

An improvement over Jack's patch that will likely not increase the
latency much, is to minimize as much as possible the delay between the
processing of cpu0 then cpu1 then cpu2 etc.. The basic logic of Jack's
patch is to _serialize_ the rcu_check_callbacks. By serializing it cpu
after cpu, he removes the contention on the lock, but there's absolutely
no reason to leave millisecond delays in between cpus, so using IPI to
queue the next callback in the next cpu would solve the problem as well
as Jack's patch but without increasing latency as much as he did.
Problem is that sending IPIs from softirq context is not allowed, like
queuing tasklets in other cpus is not allowed. So there's no easy fix
other than Jack's huge-latency-increase one, but that makes rcu not
suitable for frequent-writer case (probably not an issue for him with
some tera of ram and without zone-normal ;) but an issue for others).
And again, rcu is probably slower anyways for the frequent-writer case
(even on a 2-way), so it really should be used for frequent-reader, if
there's any legitimate frequent-writer rcu is troublesome, it's not that
rcu isn't designed for huge machines, rcu is _perfect_ for huge
machines, but only as far as you don't mind running the writer
frequently during production (like it can happen with dcache). RCU is
like the big reader lock, but it's much better than the big reader lock.

Routing cache is less of an issue since the collection should happen
extremely infrequently in normal usages (it's not nearly similar to
calling unlink or rename in normal usages), but it's troublesome too if
you're under routing attack and you've to collect entries all the time.
