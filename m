Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWFITbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWFITbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWFITbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:31:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33508 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030448AbWFITbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:31:24 -0400
Message-ID: <4489CC86.9010309@watson.ibm.com>
Date: Fri, 09 Jun 2006 15:31:18 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: balbir@in.ibm.com, Andrew Morton <akpm@osdl.org>, jlan@sgi.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <44899562.6010609@in.ibm.com> <4489BF8F.2060305@engr.sgi.com>
In-Reply-To: <4489BF8F.2060305@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>Balbir Singh wrote:
>  
>
>>Andrew Morton wrote:
>>    
>>
>>>On Fri, 09 Jun 2006 16:21:46 +0530
>>>Balbir Singh <balbir@in.ibm.com> wrote:
>>>
>>>
>>>      
>>>
>>>>Andrew Morton wrote:
>>>>
>>>>        
>>>>
>>>>>On Fri, 09 Jun 2006 03:41:04 -0400
>>>>>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>>          
>>>>>
>>>>>>Hence, this patch introduces a configuration parameter
>>>>>>    /sys/kernel/taskstats_tgid_exit
>>>>>>through which a privileged user can turn on/off sending of
>>>>>>per-tgid stats on
>>>>>>task exit.
>>>>>>            
>>>>>>
>>>>>That seems a bit clumsy.  What happens if one consumer wants the
>>>>>per-tgid
>>>>>stats and another does not?
>>>>>          
>>>>>
>>>>For all subsystems that re-use the taskstats structure from the exit
>>>>path,
>>>>we have the issue that you mentioned. Thats because several
>>>>statistics co-exist
>>>>in the same structure. These subsystems can keep their tgid-stats
>>>>empty by not
>>>>filling up anything in fill_tgid() or using this patch to
>>>>selectively enable/disable
>>>>tgid stats.
>>>>
>>>>For other subsystems, they could pass tgidstats as NULL to
>>>>taskstats_exit_send().
>>>>
>>>>        
>>>>
>>>I don't understand.  If a subsystem exists then it fills in its slots in
>>>the taskstats structure, doesn't it?
>>>
>>>No other subsystem needs a global knob, does it?
>>>
>>>You see the problem - if one userspace package wants the tgid-stats and
>>>another concurrently-running one does now, what do we do?  Just leave it
>>>enabled and run a bit slower?
>>>      
>>>
>>Another option is to get the package to define their own taskstats
>>genetlink attribute and fill it up in taskstats_exit_send(). This
>>would be similar to
>>TASKSTATS_TYPE_AGGR_PID/TGID.
>>
>>They can make this attribute independent of the taskstats structure
>>and fill
>>it based on their policy (per-pid or per-tgid). But the current interface
>>users like CSA want to build on top of the taskstats structure.
>>    
>>
>
>That was my question to you from the beginning: do you propose a common
>interface based on taskstats or genetlink?
>  
>
Actually its both, at this time. Preference is for packages to use 
taskstats unless they have absolutely
nothing in common with the stats already in struct taskstats...at which 
point they could choose to use
a different structure and ship it (alongwith the taskstats structure) 
using a different netlink attribute.
Since the processing of data happens via attributes, existing users 
(like the daemons of CSA, delay accounting
etc.) can simply ignore that extra attribute coming along.

>If CSA defines its own taskstats genetlink attirbute, does it listen to
>the same socket as delayacct? If yes, then the socket will be jammed with
>duplicate information before long.
>  
>
Very true. The use of a common taskstats ensures that no duplication 
needs to occur and as long
as performance is not an issue, extending taskstats is the preferable way.

What Balbir was pointing out is that the current taskstats interface is 
flexible enough, on account of its
use of netlink attributes, to allow other users of the interface to 
define their own attributes. But this is not
something that should be pursued at this stage.

>Is it an option to make per-tgid data a unicast? Ie, your daemon
>periodically
>polling the per-tgid stats?
>  
>
That option already exists (daemon can do a GET of per-tgid stats).
However, the reason it won't work is because the stats accumalated 
between the last poll and the
exit of the task will get lost. That was the motivation behind the 
"push" of stats from the kernel in the
first place.

As I noted in the other mail, since the per-tgid stats are actually sent 
out very few times in practice
(because of the optimization to not send it when the exiting thread is 
the only one in its thread group),
the extra data/overhead is unlikely to be an issue.

--Shailabh

>Thanks,
> - jay
>
>
>  
>
>>>If so, how much slower?  Your changelog says some potential users don't
>>>need the tgid-stats, but so what?  I assume this patch is a performance
>>>thing?  If so, has it been quantified?
>>>
>>>      
>>>
>>    
>>
>
>  
>

