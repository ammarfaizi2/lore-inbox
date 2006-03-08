Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWCHV4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWCHV4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWCHV4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:56:22 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:54704 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932584AbWCHV4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:56:19 -0500
Message-ID: <440F52FF.30908@watson.ibm.com>
Date: Wed, 08 Mar 2006 16:56:15 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hadi@cyberus.ca
CC: netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [Patch 7/7] Generic netlink interface (delay	accounting)
References: <1141026996.5785.38.camel@elinux04.optonline.net>	 <1141029060.5785.77.camel@elinux04.optonline.net>	 <1141045194.5363.12.camel@localhost.localdomain>	 <4403608E.1050304@watson.ibm.com>	 <1141652556.5185.64.camel@localhost.localdomain>	 <440C6AAA.9030301@watson.ibm.com> <1141742282.5171.55.camel@localhost.localdomain>
In-Reply-To: <1141742282.5171.55.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

>On Mon, 2006-06-03 at 12:00 -0500, Shailabh Nagar wrote:
>
>  
>
>>My design was to have the listener get both responses (what I call 
>>replies in the code) as well as events (data sent on exit of pid)
>>
>>    
>>
>
>I think i may not be doing justice explaining this, so let me be more
>elaborate so we can be in sync.
>Here is the classical way of doing things:
>
>- Assume several apps in user space and a target in the kernel (this
>could be reversed or combined in many ways, but the sake of
>simplicity/clarity make the above assumption).
>- suppose we have five user space apps A, B, C, D, E; these processes
>would typically do one of the following class of activities:
>
>a) configure (ADD/NEW/DEL etc). This is issued towards the kernel to
>set/create/delete/flush some scalar attribute or vector. These sorts of
>commands are synchronous. i.e you issue them, you expect a response
>(which may indicate success/failure etc). The response is unicast; the
>effect of what they affected may cause an event which may be multicast.
>
>b) query(GET). This is issued towards the kernel to query state of
>configured items. These class of commands are also synchronous. There
>are special cases of the query which dump everything in the target -
>literally called "dumps". The response is unicast.
>
>c) events. These are _asynchronous_ messages issued by the kernel to
>indicate some happening in the kernel. The event may be caused by #a
>above or any other activity in the kernel. Events are multicast.
>To receive them you have to register for the multicast group. You do so
>via sockets. You can register to many multicast group.
>
>For clarity again assume we have a multicast group where announcements
>of pids exiting is seen and C and D are registered to such a multicast
>group.
>Suppose process A exits. That would fall under #c above. C and D will be
>notified.
>Suppose B configures something in the kernel that forces the kernel to
>have process E exit and that such an operation is successful. B will get
>acknowledgement it succeeded (unicast). C and D will get notified
>(multicast). 
>Suppose C issued a GET to find details about a specific pid, then only C
>will get that info back (message is unicast).
>[A response message to a GET is typically designed to be the same as an
>ADD message i.e one should be able to take exactly the same message,
>change one or two things and shove back into the kernel to configure].
>Suppose D issued a GET with dump flag, then D will get the details of
>all pids (message is unicast).
>
>Is this clear? Is there more than the above you need?
>  
>
Thanks for the clarification of the usage model. While our needs are 
certainly much less complex,
it is useful to know the range of options.

>There are no hard rules on what you need to be multicasting and as an
>example you could send periodic(aka time based) samples from the kernel
>on a multicast channel and that would be received by all. It did seem
>odd that you want to have a semi-promiscous mode where a response to a
>GET is multicast. If that is still what you want to achieve, then you
>should.
>  
>
Ok, we'll probably switch to the classical mode you suggest since the 
"efficient processing"
rationale for choosing to operate in the semi-promiscous mode earlier 
can be overcome by
writing a multi-threaded userspace utility.

>>However, we could switch to the model you suggest and use a 
>>multithreaded send/receive userspace utility.
>>
>>    
>>
>
>This is more of the classical way of doing things. 
>
>
>  
>
>>>There is a recent netlink addition to make sure
>>>that events dont get sent if no listeners exist.
>>>genetlink needs to be extended. For now assume such a thing exists.
>>> 
>>>
>>>      
>>>
>>Ok. Will this addition work for both unicast and multicast modes ?
>>
>>    
>>
>
>If you never open a connection to the kernel, nothing will be generated
>towards user space. 
>There are other techniques to rate limit event generation as well (one
>such technique is a nagle-like algorithm used by xfrm).
>
>  
>
>>Will this be necessary ? Isn't genl_rcv_msg() going to return a -EOPNOTSUPP
>>automatically for us since we've not registered the command ?
>> 
>>    
>>
>
>Yes, please in your doc feedback remind me of this,
>
>  
>
>>>Also if you can provide feedback whether the doc i sent was any use
>>>and what wasnt clear etc.
>>> 
>>>
>>>      
>>>
>>Will do.
>>
>>    
>>
>
>also take a look at the excellent documentation Thomas Graf has put in
>the kernel for all the utilities for manipulating netlink messages and
>tell me if that should also be put in this doc (It is listed as a TODO).
>
>
>  
>
Ok.

Thanks,
Shailabh

>cheers,
>jamal
>
>  
>

