Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272309AbRIOM7S>; Sat, 15 Sep 2001 08:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272313AbRIOM7I>; Sat, 15 Sep 2001 08:59:08 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:23030 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S272309AbRIOM7E>; Sat, 15 Sep 2001 08:59:04 -0400
Message-ID: <3BA350A7.7D39FC23@kegel.com>
Date: Sat, 15 Sep 2001 05:59:19 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-dan i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vitaly Luban <vitaly@luban.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: spin_lock_bh() usage check, please (was: [PATCH][RFC] Signal-per-fd for 
 RT signals)
In-Reply-To: <3BA2AFFF.C7B8C4DF@kegel.com> <3BA2E144.FB0E5D55@luban.org> <3BA2E99A.1134E382@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm playing with a patch that collapses duplicate sigio signals.
It refers to task->files during signal generation,
so it crashes on a uniprocessor system when an interrupt that
causes a sigio comes in while the process was busy expanding its
file table, to wit:

> <send_signal+69/160>      <==== crash on wild pointer here
> <deliver_signal+17/80>
> <send_sig_info+86/b0>
> <send_sigio_to_task+c5/e0>
> <ip_queue_xmit+334/470>
> <tcp_rcv_established+79e/7e0>
> <tcp_v4_send_check+6e/b0>
> <send_sigio+58/b0>
> <__kill_fasync+59/70>
> <sock_wake_async+72/80>
> <sock_def_readable+5d/70>
> <tcp_rcv_established+399/7e0>
> <tcp_v4_do_rcv+3b/120>
> <tcp_v4_rcv+3e4/660>
> <ip_local_deliver+fa/170>
> <ip_rcv+304/380>
> <tulip_interrupt+618/7d0>
> <net_rx_action+17b/290>
> <net_tx_action+62/140>
> <do_softirq+7b/e0>
> <do_IRQ+dd/f0>
> <ret_from_intr+0/7>
> <vfs_rename_other+28/2b0>
> <expand_fd_array+d6/160>
> <get_unused_fd+f2/160>
> <sock_map_fd+c/1c0>
> <sock_create+f3/120>
> <sys_socket+2d/50>
> <sys_socketcall+62/200>
> <system_call+33/38>

Documentation/DocBook/kernel-locking seems to say spin_lock_bh()
is the way to address conflicts like this between a softirq and
the process.

The code referring to task->files is sprinkled into kernel/signal.c
by the patch, in routines where task->sigmask_lock is already
acquired with spin_lock_irqsave() or spin_lock_irq() before entry.

Question: is it safe to acquire task->files->file_lock with spin_lock_bh()
inside these routines, or am I risking deadlock?  Is it an issue that
I might be holding the lock while traversing a list thousands of
entries long?  For example, is adding file_lock locks to rm_sig_from_queue() as
follows safe, efficient, and proper?

/*
 * Remove signal sig from t->pending.
 * Returns 1 if sig was found.
 *
 * All callers must be holding t->sigmask_lock.
 */
static int rm_sig_from_queue(int sig, struct task_struct *t)
{
    struct sigqueue *q, **pp;
    struct sigpending *s = &t->pending;
    struct files_struct *files = t->files;

    if (!sigismember(&s->signal, sig))
        return 0;

    sigdelset(&s->signal, sig);

    pp = &s->head;

    if (files)
        spin_lock_bh(files->file_lock);    /* ??? */
    while ((q = *pp) != NULL) {
        if (q->info.si_signo == sig) {
            /* Must clear f_revents for FASYNC sigs. dank 9/2001 */
            struct file *filp;
            if (files
            &&  (q->info.si_fd < files->max_fds)
            &&  ((filp = files->fd[ q->info.si_fd ]) != 0)
            &&  (filp->f_flags & FASYNC)
            &&  (filp->f_owner.signum == sig))
                filp->f_revents = 0;

            if ((*pp = q->next) == NULL)
                s->tail = pp;
            kmem_cache_free(sigqueue_cachep,q);
            atomic_dec(&nr_queued_signals);
            continue;
        }
        pp = &q->next;
    }
    if (files)
         spin_unlock_bh(files->file_lock);   /* ??? */
    return 1;
}

Thanks,
Dan

p.s. The bug was introduced by Luban's one-signal-per-fd patch; I ran into 
it while running my variant of his patch, http://www.kegel.com/linux/onefd-dank.patch
My variant makes the following changes:
* it fixes an oops related to 'task->files' being null during SIGINT
* it fixes two oopses related to signal queue overflow
* it keeps poll data, not pointers, in struct file.  This saves space
  and makes the consequence of screwing up less severe.
* it overloads an existing struct file field to avoid the space penalty;
  it doesn't bloat struct file.
* it assumes that it's better to keep the kernel uncluttered, so it 
  changes the meaning of siginfo.si_code rather than introduces new ioctl's.
  (I hear the Austin draft of the Posix single unix spec is deleting all mention
   of SIGIO, so it looks like we're free to 'improve' that interface freely 
   once Austin becomes the law of the land :-)
  I'm perfectly willing to write patches for phhttpd and x15 to use the
  new interface in the unlikely event that everyone agrees my interface change 
  is good.
