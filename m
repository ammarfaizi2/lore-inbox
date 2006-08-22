Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWHVQ4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWHVQ4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 12:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWHVQ4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 12:56:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58024 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751416AbWHVQ4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 12:56:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       pj@sgi.com, saito.tadashi@soft.fujitsu.com, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH] ps command race fix take2 [1/4] list token
References: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
Date: Tue, 22 Aug 2006 10:56:08 -0600
In-Reply-To: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
	(KAMEZAWA Hiroyuki's message of "Tue, 22 Aug 2006 17:39:04 +0900")
Message-ID: <m164gkr9p3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> This is ps command race fix take2. Unfortunately, against 2.6.18-rc4.
> I'll rebase this to appropriate kernel if O.K. (I think this is RFC)
>
> This patch implements Paul Jackson's idea, 'inserting false link in task list'.

Currently the tasklist_lock is one of the more highly contended locks in
the kernel.  Adding an extra place it is taken is undesirable.
If could see a better algorithm for sending a signal to all processes
in a process groups we could remove the tasklist_lock entirely.

In addition you only solves half the readdir problems.  You don't solve
the seek problem which is returning to an offset you had been to
before.  A relatively rare case but...

> Good point of this approach is cost of searching task is O(N) (N=num of tgids).
> Bad point is lock and kmalloc/kfree.
> I didin't modified thread_list and cpuset's proc list, maybe future work.
>
> If searching pid bitmap is better, please take Erics.

My patch at least needs a good changelog but I believe it will work
better and can be further improved with a better pid data structure
if there is actually a problem there.  Given that I don't take
any locks it should be much friendlier at scale, and the code
was simpler.

However I will miss a few newly forked processes and I don't think your
technique will miss any.  Still neither will miss a process that
existed the entire time.

If nothing else I think it was worth posting so we could contrast the two.

Eric
