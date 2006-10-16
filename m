Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWJPKAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWJPKAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWJPKAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:00:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30666 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030337AbWJPKAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:00:36 -0400
Message-ID: <45335814.6000903@redhat.com>
Date: Mon, 16 Oct 2006 02:59:48 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
References: <20060927150957.GA18116@2ka.mipt.ru> <a36005b50610032150x8233feqe556fd93bcb5dc73@mail.gmail.com> <20061004045527.GB32267@2ka.mipt.ru> <452363C5.1020505@redhat.com> <20061004074821.GA22688@2ka.mipt.ru> <4523ED6C.9080902@redhat.com> <20061005090214.GB1015@2ka.mipt.ru> <45251A83.9060901@redhat.com> <20061006083620.GA28009@2ka.mipt.ru> <4532B99B.9030403@redhat.com> <20061016072321.GA17735@2ka.mipt.ru>
In-Reply-To: <20061016072321.GA17735@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> One can set number of events before the syscall and do not remove them
> after syscall. It can be updated if there is need for that.

Nobody doubts that it is possible.  But it is

a) potentially much expensive

and

b) an alien concept

to have the signal mask to set during the wait call implicitly. 
Conceptually it doesn't even make sense.  This is no event to wait for. 
  It a parameter for the specific wait call, just like the timeout.  And 
I fortunately haven't seen you proposing to pass the timeout value 
implicitly.


>> Not good enough?  It does exactly what it is supposed to do.  What can 
>> there be "not good enough"?
> 
> Not to move signals into special case of events. If poll() can not work
> with them it does not mean, that they need to be specified as additional
> syscall parameter, instead change poll() to work with them, which can be
> easily done with kevents.

You still seem to be completely missing the point.  The signal mask is 
no event to wait for.  It has nothing to do with this that ppoll() takes 
the signal mask as a parameter.  The signal mask is a parameter for the 
wait call just like the timeout, not more and not less.


> Do not mix warm and soft - waiting for some period is not equal to
> syscall timeout. Waiting is possible with timer kevent user (although
> only relative timeout, can be changed to support both, not a big
> problem).

That's what I'm saying all the time.  Of course it can be supported. 
But for this the timeout parameter must be a timespec pointer.  Whatever 
you could possibly mean by "do not mix warm and soft" I cannot possibly 
imagine.  Fact is that both relative and absolute timeouts are useful. 
And that for absolute timeouts the change of the clock has to be taken 
into account.


> I'm quite sure that absolute timeouts are very usefull, but not as in
> the case of waiting for syscall completeness. In any way, kevent can be
> extended to support absolute timeouts in it's timer notifications.

That's not the same.  If you argue that then the syscall should have no 
timeout parameter at all.  Fact is that setting up a timer is not for 
free.  Since the timeout is used all the time having a timeout parameter 
is the right answer.  And if you do this then do it right just like 
every other syscall other than poll: use a timespec object.  This gives 
flexibility without measurable cost.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
