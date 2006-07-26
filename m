Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWGZL0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWGZL0b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWGZL0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:26:31 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:17561 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750942AbWGZL0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:26:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=WekHEsTvf8cj1OtfS/pXd5Ch8YQcxoYSOhXRnNi9J9gwbGbm7s5KUHwa1WaXCy+Crv7owsToSwN/g7NoTF9oehVQl+nbR+KlR+oYay19VEomvu1ZDg7CZz+L3wfqYr6em57XxtBMOkcI7gT1wjCnJEEYkb4MLlBpUa6+/nRXYAU=
Date: Wed, 26 Jul 2006 13:26:48 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 0/3] [-rt] Fixes the timeout-bug in the rtmutex/PI-futex.
In-Reply-To: <20060726085556.GA19501@elte.hu>
Message-ID: <Pine.LNX.4.64.0607261307070.10713@localhost.localdomain>
References: <Pine.LNX.4.64.0607230215480.11861@localhost.localdomain>
 <20060726084152.GA15909@elte.hu> <20060726085404.GA19151@elte.hu>
 <20060726085556.GA19501@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jul 2006, Ingo Molnar wrote:

>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
>> and i also had to do the fixes below to get it to build.
>
> then it crashed with the assert below. I'll skip this one for now. I've
> attached the patches (cleaned up for whitespaces) plus the
> build-fixpatch.
>
> 	Ingo
>
> Brought up 2 CPUs
> BUG at kernel/rtmutex.c:773!
> ------------[ cut here ]------------
> kernel BUG at kernel/rtmutex.c:773!
> invalid opcode: 0000 [#1]
> PREEMPT SMP
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c03e407c>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.17-rt7 #14)
> EIP is at rt_lock_slowlock+0x21e/0x231
> eax: 00000020   ebx: c31d7000   ecx: c0477be4   edx: c31d97f0
> esi: 00000000   edi: c31d7d34   ebp: c31d7cdc   esp: c31d7c70
> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
>
>

It is a very simple bug: The waiter was made garbage by the 
debug_rt_mutex_free_waiter() before it was used in the BUG_ON() line.
My UP machine boots now with CONFIG_DEBUG_RT_MUTEXEX on in -rt8. Fix 
is below. Apply on top of the patches you just send me with no further 
changes. I hope I don't have white space damage in this small patch!!

Esben

  kernel/rtmutex.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-rt8/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rt8.orig/kernel/rtmutex.c
+++ linux-2.6.17-rt8/kernel/rtmutex.c
@@ -768,9 +768,9 @@ rt_lock_slowlock(struct rt_mutex *lock _
  	if (adjust_prio_final)
  		rt_mutex_adjust_prio_final(current, waiter.old_sched_lifo);

-	debug_rt_mutex_free_waiter(&waiter);
  	BUG_ON(current->boosting_prio != MAX_PRIO);
  	BUG_ON(waiter.old_sched_lifo != get_sched_lifo());
+	debug_rt_mutex_free_waiter(&waiter);
  }

  /*

