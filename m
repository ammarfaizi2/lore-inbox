Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSJaXpu>; Thu, 31 Oct 2002 18:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265527AbSJaXpt>; Thu, 31 Oct 2002 18:45:49 -0500
Received: from dp.samba.org ([66.70.73.150]:60358 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265523AbSJaXpp>;
	Thu, 31 Oct 2002 18:45:45 -0500
Date: Fri, 1 Nov 2002 09:00:34 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lk@tantalophile.demon.co.uk, davidel@xmailserver.org,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       lse-tech@lists.sourceforge.net, torvalds@transmeta.com, akpm@digeo.com
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-Id: <20021101090034.42e207e5.rusty@rustcorp.com.au>
In-Reply-To: <1036082758.8575.81.camel@irongate.swansea.linux.org.uk>
References: <20021031005259.GA25651@bjl1.asuk.net>
	<Pine.LNX.4.44.0210301924190.1452-100000@blue1.dev.mcafeelabs.com>
	<20021031154112.GB27801@bjl1.asuk.net>
	<1036082758.8575.81.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Oct 2002 16:45:58 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> What is hard is multiple futex waits and livelock for that. I think it
> can be done properly but I've not sat down and designed it all out - I
> wonder what Rusty thinks.

Hmm... Never thought about it.  You mean an API like:

	struct futex_set *futex_set_init();
	struct futex_set *futex_set_add(struct futex_set *, struct futex *);
	/* Returns futex obtained. */
	struct futex *futex_set_wait(struct futex_set *);

I think a naive implementation of futex_set_wait would look like:

	set = futex_set
 try:
	for each futex in set {
		if (grab in userspace) {
			close fds;
			return with futex;
		}
		close old fd for futex if any
		call FUTEX_FD to get fd notification of futex;
	}

	select on fds
	set = fds which are ready
	goto try

You could, of course, loop through the fast path once before making any
syscalls.  Another optimization is to have FUTEX_FD reuse an existing fd
rather than requiring the close.

Not sure I get the point about livelock though: deadlock is possible if
apps seek multiple locks at once without care, of course.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
