Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUA0G4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 01:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUA0G4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 01:56:44 -0500
Received: from dp.samba.org ([66.70.73.150]:28316 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261974AbUA0G4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 01:56:39 -0500
Date: Tue, 27 Jan 2004 17:41:01 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: stern@rowland.harvard.edu, greg@kroah.com, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
Message-Id: <20040127174101.10b98a57.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
	<Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004 11:02:58 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Sun, 25 Jan 2004, Alan Stern wrote:
> > 
> > Is there some reason why modules don't work like this?
> 
> There's a few:
> 
>  - pain. pain. pain.
> 
>  - doing proper refcounting of modules is _really_ really hard. The reason 
>    is that proper refcounting is a "local" issue: you reference count a
>    single data structure. It's basically impossible to make a "global" 
>    reference count without jumping through hoops.
> 
>  - lack of testing. Unloading a module happens once in a blue moon, if 
>    even then.

And modules do work like you proposed, if you use "rmmod --wait".

Doing proper refcounting is actually fairly easy: every function pointer
has an associated reference count (or pointer to the module containing
the refcount).

But how much pain are you prepared to put up with to have a pseudo-pagable
kernel?

> (As an example of "too painful, too slow", think of something like a 
> packet filter module. You'd literally have to increment the count in every 
> part that gets a packet, and decrement the count at every point where it 
> lets the packet go.  And since it would have to be SMP-safe, it would have 
> to be a locked cycle, or we'd have to have per-CPU counters - at which 
> point you now also have to worry about things like preemption and 
> sleeping, which just means that it would be a _lot_ of very fragile code).

Actually, this is already handled.  The module reference counts are per-cpu
and don't contain any barriers.  We go to an *awful* lot of pain on remove
to synchronize, but as Linus says, it's not the normal case.

Since we hit the (atomic_t) ref to the devices on every packet, bumping
the refcount on the module is lost in the noise.

But Dave doesn't want to do it: it makes the code uglier and painful.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
