Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWFLV5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWFLV5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWFLV5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:57:54 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:21073 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932215AbWFLV5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:57:53 -0400
Date: Mon, 12 Jun 2006 17:57:51 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
In-reply-to: <448DB309.70508@sgi.com>
To: Jay Lan <jlan@sgi.com>
Cc: Jay Lan <jlan@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Message-id: <448DE35F.1060103@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <44892610.6040001@watson.ibm.com>
 <20060609010057.e454a14f.akpm@osdl.org> <448952C2.1060708@in.ibm.com>
 <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com>
 <4489F93E.6070509@engr.sgi.com> <20060609162232.2f2479c5.akpm@osdl.org>
 <448A089C.6020408@engr.sgi.com> <448AB92C.4080205@watson.ibm.com>
 <448DB309.70508@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

> Shailabh Nagar wrote:
>
>> Jay Lan wrote:
>>
>>> Andrew Morton wrote:
>>>  
>>>
>>>
>>
>>>> But the overhead at present is awfully low.  If we don't need this 
>>>> ability
>>>> at present (and I don't think we do) then a paper design would be
>>>> sufficient at this time.  As long as we know we can do this in the 
>>>> future
>>>> without breaking existing APIs then OK.
>>>>
>>>>   
>>>
>>>
>>> i can see if an exiting process is the only process in the thread 
>>> group,
>>> the (not is_thread_group) condition would be true. So, that leaves
>>> multi-threaded applications that are not interested in tgid-data still
>>> receive 2x taskstats data.
>>>  
>>>
>> Jay,
>>
>> Why is the 2x taskstats data for the multithreaded app a real problem ?
>> When differnt clients agree to use a common taskstats structure, they 
>> also incur the potential
>> overhead of receiving extra data they don't really care about (in 
>> CSA's case, that would be all the
>> delay accounting fields of struct taskstats). Isn't that, in some 
>> sense, the "price" of sharing a structure
>> or delivery mechanism ?
>
>
> You are mixing the two types of overhead: 1) overhead due to tgid,
> 2) overhead due to extra fields of struct taskstats they don't care
> about.

You're right..I am mixing the two..but only to show to make the point that
anyway clients have to deal with extra data they don't care about. As 
long as the performance overhead
of that isn't significant, its not an issue.
Also, unlike, shared taskstats structure, discarding the excess per-tgid 
data is even easier
because it comes in its own netlink attribute.

>
> The type 2 overhead for CSA is very small, but is bigger for you. In our
> discussion earlier, i told you (and you accpeted) that i will insert
> 128 bytes of data into taskstat struct. I have not finalized the CSA
> work yet, but it can be 168 additional bytes or close to that number:
>
>         /* Common Accounting Fields start */
>         u32     ac_uid;                 /* User ID */
>         u32     ac_gid;                 /* Group ID */
>         u32     ac_pid;                 /* Process ID */
>         u32     ac_ppid;                /* Parent process ID */
>         struct timespec start_time;     /* Start time */
>         struct timespec exit_time;      /* Exit time */
>         u64     ac_utime;               /* User CPU time [usec] */
>         u64     ac_stime;               /* SYstem CPU time [usec] */
>         /* Common Accounting Fields end */
>
>         /* CSA accounting fields start */
>         u64     ac_sbu;                 /* System billing units */
>         u16     csa_revision;           /* CSA Revision */
>         u8      csa_type;               /* Record types */
>         u8      csa_flag;               /* Record flags */
>         u8      ac_stat;                /* Exit status */
>         u8      ac_nice;                /* Nice value */
>         u8      ac_sched;               /* Scheduling discipline */
>         u8      pad0;                   /* Unused */
>         u64     acct_rss_mem1;          /* accumulated rss usage */
>         u64     acct_vm_mem1;           /* accumulated virtual memory 
> usage */
>         u64     hiwater_rss;            /* High-watermark of RSS usage */
>         u64     hiwater_vm;             /* High-water virtual memory 
> usage */
>         u64     ac_minflt;              /* Minor Page Fault */
>         u64     ac_majflt;              /* Major Page Fault */
>         u64     ac_chr;                 /* bytes read */
>         u64     ac_chw;                 /* bytes written */
>         u64     ac_scr;                 /* read syscalls */
>         u64     ac_scw;                 /* write syscalls */
>         u64     ac_jid;                 /* Job ID */
>         /* CSA accounting fields end */
>
> This is type 2 overhead. The bigger overhead in type 2, the bigger
> impact of sending tgid data is bigger.

Fair enough.   So lets see what the excess 168 bytes does in terms of 
perf and make a determination
based on that ?

>>
>> Of course, if this overhead becomes too much, we need to find 
>> alternatives. But, as already shown,
>> even in the extreme case where app does nothing but fork/exit, there 
>> is very
>> little performance impact. So I don't see how in the common case of 
>> multithreaded apps, where exits
>> are going to be at a far lesser rate, the extra per-tgid data is a 
>> real issue.
>
>
> Yes, application handles "real" work between fork and exit. But,
> each task within a thread group still trigger do_exit on termination,
> right?

Yes...but I don't see the point ? If exits happen at a very slow rate, 
then the performance impact will drop
compared to if they happen at the insane rate in the toy program. So 
rate of exit is a factor..or did I not
get your point ?

>
>>
>> So, are we trying to solve a real problem ?
>
>
> I do not know, but i am concerned. I will run some testing with the
> taskstats struct above and get some data.


Sounds good. Please share asap so that 2.6.18 acceptance isn't held up.

Regards,
Shailabh

