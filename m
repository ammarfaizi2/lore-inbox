Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263711AbSJ3DhG>; Tue, 29 Oct 2002 22:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSJ3DhG>; Tue, 29 Oct 2002 22:37:06 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:28830 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263711AbSJ3DgD>; Tue, 29 Oct 2002 22:36:03 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 19:51:56 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <3DBF426B.6050208@netscape.com>
Message-ID: <Pine.LNX.4.44.0210291839190.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, John Gardiner Myers wrote:

> Failure to agree does not imply failure to understand.  I understand the
> model you want to apply to this problem, I do not agree that it is the
> best model to apply to this problem.

John, your first post about epoll was "the interface has a bug, please
do not merge it". Now either you have a strange way to communicate non
agreement or it is something more than that. Or maybe you wanted just
blindly kill the interface with your comments because you're totally
committed to another one currently. And the existance of an interface that
might work as well, or maybe better in some cases, could create you some
problem that I'm unaware about.



> >Why the heck ( and this for the 100th time ) do you want to go to wait for
> >an event on the newly born fd if :
> >
> >1) On connect() you have the _full_ write I/O space available
> >2) On accept() it's very likely the you'll find something more than a SYN
> >	in the first packet
> >
> >Besides, the first code is even more cleaner and simmetric, while adopting
> >your half *ss solution might suggest the user that he can go waiting for
> >events any time he wants.
> >
> The first code is hardly cleaner and is definitely not symmetric--the
> way the accept code has to set up to fall through the do_use_fd() code
> is subtle.  In the first code, the accept segment cannot be cleanly
> pulled into a callback:
>
> for (;;) {
>         nfds = sys_epoll_wait(kdpfd, &pfds, -1);
>         for(n = 0; n < nfds; ++n) {
>                 (cb[pfds[n].fd])(pfds[n].fd);
>         }
> }

Sorry, what prevents you in coding that ? If you, instead of ranting
because epoll does not fit your personal idea of event notification, took
a look to the example http server used for the test ( coroutine based )
you'll see that does exactly that. Ok, it's a mess because it supports 5
interfaces, all #ifdef'ed, but the concept is there.



> Also, your first code does not fit your "edge triggered" model--the code
> for handling 's' does not drain its input.  By the time you call
> accept(), there could be multiple connections ready to be accepted.

I really don't believe this. Are you just trolling or what ? It is clear
that your acceptor routine has to do a little more work than that in a
real program. Again, looking at the example http server might help you.
This is what the acceptor coroutine does in such _trivial_ http server :

static void *dph_acceptor(void *data)
{
        struct dph_conn *conn = (struct dph_conn *) data;
        struct sockaddr_in addr;
        int sfd, addrlen = sizeof(addr);

        while ((sfd = dph_accept(conn, (struct sockaddr *) &addr, &addrlen)) != -1) {
                if (dph_new_conn(sfd, dph_httpd) < 0) {
                        dph_close(sfd);

                }
        }
        return data;
}

and this is dph_accept :

int dph_accept(struct dph_conn *conn, struct sockaddr *addr, int *addrlen)
{
        int sfd, flags = 1;

        while ((sfd = accept(conn->sfd, addr, (socklen_t *) addrlen)) < 0) {
                if (errno == EINTR)
                        continue;
                if (errno != EAGAIN && errno != EWOULDBLOCK)
                        return -1;
                conn->events = POLLIN;
                co_resume(conn);
        }
        if (ioctl(sfd, FIONBIO, &flags) &&
                ((flags = fcntl(sfd, F_GETFL, 0)) < 0 ||
                 fcntl(sfd, F_SETFL, flags | O_NONBLOCK) < 0)) {
                close(sfd);
                return -1;
        }
        return sfd;
}

and this is dph_new_conn :

static int dph_new_conn(int sfd, void *func)
{
        struct dph_conn *conn = (struct dph_conn *) malloc(sizeof(struct dph_conn));
        struct pollfd pfd;

        if (!conn)
                return -1;

        DBL_INIT_LIST_HEAD(&conn->lnk);
        conn->sfd = sfd;
        conn->events = POLLIN | POLLOUT;
        conn->revents = 0;
        if (!(conn->co = co_create(func, NULL, stksize))) {
                free(conn);
                return -1;
        }

        DBL_LIST_ADDT(&conn->lnk, &chash[sfd % chash_size]);

        if (epoll_ctl(kdpfd, EP_CTL_ADD, sfd, POLLIN | POLLOUT) < 0) {
                DBL_LIST_DEL(&conn->lnk);
                co_delete(conn->co);
                free(conn);
                return -1;

        }

        co_call(conn->co, conn);

        return 0;
}

Oh ... I forgot the scheduler :

static int dph_scheduler(int loop, unsigned int timeout)
{
        int ii, nfds;
        struct dph_conn *conn;
        struct pollfd const *pfds;

        do {
                nfds = sys_epoll_wait(kdpfd, &pfds, timeout * 1000);

                for (ii = 0; ii < nfds; ii++, pfds++) {
                        if ((conn = dph_find(pfds->fd))) {
                                conn->revents = pfds->revents;

                                if (conn->revents & conn->events)
                                        co_call(conn->co, conn);
                        }
                }
        } while (loop);
        return 0;
}

And just to make it complete, those are read/write :

int dph_read(struct dph_conn *conn, char *buf, int nbyte)
{
        int n;

        while ((n = read(conn->sfd, buf, nbyte)) < 0) {
                if (errno == EINTR)
                        continue;
                if (errno != EAGAIN && errno != EWOULDBLOCK)
                        return -1;
                conn->events = POLLIN;
                co_resume(conn);
        }
        return n;
}

int dph_write(struct dph_conn *conn, char const *buf, int nbyte)
{
        int n;

        while ((n = write(conn->sfd, buf, nbyte)) < 0) {
                if (errno == EINTR)
                        continue;
                if (errno != EAGAIN && errno != EWOULDBLOCK)
                        return -1;
                conn->events = POLLOUT;
                co_resume(conn);
        }
        return n;
}


The functions co_resume() and co_call() are the coroutine suspend and
call. The one I'm using is this :

http://www.goron.de/~froese/coro/

but coroutine implementation is trivial. You can change the same
implementation to use an I/O driven state machine and the result does not
change.



> I am uncomfortable with the way the epoll code adds its own set of
> notification hooks into the socket and pipe code.  Much better would be
> to extend the existing set of notification hooks, like the aio poll code
> does.  That would reduce the risk of kernel bugs where some subsystem
> fails to deliver an event to one but not all types of poll notification
> hooks and it would minimize the cost of the epoll patch when epoll is
> not being used.

Doh ! John, did you actually read the code ? Could you compare AIO level
of intrusion inside the kernel code with the epoll one ? It fits _exactly_
the rt-signal hooks. One of the design goals for me was to add almost
nothing on the main path. You can lookup here for a quick compare between
aio poll and epoll for a test where events delivery efficency does matter
( pipetest ) :

http://lse.sourceforge.net/epoll/index.html

Now, I don't believe that a real world app will exchange 300000 tokens per
second through a pipe, but this help you to understand the efficency of
the epoll event notification subsystem.




- Davide




