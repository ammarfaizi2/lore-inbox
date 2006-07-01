Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWGADhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWGADhU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWGADhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:37:20 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:63628 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751804AbWGADhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:37:17 -0400
Message-ID: <44A5EDE6.3010605@watson.ibm.com>
Date: Fri, 30 Jun 2006 23:37:10 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	<20060629094408.360ac157.pj@sgi.com>	<20060629110107.2e56310b.akpm@osdl.org>	<44A57310.3010208@watson.ibm.com>	<44A5770F.3080206@watson.ibm.com>	<20060630155030.5ea1faba.akpm@osdl.org>	<44A5DBE7.2020704@watson.ibm.com> <20060630194353.1cc96ce4.akpm@osdl.or!
 g>
In-Reply-To: <20060630194353.1cc96ce4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Fri, 30 Jun 2006 22:20:23 -0400
>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
>  
>
>>>If we're going to abuse nl_pid then how about we design things so that
>>>nl_pid is treated as two 16-bit words - one word is the start CPU and the
>>>other word is the end cpu?
>>>
>>>Or, if a 65536-CPU limit is too scary, make the bottom 8 bits of nl_pid be
>>>the number of CPUS (ie: TASKSTATS_CPUS_PER_SET) and the top 24 bits is the
>>>starting CPU.  
>>>
>>><avoids mentioning nl_pad>
>>>
>>>It'd be better to use a cpumask, of course..
>>> 
>>>
>>>      
>>>
>>All these options mean each listener gets to pick a "custom" range of 
>>cpus to listen on, 
>>rather than choose one of pre-defined ranges (even if the pre-defined 
>>ranges can change
>>by a configurable TASKSTATS_CPUS_PER_SET). Which means the kernel side 
>>has to
>>figure out which of the listeners cpu range includes the currently 
>>exiting task's cpu. To do
>>this, we'll need a callback from the binding of the netlink socket (so 
>>taskstats can maintain
>>the cpu -> nl_pid mappings at any exit).
>>The current genetlink interface doesn't have that kind of flexibility 
>>(though it can be added
>>I'm sure).
>>
>>Seems a bit involved if the primary aim is to restrict the number of 
>>cpus that one listener
>> wants to listen, rather than be able to pick which ones.
>>
>>A configurable range won't suffice ?
>>
>>    
>>
>
>Set aside the implementation details and ask "what is a good design"?
>
>A kernel-wide constant, whether determined at build-time or by a /proc poke
>isn't a nice design.
>
>Can we permit userspace to send in a netlink message describing a cpumask? 
>That's back-compatible.
>  
>
Yes, that should be doable. And passing in a cpumask is much better 
since we no longer
have to maintain mappings.

So the strawman is:
Listener bind()s to genetlink using its real pid.
Sends a separate "registration" message with cpumask to listen to. 
Kernel stores (real) pid and cpumask.
During task exit, kernel goes through each registered listener (small 
list) and decides which
one needs to get this exit data and calls a genetlink_unicast to each 
one that does need it.

If number of listeners is small, the lookups should be swift enough. If 
it grows large, we
can consider a fancier lookup (but there I go again, delving into 
implementation too early :-)


Sounds good to me !

--Shailabh







