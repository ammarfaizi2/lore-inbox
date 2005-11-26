Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVKZUvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVKZUvm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 15:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKZUvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 15:51:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:19698 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750743AbVKZUvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 15:51:41 -0500
In-Reply-To: <20051126133137.GA9722@elte.hu>
References: <2F3CDB0C-5E50-11DA-8242-000A959BB91E@mvista.com> <20051126133137.GA9722@elte.hu>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7169751C-5EBE-11DA-9812-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: robust futex heap support patch
Date: Sat, 26 Nov 2005 12:51:40 -0800
To: Ingo Molnar <mingo@elte.hu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 26, 2005, at 5:31 AM, Ingo Molnar wrote:

>
> * david singleton <dsingleton@mvista.com> wrote:
>
>> There is a new patch, patch-2.6.14-rt15-rf1, that adds support for
>> robust and priority inheriting pthread_mutexes on the 'heap'.
>
> we need to go a bit slower. For now i had to remove robust-futexes from
> the -rt17 release because they broke normal (non-robust) futex support
> in -rt15. A simple mozilla startup would hang... Please send fixes
> against -rt16 and i'll try to re-add the robust futexes patch later on.
> You can find -rt16 at:

whoops, sorry.

Here's he piece that broke regular futexes.  Futex wake doesn't
need to check to see if the robust list is null or not.

Index: linux-2.6.14/kernel/futex.c
===================================================================
--- linux-2.6.14.orig/kernel/futex.c
+++ linux-2.6.14/kernel/futex.c
@@ -323,10 +323,6 @@ static int futex_wake(unsigned long uadd
         ret = get_futex_key(uaddr, &key, &head, &sem);
         if (unlikely(ret != 0))
                 goto out;
-       if (head == NULL) {
-               ret = -EINVAL;
-               goto out;
-       }

         bh = hash_futex(&key);
         spin_lock(&bh->lock);


Let me get the build fixed and add a new test for myself.  I'll start  
running
this on my desktop to do builds, run mozilla and firefox, and generally
do all my normal work.

David
>
>   
> http://people.redhat.com/mingo/realtime-preempt/older/patch-2.6.14- 
> rt16
>
>> The previous patches only supported either file based pthread_mutexes
>> or mmapped anonymous memory based pthread_mutexes.  This patch allows
>> pthread_mutexes to be 'malloc'ed while using the
>> PTHREAD_MUTEX_ROBUST_NP attribute or PTHREAD_PRIO_INHERIT attribute.
>>
>> The patch can be found at:
>>
>> http://source.mvista.com/~dsingleton
>
> this patch looks much cleaner than the earlier one, but there's one  
> more
> step to go: now that we've got the futex_head in every vma, why not  
> hang
> all robust futexes to the vma, and thus get rid of ->robust_list and
> ->robust_sem from struct address_space?
>
> 	Ingo

