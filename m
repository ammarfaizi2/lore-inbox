Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbTIWPc7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 11:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTIWPc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 11:32:59 -0400
Received: from CPE0010e000064f-CM014270111571.cpe.net.cable.rogers.com ([65.49.101.54]:23819
	"EHLO belle.augustahouse.net") by vger.kernel.org with ESMTP
	id S261627AbTIWPcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 11:32:54 -0400
Message-ID: <3F706764.1090203@sun.com>
Date: Tue, 23 Sep 2003 11:31:48 -0400
From: Mike Waychison <michael.waychison@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
References: <Pine.LNX.4.44.0309232125010.2341-100000@raven.themaw.net>
In-Reply-To: <Pine.LNX.4.44.0309232125010.2341-100000@raven.themaw.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent wrote:
> I have noticed that a deadlock can occur in the autofs4 module in the 2.6 
> kernel and RedHat kernels with the O(1) scheduler patch. The easiest way 
> to reproduce it is with an autofs-4.0.0 tree mount with at least 10 mounts 
> within a Nautilus desktop environment with the module debug flag set. 
> Perhaps this is because of the longish amount of time spent in the expire 
> state.
> 
> The scenario:
> 
> 1) An expire locates an expirable dentry and signals the user space 
> daemon to umount it.
> 2) During the umount operation Nautilus notices and scans entries in the 
> directory tree triggering a revalidate/lookup.
> 3) autofs4 places the requesting process on the umount wait queue. 
> 4) At completion of the expire both process are released from the wait 
> queue.
> 5) If the lookup gets a quantum first deadlock occurs and expiration stops 
> leaving an autofs mount that is permanently busy.
> 
> The following patch fixes this by ensuring that the expire gets a lookin 
> before the revalidate/lookup continues.

I'm not extremely familiar with the autofs4 implementation, but why is 
the expiring process in the wait queue to start off with?  Doesn't 
autofs4 let the daemon's pgrp bypass the waitqueue completely?

> 
> The problem of the remount that this causes remains and I an not sure how 
> to deal with that at this stage.

This is purely a userspace issue.  Nautilus trampling all over the 
filesystem is greatly unjustified.  If they want a decent filesystem 
change notification system put in place, let them propose something. 
Caching mountpoints entries is a bad idea.

> 
> Comments and suggestions please.
> 
> Is this acceptable for inclusion in the kernel?
> If so what should I do to make this happen?
> 
> diff -Nur autofs4-2.6.orig/fs/autofs4/autofs_i.h autofs4-2.6.deadlock/fs/autofs4/autofs_i.h
> --- autofs4-2.6.orig/fs/autofs4/autofs_i.h	2003-09-09 03:50:14.000000000 +0800
> +++ autofs4-2.6.deadlock/fs/autofs4/autofs_i.h	2003-09-22 22:48:11.000000000 +0800
> @@ -82,6 +82,7 @@
>  	char *name;
>  	/* This is for status reporting upon return */
>  	int status;
> +	struct task_struct *owner;

This new field isn't even set anywhere!!

>  	int wait_ctr;
>  };
>  
> diff -Nur autofs4-2.6.orig/fs/autofs4/waitq.c autofs4-2.6.deadlock/fs/autofs4/waitq.c
> --- autofs4-2.6.orig/fs/autofs4/waitq.c	2003-09-09 03:50:31.000000000 +0800
> +++ autofs4-2.6.deadlock/fs/autofs4/waitq.c	2003-09-23 00:02:29.209789432 +0800
> @@ -206,6 +206,11 @@
>  
>  		interruptible_sleep_on(&wq->queue);
>  
> +		if (waitqueue_active(&wq->queue) && current != wq->owner) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule_timeout(wq->wait_ctr * (HZ/10));
> +		}
> +

This doesn't avoid the problem, it just makes it go away 99.99% of the 
time.  I would suggest using a complete_all from the owner of the wq, 
and let all other waiters wait for the completion.

Again, why is the umount on this queue?

Mike Waychison

