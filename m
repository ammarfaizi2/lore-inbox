Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751934AbWCFRAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWCFRAb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbWCFRAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:00:30 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:20284 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751324AbWCFRA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:00:29 -0500
Message-ID: <440C6AAA.9030301@watson.ibm.com>
Date: Mon, 06 Mar 2006 12:00:26 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hadi@cyberus.ca
CC: netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Patch 7/7] Generic netlink interface (delay accounting)
References: <1141026996.5785.38.camel@elinux04.optonline.net>	 <1141029060.5785.77.camel@elinux04.optonline.net>	 <1141045194.5363.12.camel@localhost.localdomain>	 <4403608E.1050304@watson.ibm.com> <1141652556.5185.64.camel@localhost.localdomain>
In-Reply-To: <1141652556.5185.64.camel@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamal,

Pls keep lkml and lse-tech on cc since some of this affects the usage
of delay accounting.


jamal wrote:

>Hi Shailabh,
>Apologies for taking a week to respond ..
>
>On Mon, 2006-27-02 at 15:26 -0500, Shailabh Nagar wrote: 
>  
>
>>jamal wrote:
>>    
>>
>
>  
>
>>Yes, the current intent is to allow multiple listeners to receive the 
>>responses sent by the kernel.
>>    
>>
>
>Responses or events? There is a difference:
>Response implies the program in user space requested (ex a GET) for that
>information and is receiving such info.
>Event implies the program in user space asked to be informed of changes
>in the kernel. Example an exit would be considered an event. 
>Events are received by virtue of registering to a multicast group.
>[..] 
>  
>
My design was to have the listener get both responses (what I call 
replies in the code)
as well as events (data sent on exit of pid)

>>Since this interface (taskstats) is currently designed for that 
>>possibility, having multiple listeners, one for
>>each "component" such as delay accounting, is the model we're using.
>>We expect each component to have a pair of userspace programs, one for 
>>sending commands and the other
>>to "listen" to all replies + data generated on task exits. 
>>    
>>
>
>You need to have a sender of GETs essentially and a listener of events.
>Those are two connections. The replies of a get from user1 will not be
>sent to user2 as well - unless ... thats what you are trying to achieve;
>the question is why?
>  
>
Yes, I was trying to have an asymmetric model where the userspace sender 
of GETs
doesn't receive the reply as a unicast. Rather the reply is sent by 
multicast (alongwith all the
event data).

Reason for this unintuitive design was to make it easier to process the 
returned data.

The expected usage of delay accounting is to periodically "sample" the 
delays for all
tasks (or tgids) in the system. Also, get the delays from exiting pids 
(lets forget how tgid exit
is handled for now...irrelevant to this discussion).

Using the above two pieces of data, userspace can aggregate the "delays" 
seen by any
grouping of tasks that it chooses to implement.

In this usage scenario, its more efficient to have one receiver get both 
response and event
data and process in a loop.

However, we could switch to the model you suggest and use a 
multithreaded send/receive
userspace utility.

>>The listener 
>>is expected to register/deregister interest through
>>TASKSTATS_CMD_LISTEN and IGNORE.
>>
>>    
>>
>
>It is not necessary if you follow the model i described.
>
>  
>
>>>How does this correlate to TASKSTATS_CMD_LISTEN/IGNORE?
>>> 
>>>
>>>      
>>>
>>See above. Its mainly an optimization so that if no listener is present, 
>>there's no need to generate the data.
>>
>>    
>>
>
>Also not necessary - There is a recent netlink addition to make sure
>that events dont get sent if no listeners exist.
>genetlink needs to be extended. For now assume such a thing exists.
>  
>
Ok. Will this addition work for both unicast and multicast modes ?



>  
>
>>>>+
>>>>        
>>>>
>
>  
>
>>Good point. Should check for users sending it as a cmd and treat it as a 
>>noop. 
>>    
>>
>
>More like return an -EINVAL
>  
>
Will this be necessary ? Isn't genl_rcv_msg() going to return a -EOPNOTSUPP
automatically for us since we've not registered the command ?
 

>  
>
>>I'm just using
>>this as a placeholder for data thats returned without being requested.
>>
>>    
>>
>
>So it is unconditional?
>  
>
Yes.

>  
>
>>Come to think of it, there's no real reason to have a genlmsghdr for 
>>returned data, is there ?
>>    
>>
>
>All messages should be consistent whether they are sent from user
>or kernel.
>  
>
Ok. will retain genetlink header.

>>Other than to copy the genlmsghdr that was sent so user can identify 
>>which command was sent
>>(and I'm doing that through the reply type, perhaps redundantly).
>>
>>    
>>
>
>yes, that is a useful trick. Just make sure they are reflected
>correctly.
>
>  
>
>>Actually, the next iteration of the code will move to dynamically 
>>generated ID. But yes, will need to check for that.
>>
>>    
>>
>
>Also if you can provide feedback whether the doc i sent was any use
>and what wasnt clear etc.
>  
>
Will do.

>>Thanks for the review.
>>Couple of questions about general netlink:
>>is it intended to remain a size that will always be aligned to the 
>>NLMSG_ALIGNTO so that (NLMSG_DATA(nlhdr) + GENL_HDRLEN) can always 
>>be used as a pointer to the genlmsghdr ?
>>
>>    
>>
>
>I am not sure i followed.
>The whole message (nlhdr, genlhdr, optionalhdr, TLVs) has to be in 
>the end 32 bit aligned.
>  
>
Ok , so separate padding isn't needed to make the genlhdr, optionalhdr 
and TLV parts aligned
too.

>>Adding some macros like genlmsg_data(nlh) would be handy (currently I 
>>just define and use it locally).
>>
>>    
>>
>
>Send a patch.
>  
>
will do.


Thanks,
Shailabh

>cheers,
>jamal
>
>  
>

