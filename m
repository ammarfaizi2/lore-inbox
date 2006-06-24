Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWFXC7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWFXC7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWFXC7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:59:08 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51077 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932105AbWFXC7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:59:07 -0400
Message-ID: <449CAA78.4080902@watson.ibm.com>
Date: Fri, 23 Jun 2006 22:59:04 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jay Lan <jlan@engr.sgi.com>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com>	<20060609042129.ae97018c.akpm@osdl.org>	<4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com> <20060623164743.c894c314.akpm@osdl.org>
In-Reply-To: <20060623164743.c894c314.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Fri, 23 Jun 2006 15:07:28 -0700
>Jay Lan <jlan@engr.sgi.com> wrote:
>
>  
>
>>>>       %ovhd of tgid on over off
>>>>       (higher is worse)
>>>>
>>>>Exit     User     Sys     Elapsed
>>>>Rate     Time     Time    Time
>>>>
>>>>2283      25.76  649.41   -0.14
>>>>1193     -10.53   88.81   -0.12
>>>>963      -11.90    3.28   -0.10
>>>>806       -8.54   -0.84    0.16
>>>>694       -4.41    2.38    0.03
>>>>   
>>>>        
>>>>
>>>Oh wow.  Something's gone quadratic there.
>>> 
>>>      
>>>
>>It was due to a loop in fill_tgid() when per-TG stats
>>data are assembled for netlink:
>>        do {
>>                rc = delayacct_add_tsk(stats, tsk);
>>                if (rc)
>>                        break;
>>
>>        } while_each_thread(first, tsk);
>>
>>and it is executed inside a lock.
>>Fortunately single threaded appls do not hit this code.
>>    
>>
>
>Am I reading this right?  We do that loop when each thread within the
>thread group exits?
>
Yes.

> How come?
>  
>
To get the sum of all per-tid data for threads that are currently alive.
This is returned to userspace with each thread exit.

>Is there some better lock we can use in there?  It only has to be
>threadgroup-wide rather than kernel-wide.
>  
>
The lock we're holding is the tasklist_lock. To go through all the 
threads of a thread group
thats the only lock that can protect integrity of while_each_thread afaics.

--Shailabh


