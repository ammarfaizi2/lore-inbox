Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSJRSvz>; Fri, 18 Oct 2002 14:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265307AbSJRSvl>; Fri, 18 Oct 2002 14:51:41 -0400
Received: from mark.mielke.cc ([216.209.85.42]:56328 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265567AbSJRStr>;
	Fri, 18 Oct 2002 14:49:47 -0400
Date: Fri, 18 Oct 2002 14:55:28 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Dan Kegel <dank@kegel.com>, John Myers <jgmyers@netscape.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
Message-ID: <20021018185528.GC13876@mark.mielke.cc>
References: <3DB044C6.1080908@kegel.com> <Pine.LNX.4.44.0210181027440.1537-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210181027440.1537-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 10:41:28AM -0700, Davide Libenzi wrote:
> Yes, I like coroutines :) even if sometimes you have to be carefull with
> the stack usage ( at least if you do not want to waste all your memory ).
> Since there're N coroutines/stacks for N connections even 4Kb does mean
> something when N is about 100000. The other solution is a state machine,
> cheaper about memory, a little bit more complex about coding. Coroutines
> though helps a graceful migration from a thread based application to a
> multiplexed one. If you take a thread application and you code your
> connect()/accept()/recv()/send() like the ones coded in the example http
> server linked inside the epoll page, you can easily migrate a threaded app
> by simply adding a distribution loop like :

> for (;;) {
> 	get_events();
> 	for_each_fd
> 		call_coroutines_associated_with_ready_fd();
> }

If each of these co-routines does "while (read() != EAGAIN) wait",
your implementation is seriously flawed unless you do not mind certain
file descriptors that may have lower numbers to have a real time
priority higher than file descriptors with a higher number.

If efficiency is the true goal - the event loop itself needs to be
abstracted - not just the query and dispatch routines. Using /dev/epoll
in a way that it is compatible with other applications is an excercise
in abuse, that will only show positive results because the alternatives
to /dev/epoll are ineffective, not because /dev/epoll is a better model.

I like the idea of /dev/epoll - which means that if I used it, I would
implement an efficient model with it, not a traditional model that through
hackery will function transparently using /dev/epoll.

But that might just be me...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

