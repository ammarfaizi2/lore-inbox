Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUABRHU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 12:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265616AbUABRHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 12:07:20 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:40067 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261733AbUABRHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 12:07:18 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 Jan 2004 09:07:19 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc/patch] wake_up_info() draft ...
In-Reply-To: <3FF53A9E.7040905@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0401020858490.2278-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004, Manfred Spraul wrote:

> >why are you saying so?
> >
> >  
> >
> sizeof(waitqueue_t) increases.

Come on Manfred, you can do better :-)



> >@@ -1658,6 +1659,8 @@
> > 		unsigned flags;
> > 		curr = list_entry(tmp, wait_queue_t, task_list);
> > 		flags = curr->flags;
> >+		if (info)
> >+			dup_wait_info(&curr->info, info);
> > 		if (curr->func(curr, mode, sync) &&
> > 		    (flags & WQ_FLAG_EXCLUSIVE) &&
> > 		    !--nr_exclusive)
> >
> IMHO these two lines belong into curr->func, perhaps with a reference 
> implementation that uses
> 
> struct wait_queue_entry_info {
>     wait_queue_t wait;
>     struct wait_info info;
> };
> 
> We have already a callback pointer, so why add special case code into 
> the common codepaths? Custom callbacks could handle the special case of 
> an info wakeup.

I forgot you are the structure wrapper guy :-)) See, the idea of having a 
callback only thig works fine with things like epoll that uses it. So I'd 
be ok with it. The reason of having it done the way I did, is because even 
standard waked up task can have the ability to fetch info about the wake 
up from the wait queue item, that is the MCD of the whole wait/wake Linux 
mechanism. Also don't be fooled by the names dup/dtor by thinking that you 
have to kmalloc new data in sutuation where more that sizeof(void *) is 
needed. you can simply use a ref count method doing atomic_inc() and 
atomic_dec_and_test(). With this method you can fetch info either from the 
callback (it is already stored inside the wait queue item when the 
callback is called) or from the wait queue item itself for std woke up 
tasks.




- Davide


