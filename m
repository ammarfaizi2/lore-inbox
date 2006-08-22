Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWHVXTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWHVXTA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 19:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWHVXTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 19:19:00 -0400
Received: from xenotime.net ([66.160.160.81]:44219 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932083AbWHVXS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 19:18:59 -0400
Date: Tue, 22 Aug 2006 16:22:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-Id: <20060822162206.a766ec90.rdunlap@xenotime.net>
In-Reply-To: <1156287492.2476.134.camel@entropy>
References: <11561555871530@2ka.mipt.ru>
	<1156230051.8055.27.camel@entropy>
	<20060822072448.GA5126@2ka.mipt.ru>
	<1156234672.8055.51.camel@entropy>
	<20060822083711.GA26183@2ka.mipt.ru>
	<1156238988.8055.78.camel@entropy>
	<20060822100316.GA31820@2ka.mipt.ru>
	<1156276658.2476.21.camel@entropy>
	<20060822201646.GC3476@2ka.mipt.ru>
	<1156281182.2476.63.camel@entropy>
	<20060822143747.68acaf99.rdunlap@xenotime.net>
	<1156287492.2476.134.camel@entropy>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 15:58:12 -0700 Nicholas Miell wrote:

> On Tue, 2006-08-22 at 14:37 -0700, Randy.Dunlap wrote:
> > On Tue, 22 Aug 2006 14:13:02 -0700 Nicholas Miell wrote:
> > 
> > > On Wed, 2006-08-23 at 00:16 +0400, Evgeniy Polyakov wrote:
> > > > On Tue, Aug 22, 2006 at 12:57:38PM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > > > > On Tue, 2006-08-22 at 14:03 +0400, Evgeniy Polyakov wrote:
> > > > > Of course, since you already know how all this stuff is supposed to
> > > > > work, you could maybe write it down somewhere?
> > > > 
> > > > I will write documantation, but as you can see some interfaces are
> > > > changed.
> > > 
> > > Thanks; rapidly changing interfaces need good documentation even more
> > > than stable interfaces simply because reverse engineering the intended
> > > API from a changing implementation becomes even more difficult.
> > 
> > OK, I don't quite get it.
> > Can you be precise about what you would like?
> > 
> > a.  good documentation
> > b.  a POSIX API
> > c.  a Windows-compatible API
> > d.  other?
> > 
> > and we won't make you use any of this code.
> 
> I want something that I can be confident won't be replaced again in two
> years because nobody noticed problems with the old API design or they're
> just feeling very NIH with their snazzy new feature.
> 
> Maybe then we won't end up with another in the { signal/sigaction,
> waitpid/wait4, select/pselect, poll/ppol,  msgrcv, mq_receive,
> io_getevents, aio_suspend/aio_return, epoll_wait, inotify read,
> kevent_get_events } collection -- or do you like having a maze of
> twisted interfaces, all subtly different and none supporting the
> complete feature set?
> 
> Good documentation giving enough detail to judge the design and an API
> that fits with the current POSIX API (at least, the parts that everybody
> agrees don't suck) goes a long way toward assuaging my fears that this
> won't just be another waste of effort, doomed to be replaced by the Next
> Great Thing (We Really Mean It This Time!) in unified event loop API
> design or whatever other interface somebody happens to be working on.
> 
> ---

OK, thank you for elaborating.

I suppose that I am more <choose one> {cynical, sarcastic,
practial, pragmatic}.  I don't have a crystal ball for 2 years
out and I don't know anyone who does.

IMO we do the best that we can given some human constraints
and probably some marketplace constraints (like ship something
instead of playing with it for 5 years before shipping it).


> This is made extraordinarily difficult by the fact kernel people don't
> even agree themselves on what APIs should look like anyway and Linus
> won't take a stand on the issue -- people with influence are
> simultaneously arguing things like:
> 
> - ioctls are bad because they aren't typesafe and you should use
> syscalls instead because they are typesafe
> 
> - ioctls are good, because they're much easier to add than syscalls,
> type safety can be supplied by the library wrapper, and syscalls are a
> (relatively) scarce resource, harder to wire up in the first place, and
> are more difficult to make optional or remove entirely if you decide
> they were a stupid idea.

Yes, I was recently part of that argument in Ottawa.

> - multiplexors are bad because they're too complex or not typesafe
> 
> - multiplexors are good because they save syscall slots or ioctl numbers
> and the library wrapper provides the typesafety anyway.

Multiplexors have already lost AFAIK.  Unless someone changes their
mind.  Which happens and will continue to happen.

> - instead of syscalls or ioctls, you should create a whole new
> filesystem that has a bunch of magic files that you read from and write
> to in order to talk to the kernel

Yep.  Some people like that one.  Not everyone.

> - filesystem interfaces are bad, because they're take more effort to
> write than a syscall or a ioctl and nobody seems to know how to maintain
> and evolve a filesystem-based ABI or make them easy to use outside of a
> fragile shell script (see: sysfs)

Ack.

> - that everything in those custom filesystems should ASCII strings and
> nobody needs an actual grammar describing how to parse them, we can just
> break userspace whenever we feel like it

sysfs requires one value per file.  Little parsing required.
But I don't know how to capture atomic values from N files with sysfs.

> - that everything in those custom filesystems should be C structs, and
> screw the shell scripts

Hm, I don't recall that one.

> - new filesystem metadata should be exposed by:
> 	- xattrs
> 	- ioctls
> 	- new syscalls
> 		or
> 	- named streams/forks/not-xattrs
>   and three out of four of these suggestions are completely wrong for
>   some critical reason
> 
> - meanwhile, the networking folks are doing everything via AF_NETLINK
> sockets instead of syscalls or ioctl or whatever, I guess because the
> network stack is what's most familiar to them

I sympathize with you on that one.  I don't care for netlink much
either.  To me it's still an ioctl, even though it is routable
and extensible.

> - and there's the usual arguments about typedefs verses bare struct
> names, #defines verses enums, returning 0 on success vs. 0 on failure,
> and lots of other piddly stupid stuff that somebody just needs to say
> "this is how it's done and no arguing" about.

That's all part of the open-source development process.  Sorry
you dislike it.

> Honestly, somebody with enough clout to make it stick needs to write out
> a spec describing what new kernel interfaces should look like and how
> they should fit in with existing interfaces.

I only know 2 people who could make it stick.

> It'd probably make Evgeniy's life easier if you could just point at the
> interface guidelines and say "you did this wrong" instead of random
> people telling him to change his design and random other people telling
> him to change it back.

I agree.  We went thru some of this at the kernel summit.
The ioctls dissent topic didn't really have many dissenters.
(That was a surprise to me.)

Anyway, thanks again for the additional details.

---
~Randy
