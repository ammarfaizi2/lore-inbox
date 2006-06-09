Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWFITMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWFITMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWFITMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:12:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37030 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030414AbWFITMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:12:14 -0400
Message-ID: <4489C80C.7010100@watson.ibm.com>
Date: Fri, 09 Jun 2006 15:12:12 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, jlan@sgi.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com> <20060609010057.e454a14f.akpm@osdl.org> <448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <44897583.5060206@watson.ibm.com> <4489BD36.9080705@engr.sgi.com>
In-Reply-To: <4489BD36.9080705@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>Shailabh Nagar wrote:
>  
>
>>Andrew Morton wrote:
>>
>>    
>>
>>>On Fri, 09 Jun 2006 16:21:46 +0530
>>>Balbir Singh <balbir@in.ibm.com> wrote:
>>>
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
>>>>>>
>>>>>That seems a bit clumsy.  What happens if one consumer wants the
>>>>>per-tgid
>>>>>stats and another does not?
>>>>>    
>>>>>          
>>>>>
>>Then the tgid stat sending on exit will need to be turned on for
>>everyone.
>>    
>>
>
>I guess that is the limitation of taskstats. One multicast socket for
>every listeners.
>
>  
>
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
>>>>
>>>I don't understand.  If a subsystem exists then it fills in its slots in
>>>the taskstats structure, doesn't it?
>>> 
>>>
>>>      
>>>
>>It can choose not to, by not inserting its "fill my fields" function
>>inside the do..while_each_thread
>>loop within fill_tgid. So while they would still necessarily receive
>>the per-tgid taskstats struct on exit
>>(because some other subsystem needs it), they can atleast save on
>>filling up their part of the struct
>>if they don't need it.
>>
>>    
>>
>>>No other subsystem needs a global knob, does it?
>>> 
>>>
>>>      
>>>
>>I didn't understand.
>>
>>    
>>
>>>You see the problem - if one userspace package wants the tgid-stats and
>>>another concurrently-running one does now, what do we do?  Just leave it
>>>enabled and run a bit slower?
>>> 
>>>
>>>      
>>>
>>Yes, thats what will have to be done. If one user wants, all users
>>will need to get the stats. They can
>>limit their impact by not processing the parts of the netlink message
>>that correspond to the per-tgid stats
>>(since the per-tgid stats are sent as a separate attribute, thats easy
>>to do).
>>
>>This patch covers the use case where someone like CSA is the only user
>>(delay accounting is turned off)
>>and wants to reduce the performance impact of the kernel allocating,
>>sending and userspace discarding
>>the per-tgid stats.
>>
>>    
>>
>>>If so, how much slower?  Your changelog says some potential users don't
>>>need the tgid-stats, but so what?  I assume this patch is a performance
>>>thing? 
>>>      
>>>
>>Yes, its a performance optimization.
>>    
>>
>
>Well, for every task exists, two sets of  data (of struct taskstats) would
>be sent from kernel: one is the stats for the pid, the other is the
>up-to-current stats for the thread (tgid).
>
>Strictly speakly,  the second set of data is not per-task stats. For
>accounting
>subsystems that do not use thread as aggregation, 50% of the data from
>the kernel is useless. The option to not sending thread data is very
>important.
>Of course we are betting a customer site does not run two different
>application on the same system.
>
>  
>
>>>If so, has it been quantified?
>>> 
>>>
>>>      
>>>
>>No :-(
>>Will try to get some numbers.
>>Jay/Chris, if you can try to do that too, for the kind of usage that
>>is typical of CSA,
>>that would be great.
>>    
>>
>
>Probably not until some time next week. But as i point out, 50% of
>traffic is
>not useful to CSA.
>  
>
Jay,

There is one optimization that is already in the current code that is 
relevant here:

when a task is the only thread in its thread group, we only send per-pid 
stats, not the per-tgid
stats (which would be exactly the same).

So the net volume of data going out is not 2x for the whole machine.
It is 2x only when the thread that exits belongs to a thread group that 
currently has other members.

I don't know how common this case is ? I would think most processes are 
single-threaded. The apps
which are heavily multithreaded might also use them in a "pooled" model 
(i.e. fewer exits even though there
is a lot of multithreading). Java apps might be different 
though....don't they also operate using pools of threads ?

Note this is quite apart from the issue of how much impact an extra tgid 
stat has even if such exits are frequent.
I'm trying to get a handle on that number as we speak.

--Shailabh


>Thanks,
> - jay
>
>  
>
>>--Shailabh
>>
>>    
>>
>
>  
>

