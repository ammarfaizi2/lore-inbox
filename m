Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934429AbWKXMGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934429AbWKXMGa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 07:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934457AbWKXMGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 07:06:30 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:13549 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S934429AbWKXMG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 07:06:29 -0500
Date: Fri, 24 Nov 2006 15:05:31 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Message-ID: <20061124120531.GC32545@2ka.mipt.ru>
References: <11641265982190@2ka.mipt.ru> <456621AC.7000009@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456621AC.7000009@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Nov 2006 15:05:33 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 02:33:16PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >+ int kevent_commit(int ctl_fd, unsigned int start, 
> >+ 	unsigned int num, unsigned int over);
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

I like this interface, although current one does not allow special
synchronization in userspace, since it calculates if new commit is in
the area where previous commit was.
Will change for the next release.
 
> There is one more thing to consider.  Oftentimes the commit request will 
> be immediately followed by a kevent_wait call.  It would be good to 
> merge this pair of calls.  The two parameters new_tail and over could 
> also be passed to the kevent_wait call and the commit can happen before 
> the thread looks for new events and eventually goes to sleep.  If this 
> can be implemented then the kevent_commit syscall by itself might not be 
> needed at all.  Instead you'd call kevent_wait() and make the maximum 
> number of events which can be returned zero.

It _IS_ how previous interface worked.

	EXACTLY!

There was one syscall which committed requested number of events and
waited when there are new ready events. The only thing it missed, was
userspace index (it assumed that if userspace waits for something, then
all previous work is done).

Ulrich, I'm not going to think for other people all over the world and
blindly implementing ideas, which in a day or two will be commented as
redundant, since flow of mind has changed, and they had not enough time
to check previous version.

I will wait for some time until you and other people made theirs comments 
on interfaces and release final version in about a week, and now I will
go to hack netchannels.

	NO INTERFACE CHANGES AFTER THAT DAY. 
		COMPLETELY.

So, feel free to think about perfect interface anyone will be happy
with. But please release your thoughts not in form of abstract words,
but more precisely, at least like in this e-mail, so I could understand
what _you_ want from _your_ interface.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
