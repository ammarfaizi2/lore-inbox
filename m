Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283876AbRLRPgf>; Tue, 18 Dec 2001 10:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282547AbRLRPg2>; Tue, 18 Dec 2001 10:36:28 -0500
Received: from ns.ithnet.com ([217.64.64.10]:28170 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S282941AbRLRPgP>;
	Tue, 18 Dec 2001 10:36:15 -0500
Date: Tue, 18 Dec 2001 16:36:12 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: <mingo@elte.hu>
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] mempool-2.5.1-D2
Message-Id: <20011218163612.3a8547ad.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0112181731520.3480-100000@localhost.localdomain>
In-Reply-To: <200112172357.AAA17058@webserver.ithnet.com>
	<Pine.LNX.4.33.0112181731520.3480-100000@localhost.localdomain>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001 17:43:01 +0100 (CET)
Ingo Molnar <mingo@elte.hu> wrote:

> 
> On Tue, 18 Dec 2001, Stephan von Krawczynski wrote:
> 
> > Hm, and where is the real-world-difference to standard VM? I mean
> > today your bad-ass application gets shot down by L's oom-killer and
> > your VM will "refill". So you're not going to die for long in the
> > current situation either. [...]
> 
> Think of the following trivial case: 'the whole system is full of dirty
> pagecache pages, the rest is kmalloc()ed somewhere'. Nothing to oom,
> nothing to kill, plenty of swap left and no RAM. And besides, in this
> situation, oom is the worst possible answer, the application getting
> oom-ed is not at fault in this case.

You are right that this is a broken situation. Now your answer is a _specific_
patch: you say "let nice people using mempools survive (and fuck the rest
(implicit))". You do not solve the problem, you drive _around_ it for _certain_
VM users (the mempool guys). This is _not_ the correct answer to the situation.
In my eyes "correct" would mean: what is the reason for the pagecache (dirty)
being able to eat up all my mem (which may be _plenty_). Something is wrong
with the design then, remember the basics:(very meta this one :-) 
object vm {
	pool with free mem
	pool with cached-only mem
	pool with dirty-cache mem (your naming)
	...
	func cached_to_dirty_mem
	func dirty_to_cached_mem
	func drop_cached_mem
	func alloc_cached_mem
	...
}

Your problem obviously is that the function moving pages from dirty_to_cached
(meaning not dirty) is either not existing or not working and thats why your
situation is broken (there is nothing that can be dropped, meaning pool with
cached-only is empty and cannot be filled from dirty-cache). If it is not
existing, then the basic design relies on _external_ undefines (VM users
dropping the dirty pages themselves at undefined time and  order) and is
therefore provable incomplete and broken for all management cases with limited
resources (like mem). You cannot really intend to save the broken state by
saying "let it break, but not for mempool". As long as you cannot create a
closed circle in VM you will break. But even inside mempools you fight the same
problem. You have to rely on mempool-users giving back the resources early
enough to handle the new requests. If the timed-circle  doesn't work out as
expected you increase your mempool (resize). It's all the same. This is exactly
like a VM situation without (or without agressive) page-cache. You upgrade RAM
if you ran out. This analogy brings up the real and simple cure inside your
design: you made the page-cache go away from the mempools. This would obviously
cure VM, too. But it would seriously hit performance, so its a nono.

The really working example of limited-resources-management inside linux is the
scheduler. There you have "users" (processes) that work or not, and when there
is "no work" (e.g. idle), you may very well run niced-processes (in
simplification _one_) eating up the "rest" of the resources to make something
out of it. But if a "real" user comes in and wants resources, the nice one will
go away. It is a complete design.

In VM the page-cache should be a special case "nice" user. It can use all
available resources, but has to vanish if someone really needs them. And this
is currently _not_ solved, incomplete, and therefore contains big black holes,
like your described situation.

Regards,
Stephan

