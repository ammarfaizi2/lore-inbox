Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVATDUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVATDUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVATDUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:20:50 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:38767 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262023AbVATDUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:20:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=i0UQzvOycvan/+X26G8ItM+4dPuy1pkLoCuYzMtlJYhQ1KfTy6j5yh3tOQ0q2U6ofCIK6cilzNSnI1hAi/eOMVt7SzfExRJKLGtWNrr3sP311IUPiT8VxoQt4yunQxAVd/ZDJfGAuD+zPkj3OvjPTCgN4z45RYxwBMoZ3U2Nymw=
Message-ID: <4d6522b90501191920410780fe@mail.gmail.com>
Date: Thu, 20 Jan 2005 05:20:20 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: Bodo Eggert <7eggert@gmx.de>
Subject: Re: User space out of memory approach
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ilias Biris <xyz.biris@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501190629490.5090@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.lcmt90h.1j1scpn@ifi.uio.no> <fa.ht4gei4.1g5odia@ifi.uio.no>
	 <E1CqDGM-0000wi-00@be1.7eggert.dyndns.org>
	 <4d6522b905011805154bf27b52@mail.gmail.com>
	 <Pine.LNX.4.58.0501190629490.5090@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > If my system needs the OOM killer, it's usurally unresponsive to most
> > > userspace applications. A normal daemon would be swapped out before the
> > > runaway dhcpd grows larger than the web cache. It would have to be a mlocked
> > > RT task started from early userspace. It would be difficult to set up (unless
> > > you upgrade your distro), and almost nobody will feel like tweaking it to
> > > take the benefit (OOM == -ECANNOTHAPPEN).
> >
> > Please correct me if I got it wrong: as deamon in this case is not a normal one,
> > since it never gets rate for its own safety,
> 
> That's it's own task, it must make sure not to commit suicide. I forgot
> about that.

Ok.

> > then it needs an RT lock whenever
> > system boots.
> 
> It may not be blocked by a random RT task iff the RT task is supposed to
> be OOM-killed. Therefore it *MUST* run at the highest priority and be
> locked into the RAM.
> 
> It *SHOULD* be run at boot time, too, just in case it's needed early.

Yes. That's the idea of the application we posted to test the oom
killer ranking at
user space. At least, we are working to put it at boot time and these
suggestions are very helpful.

> > > What about creating a linked list of (stackable) algorhithms which can be
> > > extended by loading modules and resorted using {proc,sys}fs? It will avoid
> > > the extra process, the extra CPU time (and task switches) to frequently
> > > update the list and I think it will decrease the typical amount of used
> > > memory, too.
> >
> > Wouldn't this bring the (set of ) ranking algorithm(s) back to the kernel? This
> > is exactly what we're trying to avoid.
> 
> You're trying to avoid it in order to let admins try other ranking
> algorhithms (at least that's what I read). The module approach seems to be
> flexible enough to do that, and it avoids the mentioned issues. If you
> really want a userspace daemon, it can be controled by a module.-)

Yes, your reading is correct, but this choice should take into account
the "patterns"
of how memory is allocated for user's mostly used applications. Why?
The closer the
ranking gets to "The Best choice" the longer it will take to invoke
oom killer again.

I am wondering how could a module control a user space deamon if it
hasn't started
yet? I mean, processes at user space are supposed to start only after
all modules
are loaded (those loadable at boot time). So, this user space deamon
would break
this standard. But if we manage to have a special module that takes
care of loading
this stack of  OOM Killer ranking algorithms, then the deamon would
not need to break
the default order of loading modules. The init could be changed to
start the deamon,
and then the module would start controlling it. Am I right?

So that's why people is complaining every distro would have to update the init
and load this new module. Correct?

> 
> I 'm thinking of something like that:
> 
> [X] support stacking of OOM killer ranking algorhythms
> [X] Task blessing OOM filter
> [X] Userspace OOM ranking daemon
> [X] Default OOM killer ranking
> 
> -vs-
> 
> [ ] support stacking of OOM killer ranking algorhythms
> ( ) Userspace OOM ranking daemon
> (o) Default OOM killer ranking
> 

Very interesting idea. Will take that into account. Thanks a lot.

-- 
"In a world without fences ... who needs Gates?"
