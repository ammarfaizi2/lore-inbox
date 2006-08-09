Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWHINB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWHINB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWHINB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:01:26 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:58292 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750731AbWHINB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:01:26 -0400
Message-ID: <44D9DCFF.2080400@sw.ru>
Date: Wed, 09 Aug 2006 17:02:55 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_getppid oopses on debug kernel (v2)
References: <20060809143816.GA142@oleg> <44D9D03B.6060907@sw.ru> <20060809165441.GA187@oleg>
In-Reply-To: <20060809165441.GA187@oleg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Your patch doesn't cure the problem.
>>rcu_read_lock just disables preemtion and rcu_dereference
>>introduces memory barrier. _None_ of this _prevents_
>>another CPU from freeing old real_parent in parallel with your dereference.
> 
> 
> How so? Note that release_task() doesn't call put_task_struct(), it does
> call_rcu(&p->rcu, delayed_put_task_struct) instead. When delayed_put_task_struct()
> is called, all CPUs must see the new value of ->real_parent (otherwise
> RCU is just broken). If CPU sees the old value of ->real_parent, rcu_read_lock()
> protects us from delayed_put_task_struct() on another CPU.
> 
> Ok, I think this is the same "classic" pattern as:
> 
> 	old = global_ptr;
> 	global_ptr = new;
> 	call_rcu(..free_old...);
> vs
> 	rcu_read_lock();
> 	use(global_ptr);
> 	rcu_read_unlock();
> 
> Do you agree?
Agree :)
Sorry, I didn't notice that task structs are freed now with RCU :)))
In this case your patch really helps the problem. Care to prepare it?

Thanks,
Kirill
