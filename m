Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWF3BLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWF3BLa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWF3BLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:11:30 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:60698 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751372AbWF3BL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:11:29 -0400
Message-ID: <44A47A3E.5070809@watson.ibm.com>
Date: Thu, 29 Jun 2006 21:11:26 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hadi@cyberus.ca, pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	<20060629094408.360ac157.pj@sgi.com>	<20060629110107.2e56310b.akpm@osdl.org>	<44A425A7.2060900@watson.ibm.com>	<20060629123338.0d355297.akpm@osdl.org>	<44A43187.3090307@watson.ibm.com>	<1151621692.8922.4.camel@jzny2>	<44A47285.6060307@watson.ibm.com> <20060629180502.3987a98e.akpm@osdl.or!
 g>
In-Reply-To: <20060629180502.3987a98e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>  
>
>>The rates (or upper bounds) that are being discussed here, as of now, 
>>are 1000 exits/sec/CPU for
>>1024 CPU systems. That would be roughly 1M exits/system * 
>>248Bytes/message  = 248 MB/sec.
>>    
>>
>
>I think it's worth differentiating between burst rates and sustained rates
>here.
>
>One could easily imagine 10,000 threads all exiting at once, and the user
>being interested in reliably collecting the results.
>
>But if the machine is _sustaining_ such a high rate then that means that
>these exiting tasks all have a teeny runtime and the user isn't going to be
>interested in the per-thread statistics.
>
>So if we can detect the silly sustained-high-exit-rate scenario then it
>seems to me quite legitimate to do some aggressive data reduction on that. 
>Like, a single message which says "20,000 sub-millisecond-runtime tasks
>exited in the past second" or something.
>  
>
The "buffering within taskstats" might be a way out then.
As long as the user is willing to pay the price in terms of memory, we 
can collect the exiting task's
taskstats data but not send it immediately (taskstats_cache would grow) 
unless a high water mark had
been crossed. Otherwise a timer event would do the sends of accumalated 
taskstats (not all at once but
iteratively if necessary).

At task exit, despite doing a few rounds of sending of pending data, if 
netlink were still reporting errors
then it would be a sign of unsustainable rate and the pending queue 
could be dropped and a message
like you suggest could be sent.

Thoughts ?


--Shailabh

