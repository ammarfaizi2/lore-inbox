Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTEJBNC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 21:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTEJBNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 21:13:02 -0400
Received: from fmr01.intel.com ([192.55.52.18]:53718 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263628AbTEJBNA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 21:13:00 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCB00C1@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Timothy Miller'" <miller@techsource.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: A way to shrink process impact on kernel memory usage?
Date: Fri, 9 May 2003 18:25:37 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Timothy Miller [mailto:miller@techsource.com]
> 
> One of the things that's been worked on to reduce kernel memory usage
> for processes is to shrink the kernel stack from 8k to 4k.  I mean, it's
> not like you could shrink it to 6k, right?  Well, why not?  Why not
> allocate an 8k space and put various process-related data structures at
> the beginning of it?  Sure, a stack overflow could corrupt that data,
> but a stack overflow would be disasterous anyhow.

It is being done already. At least, on i386, alloc_thread_info() 
allocates two pages; at the beginning you have the thread info
structure [context and friends]. 

This is called from copy_process(), dup_task_struct(), alloc_thread_info().

However, what you say makes sense, but it'd be kind of difficult to
calculate how much is enough ... maybe, who knows. But the only 
thing you can put in there is stuff that is specific to each thread
(scheduling information, parent/s, childs, siblings, pid maps,
timers? used_math, comm, fsinfo, ipc, etc, etc ...).

Thus, it'd be interesting to collapse all the common stuff in
the task_struct corresponding to a same thread group into a single
one, and move whatever is thread specific out to a thread-specific
structure [alike to thread_info, although I guess you want to keep
thread_info really small for cache performance].

That should save a lot of task_structs when threading and move all
the info to that place you say. It is going to be a lot of work,
though, very kind of 2.7.

> Someone complained about a process structure already being too bloated.
>   Unless it's several K in size already, you can bloat it up all you
> please this way.

Not really - the more bloated, the more cache misses you will have.
There are a lot of fields that don't use all the bits and a lot
of Booleans; it'd make sense to collapse all those into a single
word if possible.

> Another advantage is that you could make the datastructures growable.
> The stack grows down, and the data grows up.  As long as they don't
> meet, all is well.

To solve that, you put the structures on the top of the area instead
of at the beginning. That way you are sure the stack cannot overflow
over your (very delicate) data structures, and makes it easier to add
an overflow guard page (as the stack end is at the beginning of a
page).

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
