Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934178AbWKXLra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934178AbWKXLra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 06:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934175AbWKXLra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 06:47:30 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:28118 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S934115AbWKXLr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 06:47:29 -0500
Date: Fri, 24 Nov 2006 14:46:15 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Message-ID: <20061124114614.GA32545@2ka.mipt.ru>
References: <11641265982190@2ka.mipt.ru> <4564E2AB.1020202@redhat.com> <20061123115504.GB20294@2ka.mipt.ru> <4565FDED.2050003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4565FDED.2050003@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Nov 2006 14:46:18 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 12:00:45PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >uidx is an index, starting from which there are unread entries. It is
> >updated by userspace when it commits entries, so it is 'consumer'
> >pointer, while kidx is an index where kernel will put new entries, i.e.
> >'producer' index. We definitely need them both.
> >Userspace can only update (implicitly by calling kevent_commit()) uidx.
> 
> Right, which is why exporting this entry is not needed.  Keep the 
> interface as small as possible.

If there are several callers of kevent_commit(), uidx can be changed far
than first user expects, so there should be possibility to check that
value. It is thus exported into shared ring buffer structure.

> Userlevel has to maintain its own index.  Just assume kevent_wait 
> returns 10 new entries and you have multiple threads.  In this case all 
> threads take their turns and pick an entry from the ring buffer.  This 
> basically has to be done with something like this (I ignore wrap-arounds 
> here to simplify the example):
> 
>   int getidx() {
>     while (uidx < kidx)
>        if (atomic_cmpxchg(uidx, uidx + 1, uidx) == 0)
>          return uidx;
>     return -1;
>   }
> 
> Very much simplified but it should show that we need a writable copy of 
> the uidx.  And this value at any time must be consistent with the index 
> the kernel assumes.

I seriously doubt it is simpler than having index provided by kernel.

> The current ring_uidx value can at best be used to reinitialize the 
> userlevel uidx value after each kevent_wait call but this is unnecessary 
> at best (since uidx must already have this value) and racy in problem 
> cases (what if more than one thread gets woken concurrently with uidx 
> having the same value and one thread stores the uidx value and 
> immediately increments it to get an index; the second store would 
> overwrite the increment).
> 
> I can assure you that any implementation I write would not use the 
> ring_uidx value.  Only trivial, single-threaded examples like you 
> ring_buffer.c could ever take advantage of this value.  It's not worth it.

You propose to make uidx shared local variable - it is doable, but it
is not required - userspace can use kernel's variable, since it is
updated exactly in the places where that index is changed.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
	Evgeniy Polyakov
