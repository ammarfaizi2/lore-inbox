Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWJEJ43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWJEJ43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 05:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWJEJ43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 05:56:29 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:51167 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751576AbWJEJ42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 05:56:28 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take19 1/4] kevent: Core files.
Date: Thu, 5 Oct 2006 11:56:24 +0200
User-Agent: KMail/1.9.4
Cc: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
References: <11587449471424@2ka.mipt.ru> <a36005b50610041057g67dcaf73wd48d9fef88187ec6@mail.gmail.com> <20061005085750.GA1015@2ka.mipt.ru>
In-Reply-To: <20061005085750.GA1015@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051156.25036.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 10:57, Evgeniy Polyakov wrote:

> Well, it is possible to create /sys/proc entry for that, and even now
> userspace can grow mapping ring until it is forbiden by kernel, which
> means limit is reached.

No need for yet another /sys/proc entry.

Right now, I (for example) may have a use for Generic event handling, but for 
a program that needs XXX.XXX handles, and about XX.XXX events per second.

Right now, this program uses epoll, and reaches no limit at all, once you pass 
the "ulimit -n", and other kernel wide tunes of course, not related to epoll.

With your current kevent, I cannot switch to it, because of hardcoded limits.

I may be wrong, but what is currently missing for me is :

- No hardcoded limit on the max number of events. (A process that can open 
XXX.XXX files should be allowed to open a kevent queue with at least XXX.XXX 
events). Right now thats not clear what happens IF the current limit is 
reached.

- In order to avoid touching the whole ring buffer, it might be good to be 
able to reset the indexes to the beginning when ring buffer is empty. (So if 
the user land is responsive enough to consume events, only first pages of the 
mapping would be used : that saves L1/L2 cpu caches)

A plus would be

- A working/usable mmap ring buffer implementation, but I think its not 
mandatory. System calls are not that expensive, especially if you can batch 
XX events per syscall (like epoll). Nice thing with a ring buffer is that we 
touch less cache lines than say epoll that have lot of linked structures.

About mmap, I think you might want a hybrid thing :

One writable page where userland can write its index, (and hold one or more 
futex shared by kernel) (with appropriate thread locking in case multiple 
threads want to dequeue events). In fast path, no syscalls are needed to 
maintain this user index.

XXX readonly pages (for user, but r/w for kernel), where kernel write its own 
index, and events of course.

Using separate cache lines avoid false sharing : kernel can update its own 
index and events without having to pay the price of cache line ping pongs.
It could use futex infrastructure to wakeup one thread 'only' instead of all 
threads waiting an event.


Eric
