Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVDAItA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVDAItA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVDAIs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:48:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:62146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261612AbVDAIsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:48:36 -0500
Date: Fri, 1 Apr 2005 00:48:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: cn_queue.c
Message-Id: <20050401004804.52519e17.akpm@osdl.org>
In-Reply-To: <1112344811.9334.146.camel@uganda>
References: <20050331173215.49c959a0.akpm@osdl.org>
	<1112341236.9334.97.camel@uganda>
	<20050331235706.5b5981db.akpm@osdl.org>
	<1112344811.9334.146.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
>  New object has 0 reference counter when created.
>  If some work is appointed to the object, then it's counter is atomically
>  incremented. It is decremented when the work is finished.
>  If object is supposed to be removed while some work
>  may be appointed to it, core ensures that no work _is_ appointed, 
>  and atomically disallows[for example removing workqueue, removing
>  callback, all with appropriate locks being hold] 
>  any other work appointment for the given object.
>  After it [when no work can be appointed to the object] if object
>  still has pending work [and thus has it's refcounter not zero], 
>  removing path waits untill appropriate refcnt hits zero. 
>  Since no _new_ work can be appointed at that level it is just
>  while (atomic_read(refcnt) != 0)
>    msleep();

More like:

	while (atomic_read(&obj->refcnt))
		msleep();
	kfree(obj);

which introduces the possibility of someone grabbing a new ref on the
object just before the kfree().  If there is no means by which any other
actor can acquire a ref to this object then OK, no race.

But it's rather surprising that such a thing can be achieved without any
locking.  What happens if another CPU has just entered
cn_queue_del_callback(), for example?  It has a live cn_callback_entry in
`cbq' which has a zero refcount - cn_queue_free_dev() can throw it away.

