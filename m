Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWHIMG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWHIMG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbWHIMG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:06:59 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:49160 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030228AbWHIMG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:06:58 -0400
Message-ID: <44D9D03B.6060907@sw.ru>
Date: Wed, 09 Aug 2006 16:08:27 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_getppid oopses on debug kernel (v2)
References: <20060809143816.GA142@oleg>
In-Reply-To: <20060809143816.GA142@oleg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Although I'm not sure it's needed for this problem. A getppid() which does
>>
>>asmlinkage long sys_getppid(void)
>>{
>>	int pid;
>>
>>	read_lock(&tasklist_lock);
>>	pid = current->group_leader->real_parent->tgid;
>>	read_unlock(&tasklist_lock);
>>
>>	return pid;
>>}
>>
>>seems like a fine implementation to me ;)
> 
> 
> Why do we need to use ->group_leader? All threads should have the same
> ->real_parent.
I'm not sure this is true for old LinuxThreads...

> Why do we need tasklist_lock? I think rcu_read_lock() is enough.
> 
> In other words, do you see any problems with this code
> 
> 	smlinkage long sys_getppid(void)
> 	{
> 		int pid;
> 
> 		rcu_read_lock();
> 		pid = rcu_dereference(current->real_parent)->tgid;
> 		rcu_read_unlock();
> 
> 		return pid;
> 	}
> 
> ? Yes, we may read a stale value for ->real_parent, but the memory
> can't be freed while we are under rcu_read_lock(). And in this case
> the returned value is ok because the task could be reparented just
> after return anyway.
Your patch doesn't cure the problem.
rcu_read_lock just disables preemtion and rcu_dereference
introduces memory barrier. _None_ of this _prevents_
another CPU from freeing old real_parent in parallel with your dereference.

You can minimize the probability very much by making local_irq_disable()/enable()
around the code in question, but still it won't be a real fix (at least due to NMIs).

Kirill

