Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWCRPnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWCRPnw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWCRPnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:43:52 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:28066 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750913AbWCRPnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:43:51 -0500
Message-ID: <441C2AA0.3080200@us.ibm.com>
Date: Sat, 18 Mar 2006 10:43:28 -0500
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, hch@lst.de,
       mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Use rcu_assign_pointer when setting sighand
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>		<m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>		<441AF596.F6E66BC9@tv-sign.ru> <20060317125607.78a5dbe4.akpm@osdl.org> <441C0741.3BC25010@tv-sign.ru>
In-Reply-To: <441C0741.3BC25010@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:

>Andrew Morton wrote:
>  
>
>>Oleg Nesterov <oleg@tv-sign.ru> wrote:
>>    
>>
>>>Isn't it better to just replace this code with
>>>'BUG_ON(new_sigh != NULL)' ?
>>>
>>>It is never executed, but totally broken, afaics.
>>>task_lock() has nothing to do with ->sighand changing.
>>>
>>>      
>>>
>>/*
>> * Unsharing of sighand for tasks created with CLONE_SIGHAND is not
>> * supported yet
>> */
>>static int unshare_sighand(unsigned long unshare_flags, struct sighand_struct **new_sighp)
>>
>>It's all just a place-holder at present.
>>
>>If we don't plan on ever supporting unshare(CLONE_SIGHAND) we should take
>>that code out and make it return EINVAL.  Right now.
>>
>>And because we don't presently support CLONE_SIGHAND we should return
>>EINVAL if it's set.  Right now.
>>
>>And we should change sys_unshare() to reject not-understood flags.  Right
>>now.
>>
>>If we don't do these things we'll silently break 2.6.16-back-compatibility
>>of applications which are coded for future kernels.
>>    
>>
>
>unshare_sighand() is ok, it never populates *new_sighp, it just returns
>errror code: 0 when ->sighand is not shared, EINVAL otherwise.
>
>I argued about 'if (new_sigh)' code in sys_unshare() because it lies about
>locking rules.
>
>Btw, copy_process() forbids CLONE_SIGHAND without CLONE_VM (is there a
>good reason for that?), but one can do unshare(CLONE_VM). This is odd.
>  
>
Yes, copy_process forbids cloning of signal handlers without cloning of vm.
However, it does allow cloning of vm without cloning of signal handlers. For
those processes, that are sharing vm but not signal handlers, unsharing 
of vm
is allowed.

>Oleg.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

