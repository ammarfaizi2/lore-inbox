Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752133AbWFLSbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbWFLSbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbWFLSbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:31:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1179 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752135AbWFLSbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:31:46 -0400
Message-ID: <448DB309.70508@sgi.com>
Date: Mon, 12 Jun 2006 11:31:37 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Jay Lan <jlan@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com> <20060609010057.e454a14f.akpm@osdl.org> <448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com> <4489F93E.6070509@engr.sgi.com> <20060609162232.2f2479c5.akpm@osdl.org> <448A089C.6020408@engr.sgi.com> <448AB92C.4080205@watson.ibm.com>
In-Reply-To: <448AB92C.4080205@watson.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Jay Lan wrote:
> 
>> Andrew Morton wrote:
>>  
>>
>>
> 
>>> But the overhead at present is awfully low.  If we don't need this 
>>> ability
>>> at present (and I don't think we do) then a paper design would be
>>> sufficient at this time.  As long as we know we can do this in the 
>>> future
>>> without breaking existing APIs then OK.
>>>
>>>   
>>
>> i can see if an exiting process is the only process in the thread group,
>> the (not is_thread_group) condition would be true. So, that leaves
>> multi-threaded applications that are not interested in tgid-data still
>> receive 2x taskstats data.
>>  
>>
> Jay,
> 
> Why is the 2x taskstats data for the multithreaded app a real problem ?
> When differnt clients agree to use a common taskstats structure, they 
> also incur the potential
> overhead of receiving extra data they don't really care about (in CSA's 
> case, that would be all the
> delay accounting fields of struct taskstats). Isn't that, in some sense, 
> the "price" of sharing a structure
> or delivery mechanism ?

You are mixing the two types of overhead: 1) overhead due to tgid,
2) overhead due to extra fields of struct taskstats they don't care
about.

The type 2 overhead for CSA is very small, but is bigger for you. In our
discussion earlier, i told you (and you accpeted) that i will insert
128 bytes of data into taskstat struct. I have not finalized the CSA
work yet, but it can be 168 additional bytes or close to that number:

         /* Common Accounting Fields start */
         u32     ac_uid;                 /* User ID */
         u32     ac_gid;                 /* Group ID */
         u32     ac_pid;                 /* Process ID */
         u32     ac_ppid;                /* Parent process ID */
         struct timespec start_time;     /* Start time */
         struct timespec exit_time;      /* Exit time */
         u64     ac_utime;               /* User CPU time [usec] */
         u64     ac_stime;               /* SYstem CPU time [usec] */
         /* Common Accounting Fields end */

         /* CSA accounting fields start */
         u64     ac_sbu;                 /* System billing units */
         u16     csa_revision;           /* CSA Revision */
         u8      csa_type;               /* Record types */
         u8      csa_flag;               /* Record flags */
         u8      ac_stat;                /* Exit status */
         u8      ac_nice;                /* Nice value */
         u8      ac_sched;               /* Scheduling discipline */
         u8      pad0;                   /* Unused */
         u64     acct_rss_mem1;          /* accumulated rss usage */
         u64     acct_vm_mem1;           /* accumulated virtual memory 
usage */
         u64     hiwater_rss;            /* High-watermark of RSS usage 
*/
         u64     hiwater_vm;             /* High-water virtual memory 
usage */
         u64     ac_minflt;              /* Minor Page Fault */
         u64     ac_majflt;              /* Major Page Fault */
         u64     ac_chr;                 /* bytes read */
         u64     ac_chw;                 /* bytes written */
         u64     ac_scr;                 /* read syscalls */
         u64     ac_scw;                 /* write syscalls */
         u64     ac_jid;                 /* Job ID */
         /* CSA accounting fields end */

This is type 2 overhead. The bigger overhead in type 2, the bigger
impact of sending tgid data is bigger.

> 
> Of course, if this overhead becomes too much, we need to find 
> alternatives. But, as already shown,
> even in the extreme case where app does nothing but fork/exit, there is 
> very
> little performance impact. So I don't see how in the common case of 
> multithreaded apps, where exits
> are going to be at a far lesser rate, the extra per-tgid data is a real 
> issue.

Yes, application handles "real" work between fork and exit. But,
each task within a thread group still trigger do_exit on termination,
right?

> 
> So, are we trying to solve a real problem ?

I do not know, but i am concerned. I will run some testing with the
taskstats struct above and get some data.

Thanks,
  - jay


> 
> I'll address the alternatives in a separate mail but lets address this 
> point first please.
> 
> --Shailabh

