Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWGCPCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWGCPCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 11:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWGCPCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 11:02:22 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:44338 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751194AbWGCPCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 11:02:20 -0400
Date: Mon, 03 Jul 2006 11:02:17 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
In-reply-to: <20060702215350.2c1de596.pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       hadi@cyberus.ca, netdev@vger.kernel.org
Message-id: <44A93179.2080303@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <44892610.6040001@watson.ibm.com> <449C6620.1020203@engr.sgi.com>
 <20060623164743.c894c314.akpm@osdl.org> <449CAA78.4080902@watson.ibm.com>
 <20060623213912.96056b02.akpm@osdl.org> <449CD4B3.8020300@watson.ibm.com>
 <44A01A50.1050403@sgi.com> <20060626105548.edef4c64.akpm@osdl.org>
 <44A020CD.30903@watson.ibm.com> <20060626111249.7aece36e.akpm@osdl.org>
 <44A026ED.8080903@sgi.com> <20060626113959.839d72bc.akpm@osdl.org>
 <44A2F50D.8030306@engr.sgi.com> <20060628145341.529a61ab.akpm@osdl.org>
 <44A2FC72.9090407@engr.sgi.com> <20060629014050.d3bf0be4.pj@sgi.com>
 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
 <20060629094408.360ac157.pj@sgi.com> <20060629110107.2e56310b.akpm@osdl.org>
 <44A57310.3010208@watson.ibm.com> <44A5770F.3080206@watson.ibm.com>
 <20060630155030.5ea1faba.akpm@osdl.org> <44A5DBE7.2020704@watson.ibm.com>
 <44A5EDE6.3010605@watson.ibm.com> <20060702215350.2c1de596.pj@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

>Shailabh wrote:
>  
>
>>Sends a separate "registration" message with cpumask to listen to. 
>>Kernel stores (real) pid and cpumask.
>>    
>>
>
>Question:
>=========
>
>Ah - good.
>
>So this means that I could configure a system with a fork/exit
>intensive, performance critical job on some dedicated CPUs, and be able
>to collect taskstat data from tasks exiting on the -other- CPUS, while
>avoiding collecting data from this special job, thus avoiding any
>taskstat collection performance impact on said job.
>
>If I'm understanding this correctly, excellent.
>  
>
Yes. If no one registers to listen on a particular CPU, data from tasks 
exiting on that cpu is
not sent out at all.

>Caveat:
>=======
>
>Passing cpumasks across the kernel-user boundary can be tricky.
>
>Historically, Unix has a long tradition of boloxing up the passing
>of variable length data types across the kernel-user boundary.
>
>We've got perhaps a half dozen ways of getting these masks out of the
>kernel, and three ways of getting them (or the similar nodemasks) back
>into the kernel.  The three ways being used in the sched_setaffinity
>system call, the mbind and set_mempolicy system calls, and the cpuset
>file system.
>
>All three of these ways have their controversial details:
> * The kernel cpumask mask size needed for sched_setaffinity calls is
>   not trivially available to userland.
> * The nodemask bit size is off by one in the mbind and set_mempolicy
>   calls.
> * The CPU and Node masks are ascii, not binary, in the cpuset calls.
>
>One option that might make sense for these task stat registrations
>would be to:
> 1) make the kernel/sched.c get_user_cpu_mask() routine generic,
>    moving it to non-static lib/*.c code, and
> 2) provide a sensible way for user space to query the size of
>    the kernel cpumask (and perhaps nodemask while you're at it.)
>
>Currently, the best way I know for user space to query the kernels
>cpumask and nodemask size is to examine the length of the ascii
>string values labeled "Cpus_allowed:" and "Mems_allowed:" in the file
>/proc/self/status.  These ascii strings always require exactly nine
>ascii chars to express each 32 bits of kernel mask code, if you include
>in the count the trailing ',' comma or '\n' newline after each eight
>ascii character word.
>
>Probing /proc/self/status fields for these mask sizes is rather
>unobvious and indirect, and requires caching the result if you care at
>all about performance.  Userland code in support of your taskstat
>facility might be better served by a more obvious way to size cpumasks.
>
>... unless of course you're inclined to pass cpumasks formatted as
>    ascii strings, in which case speak up, as I'd be delighted to
>    throw in my 2 cents on how to do that ;).
>  
>
Thanks for the size info. I did hit it while coding this up.

So I chose to use the "cpulist" ascii format that has been helpfully 
provided in include/linux/cpumask.h (by whom I wonder :-)

User specified the cpumask as an ascii string containing comma separated 
cpu ranges.
Kernel parses the same and stores it as a cpumask_t after which we can 
iterate over the
mask using standard helpers.

Since registration/deregistration is not a common operation, the 
overhead of parsing
ascii strings should be acceptable and avoids the hassles of trying to 
determine kernel cpumask size. I don't know if there are buffer overflow 
issues in passing a string (though I'm using the
standard netlink way of passing it up using NLA_STRING).

Will post the patch shortly.

--Shailabh
