Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934985AbWKXQa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934985AbWKXQa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 11:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934984AbWKXQa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 11:30:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40327 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934982AbWKXQa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 11:30:57 -0500
Message-ID: <45671E16.6060005@redhat.com>
Date: Fri, 24 Nov 2006 08:30:14 -0800
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
References: <11641265982190@2ka.mipt.ru> <4564E2AB.1020202@redhat.com> <20061123115504.GB20294@2ka.mipt.ru> <4565FDED.2050003@redhat.com> <20061124114614.GA32545@2ka.mipt.ru>
In-Reply-To: <20061124114614.GA32545@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
>> Very much simplified but it should show that we need a writable copy of 
>> the uidx.  And this value at any time must be consistent with the index 
>> the kernel assumes.
> 
> I seriously doubt it is simpler than having index provided by kernel.

What has simpler to do with it?  The userlevel code should not modify 
the ring buffer structure at all.  If we'd do this then all operations, 
at least on the uidx field, would have to be atomic operations.  This is 
currently not the case for the kernel side since it's protected by a 
lock for the event queue.  Using the uidx field from userlevel would 
therefore just make things slower.

And for what?  Changing the uidx value would make the commit syscall 
unnecessary.  This might be an argument but it sounds too dangerous. 
IMO the value should be protected by the kernel.

And in any case, the uidx value cannot be updated until the event 
actually has been processed.  But the threads still need to coordinate 
distributing the events from the ring buffer amongst themselves.  This 
will in any case require a second variable.

So, if you want to do away with the commit syscall, keep the uidx value. 
  This also requires that the ring buffer head will always be writable 
(something I'd like to avoid making part of the interface but I'm 
flexible on this).  Otherwise, the ring_uidx element can go away, it's 
not needed and will only make people think about wrong approaches to use it.


> You propose to make uidx shared local variable - it is doable, but it
> is not required - userspace can use kernel's variable, since it is
> updated exactly in the places where that index is changed.

As said above, we always need another variable and uidx is only a 
replacement for the commit call.  Until the event is processed the uidx 
cannot be incremented since otherwise the ring buffer entry might be 
overwritten.

And kernel people of all should be happy to limit the exposure of the 
implementation.  So, leave the problem of keeping track of the tail 
pointer to the userlevel code.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
