Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132279AbRCWAHk>; Thu, 22 Mar 2001 19:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbRCWAFV>; Thu, 22 Mar 2001 19:05:21 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:60353 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132245AbRCWAFA>; Thu, 22 Mar 2001 19:05:00 -0500
Message-ID: <3ABA92F0.CF6729C2@uow.edu.au>
Date: Fri, 23 Mar 2001 00:04:00 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.2-ac19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: frey@cxau.zko.dec.com, linux-kernel@vger.kernel.org
Subject: Re: kernel_thread vs. zombie
In-Reply-To: <007801c0b309$5bca3530$90600410@SCHLEPPDOWN> <20010322233355.8870@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> 
> >daemonize() makes calls that are all protected with the
> >big kernel lock in do_exit(). All usages of daemonize have
> >the big kernel lock held. So I guess it just needs it.
> >
> >Please let me know whether you have success if it makes
> >a difference with having it held.
> 
> With a bit more experiments, I have this behaviour:
> 
> (I hold the kerne lock, daemonize(), and release the kernel lock, then do
> my probe thing which takes a few seconds, and let the thread die by itself)
> 
>  - When started during boot (low PID (9)) It becomes a zombie
>  - When started from a process that quits after sending the ioctl,
>    it is correctly "garbage collected".
>  - When started from a process that stays around, it becomes a zombie too
> 
> So something is not working, or I'm missing something obvious, or whatever...
> 
> Any clue ?

Take a look at kernel/kmod.c:call_usermodehelper().  Copy it.

This will make your thread a child of keventd.  This takes
care of things like chrootedness, uids, cwds, signal masks,
reaping children, open files, and all the other crud which
you can accidentally inherit from your caller.

something like:

struct my_struct
{
    struct tq_struct tq;
    void (*function)(void *);
    struct semaphore sem;
    <other stuff>
};

/* keventd runs this */
void helper(void *data)
{
    struct my_struct *my_ptr = data;

    kernel_thread(my_ptr->function, my_ptr, CLONE_FLAGS|SIGCHLD);
}

start_thread(struct my_struct *my_ptr)
{
    my_ptr->tq.sync = 0;
    INIT_LIST_HEAD(&my_ptr->tq.list);
    my_ptr->routine = helper;
    my_ptr->data = my_ptr;
    schedule_task(&my_ptr->tq);
}
