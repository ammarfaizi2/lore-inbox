Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751912AbWFUBTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbWFUBTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWFUBTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:19:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6600 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751912AbWFUBTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:19:18 -0400
Date: Tue, 20 Jun 2006 18:18:53 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Message-Id: <20060620181853.9312eb72.pj@sgi.com>
In-Reply-To: <200606191021.03631.ak@suse.de>
References: <200606140942.31150.ak@suse.de>
	<20060618171511.e0e6de26.pj@sgi.com>
	<200606191021.03631.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> While vgetcpu() can be used for this most likely glibc TLS is already 
> good enough for this. So it will help, but I don't think it's the primary
> motivation.

Elsewhere on this thread, Jes wrote:
> ... libc
> should offer a memory pool per thread and have it created when it's
> first touched by the thread. That solves exactly what you have described
> so far unless is something else you also expect to benefit from
> vgetcpu().

I don't see a reply from you (Andi) on Jes's comment.

Why can't Thread Local Storage (TLS) or other per-thread data be used
for a memory pool, as Jes suggests.

It seems to me that we don't need vgetcpu() at all.  Instead, we should
make things that would use it per-thread, not per-cpu.  If it works for
the statistics gathering you recommended I use TLS for, why not for
malloc pages as well?

That would seem to be a better abstraction anyway:

* A threads cpu can be changed without notice, but a tasks threads
  don't change unless the task intentionally does it.

* Two threads on the same cpu could collide on some per-cpu
  data, where they'd be find on per-thread data.

We already have user visibility into what cpu a task is executing on,
via the /proc/<pid>/stat file (39th field).  That's slow, of course.

The main reason for speeding it up seems to make it useful in critical
places, turning it from an infrequently used debugging option into
a critical element of certain NUMA aware user level code.

I'd think we should not be introducing a new construct, a threads
current cpu, as such a first class component unless:
 1) we do so on all arch's, and
 2) we don't alread have a better construct (TLS).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
