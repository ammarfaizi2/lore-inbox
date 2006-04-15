Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbWDOWaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWDOWaV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWDOWaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:30:21 -0400
Received: from smtp-out.google.com ([216.239.45.12]:22079 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932509AbWDOWaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:30:20 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=AaPJb7X9XxQeAURWqJ5wEXR+y+QKnOLz/CnkofplLDj8ZnITP4TkjFRw8Kx5X6NnR
	CRBBSgsdvr6iVDUClorvA==
Message-ID: <444173EE.4060602@google.com>
Date: Sat, 15 Apr 2006 15:30:06 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: Clear performance regression on reaim7 in 2.6.15-git6
References: <4441452F.3060009@google.com>	<20060415141744.042231a8.akpm@osdl.org>	<44416616.10908@google.com> <20060415145227.5d1249bd.akpm@osdl.org>
In-Reply-To: <20060415145227.5d1249bd.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@google.com> wrote:
> 
>>drilling down into the results directories can get you the command line,
>> looks like "reaim -f workfile.short -s 1 -e 10 -i 2" to me. Buggered if
>> I can recall what that did though.
>>
>> (http://test.kernel.org/abat/20229/004.reaim.test/results/cmdline)
>>
>> I *think* it's only ia32 NUMA boxes, at least as far as I can see from
>> a quick poke around. Which would make me guess at scheduler code. Gitweb
>> would be nice to use, but it doesn't tag the -git snapshots, AFAICS, 
>> which is a real shame. Nor does the git snapshot include the git tag,
>> as far as I know. Grrrr. I guess I'll download the snapshots and diff
>> them, and try to pull out the sched changes by hand. Much suckage.
> 
> 
> The diffstat for 2.6.15-git5 -> 2.6.15-git6 is at
> http://www.zip.com.au/~akpm/linux/patches/stuff/2 - only a single line
> changed in sched.c:
> 
> diff -uNr 2.6.15-git5/kernel/sched.c 2.6.15-git6/kernel/sched.c
> --- 2.6.15-git5/kernel/sched.c	2006-04-15 14:10:43.000000000 -0700
> +++ 2.6.15-git6/kernel/sched.c	2006-04-15 14:10:52.000000000 -0700
> @@ -4386,6 +4386,7 @@
>  	} while_each_thread(g, p);
>  
>  	read_unlock(&tasklist_lock);
> +	mutex_debug_show_all_locks();
>  }

Hmm. whilst it's probably not that call, it does look like mutex 
debugging. Look at the profiles from reaim between -git5 and -git6:

before:
http://test.kernel.org/abat/20115/004.reaim.test/profiling/profile.text

after:
http://test.kernel.org/abat/20229/004.reaim.test/profiling/profile.text

  1262 kfree                                      3.5056
    820 mutex_lock_interruptible                 164.0000
    752 __mutex_lock_slowpath                      0.8754
     43 schedule                                   0.0284
     35 _spin_lock                                 2.3333
     25 debug_mutex_set_owner                      0.1613
     23 debug_mutex_add_waiter                     0.1586

/me hugs his huge stacks of data.

--------------------------------

config DEBUG_MUTEXES
         bool "Mutex debugging, deadlock detection"
         default y
         depends on DEBUG_KERNEL
         help
          This allows mutex semantics violations and mutex related deadlocks
          (lockups) to be detected and reported automatically.

--------------------------------

Hmmm. Who the hell thought defaulting that to 'y' was a good plan????
It's still broken in 17-rc1 ... will send you a patch in a sec.

M.

PS. Jeff Garzik pointed out there *are* git tags for each -git snapshot
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.17-rc1-git11.id
which is really helpful.

