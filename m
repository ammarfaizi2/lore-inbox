Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757491AbWKWWsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757491AbWKWWsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 17:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757490AbWKWWsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 17:48:16 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37050 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1757489AbWKWWsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 17:48:14 -0500
Message-ID: <45662522.9090101@garzik.org>
Date: Thu, 23 Nov 2006 17:48:02 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <456621AC.7000009@redhat.com>
In-Reply-To: <456621AC.7000009@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Evgeniy Polyakov wrote:
>> + int kevent_commit(int ctl_fd, unsigned int start, +     unsigned int 
>> num, unsigned int over);
> 
> I think we can simplify this interface:
> 
>    int kevent_commit(int ctl_fd, unsigned int new_tail,
>                      unsigned int over);
> 
> The kernel sets the ring_uidx value to the 'new_tail' value if the tail 
> pointer would be incremented (module wrap around) and is not higher then 
> the current front pointer.  The test will be a bit complicated but not 
> more so than what the current code has to do to check for mistakes.
> 
> This approach has the advantage that the commit calls don't have to be 
> synchronized.  If one thread sets the tail pointer to, say, 10 and 
> another to 12, then it does not matter whether the first thread is 
> delayed.  If it will eventually be executed the result is simply a no-op 
> and since second thread's action supersedes it.
> 
> Maybe the current form is even impossible to use with explicit locking 
> at userlevel.  What if one thread, which is about to call kevent_commit, 
> if indefinitely delayed.  Then this commit request's value is never 
> taken into account and the tail pointer is always short of what it 
> should be.

I'm really wondering is designing for N-threads-to-1-ring is the wisest 
choice?

Considering current designs, it seems more likely that a single thread 
polls for socket activity, then dispatches work.  How often do you 
really see in userland multiple threads polling the same set of fds, 
then fighting to decide who will handle raised events?

More likely, you will see "prefork" (start N threads, each with its own 
ring) or a worker pool (single thread receives events, then dispatches 
to multiple threads for execution) or even one-thread-per-fd (single 
thread receives events, then starts new thread for handling).

If you have multiple threads accessing the same ring -- a poor design 
choice -- I would think the burden should be on the application, to 
provide proper synchronization.

If the desire is to have the kernel distributes events directly to 
multiple threads, then the app should dup(2) the fd to be watched, and 
create a ring buffer for each separate thread.

	Jeff


