Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318102AbSG2VZH>; Mon, 29 Jul 2002 17:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318105AbSG2VZH>; Mon, 29 Jul 2002 17:25:07 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:57279 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S318102AbSG2VZG>; Mon, 29 Jul 2002 17:25:06 -0400
Message-ID: <3FAD1088D4556046AEC48D80B47B478C0101F3AF@usslc-exch-4.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Matthew Wilcox'" <willy@debian.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-ia64@linuxia64.org'" <linux-ia64@linuxia64.org>
Subject: RE: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
Date: Mon, 29 Jul 2002 16:29:09 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jul 29, 2002 at 04:05:35PM -0500, Van Maren, Kevin wrote:
> > Recursive read locks certainly make it more difficult to fix the
> > problem.  Placing a band-aid on gettimeofday will fix the symptom
> > in one location, but will not fix the general problem, which is
> > writer starvation with heavy read lock load.  The only way to fix
> > that is to make writer locks fair or to eliminate them (make them
> > _all_ stateless).
> 
> The basic principle is that if you see contention on a spinlock, you
> should eliminate the spinlock somehow.  making spinlocks 
> `fair' doesn't
> help that you're spending lots of time spinning on a lock.

Yes, but that isn't the point: unless you eliminate all rw locks,
it is conceptually possible to cause a kernel deadlock by forcing
contention on the locks you didn't remove, if the user can force
the kernel to acquire a reader lock and if something else needs to
acquire the writer lock.  Correctness is the issue, not performance.
You have locks because there _could_ be contention, and locks handle
that contention _correctly_.  If you can eliminate the contention,
you can eliminate the locks, but if there is a chance for contention,
the locks have to remain, _and_ they have to handle contention
_correctly_, which does not occur with the current reader/writer
lock code, which can hang the kernel just as dead as a writer
between recursive reader lock calls with my code.

Kevin
