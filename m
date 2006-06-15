Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031034AbWFOS3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031034AbWFOS3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 14:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031035AbWFOS3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 14:29:24 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:27363 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1031034AbWFOS3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 14:29:24 -0400
Message-ID: <4491A6E6.3090503@watson.ibm.com>
Date: Thu, 15 Jun 2006 14:28:54 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@sgi.com>
CC: Balbir Singh <balbir@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Sturtivant <csturtiv@sgi.com>
Subject: Re: ON/OFF control of taskstats accounting data at do_exit
References: <449093D6.6000806@engr.sgi.com> <4490CDC2.3090009@watson.ibm.com> <4490D515.8070308@engr.sgi.com> <449182FB.6020907@watson.ibm.com> <449197D3.3090109@sgi.com>
In-Reply-To: <449197D3.3090109@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> Shailabh Nagar wrote:

>>
>> Assembly and delivery of data is done by the taskstats code, calling
>> subsystem-specific functions to fill
>> the commonly used struct taskstats and relying on genetlink to do the
>> delivery.
>> This can be turned on/off using a dynamic parameter such as
>> /sys/kernel/taskstats_enable which sets
>> some internal variable that is used to do early exits from relevant
>> functions (mainly taskstats_send_stats
>> and taskstats_exit_send)
>> Doing so will have impact on
>> a) queries sent to the kernel by monitoring applications
>> b) task exit data sent by kernel to apps listening on the multicast
>> socket
>>
>> For consistency, I'm assuming both a) and b) will have to be affected
>> when taskstats is turned off.
>> Also, I'm assuming monitoring applications aren't aware of the turn off.
> 
> 
> I do not see impacts of both cases above since it would not happen.
> I expect the event of turning off taskstats feature is coordidated
> by the system adminstrator, so all users are notified in advance.

Agreed that all users will be notified. Once that happens, what do you expect
these users will do to the applications they are running that
a) query per-task data periodically, or
b) monitor exit data

Either these applications will continue running (querying, listening) and
have to understand that they cannot expect more data
or they will be stopped(or suspended) from doing the monitoring/querying.

If its the latter, then we don't really need kernel changes since we only save on
a little bit of assembling data overhead.

If its the former, then yes, it will be useful to have the kernel changes.

> 
> For that reason, i think exposing the switch at sysfs is not a good
> idea. Instead, /etc/init.d/taskstats script would be right for
> this purpose. 

I don't get the difference between these two options as far as kernel is concerned.
A systemwide switch that can be set by only by a privileged user is what is needed
either way, right ? Whether it is in sys/kernel (through sysfs) or
/proc/sys/kernel (through /proc and via sysctl) ? Or is there something else that an
/etc/init.d/taskstats script can do to set a kernel parameter ?


> At kernel side, we would need to make this possible.
> 
> What do you think?
> 
> Regards,
>  - jay
> 
>>
>> What happens to case a) ? Apps will need to get some error message as
>> a reply. Some assembly overhead
>> is saved (since such an error reply can be sent right away as soon as
>> a query command is seen) but no
>> substantial saving on the delivery part.
>>
>> For case b), we can save on assembly and delivery by exiting early
>> from taskstats_exit_send(). But won't
>> we need to send some message (if not periodically, atleast once) to
>> listening apps that they shouldn't
>> expect any exit data ? Semantics of suddenly not seeing any exit data
>> could be misinterpreted ?
>>
>> Its easy enough to implement...just concerned about the semantics of
>> doing so (as far as userspace
>> apps are concerned) and utility in general settings. Utility in case
>> where only CSA is running (delay
>> accounting and other users turned off) is clear.
>>
>> Thoughts ?
>>
>> --Shailabh
>>
>>
>>
>>
>>
>>
>>
>>
> 

