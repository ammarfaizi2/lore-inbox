Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQKMLUk>; Mon, 13 Nov 2000 06:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQKMLU3>; Mon, 13 Nov 2000 06:20:29 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:58510 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129385AbQKMLUU>; Mon, 13 Nov 2000 06:20:20 -0500
Message-ID: <3A0FCD72.1F4C5C46@uow.edu.au>
Date: Mon, 13 Nov 2000 22:16:02 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Jasper Spaans <jasper@spaans.ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11pre2-ac1 and previous problem
In-Reply-To: Your message of "Mon, 13 Nov 2000 09:58:17 BST."
	             <20001113095816.A29077@spaans.ds9a.nl> <2002.974112299@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 13 Nov 2000 09:58:17 +0100,
> Jasper Spaans <jasper@spaans.ds9a.nl> wrote:
> >All right, here's another one, this time using the oops directly from the
> >console -- this seems to give better symbols.. The 'console shuts up ...'
> >works, the oops from the other CPU didn't get put out.
> 
> Ohhhh, damn!  For NMI lockups we want the console to stay live so NMI
> detection on the other cpus can be printed.  NMI is normally caused by
> spinlock problems and it is useful to know what the other cpus are
> doing.  Andrew, do you want to have a go at fixing this?

Uh, sure - I just _love_ running fsck :)  I'm working on this stuff
at present.  That wake_up in printk() is baaaaad...

> >Will try test11-pre3 + kdb this afternoon, if it compiles.
> 
> Patch kdb-v1.5-2.4.0-test11-pre3.gz should be OK.

It would be very, very interesting to see where the other CPU is.

I can see one bug from Jasper's trace: setscheduler() does:

        spin_lock_irq(&runqueue_lock);
        read_lock(&tasklist_lock);

whereas the exit_notify->do_notify_parent->send_sig_info->wake_up_process
path does:

        write_lock_irq(&tasklist_lock);
        spin_lock_irqsave(&runqueue_lock, flags);

Death by double deadlock.  But I doubt if setscheduler() is the
source - who ever calls that?

The correct locking hierarchy is, I think:

	spin_lock(runqueue_lock)
	read/write_lock(tasklist_lock)
	read/write_unlock(tasklist_lock)
	spin_unlock(runqueue_lock)

Jasper, as a random stab in the dark you may care to try this:

--- linux-2.4.0-test11-pre4/kernel/exit.c	Sun Oct 15 01:27:46 2000
+++ linux-akpm/kernel/exit.c	Mon Nov 13 22:05:37 2000
@@ -381,8 +381,10 @@
 	 *	jobs, send them a SIGHUP and then a SIGCONT.  (POSIX 3.2.2.2)
 	 */
 
-	write_lock_irq(&tasklist_lock);
+	read_lock_irq(&tasklist_lock);
 	do_notify_parent(current, current->exit_signal);
+	read_unlock_irq(&tasklist_lock);
+	write_lock_irq(&tasklist_lock);
 	while (current->p_cptr != NULL) {
 		p = current->p_cptr;
 		current->p_cptr = p->p_osptr;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
