Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268355AbTBNLHn>; Fri, 14 Feb 2003 06:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268356AbTBNLHn>; Fri, 14 Feb 2003 06:07:43 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:44292 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268355AbTBNLHl>; Fri, 14 Feb 2003 06:07:41 -0500
Date: Fri, 14 Feb 2003 12:16:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Werner Almesberger <wa@almesberger.net>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-Reply-To: <20030214020901.22E6C2C002@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302141035270.1336-100000@serv>
References: <20030214020901.22E6C2C002@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Feb 2003, Rusty Russell wrote:

> When you have an object which may vanish, the linux kernel idiom runs
> something like this:
> 
> 	write_lock()
> 	find available object in list
> 	inc object refcount
> 	write_unlock()
> 
> The writelock protects the infrastructure, the refcount protects the
> object.  Deleting is done in two stages (mark deleted and drop
> refcount, then whoever drops the refcount to 0 actually does the
> free).  Usually "mark deleted" means simply remove from the list, but
> not always.
> 
> The current module code uses exactly the same idiom for the code
> itself: we use a heavily read-optimized lock, but that's an
> implementation detail.

It's not the same, please see: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=104284223130775&w=2
I explained why the current module locking is more complex and why it's 
actually a three stage delete.

Let's take an example: procfs entries. That's a more interesting example, 
because these can be dynamically created, but they also include pointers 
to the module.
To keep it simple we create/remove an entry from a nonmodular kernel (so 
module functions are dummies):

	foo_entry = create_proc_entry();
	foo_entry->data = kmalloc();
	foo_entry->read_proc = foo_read;
	foo_entry->write_proc = foo_write;

Problem 1: If the user opens that new proc entry, he must be prepared that 
the new entry is not fully initialized yet.
Problem 2: There are no memory barriers, that means it's undefined in 
which order the data, read_proc, write_proc members arrive at another 
cpu, so it's possible that foo_read/foo_write can be called with a NULL 
data pointer.

Now let's remove it again:

	data = foo_entry->data;
	remove_proc_entry();
	kfree(data);

Problem: Should the entry still be busy, procfs just prints a warning, 
delays cleanup and returns immediately, so the data can be accessed after 
it was freed.

Now we do the same from a module but not from module_init/module_exit, 
that means we dynamically want to create/remove entries during the module 
life time. When we create the entry we also initialize the owner member, 
but this doesn't help with any of the above problems. The only thing 
module locking changes is that we know that it's safe to free the data at 
the time module_exit is called, but this might happen in the distant 
future or even never.

Rusty, above are real problems, the module locking fixes these problems 
during module_init/module_exit, but how can these problems fixed in the 
other cases and how does the module locking help?

bye, Roman

