Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWGMWYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWGMWYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWGMWYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:24:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030431AbWGMWYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:24:44 -0400
Date: Thu, 13 Jul 2006 15:24:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: memory corruptor in .18rc1-git
Message-Id: <20060713152425.86412ea3.akpm@osdl.org>
In-Reply-To: <20060713221330.GB3371@redhat.com>
References: <20060713221330.GB3371@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 18:13:30 -0400
Dave Jones <davej@redhat.com> wrote:

> Three times in the last week, I've had a box running the -git-du-jour
> spontaneously reboot.  It just happened again, this time I had a serial
> console hooked up, but it rebooted before transferring much data.
> The one thing it did spew however was "List corruption. prev->ne",
> which came from the patch below which I had in my tree.
> (The latter half is likely irrelevant, and came from chasing a different bug)
> 
> Things in common at all three times it happened..
> reading email, and listening to oggs with rhythmbox.
> Another ALSA bug maybe ?
> 
> I've up'd the speed of the serial console, in the hope that more chars
> make it over the wire before reboot should this happen again.

Are you using SMP?  We have a known slab locking bug.

There have been a couple of slab.c patches committed today, but neither of
them appear to actually fix the bug.

The below should fix it, and testing this (disable lockdep) would be
useful.

It's going to take a bit of work to unpickle it all now.

diff -puN mm/slab.c~revert-slabc-lockdep-locking-change mm/slab.c
--- a/mm/slab.c~revert-slabc-lockdep-locking-change
+++ a/mm/slab.c
@@ -3100,16 +3100,7 @@ static void free_block(struct kmem_cache
 		if (slabp->inuse == 0) {
 			if (l3->free_objects > l3->free_limit) {
 				l3->free_objects -= cachep->num;
-				/*
-				 * It is safe to drop the lock. The slab is
-				 * no longer linked to the cache. cachep
-				 * cannot disappear - we are using it and
-				 * all destruction of caches must be
-				 * serialized properly by the user.
-				 */
-				spin_unlock(&l3->list_lock);
 				slab_destroy(cachep, slabp);
-				spin_lock(&l3->list_lock);
 			} else {
 				list_add(&slabp->list, &l3->slabs_free);
 			}
_

