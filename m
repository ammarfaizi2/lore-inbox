Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWCRQa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWCRQa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 11:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWCRQa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 11:30:28 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:57995 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751453AbWCRQa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 11:30:27 -0500
Message-ID: <441C3587.2070308@us.ibm.com>
Date: Sat, 18 Mar 2006 11:29:59 -0500
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Oleg Nesterov <oleg@tv-sign.ru>, ebiederm@xmission.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, hch@lst.de,
       mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Use rcu_assign_pointer when setting sighand
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>	<m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>	<441AF596.F6E66BC9@tv-sign.ru> <20060317125607.78a5dbe4.akpm@osdl.org>
In-Reply-To: <20060317125607.78a5dbe4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Oleg Nesterov <oleg@tv-sign.ru> wrote:
>  
>
>>"Eric W. Biederman" wrote:
>>    
>>
>>>@@ -1573,7 +1573,7 @@ asmlinkage long sys_unshare(unsigned lon
>>>
>>>                if (new_sigh) {
>>>                        sigh = current->sighand;
>>>-                       current->sighand = new_sigh;
>>>+                       rcu_assign_pointer(current->sighand, new_sigh);
>>>                        new_sigh = sigh;
>>>                }
>>>      
>>>
>>Isn't it better to just replace this code with
>>'BUG_ON(new_sigh != NULL)' ?
>>
>>It is never executed, but totally broken, afaics.
>>task_lock() has nothing to do with ->sighand changing.
>>
>>    
>>
>
>/*
> * Unsharing of sighand for tasks created with CLONE_SIGHAND is not
> * supported yet
> */
>static int unshare_sighand(unsigned long unshare_flags, struct sighand_struct **new_sighp)
>
>It's all just a place-holder at present.
>
>If we don't plan on ever supporting unshare(CLONE_SIGHAND) we should take
>that code out and make it return EINVAL.  Right now.
>
>And because we don't presently support CLONE_SIGHAND we should return
>EINVAL if it's set.  Right now.
>  
>
unshare does return EINVAL if signal handler unsharing is attempted by a
process that is currently sharing its signal handler with another 
process. However,
because of the interaction between signal handlers and vm, CLONE_SIGHAND
is set anytime vm unsharing is attempted. That is, if you are trying to 
unshare
vm, you must unshare signal handlers. But if they are not being shared 
in the
first place, there is no need to prevent unsharing of vm.

Therefore, unshare returns EINVAL if unsharing of signal handlers and/or vm
is attempted by a process that is sharing its signal handler.

>And we should change sys_unshare() to reject not-understood flags.  Right
>now.
>  
>
Eric just posted a patch to do this.

>If we don't do these things we'll silently break 2.6.16-back-compatibility
>of applications which are coded for future kernels.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

