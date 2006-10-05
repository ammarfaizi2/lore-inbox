Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWJEOB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWJEOB1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWJEOB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:01:26 -0400
Received: from berlioz.imada.sdu.dk ([130.225.128.12]:14001 "EHLO
	berlioz.imada.sdu.dk") by vger.kernel.org with ESMTP
	id S1751116AbWJEOBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:01:25 -0400
From: Hans Henrik Happe <hhh@imada.sdu.dk>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take19 1/4] kevent: Core files.
Date: Thu, 5 Oct 2006 16:01:19 +0200
User-Agent: KMail/1.9.1
Cc: Eric Dumazet <dada1@cosmosbay.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
References: <11587449471424@2ka.mipt.ru> <200610051156.25036.dada1@cosmosbay.com> <20061005102106.GE1015@2ka.mipt.ru>
In-Reply-To: <20061005102106.GE1015@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051601.20701.hhh@imada.sdu.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 12:21, Evgeniy Polyakov wrote:
> On Thu, Oct 05, 2006 at 11:56:24AM +0200, Eric Dumazet (dada1@cosmosbay.com) 
wrote:
> > On Thursday 05 October 2006 10:57, Evgeniy Polyakov wrote:
> > 
> > > Well, it is possible to create /sys/proc entry for that, and even now
> > > userspace can grow mapping ring until it is forbiden by kernel, which
> > > means limit is reached.
> > 
> > No need for yet another /sys/proc entry.
> > 
> > Right now, I (for example) may have a use for Generic event handling, but 
for 
> > a program that needs XXX.XXX handles, and about XX.XXX events per second.
> > 
> > Right now, this program uses epoll, and reaches no limit at all, once you 
pass 
> > the "ulimit -n", and other kernel wide tunes of course, not related to 
epoll.
> > 
> > With your current kevent, I cannot switch to it, because of hardcoded 
limits.
> > 
> > I may be wrong, but what is currently missing for me is :
> > 
> > - No hardcoded limit on the max number of events. (A process that can open 
> > XXX.XXX files should be allowed to open a kevent queue with at least 
XXX.XXX 
> > events). Right now thats not clear what happens IF the current limit is 
> > reached.
> 
> This forces to overflows in fixed sized memory mapped buffer.
> If we remove memory mapped buffer or will allow to have overflows (and
> thus skipped entries) keven can easily scale to that limits (tested with
> xx.xxx events though).
> 
> > - In order to avoid touching the whole ring buffer, it might be good to be 
> > able to reset the indexes to the beginning when ring buffer is empty. (So 
if 
> > the user land is responsive enough to consume events, only first pages of 
the 
> > mapping would be used : that saves L1/L2 cpu caches)
> 
> And what happens when there are 3 empty at the beginning and \we need to
> put there 4 ready events?

Couldn't there be 3 areas in the mmap buffer:

- Unused: entries that the kernel can alloc from.
- Alloced: entries alloced by kernel but not yet used by user. Kernel can 
update these if new events requires that.
- Consumed: entries that the user are processing.

The user takes a set of alloced entries and make them consumed. Then it 
processes the events after which it makes them unused. 

If there are no unused entries and the kernel needs some, it has wait for free 
entries. The user has to notify when unused entries becomes available. It 
could set a flag in the mmap'ed area to avoid unnessesary wakeups.

The are some details with indexing and wakeup notification that I have left 
out, but I hope my idea is clear. I could give a more detailed description if 
requested. Also, I'm a user-level programmer so I might not get the whole 
picture.

Hans Henrik Happe
