Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbTIJQ6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbTIJQ6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:58:15 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32926
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265264AbTIJQ6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:58:12 -0400
Date: Wed, 10 Sep 2003 18:59:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910165944.GL21086@dualathlon.random>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f201c376f8$231d5e00$beae7450@wssupremo>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ciao Luca,

On Tue, Sep 09, 2003 at 07:30:58PM +0200, Luca Veraldi wrote:
> Hi all.
> At the web page
> http://web.tiscali.it/lucavera/www/root/ecbm/index.htm
> You can find the results of my attempt in modifing the linux kernel sources
> to implement a new Inter Process Communication mechanism.
> 
> It is called ECBM for Efficient Capability-Based Messaging.
> 
> In the reading You can also find the comparison of ECBM 
> against some other commonly-used Linux IPC primitives 
> (such as read/write on pipes or SYS V tools).
> 
> The results are quite clear.

in terms of design as far as I can tell the most efficient way to do
message passing is not pass the data through the kernel at all (no
matter if you intend to copy it or not), and to simply use futex on top
of shm to synchronize/wakeup the access.  If we want to make an API
widespread, that should be simply an userspace library only.

It's very inefficient to mangle pagetables and flush the tlb in a flood
like you're doing (or better like you should do), when you can keep the
memory mapped in *both* tasks at the same time *always* and there's no
need of any kernel modification at all for that much more efficient
design that I'm suggesting. Obviously lots of apps are already using
this design and there's no userspace API simply because that's not
needed. The only thing we need from the kernel is the wakeup mechanism
and that's already provided by the futex (in the past userspae apps
using this design used sched_yield, and that was very bad).

About the implementation - the locking looks very wrong: you miss the
page_table_lock in all the pte walking, you take a totally worthless
lock_kernel() all over the place for no good reason, and the
unconditional set_bit(PG_locked) clear_bit(PG_locked) on random pieces
of ram almost guarantees that you'll corrupt ram quickly (the PG_locked
is reserved for I/O serialization, the same ram that you're working on
can be sent to disk or to swap by the kernel at the same time and it can
be already locked, you can't clear_bit unless you're sure you're the guy
that owns the lock, and you aren't sure because you didn't test if
you're the owner, so that smeels like an huge bug that will random
corrupt ram, like the pte walking race).

there's also an obvious DoS that is trivial to generate by locking in
ram some 64G of ram with ecbm_create_capability() see the for(count=0;
count<pages; ++count) atomic_inc (btw, you should use get_page, and all
the operations like LockPage to play with pages).

I also don't see where you flush the tlb after the set_pte, and where
you release the ram pointed by the pte (it seems you're leaking plenty
of memory that way).

I didn't check at all the credential checks (I didn't run into it while
reading the code, but I assume I overlooked it). (do you rely on a
random number? that's probably statistically secure, but we can
guarantee security on a local box, we must not work by luck whenever
possible)

this was a very quick review, hope this helps,

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
