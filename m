Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265290AbSJRVTO>; Fri, 18 Oct 2002 17:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265301AbSJRVTO>; Fri, 18 Oct 2002 17:19:14 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:49035 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265290AbSJRVTN>; Fri, 18 Oct 2002 17:19:13 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Oct 2002 14:33:35 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Charles 'Buck' Krasic" <krasic@acm.org>
cc: John Gardiner Myers <jgmyers@netscape.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <xu465vzo417.fsf@brittany.cse.ogi.edu>
Message-ID: <Pine.LNX.4.44.0210181426390.1537-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Oct 2002, Charles 'Buck' Krasic wrote:

> I'm getting confused over what minute details are being disputed here.
>
> This debate might get clearer, to me anyway, if the example code
> fragments were more concrete.
>
> So if anybody still cares at this point, here is my stab at clarifying
> some things.
>
> PART I:  THE RACE
>
> Suppose we have the following:
>
> 1 for(;;) {
> 2      fd = event_wait(...);
> 3      if(fd == my_listen_fd) {
> 4           /* new connections */
> 5           while((new_fd = my_accept(my_listen_fd, ...) != EAGAIN))
> 6                   epoll_addf(new_fd, ...);
> 7       } else {
> 8           /* established connections */
> 9           while(do_io(fd) != EAGAIN)
> 10      }
> 11 }
>
> With the current epoll/rtsig semantics, there is a race condition
> above.  I think this essentially the same race condition as the
> snippet at the top of this message.
>
> Just to be clear, I walk completely through the steps in the race
> scenario, as follows.
>
> We start with our application blocked in line 2.
>
> A new connection is initiated by the application on other side.
>
> The kernels exchange SYNs, causing the connection to be established.
>
> The kernel on our side queues the new connection, waiting for the
> application on this side to call accept().  In the process it fires an
> edge POLLIN on the listen_fd, which wakes up the kernel side of line
> 2.  However, some time may pass before we actually wake up.
>
> Meanwhile, the other side immediately sends some application level
> data. The other side is going to wait for us to read the application
> level data and respond.  So it is now blocked.
>
> All of this happens before our application runs line 5 to pick up the
> new connection from the kernel.
>
> Here comes the race:
>
> Before we reach line 6, new_fd is not in epoll mode, so packet
> arrivals do not trigger a POLLIN edge notfication on new_fd.
>
> After line 6, there will be no data from the other side, so there will
> still be no POLLIN edge notification for new_fd.
>
> Therefore, line 2 will never yield a POLLIN event for new_fd, and the
> new connection is now deadlocked.
>
> Is this the kind of race we're talking about?

Exactly, you're going to wait for an event w/out having consumed the
possibly available I/O space.



> If so, we proceed as follows.
>
> PART 2: SOLUTIONS
>
> A race free alternative to write the code above is as follows.  Only
> one new line (marked with *) is added.
>
> 1 for(;;) {
> 2      fd = event_wait(...);
> 3      if(fd == my_listen_fd) {
> 4           /* new connections */
> 5           while((new_fd = my_accept(my_listen_fd, ...) != EAGAIN)) {
> 6                    epoll_addf(new_fd, ...);
> 7*                   while(do_io(new_fd) != EAGAIN);
> 8           }
> 9       } else {
> 10           /* established connections */
> 11           while(do_io(fd) != EAGAIN)
> 12      }
> 13 }

Exactly, this is the sketchy solution ( but event_wait() return more than
one fd though ).




- Davide


