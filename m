Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265354AbSJRVA1>; Fri, 18 Oct 2002 17:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbSJRVA1>; Fri, 18 Oct 2002 17:00:27 -0400
Received: from cse.ogi.edu ([129.95.20.2]:17900 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S265354AbSJRVAY>;
	Fri, 18 Oct 2002 17:00:24 -0400
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210171121390.1631-100000@blue1.dev.mcafeelabs.com>
	<3DB05AB2.3010907@netscape.com>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 18 Oct 2002 14:01:08 -0700
In-Reply-To: <3DB05AB2.3010907@netscape.com>
Message-ID: <xu465vzo417.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> >[N-1] for (;;) {
> >[N  ]     fd = event_wait(...);
> >[N+1]     while (do_io(fd) != EAGAIN);
> >[N+2} }

I'm getting confused over what minute details are being disputed here.

This debate might get clearer, to me anyway, if the example code
fragments were more concrete.

So if anybody still cares at this point, here is my stab at clarifying
some things.

PART I:  THE RACE

Suppose we have the following:

1 for(;;) {
2      fd = event_wait(...);
3      if(fd == my_listen_fd) {
4           /* new connections */
5           while((new_fd = my_accept(my_listen_fd, ...) != EAGAIN)) 
6                   epoll_addf(new_fd, ...);
7       } else {
8           /* established connections */
9           while(do_io(fd) != EAGAIN)
10      }
11 }

With the current epoll/rtsig semantics, there is a race condition
above.  I think this essentially the same race condition as the
snippet at the top of this message.  

Just to be clear, I walk completely through the steps in the race
scenario, as follows.

We start with our application blocked in line 2.  

A new connection is initiated by the application on other side.

The kernels exchange SYNs, causing the connection to be established.

The kernel on our side queues the new connection, waiting for the
application on this side to call accept().  In the process it fires an
edge POLLIN on the listen_fd, which wakes up the kernel side of line
2.  However, some time may pass before we actually wake up.

Meanwhile, the other side immediately sends some application level
data. The other side is going to wait for us to read the application
level data and respond.  So it is now blocked.

All of this happens before our application runs line 5 to pick up the
new connection from the kernel.  

Here comes the race:

Before we reach line 6, new_fd is not in epoll mode, so packet
arrivals do not trigger a POLLIN edge notfication on new_fd.

After line 6, there will be no data from the other side, so there will
still be no POLLIN edge notification for new_fd.

Therefore, line 2 will never yield a POLLIN event for new_fd, and the
new connection is now deadlocked.

Is this the kind of race we're talking about?

If so, we proceed as follows.

PART 2: SOLUTIONS

A race free alternative to write the code above is as follows.  Only
one new line (marked with *) is added.

1 for(;;) {
2      fd = event_wait(...);
3      if(fd == my_listen_fd) {
4           /* new connections */
5           while((new_fd = my_accept(my_listen_fd, ...) != EAGAIN)) {
6                    epoll_addf(new_fd, ...);
7*                   while(do_io(new_fd) != EAGAIN);
8           }
9       } else {
10           /* established connections */
11           while(do_io(fd) != EAGAIN)
12      }
13 }

The example above works with current epoll and rtsig semantics.  This
is just rephrasing what Davide has been saying: "Never call event_wait
without first ensuring that IO space is definitively exhausted".

Or we could have (to make John happier?):

1 for(;;) {
2      fd = event_wait(...);
3      if(fd == my_listen_fd) {
4           /* new connections */
5           while((new_fd = my_accept(my_listen_fd, ...) != EAGAIN)) {
6*                  epoll_addf(new_fd, &pfd, ...);
7*                  if(pfd.revents & POLLIN) {
7*                      while(do_io(new_fd) != EAGAIN);
8*                  } 
8           }
9       } else {
10           /* established connections */
11           while(do_io(fd) != EAGAIN)
12      }
13 }

Here, epoll_addf primitive has been modified to return the initial
status.  Presumably so we avoid the first call to do_io if there is
nothing to do yet.

If it's easy to do (change add primitive that is), why not?

The first solution works either way.

-- Buck









