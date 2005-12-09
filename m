Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVLIOQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVLIOQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVLIOQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:16:04 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:12773 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932131AbVLIOQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:16:02 -0500
Message-ID: <43999199.70608@us.ibm.com>
Date: Fri, 09 Dec 2005 09:15:53 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Ingo Molnar <mingo@elte.hu>, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.gov, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/5] New system call, unshare
References: <1134079791.5476.8.camel@hobbs.atlanta.ibm.com> <20051209105502.GA20314@elte.hu> <20051209120244.GL27946@ftp.linux.org.uk>
In-Reply-To: <20051209120244.GL27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Fri, Dec 09, 2005 at 11:55:02AM +0100, Ingo Molnar wrote:
>  
>
>>* JANAK DESAI <janak@us.ibm.com> wrote:
>>
>>    
>>
>>>[PATCH -mm 1/5] unshare system call: System call handler function 
>>>sys_unshare
>>>      
>>>
>>>+       if (unshare_flags & ~(CLONE_NEWNS | CLONE_VM))
>>>+               goto errout;
>>>      
>>>
>>just curious, did you consider all the other CLONE_* flags as well, to 
>>see whether it makes sense to add unshare support for them?
>>    
>>
>
>IMO the right thing to do is
>	* accept *all* flags from the very beginning
>	* check constraints ("CLONE_NEWNS must be accompanied by CLONE_FS")
>and either -EINVAL if they are not satisfied or silently force them.
>	* for each unimplemented flag check if we corresponding thing
>is shared; -EINVAL otherwise.
>
>Then for each flag we care to implement we should replace such check with
>actual unsharing - a patch per flag.
>
>CLONE_FS and CLONE_FILES are *definitely* worth implementing and are
>trivial to implement.  The only thing we must take care of is doing
>all replacements under task_lock, without dropping it between updates.
>  
>

Ok, thanks. I will restructure code and reorganize patches accordingly 
and post
updated patches.

To answer Ingo's question, we did look at other flags when I started. 
However,
I wanted to keep the system call simple enough, with atleast namespace 
unsharing,
so it would get accepted. In the original discussion on fsdevel, 
unsharing of vm
was mentioned as useful so I added that in addition to namespace unsharing.

>I would say that CLONE_SIGHAND is also an obvious candidate for adding.
>  
>
I did have signal handler unsharing in one of the earlier incarnation of 
the patch,
however Chris Wright alerted me (on IRC) to a possible problem with posix
real time signals if we allow unsharing of signal handlers. He pointed 
me to the
way send_sigqueue is stashing sighand lock for later use and since 
timers are
flushed on exec and exit, it may lead to an oops. Since my primary 
interest was
in namespace unsharing, I disallowed unsharing of signal handler. I will 
take a
look at it more detail and come back with specific issues with sighand
unsharing.

Thanks.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

