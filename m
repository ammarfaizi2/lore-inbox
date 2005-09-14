Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVINP5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVINP5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVINP5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:57:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:47846 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030219AbVINP5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:57:08 -0400
Date: Wed, 14 Sep 2005 17:56:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <20050913103724.19ac5efa.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0509141446590.3728@scrub.home>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
 <20050912043943.5795d8f8.akpm@osdl.org> <20050912075155.3854b6e3.pj@sgi.com>
 <Pine.LNX.4.61.0509121821270.3743@scrub.home> <20050912153135.3812d8e2.pj@sgi.com>
 <Pine.LNX.4.61.0509131120020.3728@scrub.home> <20050913103724.19ac5efa.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 13 Sep 2005, Paul Jackson wrote:

> > If I read the source correctly, a cpuset cannot be removed or moved while 
> > it's attached to a task, which makes it a lot simpler.
> 
> Yes - a cpuset cannot be removed while attached (count > 0).  And there
> is no 'move' that I know of.  A rename(2) system call on a cpuset in
> the cpuset filesystem gets the vfs default -EINVAL response.
> 
> So, yes, if I can pin a cpuset with a per-cpuset spinlock on it, then
> its parent chain (and whatever else I take care to guard with that
> spinlock) is held as well (the cpuset->parent chain is pinned).  I
> guess this some of what you meant by your phrase "makes it a lot
> simpler".

I don't think a per-cpuset spinlock will be necessary (at least 
initially).
The complete active condition is actually (atomic_read(&cs->count) || 
!list_empty(&cs->children)). These means if any child is possibly active 
so is the parent. 
Modifications in the cpuset hierarchy require the cpuset_sem and an 
inactive cpuset, (de)activating a cpuset requires the cpuset_sem and 
(let's call it) cpuset_tasklock.
Callbacks from the allocator now only need cpuset_tasklock to access the 
cpuset via tsk->cpuset and to keep it active and an active cpuset can't be 
removed from the hierarchy.

> You also wrote:
> > You can BTW avoid locking in cpuset_exit() completely in the common case:
> > 
> > 	tsk->cpuset = NULL;
> > 	if (atomic_dec_and_test(&cs->count) && notify_on_release(cs)) {
> 
> I don't think that works.  And I suspect you are proposing the same bug
> that I had, and fixed with the following patch:

You're right, it should better look like this:

	tsk->cpuset = NULL;
	if (atomic_read(&cs->count) == 1 && notify_on_release(cs)) {
		...
	}
	atomic_dec(&cs->count);

This way it only may happen that two notifaction are sent.

bye, Roman
