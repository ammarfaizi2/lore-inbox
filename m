Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757793AbWKXQII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757793AbWKXQII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 11:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757795AbWKXQII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 11:08:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45539 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757793AbWKXQIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 11:08:05 -0500
Message-ID: <456718A3.1070108@redhat.com>
Date: Fri, 24 Nov 2006 08:06:59 -0800
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
References: <11641265982190@2ka.mipt.ru> <4564E162.8040901@redhat.com> <20061123115240.GA20294@2ka.mipt.ru> <4565FA60.9000402@redhat.com> <20061124110143.GF13600@2ka.mipt.ru>
In-Reply-To: <20061124110143.GF13600@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
>> I know this is how it's done now.  But it is not where it has to end. 
>> IMO we have to get to a solution where new events are posted to the ring 
>> buffer asynchronously, i.e., without a thread calling kevent_wait.  And 
>> then you need the extra parameter and verification.  Even if it's today 
>> not needed we have to future-proof the interface since it cannot be 
>> changed once in use.
> 
> There is a special flag in kevent_user to wake it if there are no ready
> events - kernel thread which has added new events will set it and thus
> subsequent kevent_wait() will return with updated indexes - userspace
> must check indexes after kevent_wait().

You misunderstand.  I don't want to return without waiting unconditionally.

There is a race which has to be closed.  It's exactly the same as in the 
futex syscall.  I've shown the interaction between the kernel and the 
thread in the previous mail.  There is inevitably a time difference 
between the thread checking whether the ring buffer is empty and the 
kernel putting the thread to sleep in the kevent_wait call.

This is no problem with the current kevent_wait implementation since the 
ring buffer is not filled asynchronously.  But if/when it will be the 
kernel might add something to the ring buffer _after_ the thread checks 
for an empty ring buffer and _before_ it enters the kernel in the 
kevent_wait syscall.

The kevent_wait syscall will only wake the thread when a new event is 
posted.  We do not in general want it to be woken when the ring buffer 
is non empty.  This would create far too many unnecessary wakeups it 
there is more than one thread working on the queue.

With the addition parameters for kevent_wait indicating when the calling 
thread last checked the ring buffer the kernel can find out whether the 
decision to call kevent_wait was made based on outdated information or 
not.  Outdated in the case a new event has been posted.  In this case 
the thread is not put to sleep but instead returns.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
