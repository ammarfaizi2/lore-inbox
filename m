Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933890AbWKWUBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933890AbWKWUBy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933886AbWKWUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:01:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7385 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933857AbWKWUBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:01:53 -0500
Message-ID: <4565FDED.2050003@redhat.com>
Date: Thu, 23 Nov 2006 12:00:45 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <4564E2AB.1020202@redhat.com> <20061123115504.GB20294@2ka.mipt.ru>
In-Reply-To: <20061123115504.GB20294@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> uidx is an index, starting from which there are unread entries. It is
> updated by userspace when it commits entries, so it is 'consumer'
> pointer, while kidx is an index where kernel will put new entries, i.e.
> 'producer' index. We definitely need them both.
> Userspace can only update (implicitly by calling kevent_commit()) uidx.

Right, which is why exporting this entry is not needed.  Keep the 
interface as small as possible.

Userlevel has to maintain its own index.  Just assume kevent_wait 
returns 10 new entries and you have multiple threads.  In this case all 
threads take their turns and pick an entry from the ring buffer.  This 
basically has to be done with something like this (I ignore wrap-arounds 
here to simplify the example):

   int getidx() {
     while (uidx < kidx)
        if (atomic_cmpxchg(uidx, uidx + 1, uidx) == 0)
          return uidx;
     return -1;
   }

Very much simplified but it should show that we need a writable copy of 
the uidx.  And this value at any time must be consistent with the index 
the kernel assumes.

The current ring_uidx value can at best be used to reinitialize the 
userlevel uidx value after each kevent_wait call but this is unnecessary 
at best (since uidx must already have this value) and racy in problem 
cases (what if more than one thread gets woken concurrently with uidx 
having the same value and one thread stores the uidx value and 
immediately increments it to get an index; the second store would 
overwrite the increment).

I can assure you that any implementation I write would not use the 
ring_uidx value.  Only trivial, single-threaded examples like you 
ring_buffer.c could ever take advantage of this value.  It's not worth it.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
