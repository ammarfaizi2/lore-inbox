Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWHULOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWHULOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWHULOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:14:44 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:1000 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750976AbWHULOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:14:43 -0400
Date: Mon, 21 Aug 2006 15:13:36 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take9 1/2] kevent: Core files.
Message-ID: <20060821111335.GA8608@2ka.mipt.ru>
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru> <20060816134550.GA12345@infradead.org> <20060816135642.GD4314@2ka.mipt.ru> <20060818104607.GB20816@infradead.org> <20060818112336.GB11034@2ka.mipt.ru> <20060821105637.GB28759@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060821105637.GB28759@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 21 Aug 2006 15:13:39 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 11:56:37AM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> On Fri, Aug 18, 2006 at 03:23:36PM +0400, Evgeniy Polyakov wrote:
> > > defines make some sense for userspace-visible ABIs because then people
> > > can test for features with ifdef.  It doesn't make any sense for constants
> > > that are used purely in-kernel.  For those enums make more sense because
> > > you can for example looks at the symbolic names with a debugger.
> > 
> > Enums are only usefull when value is increased with each new member by
> > one.
> 
> No, they are not.  Please search the lkml archives, this came up multiple
> times.

Enums when OR'ed and ANDed in theory can produce value out of the enum
set.
And what is the difference between
#define A 1
#define B 2
#define C 4
and
enum {
 A = 1,
 B = 2,
 C = 4,
}
?

> > There will be either several syscalls or multiplexer...
> > I prefer to have one syscall and a lot of multiplexers inside.
> 
> To make life for everyone to detangle the mess hard.  Please at least
> try to follow existing design principles.

I added as less as possible syscalls - control one read ones.
The former can initialize/add/remove/modify kevents, the latter reads
ready events.

> > > > I created a char device in first releases and was forced to not use it
> > > > at all.
> > > 
> > > Do you have a reference to it?  In this case a char devices makes a lot of
> > > sense because you get a filedescriptor and have operations only defined on
> > > it.  In fact given that you have a multiplexer anyway there's really no
> > > point in adding a syscall for that aswell, you could rather use the existing
> > > and debugged ioctl() multiplexer.  Sure, it's still not what we consider
> > > nice, but better than adding even more odd multiplexer syscalls.
> > 
> > Somewhere in february.
> > Here is link to initial anounce which used ioctl and raw char device and
> > enums for all constants.
> > 
> > http://marc.theaimsgroup.com/?l=linux-netdev&m=113949344414464&w=2
> 
> That thread only shows your patch but no comments to it.  Do you have
> an url for the complaint about this design?  And please include the author
> of it in the cc list of your reply so we can settle the arguments.

enum vs. defines were changed after David Miller's suggestion, since the
whole network stack and epoll use defines extensively, and kevent was
built for them in a first time.

I do not remember who suggested not to use char device, but I saw that
inotify specially mention about ioct/syscall issues, old discussion
about event handling mechanism somewhere in this thread:
http://uwsg.iu.edu/hypermail/linux/kernel/0010.3/0002.html

It looks a bit illogical to have epoll/poll syscalls and read data from
char device and it's ioctls for network sockets completeness or timer
notifications.

-- 
	Evgeniy Polyakov
