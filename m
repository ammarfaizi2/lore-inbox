Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbTJPEzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 00:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTJPEzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 00:55:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:33772 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262732AbTJPEzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 00:55:06 -0400
Date: Wed, 15 Oct 2003 21:58:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: albertogli@telpin.com.ar, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.6.0-test5/6 (and probably 7 too) size-4096 memory leak
Message-Id: <20031015215824.165dc4c7.akpm@osdl.org>
In-Reply-To: <20031016044334.GE4461@holomorphy.com>
References: <20031016025554.GH4292@telpin.com.ar>
	<20031015211918.1a70c4d2.akpm@osdl.org>
	<20031016044334.GE4461@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Alberto Bertogli <albertogli@telpin.com.ar> wrote:
> >>  Slabinfo reports that size-4096 has 104341 active objects and growing.
> >>  On another box at home I see the same issue with test6, but "only" with
> >>  11612 objects; I'm not posting info on this box as I guess the mailserver
> >>  is much more important because the leak is really noticeable.
> 
> On Wed, Oct 15, 2003 at 09:19:18PM -0700, Andrew Morton wrote:
> > At least I'm not the only one; my main desktop machine does the same
> > thing.  It leaks two megabytes a day into size-4096, like clockwork.  It's
> > up to 43 megs now.
> > I was ignoring it and hoping it would go away.  Ho hum.  Tricky.
> 
> I immediately thought of bundling this in with the do_exit() BUG() and
> /proc/ oopsen, but we would see a task_t leak also in that case. I still
> say the /proc/ change is swiss cheese (well, in concept there's nothing
> wrong with what it wants to do, but there's something definitely wrong
> with the implementation since backing it out stops things from oopsing),
> but this looks unrelated therefore (which is actually depressing, since
> we can't kill all three in one shot and/or get anywhere by correlating).
> I should try using a dedicated stack slab to see if they're stacks even
> though task_t's aren't leaking.
> 

This leak is at least a couple of months old.

The recent (test7) /proc oops was fixed when Linus reverted the
job-control-in-signal-struct patch.

This leak is of size-4096: it isn't kernel stacks.

I did a quicky audit of all kmalloc(PAGE_SIZE) instances and everything
looked OK: one suspect in the NFS server but I wasn't able to force
speedier bloat by exercising the NFS server in my normal usage pattern.

I'm thinking we need to stuff builtin_return_address(0) into the object and
write a dumper, but I haven't looked into that.  Maybe I can persuade
Manfred to cook up a custom patch to do that?  Just for size-4096?  Something
really crude will be fine.
