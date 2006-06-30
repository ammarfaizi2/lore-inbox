Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWF3DBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWF3DBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 23:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWF3DBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 23:01:49 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:60621 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S964933AbWF3DBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 23:01:48 -0400
Message-ID: <44A49418.5080103@watson.ibm.com>
Date: Thu, 29 Jun 2006 23:01:44 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hadi@cyberus.ca
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, csturtiv@sgi.com,
       balbir@in.ibm.com, jlan@engr.sgi.com, Valdis.Kletnieks@vt.edu,
       pj@sgi.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	 <20060623164743.c894c314.akpm@osdl.org>	 <449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	 <449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	 <20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	 <20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	 <20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	 <20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	 <20060629014050.d3bf0be4.pj@sgi.com>	 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	 <20060629094408.360ac157.pj@sgi.com>	 <20060629110107.2e56310b.akpm@osdl.org>	<44A425A7.2060900@watson.ibm.com>	 <20060629123338.0d355297.akpm@osdl.org>	<44A43187.3090307@watson.ibm.com>	 <1151621692.8922.4.camel@jzny2>	<44A47285.6060307@watson.ibm.com>	 <20060629180502.3987a98e.akpm@osdl.or! g> <44A47A3E.5070809@watson.ibm.com> <1151631048.8922.139.camel@jzny2>
In-Reply-To: <1151631048.8922.139.camel@jzny2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

>On Thu, 2006-29-06 at 21:11 -0400, Shailabh Nagar wrote:
>  
>
>>Andrew Morton wrote:
>>
>>    
>>
>>>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>>      
>>>
>[..]
>  
>
>>>So if we can detect the silly sustained-high-exit-rate scenario then it
>>>seems to me quite legitimate to do some aggressive data reduction on that. 
>>>Like, a single message which says "20,000 sub-millisecond-runtime tasks
>>>exited in the past second" or something.
>>> 
>>>
>>>      
>>>
>>The "buffering within taskstats" might be a way out then.
>>    
>>
>
>Thats what it looks like.
>
>  
>
>>As long as the user is willing to pay the price in terms of memory,
>>    
>>
>
>You may wanna draw a line to the upper limit - maybe even allocate slab
>space.
>  
>
Didn't quite understand...could you please elaborate ?
Today we have a slab cache from which the taskstats structure gets 
allocated at the beginning
of the exit() path.
The upper limit to which you refer is the amount of slab memory the user 
is willing to be used
to store the bursty traffic ?


>> we can collect the exiting task's taskstats data but not send it 
>>immediately (taskstats_cache would grow) 
>>unless a high water mark had been crossed. Otherwise a timer event would do the 
>>sends of accumalated  taskstats (not all at once but
>>iteratively if necessary).
>>
>>    
>>
>
>Sounds reasonable. Thats what xfrm events do. 
>

>Try to have those
>parameters settable because different machines or users may have
>different view as to what is proper - maybe even as simple as sysctl.
>  
>
Sounds good.

>  
>
>>At task exit, despite doing a few rounds of sending of pending data, if 
>>netlink were still reporting errors
>>then it would be a sign of unsustainable rate and the pending queue 
>>could be dropped and a message like you suggest could be sent.
>>
>>    
>>
>
>When you send inside the kernel - you will get an error if there's
>problems sending to the socket queue. So you may wanna use that info
>to release the kernel allocated entries or keep them for a little
>longer.
>
>Hopefully that helps.
>  
>
Yes it does. Thanks for the tips.

Will code up something and send out so this can become more concrete.

--Shailabh

>cheers,
>jamal
> 
>
>  
>

