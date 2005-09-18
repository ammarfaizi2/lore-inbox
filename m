Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVIRUJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVIRUJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVIRUJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 16:09:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932073AbVIRUJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 16:09:42 -0400
Date: Sun, 18 Sep 2005 13:09:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: Unusually long delay in the kernel
Message-Id: <20050918130902.23a824e0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509181057570.27009-100000@netrider.rowland.org>
References: <20050917164117.1eee31c2.akpm@osdl.org>
	<Pine.LNX.4.44L0.0509181057570.27009-100000@netrider.rowland.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, 17 Sep 2005, Andrew Morton wrote:
> 
>  > > > That code could be converted to the kthread API btw.
>  > > 
>  > > Hmph.  Near as I can tell, the only changes that would involve are:
>  > > 
>  > > 	Converting the thread creation call from kernel_thread to
>  > > 	kthread_run.
>  > > 
>  > > 	Adding another call to wake the thread up once it has been
>  > > 	created.
>  > > 
>  > > 	Removing the call to daemonize.
>  > > 
>  > > There wouldn't be any need to call kthread_stop -- and in fact it wouldn't 
>  > > work, as the thread waits on a semaphore while it is idle (kthread_stop 
>  > > can't cope with things like that).
>  > 
>  > Well I was assuming that the semaphore would go away as well.  Kernel
>  > threads normally use waitqueues to await more work.
> 
>  Some kernel threads have a producer-consumer relationship with their
>  clients, and it's important that they wake exactly once each time they are
>  invoked.  A semaphore is the natural way to manage such a thread, but the
>  kthread API isn't set up to handle such things.  It's possible to make
>  this work, by using a manual poor-man's semaphore implementation, but that
>  seems ridiculous.

OK.

>  Would this patch be acceptable?

Well it makes all kthread_stop() callers pass an additional (unused)
argument.  I'd make kthread_stop() and kthread_stop_sem() real C functions,
hide the code sharing within kthread.c.

