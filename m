Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVIQXly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVIQXly (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 19:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVIQXly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 19:41:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751235AbVIQXlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 19:41:53 -0400
Date: Sat, 17 Sep 2005 16:41:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unusually long delay in the kernel
Message-Id: <20050917164117.1eee31c2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509171750210.1078-100000@netrider.rowland.org>
References: <20050916235259.61b87069.akpm@osdl.org>
	<Pine.LNX.4.44L0.0509171750210.1078-100000@netrider.rowland.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> > Presumably it's spinning on the bkl.  Is this actually an SMP machine?  If
> > so, perhaps some other process is holding the bkl for a long time.  Perhaps
> > a netdevice spending a long time diddling hardware in an ioctl, something
> > like that.
> 
> I need to do more precise tests.  Some quick informal tests indicated that 
> the lock_kernel call and the daemonize call each took a noticeable time.  

Something odd is happening.

> > That code could be converted to the kthread API btw.
> 
> Hmph.  Near as I can tell, the only changes that would involve are:
> 
> 	Converting the thread creation call from kernel_thread to
> 	kthread_run.
> 
> 	Adding another call to wake the thread up once it has been
> 	created.
> 
> 	Removing the call to daemonize.
> 
> There wouldn't be any need to call kthread_stop -- and in fact it wouldn't 
> work, as the thread waits on a semaphore while it is idle (kthread_stop 
> can't cope with things like that).

Well I was assuming that the semaphore would go away as well.  Kernel
threads normally use waitqueues to await more work.

> 
> That reminds me, I've got another question.  Once a thread has called
> daemonize, or if it was started using kthread_run, all its signals are
> blocked.  Is it still possible that through some extraordinary
> circumstance the thread could receive a signal, or are we absolutely
> guaranteed that no signals will arrive until the thread enables them?  

Kernel threads should sleep in state TASK_INTERRUPTIBLE, with all signals
blocked.  Because they don't want to contribute to the load average, and
because they shouldn't use signals.

So if it was possible to deliver a signal to an all-signals-blocked kernel
thread, that kernel thread would go into a busy loop, because all of its
sleep attempts will fall straight through (signal_pending() is true).  So I
think it's safe to assume that nobody ever does force_sig() on a kenrel
thread.

> It's important to know the answer, because normally a thread spends its
> idle time waiting on down_interruptible or something similar.  If a signal
> managed to get through somehow, the thread would never be able to go back
> to sleep unless it explicitly flushed its signals.

Yup.
