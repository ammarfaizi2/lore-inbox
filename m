Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbUK2R6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUK2R6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 12:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUK2R6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 12:58:53 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:16852 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261438AbUK2R6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 12:58:51 -0500
Message-ID: <41AB6346.2080601@colorfullife.com>
Date: Mon, 29 Nov 2004 18:58:30 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, roland@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use pid_alive in proc_pid_status
References: <41A9B589.1090005@colorfullife.com> <20041128222151.4d53fd14.akpm@osdl.org> <20041129094152.GB7868@elte.hu>
In-Reply-To: <20041129094152.GB7868@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Andrew Morton <akpm@osdl.org> wrote:
>
>  
>
>>> +int pid_alive(struct task_struct *p)
>>> +{
>>> +	return p->pids[PIDTYPE_PID].nr != 0;
>>> +}
>>>      
>>>
>>Can we not simply test p->exit_state?  That's already done in quite a
>>few places and making things consistent would be nice.
>>    
>>
>
>as long as it's accessed from under the tasklist_lock, it ought to be
>fine to check for p->exit_state != EXIT_DEAD and dereference
>p->group_leader afterwards.
>
>  
>
The tricky part is proc_pid_unhash()/proc_pid_flush(): Right now 
removing a pid from the pid bitmap and disabling /proc/<pid>/* is 
atomic: Both operations are done under tasklist_lock.
I think it would be better to modify pid_alive to p->exit_state and 
disable /proc/<pid>/* access when the exit state is set to DEAD, but 
that that would be a larger change. Probably unhash and flush could be 
merged into one function.
But I don't understand the lines in wait_task_zombie that reset 
exit_state from DEAD to ZOMBIE, so perhaps I overlook something.

--
    Manfred
