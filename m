Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUADEm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 23:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUADEm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 23:42:26 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:18304 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265127AbUADEmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 23:42:24 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 3 Jan 2004 20:42:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040104043037.007922C0F1@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0401032039350.2022-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0401031021280.1678-100000@bigblue.dev.mdolabs.com> you write:
> > Rusty, I took a better look at the patch and I think we can have 
> > per-kthread stuff w/out littering the task_struct and by making the thing 
> > more robust.
> 
> Except sharing data with a lock is perfectly robust.
> 
> > We keep a global list_head protected by a global spinlock. We 
> > define a structure that contain all the per-kthread stuff we need 
> > (including a task_struct* to the kthread itself). When a kthread starts it 
> > will add itself to the list, and when it will die it will remove itself 
> > from the list.
> 
> Yeah, I deliberately didn't implement this, because (1) it seems like
> a lot of complexity when using a lock and letting them share a single
> structure works fine and is even simpler, and (2) the thread can't
> just "do_exit()".
> 
> You can get around (2) by having a permenant parent "kthread" thread
> which is a parent to all the kthreads (it'll get a SIGCHLD when
> someone does "do_exit()").  But the implementation was pretty ugly,
> since it involved having a communications mechanism with the kthread
> parent, which means you have the global ktm_message-like-thing for
> this...

You will lose in any case. What happens if the thread does do_exit() and 
you do kthread_stop() after that?
With the patch I posted to you, the kthread_stop() will simply miss the 
lookup and return -ENOENT.



- Davide


