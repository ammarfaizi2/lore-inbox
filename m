Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWGACUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWGACUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 22:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWGACUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 22:20:34 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:31246 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932117AbWGACUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 22:20:33 -0400
Message-ID: <44A5DBE7.2020704@watson.ibm.com>
Date: Fri, 30 Jun 2006 22:20:23 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	<20060629094408.360ac157.pj@sgi.com>	<20060629110107.2e56310b.akpm@osdl.org>	<44A57310.3010208@watson.ibm.com>	<44A5770F.3080206@watson.ibm.com> <20060630155030.5ea1faba.akpm@osdl.org>
In-Reply-To: <20060630155030.5ea1faba.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>  
>
>>+/*
>>+ * Per-task exit data sent from the kernel to user space
>>+ * is tagged by an id based on grouping of cpus.
>>+ *
>>+ * If userspace specifies a non-zero P as the nl_pid field of
>>+ * the sockaddr_nl structure while binding to a netlink socket,
>>+ * it will receive exit data from threads that exited on cpus in the range
>>+ *
>>+ *    [(P-1)*Y, P*Y-1]
>>+ *
>>+ *  where Y = TASKSTATS_CPUS_PER_SET
>>+ *  i.e. if TASKSTATS_CPUS_PER_SET is 16,
>>+ *  to listen to data from cpus 0..15, specify P=1
>>+ *  for cpus 16..32, specify P=2 etc.
>>+ *
>>+ *  To listen to data from all cpus, userspace should use P=0
>>+ */
>>+
>>+#define TASKSTATS_CPUS_PER_SET	16
>>    
>>
>
>The constant is unpleasant.
>  
>
I was planning to make it configurable. But that would still not be as 
flexible as below...

>If we're going to abuse nl_pid then how about we design things so that
>nl_pid is treated as two 16-bit words - one word is the start CPU and the
>other word is the end cpu?
>
>Or, if a 65536-CPU limit is too scary, make the bottom 8 bits of nl_pid be
>the number of CPUS (ie: TASKSTATS_CPUS_PER_SET) and the top 24 bits is the
>starting CPU.  
>
><avoids mentioning nl_pad>
>
>It'd be better to use a cpumask, of course..
>  
>
All these options mean each listener gets to pick a "custom" range of 
cpus to listen on, 
rather than choose one of pre-defined ranges (even if the pre-defined 
ranges can change
by a configurable TASKSTATS_CPUS_PER_SET). Which means the kernel side 
has to
figure out which of the listeners cpu range includes the currently 
exiting task's cpu. To do
this, we'll need a callback from the binding of the netlink socket (so 
taskstats can maintain
the cpu -> nl_pid mappings at any exit).
The current genetlink interface doesn't have that kind of flexibility 
(though it can be added
I'm sure).

Seems a bit involved if the primary aim is to restrict the number of 
cpus that one listener
 wants to listen, rather than be able to pick which ones.

A configurable range won't suffice ?

--Shailabh
