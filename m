Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934193AbWKWWeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934193AbWKWWeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 17:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934198AbWKWWeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 17:34:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34222 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934193AbWKWWeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 17:34:21 -0500
Message-ID: <456621AC.7000009@redhat.com>
Date: Thu, 23 Nov 2006 14:33:16 -0800
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
References: <11641265982190@2ka.mipt.ru>
In-Reply-To: <11641265982190@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> + int kevent_commit(int ctl_fd, unsigned int start, 
> + 	unsigned int num, unsigned int over);

I think we can simplify this interface:

    int kevent_commit(int ctl_fd, unsigned int new_tail,
                      unsigned int over);

The kernel sets the ring_uidx value to the 'new_tail' value if the tail 
pointer would be incremented (module wrap around) and is not higher then 
the current front pointer.  The test will be a bit complicated but not 
more so than what the current code has to do to check for mistakes.

This approach has the advantage that the commit calls don't have to be 
synchronized.  If one thread sets the tail pointer to, say, 10 and 
another to 12, then it does not matter whether the first thread is 
delayed.  If it will eventually be executed the result is simply a no-op 
and since second thread's action supersedes it.

Maybe the current form is even impossible to use with explicit locking 
at userlevel.  What if one thread, which is about to call kevent_commit, 
if indefinitely delayed.  Then this commit request's value is never 
taken into account and the tail pointer is always short of what it 
should be.


There is one more thing to consider.  Oftentimes the commit request will 
be immediately followed by a kevent_wait call.  It would be good to 
merge this pair of calls.  The two parameters new_tail and over could 
also be passed to the kevent_wait call and the commit can happen before 
the thread looks for new events and eventually goes to sleep.  If this 
can be implemented then the kevent_commit syscall by itself might not be 
needed at all.  Instead you'd call kevent_wait() and make the maximum 
number of events which can be returned zero.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
