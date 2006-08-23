Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWHWMrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWHWMrf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWHWMrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:47:35 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:28844 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932445AbWHWMre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:47:34 -0400
Date: Wed, 23 Aug 2006 21:46:40 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, ak@suse.de
Subject: Re: [RFC][PATCH] ps command race fix take2 [1/4] list token
Message-Id: <20060823214640.699ceacb.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <m1r6z7ofbn.fsf@ebiederm.dsl.xmission.com>
References: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
	<m164gkr9p3.fsf@ebiederm.dsl.xmission.com>
	<20060823072256.7d931f8b.kamezawa.hiroyu@jp.fujitsu.com>
	<m1ac5woube.fsf@ebiederm.dsl.xmission.com>
	<20060823173323.b9cf1509.kamezawa.hiroyu@jp.fujitsu.com>
	<m1r6z7ofbn.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 05:35:08 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> What you are proposing is to reduce contention by having several different
> locks for each of the global data structures. 
not for each, just a lock for a list for for_each_process ;)
About cache bounsing, it's problem if heavy.
In my plan, fork/exit/proc_readdir will have write lock of
for_each_process_write_lock. talking this again after take3 will be good.
If I'm very lucky, I'll find some another way..

> >> >> In addition you only solves half the readdir problems.  You don't solve
> >> >> the seek problem which is returning to an offset you had been to
> >> >> before.  A relatively rare case but...
> >> >> 
> >> > Ah, I should add lseek handler for proc root. Okay.
> >> 
> >> Hmm.  Possibly.  Mostly what I was thinking is that a token in the
> >> list simply cannot solve the problem of a guaranteeing lseek to a
> >> previous position works.  I really haven't looked closely on
> >> how you handle that case.
> >> 
> > I'll try some. But lseek on directory, which is modified at any moment, cannot
> > work stable anyway.
> 
> It can work as well as anything else in readdir.  It can ensure that you don't
> miss things that haven't been added or deleted during the while you are in
> the middle of readdir.    I'm just after the usual Single Unix Spec/POSIX guarantees.
> The same thing that are missing in the current readdir implementation.
> 
BTW, what position means at lseek() in directory ? 
bytes ? implementation dependent ? 

I'm thinking of implementing "position" as offset in task list. 
Hmm..about lseek(), it's obvious that searching in a table has an advantage.
we cannot define position with list.
What will you do if user moves f->pos to not-used-position.

I have no complaint about pidmap scanning next_tgid() unless it doesn't scan
all over the world.

-Kame

