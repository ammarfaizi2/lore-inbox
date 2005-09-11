Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVIKGwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVIKGwM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 02:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVIKGwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 02:52:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30627 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932427AbVIKGwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 02:52:11 -0400
Date: Sat, 10 Sep 2005 23:51:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been
 merged
Message-Id: <20050910235139.4a8865c2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0509101904070.20145@schroedinger.engr.sgi.com>
References: <200509101120.19236.ak@suse.de>
	<20050910023337.7b79db9a.akpm@osdl.org>
	<Pine.LNX.4.62.0509100921260.17110@schroedinger.engr.sgi.com>
	<20050910175901.7af1e437.akpm@osdl.org>
	<Pine.LNX.4.62.0509101904070.20145@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Sat, 10 Sep 2005, Andrew Morton wrote:
> 
> > > Well its ugly because you said that the fixes to make it less ugly were 
> > > "useless". I can still submit those fixes that make numa_maps a part of 
> > > smaps and that cleanup the way policies are displayed.
> > 
> > It would be useful to see these.
> 
> URLs (these are not up to date and in particular the conversion
> functions are much simpler in recent versions thanks to some help by
> Paul Jackson since then)
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0507.3/1662.html
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0507.3/1663.html
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0507.3/1665.html
> 

That doesn't looks like a great improvement.  The code you have there now
is quite straightforward.

> 
> > > > >  - it presents lots of kernel internal information and mempolicy
> > > > >  internals (like how many people have a page mapped) etc.
> > > > >  to userland that shouldn't be exposed to this.
> > > Very important information.
> > Important to whom?  Kernel developers or userspace developers?  If the
> > latter, what use do they actually make of it?  Shouldn't it be documented?
> 
> Both. System administrators would like to know on which node an 
> application has allocated memory. They would also like to change the way 
> applications do allocate memory while they are running but Andi has 
> philosophical concerns about that and will not even discuss methods to fix 
> the design issues in order to make that possible. Got a couple here ready 
> pull out if an opportunity arises.

Well I can understand concerns about externally fiddling with a process's
allocation policies, but that's a separate issue from the one at hand.

I'd expect that the ability to know "on which node an application has
allocated memory" would be more valuable to a developer than to a sysadmin.
Can you provide an example usage?

> I still have a hard time to see how people can accept the line of 
> reasoning that says:
> 
>  Users are not allowed to know on which nodes the operating system 
>  allocated resources for a process

This would only be useful if the process wasn't explicitly setting memory
policies, yes?  It's "hey, where is did all my memory end up".

> and are also not allowed to see the 
>  memory policies in effect for the memory areas

And this is the case where the process _has_ set some memory allocation
policies.

Certainly I can see value in that.  How can a developer test his
code without any form of runtime feedback?

> Then the application developers have to guess the effect that the memory 
> policies have on memory allocation. For memory alloc debugging the poor 
> app guys must today simply imagine what the operating system is doing. 
> They can see the amount of total memory allocated on a node via other proc 
> entries and then guess based on that which application has taken it. Then 
> they modify their apps and do another run. 

Agree.

What does Andi mean by "there was a theoretical usecase where it might be
needed, but there were better solutions proposed for this"?  The
application developer's problem here seems very real to me.  Maybe the
"theoretical usecase" was something different?

> My thinking today is that I'd rather leave /proc/<pid>/numa_stats 
> instead of using smaps because the smaps format is a bit verbose and 
> will make it difficult to see the allocation distribution.

We don't want /proc/pid/smaps to have different formats on NUMA versus !NUMA.

> I have a new series of patches here that does a gradual thing with
> the policy layer:

That's off-topic.



Andi, I don't understand the objection.  If I was developing the memory
policy tuning component of some honking number-crunching app I'd sure as
heck want to have some way of seeing the results of my efforts.  How do I
do that without numa_maps?

And the content doesn't look too bad:

2000000000000000 default MaxRef=43 Pages=11 Mapped=11 N0=4 N1=3 N2=2 N3=2
2000000000038000 default MaxRef=1 Pages=2 Mapped=2 Anon=2 N0=2
2000000000040000 default MaxRef=1 Pages=1 Mapped=1 Anon=1 N0=1
2000000000058000 default MaxRef=43 Pages=61 Mapped=61 N0=14 N1=15 N2=16 N3=16
2000000000268000 default MaxRef=1 Pages=2 Mapped=2 Anon=2 N0=2

It's easy to parse and it is extensible.  It needs documenting though.

