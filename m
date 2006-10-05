Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWJEPHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWJEPHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWJEPHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:07:55 -0400
Received: from berlioz.imada.sdu.dk ([130.225.128.12]:8120 "EHLO
	berlioz.imada.sdu.dk") by vger.kernel.org with ESMTP
	id S1751287AbWJEPHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:07:53 -0400
From: Hans Henrik Happe <hhh@imada.sdu.dk>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take19 1/4] kevent: Core files.
Date: Thu, 5 Oct 2006 17:07:48 +0200
User-Agent: KMail/1.9.1
Cc: Eric Dumazet <dada1@cosmosbay.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
References: <11587449471424@2ka.mipt.ru> <200610051601.20701.hhh@imada.sdu.dk> <20061005141556.GA30715@2ka.mipt.ru>
In-Reply-To: <20061005141556.GA30715@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051707.49087.hhh@imada.sdu.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 16:15, Evgeniy Polyakov wrote:
> On Thu, Oct 05, 2006 at 04:01:19PM +0200, Hans Henrik Happe 
(hhh@imada.sdu.dk) wrote:
> > > And what happens when there are 3 empty at the beginning and \we need to
> > > put there 4 ready events?
> > 
> > Couldn't there be 3 areas in the mmap buffer:
> > 
> > - Unused: entries that the kernel can alloc from.
> > - Alloced: entries alloced by kernel but not yet used by user. Kernel can 
> > update these if new events requires that.
> > - Consumed: entries that the user are processing.
> > 
> > The user takes a set of alloced entries and make them consumed. Then it 
> > processes the events after which it makes them unused. 
> > 
> > If there are no unused entries and the kernel needs some, it has wait for 
free 
> > entries. The user has to notify when unused entries becomes available. It 
> > could set a flag in the mmap'ed area to avoid unnessesary wakeups.
> > 
> > The are some details with indexing and wakeup notification that I have 
left 
> > out, but I hope my idea is clear. I could give a more detailed description 
if 
> > requested. Also, I'm a user-level programmer so I might not get the whole 
> > picture.
> 
> This looks good on a picture, but how can you put it into page-based
> storage without major and complex shared structures, which should be
> properly locked between kernelspace and userspace?

I wasn't clear about the structure. I meant a ring-buffer with 3 areas. So 
it's basically the same model as Eric Dumazet described, only with 3 indexes; 
2 in the user-writeable page and 1 in kernel.

When the kernel has alloced an entry it should store it in a way that makes it 
invalid after user consumsion, which is simply an increment of an index. 
Sliding-window like schemes should solve this.

Hans Henrik Happe
