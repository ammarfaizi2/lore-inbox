Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWFISZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWFISZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWFISZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:25:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27277 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030348AbWFISZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:25:57 -0400
Message-ID: <4489BD36.9080705@engr.sgi.com>
Date: Fri, 09 Jun 2006 11:25:58 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, jlan@sgi.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com> <20060609010057.e454a14f.akpm@osdl.org> <448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <44897583.5060206@watson.ibm.com>
In-Reply-To: <44897583.5060206@watson.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Andrew Morton wrote:
>
>> On Fri, 09 Jun 2006 16:21:46 +0530
>> Balbir Singh <balbir@in.ibm.com> wrote:
>>
>>  
>>
>>> Andrew Morton wrote:
>>>   
>>>> On Fri, 09 Jun 2006 03:41:04 -0400
>>>> Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>>>
>>>>
>>>>     
>>>>> Hence, this patch introduces a configuration parameter
>>>>>     /sys/kernel/taskstats_tgid_exit
>>>>> through which a privileged user can turn on/off sending of
>>>>> per-tgid stats on
>>>>> task exit.
>>>>>       
>>>> That seems a bit clumsy.  What happens if one consumer wants the
>>>> per-tgid
>>>> stats and another does not?
>>>>     
> Then the tgid stat sending on exit will need to be turned on for
> everyone.

I guess that is the limitation of taskstats. One multicast socket for
every listeners.

>
>>> For all subsystems that re-use the taskstats structure from the exit
>>> path,
>>> we have the issue that you mentioned. Thats because several
>>> statistics co-exist
>>> in the same structure. These subsystems can keep their tgid-stats
>>> empty by not
>>> filling up anything in fill_tgid() or using this patch to
>>> selectively enable/disable
>>> tgid stats.
>>>   
>>> For other subsystems, they could pass tgidstats as NULL to
>>> taskstats_exit_send().
>>>
>>>   
>>
>> I don't understand.  If a subsystem exists then it fills in its slots in
>> the taskstats structure, doesn't it?
>>  
>>
> It can choose not to, by not inserting its "fill my fields" function
> inside the do..while_each_thread
> loop within fill_tgid. So while they would still necessarily receive
> the per-tgid taskstats struct on exit
> (because some other subsystem needs it), they can atleast save on
> filling up their part of the struct
> if they don't need it.
>
>> No other subsystem needs a global knob, does it?
>>  
>>
> I didn't understand.
>
>> You see the problem - if one userspace package wants the tgid-stats and
>> another concurrently-running one does now, what do we do?  Just leave it
>> enabled and run a bit slower?
>>  
>>
> Yes, thats what will have to be done. If one user wants, all users
> will need to get the stats. They can
> limit their impact by not processing the parts of the netlink message
> that correspond to the per-tgid stats
> (since the per-tgid stats are sent as a separate attribute, thats easy
> to do).
>
> This patch covers the use case where someone like CSA is the only user
> (delay accounting is turned off)
> and wants to reduce the performance impact of the kernel allocating,
> sending and userspace discarding
> the per-tgid stats.
>
>> If so, how much slower?  Your changelog says some potential users don't
>> need the tgid-stats, but so what?  I assume this patch is a performance
>> thing? 
> Yes, its a performance optimization.

Well, for every task exists, two sets of  data (of struct taskstats) would
be sent from kernel: one is the stats for the pid, the other is the
up-to-current stats for the thread (tgid).

Strictly speakly,  the second set of data is not per-task stats. For
accounting
subsystems that do not use thread as aggregation, 50% of the data from
the kernel is useless. The option to not sending thread data is very
important.
Of course we are betting a customer site does not run two different
application on the same system.

>
>> If so, has it been quantified?
>>  
>>
> No :-(
> Will try to get some numbers.
> Jay/Chris, if you can try to do that too, for the kind of usage that
> is typical of CSA,
> that would be great.

Probably not until some time next week. But as i point out, 50% of
traffic is
not useful to CSA.

Thanks,
 - jay

>
> --Shailabh
>

