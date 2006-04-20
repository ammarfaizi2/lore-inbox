Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWDTUEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWDTUEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWDTUEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:04:05 -0400
Received: from emulex.emulex.com ([138.239.112.1]:8865 "EHLO emulex.emulex.com")
	by vger.kernel.org with ESMTP id S1750865AbWDTUED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:04:03 -0400
Message-ID: <4447E91E.7030603@emulex.com>
Date: Thu, 20 Apr 2006 16:03:42 -0400
From: James Smart <James.Smart@Emulex.Com>
Reply-To: James.Smart@Emulex.Com
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Mike Christie <michaelc@cs.wisc.edu>
CC: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com> <444633B5.5030208@emulex.com> <4446AC80.6040604@cs.wisc.edu> <44479BA8.1000405@emulex.com> <4447C8C2.30909@cs.wisc.edu>
In-Reply-To: <4447C8C2.30909@cs.wisc.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Apr 2006 20:03:42.0821 (UTC) FILETIME=[8617E950:01C664B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: We've transitioned off topic. If what this means is "there isn't a good
way except by ioctls (which still isn't easily portable) or system calls",
then that's ok. Then at least we know the limits and can look at other
implementation alternatives.

Mike Christie wrote:
> James Smart wrote:
>> Mike Christie wrote:
>>> For the tasks you want to do for the fc class is performance critical?
>> No, it should not be.
>>
>>> If not, you could do what the iscsi class (for the netdev people this is
>>> drivers/scsi/scsi_transport_iscsi.c) does and just suffer a couple
>>> copies. For iscsi we do this in userspace to send down a login pdu:
>>>
>>>     /*
>>>      * xmitbuf is a buffer that is large enough for the iscsi_event,
>>>      * iscsi pdu (hdr_size) and iscsi pdu data (data_size)
>>>      */
>> Well, the real difference is that the payload of the "message" is actually
>> the payload of the SCSI command or ELS/CT Request. Thus, the payload may
> 
> I am not sure I follow. For iscsi, everything after the iscsi_event
> struct can be the iscsi request that is to be transmitted. The payload
> will not normally be Mbytes but it is not a couple if bytes.

True... For a large read/write - it will eventually total what the i/o
request size was, and you did have to push it through the socekt.
What this discussion really comes down to is the difference between initiator
offload and what a target does.

The initiator offloads the "full" i/o from the users - e.g. send command,
get response. In the initiator case, the user isn't aware of each and
every IU that makes up the i/o. As it's on an i/o basis, the LLDD doing
the offload needs the full buffer sitting and ready. DMA is preferred so
the buffer doesn't have to be consuming socket/kernel/driver buffers while
it's pending - plus speed.

In the target case, the target controls each IU and it's size, thus it
only has to have access to as much buffer space as it wants to push the next
IU. The i/o can be "paced" by the target. Unfortunately, this is an entirely
different use model than users of a scsi initiator expect, and it won't map
well into replacing things like our sg_io ioctls.

> Instead of netlink for scsi commands and transport requests....
> 
> For scsi commands could we just use sg io, or is there something special
> about the command you want to send? If you can use sg io for scsi
> commands, maybe for transport level requests (in my example iscsi pdu)
> we could modify something like sg/bsg/block layer scsi_ioctl.c to send
> down transport requests to the classes and encapsulate them in some new
> struct transport_requests or use the existing struct request but do that
> thing people keep taling about using the request/request_queue for
> message passing.

Well - there's 2 parts to this answer:

First : IOCTL's are considered dangerous/bad practice and therefore it would
   be nice to find a replacement mechanism that eliminates them. If that
   mechanism has some of the cool features that netlink does, even better.
   Using sg io, in the manner you indicate, wouldn't remove the ioctl use.
   Note: I have OEMs/users that are very confused about the community's statement
   about ioctls. They've heard they are bad, should never be allowed, will no
   be longer supported, but yet they are at the heart of DM and sg io and other
   subsystems. Other than a "grandfathered" explanation, they don't understand
   why the rules bend for one piece of code but not for another. To them, all
   the features are just as critical regardless of whose providing them.

Second: transport level i/o could be done like you suggest, and we've
   prototyped some of this as well. However, there's something very wrong
   about putting "block device" wrappers and settings around something that
   is not a block device.  In general, it's a heck of a lot of overhead and
   still doesn't solve the real issue - how to portably pass that user buffer
   in to/out of the kernel.


-- james s
