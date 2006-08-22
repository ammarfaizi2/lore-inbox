Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWHVWXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWHVWXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 18:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWHVWXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 18:23:35 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36809 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751328AbWHVWXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 18:23:34 -0400
Date: Wed, 23 Aug 2006 07:22:56 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, ak@suse.de
Subject: Re: [RFC][PATCH] ps command race fix take2 [1/4] list token
Message-Id: <20060823072256.7d931f8b.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <m164gkr9p3.fsf@ebiederm.dsl.xmission.com>
References: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
	<m164gkr9p3.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 10:56:08 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> 
> > This is ps command race fix take2. Unfortunately, against 2.6.18-rc4.
> > I'll rebase this to appropriate kernel if O.K. (I think this is RFC)
> >
> > This patch implements Paul Jackson's idea, 'inserting false link in task list'.
> 
> Currently the tasklist_lock is one of the more highly contended locks in
> the kernel.  Adding an extra place it is taken is undesirable.
yes. taking lock is a probem.
I know current readdir() uses 8192 bytes buffer for getdents64(). Then,
maybe write-lock will be acquired all-tgids/400+ times for inserting token
(in 32bit system).
 
> If could see a better algorithm for sending a signal to all processes
> in a process groups we could remove the tasklist_lock entirely.
> 
??
Sorry, could you explain more ?

> In addition you only solves half the readdir problems.  You don't solve
> the seek problem which is returning to an offset you had been to
> before.  A relatively rare case but...
> 
Ah, I should add lseek handler for proc root. Okay.

> > Good point of this approach is cost of searching task is O(N) (N=num of tgids).
> > Bad point is lock and kmalloc/kfree.
> > I didin't modified thread_list and cpuset's proc list, maybe future work.
> >
> > If searching pid bitmap is better, please take Erics.
> 
> My patch at least needs a good changelog but I believe it will work
> better and can be further improved with a better pid data structure
> if there is actually a problem there.  Given that I don't take
> any locks it should be much friendlier at scale, and the code
> was simpler.
yes. it has several good points and simple.
My patch's point is just using task_list if we can, because it exists for keeping
all tasks(tgids).

> 
> However I will miss a few newly forked processes and I don't think your
> technique will miss any.  Still neither will miss a process that
> existed the entire time.
> 
> If nothing else I think it was worth posting so we could contrast the two.
> 
please post again. I think comparing the two is good.
I will post take3 with improved comments and lseek handler, and so on.

-Kame 

