Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030635AbWHIKOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030635AbWHIKOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030636AbWHIKOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:14:39 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:9935 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1030635AbWHIKOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:14:39 -0400
Date: Wed, 9 Aug 2006 18:38:16 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@sw.ru>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_getppid oopses on debug kernel (v2)
Message-ID: <20060809143816.GA142@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> Although I'm not sure it's needed for this problem. A getppid() which does
>
> asmlinkage long sys_getppid(void)
> {
> 	int pid;
>
> 	read_lock(&tasklist_lock);
> 	pid = current->group_leader->real_parent->tgid;
> 	read_unlock(&tasklist_lock);
>
> 	return pid;
> }
>
> seems like a fine implementation to me ;)

Why do we need to use ->group_leader? All threads should have the same
->real_parent.

Why do we need tasklist_lock? I think rcu_read_lock() is enough.

In other words, do you see any problems with this code

	smlinkage long sys_getppid(void)
	{
		int pid;

		rcu_read_lock();
		pid = rcu_dereference(current->real_parent)->tgid;
		rcu_read_unlock();

		return pid;
	}

? Yes, we may read a stale value for ->real_parent, but the memory
can't be freed while we are under rcu_read_lock(). And in this case
the returned value is ok because the task could be reparented just
after return anyway.

Oleg.

