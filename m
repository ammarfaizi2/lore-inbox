Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWHBRRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWHBRRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWHBRRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:17:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:59288 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751280AbWHBRRS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:17:18 -0400
Message-ID: <44D0DE13.7090205@in.ibm.com>
Date: Wed, 02 Aug 2006 22:47:07 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Jay Lan <jlan@sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 1/3] add basic accounting fields to taskstats
References: <44CE57EF.2090409@sgi.com> <44CF6433.50108@in.ibm.com> <44CFCCE4.7060702@sgi.com> <44D0C56C.3030505@watson.ibm.com>
In-Reply-To: <44D0C56C.3030505@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Jay Lan wrote:
>> Balbir Singh wrote:
>>
>>> Jay Lan wrote:
>>>
>>>>  
>>>> -#define TASKSTATS_VERSION    1
>>>> +#define TASKSTATS_VERSION    2
>>>> +#define TASK_COMM_LEN        16
>>>>  
>>>
>>>
>>>
>>> We should find a way to keep this in sync with with the definition
>>> in linux/sched.h (won't we a warning if both this header and
>>> linux/sched.h are included together?)
>>
>>
>> I do not know how to sync it up. This header linux/taskstats.h is
>> meant to be included by userspace programs. If an application
>> happens to include linux/sched.h, which includes linux/time.h,
>> the application will very likely have compilation errors because
>> the "struct timespec" declaration in <linux/time.h> and <time.h>
>> are conflicting.
>>
>> The <linux/acct.h> defines it to
>> #define ACCT_COMM    16
>>
>> I can change our define to TS_COMM_LEN with remakes saying it
>> should be in sync with the TAKS_COMM_LEN defined in linux/sched.h.
> 
> This seems like a good enough way to do it. There's no real need for
> the taskstats comm length to remain exactly in sync with the task struct's
> comm length (by way of trying to include sched.h etc.) though avoiding the
> compile error by renaming is desirable as Balbir pointed out.
> 
> Moreover, TASK_COMM_LEN in linux/sched.h isn't likely to change much -
> if it increases and csa_acct users also really need the extra info 
> provided,
> taskstats can always be changed and version bumped up. If the size 
> decreases
> there's no harm done (strncpy should be sufficient protection).
> 
> --Shailabh
> 

I am not sure if there is a version of BUG_ON() for compile time
asserts. Basically, if we have an infrastructure of the form

/*
  * From C/C++ users journal November 2004
  */
#define STATIC_BUG_ON(e) 	\
	switch (0) {		\
	case  0:		\
	case (e):		\
		;		\
	}

Then the STATIC_BUG_ON() can catch as shown below.

#define TASK_COMM_LEN 	16
#define T_COMM_LEN	20

int
main(void)
{
	STATIC_BUG_ON(TASK_COMM_LEN == T_COMM_LEN);
}

STATIC_BUG_ON gives the following warning

bug_on_c.c: In function `main':
bug_on_c.c:19: duplicate case value
bug_on_c.c:19: previously used here

but with T_COMM_LEN set to 16

It compiles without any errors, the code generated also
looks like it has no overhead

int
main(void)
{
  8048310:       55                      push   %ebp
  8048311:       89 e5                   mov    %esp,%ebp
  8048313:       83 ec 08                sub    $0x8,%esp
  8048316:       83 e4 f0                and    $0xfffffff0,%esp
         STATIC_BUG_ON(TASK_COMM_LEN == T_COMM_LEN);
}
  8048319:       c9                      leave
  804831a:       c3                      ret
  804831b:       90                      nop


Assuming such infrastructure is available, you could then
do

#ifdef __KERNEL__
#include <linux/sched.h>
#define TS_COMM_LEN	16
STATIC_BUG_ON (TS_COMM_LEN == TASK_COMM_LEN);
#endif

Comments?

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
