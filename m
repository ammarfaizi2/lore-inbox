Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265404AbSJaUNJ>; Thu, 31 Oct 2002 15:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265405AbSJaUNI>; Thu, 31 Oct 2002 15:13:08 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:32394 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265404AbSJaUNB>; Thu, 31 Oct 2002 15:13:01 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 31 Oct 2002 12:28:11 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
In-Reply-To: <20021031154112.GB27801@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0210311211160.1562-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Jamie Lokier wrote:

> ps. I thought I should explain what bothers me most about epoll at the
> moment.  It's good at what it does, but it's so very limited in what
> it supports.
>
> I have a high performance server application in mind, that epoll is
> _almost_ perfect for but not quite.
>
> Davide, you like coroutines, so perhaps you will appreciate a web
> server that serves a mixture of dynamic and static content, using
> coroutines and user+kernel threading in a carefully balanced way.
> Dynamic content is cached, accurately (taking advantage of nanosecond
> mtimes if possible), yet served as fast as static pages (using a
> clever cache validation method), and is built from files (read using
> aio to improve throughput) and subrequests to other servers just like
> a proxy.  Data is served zero-copy using sendfile and /dev/shm.
>
> A top quality server like that, optimised for performance, has to
> respond to these events:
>
> 	- network accept()
> 	- read/write/exception on sockets and pipes
> 	- timers
> 	- aio
> 	- futexes
> 	- dnotify events
>
> See how epoll only helps with the first two?  And this is the very
> application space that epoll could _almost_ be perfect for.
>
> Btw, it doesn't _have_ to be a web server.  Enterprise scale Java
> runtimes, database servers, spider clients, network load generators,
> proxies, even humble X servers - also have very similar requirements.
>
> There are several scalable and fast event queuing mechanisms in the
> kernel now: rt-signals, aio and epoll, yet each of them is limited by
> only keeping track of a few kinds of possible event.
>
> Technically, it's possible to use them all together.  If you want to
> react to all the kinds of events I listed above, you have to.  But
> it's mighty ugly code to use them all at once, and it's certainly not
> the "lean and mean" event loop that everyone aspires to.
>
> By adding yet another mechanism without solving the general problem,
> epoll just makes the mighty ugly userspace more ugly.  (But it's
> probably worth using - socket notifcation through rt-signals has its
> own problems).
>
> I would very much like to see a general solution to the problem of all
> different kinds of events being queued to userspace efficiently,
> through one mechanism ("to bind them all...").  Every piece of this puzzle
> has been written already, they're just not joined up very well.
>
> I'm giving this serious thought now, if anyone wants to offer input.

Jamie, the fact that epoll supports a limited number of "objects" was an
as-designed at that time. I see it quite easy to extend it to support
other objects. Futexes are a matter of one line of code int :

/* Waiter either waiting in FUTEX_WAIT or poll(), or expecting signal */
static inline void tell_waiter(struct futex_q *q)
{
        wake_up_all(&q->waiters);
        if (q->filp) {
                send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
+		file_notify_send(q->filp, ION_IN, POLLIN | POLLRDNORM);
	}
}

Timer, as long as you access them through a file* interface ( like futexes )
will become trivial too. Another line should be sufficent for dnotify :

void __inode_dir_notify(struct inode *inode, unsigned long event)
{
        struct dnotify_struct * dn;
        struct dnotify_struct **prev;
        struct fown_struct *    fown;
        int                     changed = 0;

        write_lock(&dn_lock);
        prev = &inode->i_dnotify;
        while ((dn = *prev) != NULL) {
                if ((dn->dn_mask & event) == 0) {
                        prev = &dn->dn_next;
                        continue;
                }
                fown = &dn->dn_filp->f_owner;
                send_sigio(fown, dn->dn_fd, POLL_MSG);
+		file_notify_send(dn->dn_filp, ION_IN, POLLIN | POLLRDNORM | POLLMSG);
                if (dn->dn_mask & DN_MULTISHOT)
                        prev = &dn->dn_next;
                else {
                        *prev = dn->dn_next;
                        changed = 1;
                        kmem_cache_free(dn_cache, dn);
                }
        }
        if (changed)
                redo_inode_mask(inode);
        write_unlock(&dn_lock);
}

This is the result of a quite quick analysis, but I do not expect it to be
much more difficult than that.




- Davide


