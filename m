Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265390AbSJRTFG>; Fri, 18 Oct 2002 15:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265376AbSJRTEb>; Fri, 18 Oct 2002 15:04:31 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:8587 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265200AbSJRTCn>; Fri, 18 Oct 2002 15:02:43 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Oct 2002 12:16:48 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: Dan Kegel <dank@kegel.com>, John Myers <jgmyers@netscape.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <20021018185528.GC13876@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0210181209510.1537-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Mark Mielke wrote:

> On Fri, Oct 18, 2002 at 10:41:28AM -0700, Davide Libenzi wrote:
> > Yes, I like coroutines :) even if sometimes you have to be carefull with
> > the stack usage ( at least if you do not want to waste all your memory ).
> > Since there're N coroutines/stacks for N connections even 4Kb does mean
> > something when N is about 100000. The other solution is a state machine,
> > cheaper about memory, a little bit more complex about coding. Coroutines
> > though helps a graceful migration from a thread based application to a
> > multiplexed one. If you take a thread application and you code your
> > connect()/accept()/recv()/send() like the ones coded in the example http
> > server linked inside the epoll page, you can easily migrate a threaded app
> > by simply adding a distribution loop like :
>
> > for (;;) {
> > 	get_events();
> > 	for_each_fd
> > 		call_coroutines_associated_with_ready_fd();
> > }
>
> If each of these co-routines does "while (read() != EAGAIN) wait",
> your implementation is seriously flawed unless you do not mind certain
> file descriptors that may have lower numbers to have a real time
> priority higher than file descriptors with a higher number.

No, once a file descriptor is ready the associated coroutine is called
with a co_call() and, for example, the read function is :

int dph_read(struct dph_conn *conn, char *buf, int nbyte)
{
    int n;

    while ((n = read(conn->sfd, buf, nbyte)) < 0) {
        if (errno == EINTR)
            continue;
        if (errno != EAGAIN && errno != EWOULDBLOCK)
            return -1;
        conn->events = POLLIN | POLLERR | POLLHUP;
        co_resume(conn);
    }
    return n;
}

where co_resume() preempt the current coroutine and run another one ( that
is the scheduler coroutine ). The scheduler coroutine looks like :

static int dph_scheduler(int loop, unsigned int timeout)
{
    int ii;
    static int nfds = 0;
    struct dph_conn *conn;
    static struct pollfd *pfds = NULL;

    do {
        if (!nfds) {
            struct evpoll evp;

            evp.ep_timeout = timeout;
            evp.ep_resoff = 0;

            nfds = ioctl(kdpfd, EP_POLL, &evp);
            pfds = (struct pollfd *) (map + evp.ep_resoff);
        }
        for (ii = 0; ii < EPLIMTEVENTS && nfds > 0; ii++, nfds--, pfds++) {
            if ((conn = dph_find(pfds->fd))) {
                conn->revents = pfds->revents;

                if (conn->revents & conn->events)
                    co_call(conn->co, conn);
            }
        }
    } while (loop);
    return 0;
}

These functions are taken from the really simple example http server used
to test/compare /dev/epoll with poll()/select()/rt-sig//dev/poll :

http://www.xmailserver.org/linux-patches/dphttpd_last.tar.gz




- Davide


