Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSKARUr>; Fri, 1 Nov 2002 12:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265431AbSKARUr>; Fri, 1 Nov 2002 12:20:47 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:3717 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265368AbSKARUo>; Fri, 1 Nov 2002 12:20:44 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 1 Nov 2002 09:36:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
In-Reply-To: <20021101020119.GC30865@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211010914340.1715-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Jamie Lokier wrote:

> I have no objections to it.  Generally, I'd like epoll to be able to
> report _what_ the event was (not just POLL_RDNORM, but what kind of
> dnotify event), but as I don't get to run on an ideal kernel [;)] I'll
> be happy with POLL_RDNORM.

See below ...


> > I still believe that the 1:1 mapping is sufficent and with that in place (
> > and the one line patch to kernel/futex.c ) futex support comes nicely.
>
> It does work - actually, with ->poll() you don't need any lines in futex.c :)

The global poll hook might work, but you can deliver anything with your
callback. And you have to actually do another poll to understand which
poll flags you really got. Adding the famous one-lines patches to single
devices anytime there's the need, being file_notify_send() completely
expandible, enable you to have a more detailed report to send back to the
caller.



> You avoid the extra CPU cycles like this:
>
>     1. EP_CTL_ADD adds the listener to the file's wait queue using
>        ->poll(), and gets a free test of the object readiness [;)]
>
>     2. When the transition happens, the wakeup will call your function,
>        epoll_wakeup_function.  That removes the listener from the file's
>        wait queue.  Note, you won't see any more wakeups from that file.
>
>     3. When you report the event user space, _then_ you automatically
>        add the listener back to the file's wait queue by calling ->poll().
>
> This way, there are no spurious wakeups, and nothing to collapse.  I
> would not be surprised if this is quite fast - perhaps as fast as the
> special epoll hooks.

Jamie, I'm afraid it won't. This is the cost of reporting events to the
user with the current epoll :

                ep->eventcnt = 0;
                ++ep->ver;
                if (ep->pages == ep->pages0) {
                        ep->pages = ep->pages1;
                        dvp->ep_resoff = 0;
                } else {
                        ep->pages = ep->pages0;
                        dvp->ep_resoff = ep->numpages * PAGE_SIZE;
                }

Using the global poll hook you have several problem. First the poll table
is not suitable to single insert/removal, all you need is a poll_wait()
that, recognizing a special type of table, do insert in the wait queue
differently. For example you'll have :


typedef struct poll_table_struct {
+	int queue;
+	wait_queue_t *q;
        int error;
        struct poll_table_page * table;
} poll_table;

This togheter with :

static inline void poll_initwait_ex(poll_table* pt, wait_queue_t *q, int queue)
{
+	pt->queue = queue;
+	pt->q = q;
        pt->error = 0;
        pt->table = NULL;
}

And the :

void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
{
        struct poll_table_page *table = p->table;

+	if (!p->queue)
+		return;
+	if (p->q) {
+		add_wait_queue(wait_address, p->q);
+		return;
+	}
        if (!table || POLL_TABLE_FULL(table)) {
                struct poll_table_page *new_table;

                new_table = (struct poll_table_page *) __get_free_page(GFP_KERNEL);
                if (!new_table) {
                        p->error = -ENOMEM;
                        __set_current_state(TASK_RUNNING);
                        return;
                }
                new_table->entry = new_table->entries;
                new_table->next = table;
                p->table = new_table;
                table = new_table;
        }

        /* Add a new entry */
        {
                struct poll_table_entry * entry = table->entry;
                table->entry = entry+1;
                get_file(filp);
                entry->filp = filp;
                entry->wait_address = wait_address;
                init_waitqueue_entry(&entry->wait, current);
                add_wait_queue(wait_address,&entry->wait);
        }
}


This enable you to do two things :

1) During the EP_CTL_ADD you do :

	poll_table pt;

	poll_initwait_ex(&pt, &dpi->q, 1);
	file->f_op->poll(file, &pt);

	and this adds _your_own_ wait queue object in the file poll queue.
	No full blow poll_table. You need your own wait queue because when
	the callback ( wakeup ) is called you need to call container_of()
	to get the dpi*

2) Before reporting events you need to fetch _real_ poll flags for each
	file you received the callback from. You do :

        poll_table pt;

        poll_initwait_ex(&pt, NULL, 0);
        flags = file->f_op->poll(file, &pt);

You really don't want to remove and add to file's poll queue _every_ time
you receive an event. You're going to pay a lot for that. I'm currently
coding this one to give it a try to see what kind of performances I get.
With the global poll hook you won't be able to do more detailed event
report that file_notify_event() enable you to do.



- Davide


