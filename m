Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbSJ2HSo>; Tue, 29 Oct 2002 02:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSJ2HSo>; Tue, 29 Oct 2002 02:18:44 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:19840 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261570AbSJ2HSl>; Tue, 29 Oct 2002 02:18:41 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 23:34:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updated sys_epoll now with man pages
In-Reply-To: <3DBE1824.B3D84E9F@digeo.com>
Message-ID: <Pine.LNX.4.44.0210282247520.1002-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Andrew Morton wrote:

> epoll seems to be a good and desirable thing.  To move forward I
> believe we need to get this code reviewed, and documented.

Ok, this is the long story ...
The epoll interface completely hooks in the existing sk_wake_async()
function that is already called to issue async events for rt-sig. The
patch adds :

struct file {
    ...
    /* file callback list */
    rwlock_t f_cblock;
    struct list_head f_cblist;
};

a list of callback to be called upon event dispatch. This list is
maintained by fs/fcblist.c and each entry of such list is an item :

struct fcb_struct {
    struct list_head llink;
    void (*cbproc)(struct file *, void *, unsigned long *, long *);
    void *data;
    unsigned long local[FCB_LOCAL_SIZE];
};

This list is initiated in fs/file_table.c by calling :

static inline void file_notify_init(struct file *filep)
{
    rwlock_init(&filep->f_cblock);
    INIT_LIST_HEAD(&filep->f_cblist);
}

( defined in include/linux/fcblist.h ) in functions :

get_empty_filp()
init_private_file()

and is cleaned up calling :

void file_notify_cleanup(struct file *filep)
{
    unsigned long flags;
    struct list_head *lnk, *lsthead;

    fcblist_write_lock(filep, flags);

    lsthead = &filep->f_cblist;
    while ((lnk = list_first(lsthead))) {
        struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct, llink);

        list_del(lnk);
        fcblist_write_unlock(filep, flags);
        kfree(fcbp);
        fcblist_write_lock(filep, flags);
    }

    fcblist_write_unlock(filep, flags);
}

from inside :

__fput()

When an fd is inserted in the interest set the drivers/char/eventpoll.c
code adds a callback ( notify_proc() ) to the callback list of the
inserted file by monitoring all the async dispatches done on such file.
This dispatches hooks :

static inline void sk_wake_async(struct sock *sk, int how, int band)
{
    if (sk->socket) {
        if (sk->socket->file)
            file_send_notify(sk->socket->file, ion_band_table[band - POLL_IN],
                    poll_band_table[band - POLL_IN]);
        if (sk->socket->fasync_list)
            sock_wake_async(sk->socket, how, band);
    }
}

where the simple insertion of :

static inline void file_send_notify(struct file *filep, long ioevt, long plevt) {
    long event[] = { ioevt, plevt, -1 };

    file_notify_event(filep, event);
}

void file_notify_event(struct file *filep, long *event)
{
    unsigned long flags;
    struct list_head *lnk, *lsthead;

    fcblist_read_lock(filep, flags);

    lsthead = &filep->f_cblist;
    list_for_each(lnk, lsthead) {
        struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct, llink);

        fcbp->cbproc(filep, fcbp->data, fcbp->local, event);
    }

    fcblist_read_unlock(filep, flags);
}

will garantie that all the associated callbacks are properly invoked.
So, now we know how event reaches the core of the implementation, that is :

static void notify_proc(struct file *file, void *data, unsigned long *local, long *event)
{
    struct epitem *dpi = data;
    struct eventpoll *ep = dpi->ep;
    struct pollfd *pfd;

    DNPRINTK(3, (KERN_INFO "[%p] eventpoll: notify(%p, %p, %ld, %ld) ep=%p\n",
                 current, file, data, event[0], event[1], ep));

    write_lock(&ep->lock);
    if (!(dpi->pfd.events & event[1]))
        goto out;

    if (dpi->index < 0 || dpi->ver != ep->ver) {
        if (ep->eventcnt >= (ep->numpages * POLLFD_X_PAGE))
            goto out;
        dpi->index = ep->eventcnt++;
        dpi->ver = ep->ver;
        pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
                                 EVENT_PAGE_OFFSET(dpi->index));
        *pfd = dpi->pfd;
    } else {
        pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
                                 EVENT_PAGE_OFFSET(dpi->index));
        if (pfd->fd != dpi->pfd.fd) {
            if (ep->eventcnt >= (ep->numpages * POLLFD_X_PAGE))
                goto out;
            dpi->index = ep->eventcnt++;
            pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
                                     EVENT_PAGE_OFFSET(dpi->index));
            *pfd = dpi->pfd;
        }
    }

    pfd->revents |= (pfd->events & event[1]);

    if (waitqueue_active(&ep->wq))
        wake_up(&ep->wq);
    if (waitqueue_active(&ep->poll_wait))
        wake_up(&ep->poll_wait);
out:
    write_unlock(&ep->lock);
}

The eventpoll interface uses a double-buffer to store events. While the
user space processes the old returned ones, the kernel fills in the other
buffer. Those buffers are switched on sys_epoll_wait() or the old
ioctl(EP_POLL). The buffer is mmap()ed in user space and in this way
there's no kernel to user space memory movement, besides the 4/8 bytes of
the returned pointer. The notify_proc() basically stores the new incoming
event into the existing slot ( if any ) or moves to the next slot if the
source "fd" did not have any event slot allocated. Determining if the fd
had a previous slot allocated is done by checking the ->index, ->ver and
the stored ->pfd.fd. If the event trigger a new slot allocation the number
of stored event slot ( ep->eventcnt ) is increased and, on exit, the wake
up list is invoked. Each epoll file descriptor has its own f->private_data
structure :

struct eventpoll {
    /* semaphore used to serialize event set changes */
    struct rw_semaphore acsem;
    /* rw lock used to serialize hash and double buffer access */
    rwlock_t lock;
    /* wait queue for sysy_epoll_wait() and ioctl(EP_POLL) */
    wait_queue_head_t wq;
    /* wait queue for f->poll() */
    wait_queue_head_t poll_wait;
    /* fd hash and associated variables */
    struct list_head *hash;
    unsigned int hbits;
    unsigned int hmask;
    atomic_t hents;
    atomic_t resize;
    /* double buffer variables */
    int numpages;
    char **pages;
    char *pages0[MAX_EVENTPOLL_PAGES];
    char *pages1[MAX_EVENTPOLL_PAGES];
    /* vma base address where the mmap() took place */
    unsigned long vmabase;
    /* mmap()ed flag */
    atomic_t mmapped;
    /* number of available events */
    int eventcnt;
    /* versioning used to validate double buffer entries */
    event_version_t ver;
};

And each entry in the hash table is described by :

struct epitem {
    struct list_head llink;
    struct eventpoll *ep;
    struct file *file;
    struct pollfd pfd;
    int index;
    event_version_t ver;
};

The rest of the code is simply "infrastructure" needed to be able to
support a file* ( f_op ) and also the inode source file system.
About the stability of the code, I can say that it has been heavily stress
tested ( the old epoll code is used in production appliance ) on both UP
and SMP and guys that actually tested it could report how many crashes
they had. Does it have bugs ? Obviously it does ... but spotting the
eventually new ones will be more productive than ranting about the fact
that you found some in the previous revision. Andrew, if we don't want to
merge this, it's fine for me. Just don't shoot "several weeks" to review
something that "at the bone" are no more than 200 lines of code. And we're
talking about a code that, per Linus statement, will have about 8 months
to see the light ...




- Davide








