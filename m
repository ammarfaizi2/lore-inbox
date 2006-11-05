Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbWKELqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbWKELqF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 06:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWKELqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 06:46:05 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:5530 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932673AbWKELqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 06:46:04 -0500
Date: Sun, 5 Nov 2006 14:43:55 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nate Diller <nate.diller@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Oleg Verych <olecom@flower.upol.cz>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061105114354.GA2537@2ka.mipt.ru>
References: <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com> <20061102062158.GC5552@2ka.mipt.ru> <5c49b0ed0611021140u360342f2v1e83c73d03eea329@mail.gmail.com> <20061103084240.GB1184@2ka.mipt.ru> <20061103085712.GA3725@elf.ucw.cz> <20061103091301.GC1184@2ka.mipt.ru> <20061105111933.GB4965@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061105111933.GB4965@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 05 Nov 2006 14:43:56 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 12:19:33PM +0100, Pavel Machek (pavel@ucw.cz) wrote:
> Hi!
> 
> On Fri 2006-11-03 12:13:02, Evgeniy Polyakov wrote:
> > On Fri, Nov 03, 2006 at 09:57:12AM +0100, Pavel Machek (pavel@ucw.cz) wrote:
> > > > So, kqueue API and structures can not be usd in Linux.
> > > 
> > > Not sure what you are smoking, but "there's unsigned long in *bsd
> > > version, lets rewrite it from scratch" sounds like very bad idea. What
> > > about fixing that one bit you don't like?
> > 
> > It is not about what I dislike, but about what is broken or not.
> > Putting u64 instead of a long or some kind of that _is_ incompatible
> > already, so why should we even use it?
> 
> Well.. u64 vs unsigned long *is* binary incompatible, but it is
> similar enough that it is going to be compatible at source level, or
> maybe userland app will need *minor* ifdefs... That's better than two
> completely different versions...
> 
> > And, btw, what we are talking about? Is it about the whole kevent
> > compared to kqueue in kernelspace, or just about what structure is being
> > transferred between kernelspace and userspace?
> > I'm sure, it was some kind of a joke to 'not rewrite *bsd from scratch
> > and use kqueue in Linux kernel as is'.
> 
> No, it is probably not possible to take code from BSD kernel and "just
> port it". But keeping same/similar userland interface would be nice.

It is not only probably, but not even unlikely - it is impossible to get
FreeBSD kqueue code and port it - that port will be completely different
system.
It is impossible to have the same event structure, one should create
#if defined kqueue
fill all members of the structure
#else if defined kevent
fill different members name, since Linux does not even have some types
#endif

*BSD kevent (structure transferred between userspace and kernelspace)
struct kevent {
	uintptr_t ident;	     /* identifier for this event */
	short     filter;	     /* filter for event */
	u_short   flags;	     /* action flags for kqueue */
	u_int     fflags;	     /* filter flag value */
	intptr_t  data;	     		/* filter data value */
	void      *udata;		/* opaque user data identifier */
};

You must fill all fields differently due to above.
Just an example: Linux kevent has extended ID field which is grouped
into type.event, kqueue has different pointer indent and short filter.

Linux kevent does not have filters, but instead it has generic storages
of events which can be processed in any way origin of the storage wants
(this for example allows to create aio_sendfile() (which is dropped from
patchset currently) which no other system in the wild has).

There are too many differences. It is just different systems.
If both can be described by sentence "system which handles events", it
does not mean that they are the same and can use the structures or even
have similar design. 

Kevent is not kqueue in any way (although there are certain
similarities), so they can not share anything.

> 										Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
	Evgeniy Polyakov
