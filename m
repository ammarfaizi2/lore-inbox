Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWBJUg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWBJUg5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWBJUg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:36:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6859 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932187AbWBJUgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:36:54 -0500
Date: Fri, 10 Feb 2006 21:36:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nigel@suspend2.net,
       Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH -mm] swsusp: freeze user space processes first
Message-ID: <20060210203636.GA1761@elf.ucw.cz>
References: <200602051014.43938.rjw@sisk.pl> <20060205013859.60a6e5ab.akpm@osdl.org> <200602051134.19490.rjw@sisk.pl> <20060205105037.GA26222@elte.hu> <20060205111145.GE1790@elf.ucw.cz> <20060205142226.GA20141@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205142226.GA20141@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > then i'd suggest to change the vfork implementation to make this code 
> > > freezable. Nothing that userspace does should cause freezing to fail.  
> > > If it does, we've designed things incorrectly on the kernel side.
> > 
> > Does that also mean we have bugs with signal delivery? If vfork(); 
> > sleep(100000); causes process to be uninterruptible for few days, it 
> > will not be killable and increase load average...
> 
> "half-done" vforks are indeed in uninterruptible sleep. They are not 
> directly killable, but they are killable indirectly through their 
> parent. But yes, in theory it would be cleaner if the vfork code used 
> wait_for_completion_interruptible(). It has to be done carefully though, 
> for two reasons:
> 
> - implementational: use task_lock()/task_unlock() to protect
>   p->vfork_done in mm_release() and in do_fork().
> 
> - semantical: signals to a vfork-ing parent are defined to be delayed
>   to after the child has released the parent/MM.

We could still deliver sigkill and stopping for the freezer, no?

> the (untested) patch below handles issue #1, but doesnt handle issue #2: 
> this patch opens up a vfork parent to get interrupted early, with any 
> signal.

It seems to fix D state for me, and does not seem to have any ill
effects.

							Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
