Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVFBHhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVFBHhV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFBHhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:37:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:65481 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261597AbVFBHg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:36:57 -0400
Subject: Re: Freezer Patches.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050602073119.GC1841@elf.ucw.cz>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz>
	 <1117665934.19020.94.camel@gaston> <20050601230235.GF11163@elf.ucw.cz>
	 <1117676753.10888.105.camel@localhost> <20050602071431.GA1841@elf.ucw.cz>
	 <1117697187.10888.138.camel@localhost>  <20050602073119.GC1841@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 17:36:12 +1000
Message-Id: <1117697772.31082.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 09:31 +0200, Pavel Machek wrote:
> Hi!
> 
> > > If sys_sync() is not working, *fix sys_sync()*. [BTW I see that
> > > problem before and I think it is being worked on.] I'm *not* going to
> > > work around it in refrigerator.
> > 
> > I'm not saying sys_sync is broken. I _am_ saying that if you have
> > processes submitting I/O while you're trying to sync, syncing will take
> > longer and you may well still end up with dirty buffers at the end. On
> > top of this, you may think freezing has failed because processes don't
> > enter the refrigerator within your timelimit (assuming you have
> > one).
> 
> Then simple launch sys_sync(), let it finish, *then* do
> refrigeration. That way sys_sync() does not count to the timelimit.
> 
> Now, sys_sync() takes too long on some setups. That needs to be fixed,
> anyway; users don't like to wait for 15 minutes after typing
> "sync". Do not work around it in refrigerator.

Whatever you guys decide to do (I actually do sys_sync() before freezing
on pmac and yes, it takes sometimes way too long), to be uber-safe, we
could/should _also_ do sync after freezing userland processes and before
freezing kernel threads (that is, splitting here). In fact, that would
help also avoid deadlocks where a frozen kernel thread is holding a
semaphore preventing a process from freezing.

That way, if we sys_sync() once processes are sleeping and before kernel
threads are, we pretty-much make sure no new dirty buffer will appear.

Anyway, that's mostly food for thoughts at this point

Ben.


