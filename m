Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVIQWPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVIQWPX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 18:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVIQWPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 18:15:23 -0400
Received: from mx1.rowland.org ([192.131.102.7]:29456 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751134AbVIQWPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 18:15:23 -0400
Date: Sat, 17 Sep 2005 18:15:21 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unusually long delay in the kernel
In-Reply-To: <20050916235259.61b87069.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0509171750210.1078-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, Andrew Morton wrote:

> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > This code excerpt is taken from the start of the control thread for the 
> >  usb-storage driver in 2.6.14-rc1:
> > 
> > 
> >  static int usb_stor_control_thread(void * __us)
> >  {
> >  	struct us_data *us = (struct us_data *)__us;
> >  	struct Scsi_Host *host = us_to_host(us);
> > 
> >  printk(KERN_INFO "Before thread start\n");
> >  	lock_kernel();
> > 
> >  	/*
> >  	 * This thread doesn't need any user-level access,
> >  	 * so get rid of all our resources.
> >  	 */
> >  	daemonize("usb-storage");
> >  	current->flags |= PF_NOFREEZE;
> >  	unlock_kernel();
> >  printk(KERN_INFO "After thread start\n");
> > 
> > 
> >  The code between the two printk's takes a long time to run.  I don't have 
> >  precise numbers, but it feels like more than 1 second.
> > 
> >  (1) Can anyone explain why, or indicate how to speed it up?
> 
> What's it doing at the time?  (kgdb is great for this sort of thing: hit
> ^C, go for a wander through the thread callchains).
> 
> Presumably it's spinning on the bkl.  Is this actually an SMP machine?  If
> so, perhaps some other process is holding the bkl for a long time.  Perhaps
> a netdevice spending a long time diddling hardware in an ioctl, something
> like that.

I need to do more precise tests.  Some quick informal tests indicated that 
the lock_kernel call and the daemonize call each took a noticeable time.  
I'll respond later with more details.

> >  (2) Are the {un}lock_kernel calls really needed?
> 
> Definitely not.

Good; I'll take them out.

> That code could be converted to the kthread API btw.

Hmph.  Near as I can tell, the only changes that would involve are:

	Converting the thread creation call from kernel_thread to
	kthread_run.

	Adding another call to wake the thread up once it has been
	created.

	Removing the call to daemonize.

There wouldn't be any need to call kthread_stop -- and in fact it wouldn't 
work, as the thread waits on a semaphore while it is idle (kthread_stop 
can't cope with things like that).

So overall, it appears that converting to the kthread API would add the
overhead of an extra context switch at startup and synchronous
termination, without bringing any advantages at all.


That reminds me, I've got another question.  Once a thread has called
daemonize, or if it was started using kthread_run, all its signals are
blocked.  Is it still possible that through some extraordinary
circumstance the thread could receive a signal, or are we absolutely
guaranteed that no signals will arrive until the thread enables them?  
It's important to know the answer, because normally a thread spends its
idle time waiting on down_interruptible or something similar.  If a signal
managed to get through somehow, the thread would never be able to go back
to sleep unless it explicitly flushed its signals.

(I ask because I once noticed, looking through the signal-processing code, 
that the kernel itself could send an unblockable signal.  Don't recall 
where or when, though.)

Alan Stern

