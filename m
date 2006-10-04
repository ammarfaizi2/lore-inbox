Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030727AbWJDR5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030727AbWJDR5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbWJDR5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:57:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:17831 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030731AbWJDR5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:57:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K5XMJqEC6nZUuG2csc/GNAxgOIvqY5fn0xILhmk3Y2OvKdu9ihMRHB+tdm5f8+wsmJocF8KzmAxxCcJwrtWxTK2bpNzOnANY5N8i3mLaG1S59O/N/eSlc4UrPLORBALa6NChjvCgqTyrrHdaOMw2gpvIk6dIWfRqPH1KYe8bvVw=
Message-ID: <a36005b50610041057g67dcaf73wd48d9fef88187ec6@mail.gmail.com>
Date: Wed, 4 Oct 2006 10:57:32 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take19 1/4] kevent: Core files.
Cc: lkml <linux-kernel@vger.kernel.org>, "David Miller" <davem@davemloft.net>,
       "Ulrich Drepper" <drepper@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, "Zach Brown" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Chase Venters" <chase.venters@clientec.com>,
       "Johann Borck" <johann.borck@densedata.com>
In-Reply-To: <20061004064855.GA1981@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11587449471424@2ka.mipt.ru> <1158744950130@2ka.mipt.ru>
	 <a36005b50610032334n50e66198rdfef30e4ccf545c8@mail.gmail.com>
	 <20061004064855.GA1981@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> http://tservice.net.ru/~s0mbre/archive/kevent/evserver_kevent.c
> http://tservice.net.ru/~s0mbre/archive/kevent/evtest.c

These are simple programs which by themselves have problems.  For
instance, I consider a very bad idea to hardcode the size of the ring
buffer.  Specifying macros in the header file counts as hardcoding.
Systems grow over time and so will the demand of connections.  I have
no problem with the kernel hardcoding the value internally (or having
a /proc entry to select it) but programs should be able to dynamically
learn about the value so they don't have to be recompiled.

But more problematic is that I don't see how the interfaces can be
efficiently used in multi-threaded (or multi-process) programs.  How
would multiple threads using the same kevent queue and running in the
same kevent_get_events() loop work out?  How do they guarantee that
each request is only handled once?

>From what I see now this means a second data structure is needed to
keep track of the state of each entry.  But even then, how do we even
recognized used ring buffer entries?

For instance, assume two threads.  Both call get_events, one event is
reported, both threads are woken up (which is another thing to
consider, more later).  One thread uses ring buffer entry, the other
goes back to sleep in get_events.  Now, how does the kernel know when
the other thread is done working on the ring buffer entry?  There
might be lots of entries coming in overflowing the entire buffer.
Heck, you don't even need two threads for this scenario.

When I was thinking about this (and discussing it in Ottawa) I was
always assuming that we have a status field in the ring buffer entry
which lets the userlevel code indicate whether the entry is free again
or not.  This requires a writable mapping, yes, and potentially causes
cache line ping-pong.  I think Zach mentioned he has some ideas about
this.


As for the multiple thread wakeup, I mentioned this before.  We have
to avoid the trampling herd problem.  We cannot wakeup all waiters.
But we also cannot assume that, without protocols, waking up just one
for each available entry is sufficient.  So the first question is:
what is the current policy?


> AIO was removed from patchset by request of Cristoph.
> Timers, network AIO, fs AIO, socket nortifications and poll/select
> events work well with existing structures.

Well, excuse me if I don't take your word for it.  I agree, the AIO
code should not be submitted along with this.  The same for any other
code using the event handling.  But we need to check whether the
interface is generic enough to accomodate them in a way which actually
makes sense.  Again, think highly threaded processes or multiple
processes sharing the same event queue.


> It is even possible to create variable sized kevents - each kevent
> contain pointer to user's data, which can be considered as pointer to
> additional area (it's size kernel implementation for given kevent type
> can determine from other parameters or use predefined one and fetch
> additional data in ->enqueue() callback).

That sounds interesting and certainly helps with securing the
interface for the future.  But if there is anything we can do to avoid
unnecessary costs we should do it, even if this means investigation
all this further.
