Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbULWX0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbULWX0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 18:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbULWX0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 18:26:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:38841 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261330AbULWX0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 18:26:31 -0500
Date: Thu, 23 Dec 2004 15:30:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: holt@sgi.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AB-BA deadlock between uidhash_lock and tasklist_lock.
Message-Id: <20041223153053.173098f5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412240019540.3504@dragon.hygekrogen.localhost>
References: <20041222220800.GB6213@lnx-holt.americas.sgi.com>
	<20041223173749.GA18887@lnx-holt.americas.sgi.com>
	<20041223145433.596db88c.akpm@osdl.org>
	<Pine.LNX.4.61.0412240019540.3504@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> On Thu, 23 Dec 2004, Andrew Morton wrote:
> 
> > +/*
> > + * uidhash_lock is taken inside write_lock_irq(&tasklist_lock).  If a timer
> > + * interrupt were to occur while we hold uidhash_lock, and that interrupt takes
> > + * read_lock(&tasklist_lock) then we have an ab/ba deadlock scenario.  Hence
> > + * uidhash_lock must always be taken in an ir-qsafe manner to hold off the
> > + * timer interrupt.
> > + */
> 

hrm.  Why don't we just do this?

--- 25/kernel/exit.c~a	Thu Dec 23 15:29:57 2004
+++ 25-akpm/kernel/exit.c	Thu Dec 23 15:30:04 2004
@@ -242,9 +242,8 @@ void reparent_to_init(void)
 	memcpy(current->signal->rlim, init_task.signal->rlim,
 	       sizeof(current->signal->rlim));
 	atomic_inc(&(INIT_USER->__count));
-	switch_uid(INIT_USER);
-
 	write_unlock_irq(&tasklist_lock);
+	switch_uid(INIT_USER);
 }
 
 void __set_special_pids(pid_t session, pid_t pgrp)
_

I see no reason why switch_uid() needs tasklist_lock.  set_user() doesn't
hold it?

