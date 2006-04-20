Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWDTUkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWDTUkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWDTUke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:40:34 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:21908 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751262AbWDTUkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:40:33 -0400
Message-ID: <4447F1B9.1010003@cs.wisc.edu>
Date: Thu, 20 Apr 2006 15:40:25 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: James.Smart@Emulex.Com
CC: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com> <444633B5.5030208@emulex.com> <4446AC80.6040604@cs.wisc.edu> <44479BA8.1000405@emulex.com> <4447C8C2.30909@cs.wisc.edu> <4447E91E.7030603@emulex.com> <4447F09D.9090501@cs.wisc.edu>
In-Reply-To: <4447F09D.9090501@cs.wisc.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie wrote:
> James Smart wrote:
>> Note: We've transitioned off topic. If what this means is "there isn't a
>> good
>> way except by ioctls (which still isn't easily portable) or system calls",
>> then that's ok. Then at least we know the limits and can look at other
>> implementation alternatives.
>>
>> Mike Christie wrote:
>>> James Smart wrote:
>>>> Mike Christie wrote:
>>>>> For the tasks you want to do for the fc class is performance critical?
>>>> No, it should not be.
>>>>
>>>>> If not, you could do what the iscsi class (for the netdev people
>>>>> this is
>>>>> drivers/scsi/scsi_transport_iscsi.c) does and just suffer a couple
>>>>> copies. For iscsi we do this in userspace to send down a login pdu:
>>>>>
>>>>>     /*
>>>>>      * xmitbuf is a buffer that is large enough for the iscsi_event,
>>>>>      * iscsi pdu (hdr_size) and iscsi pdu data (data_size)
>>>>>      */
>>>> Well, the real difference is that the payload of the "message" is
>>>> actually
>>>> the payload of the SCSI command or ELS/CT Request. Thus, the payload may
>>> I am not sure I follow. For iscsi, everything after the iscsi_event
>>> struct can be the iscsi request that is to be transmitted. The payload
>>> will not normally be Mbytes but it is not a couple if bytes.
>> True... For a large read/write - it will eventually total what the i/o
>> request size was, and you did have to push it through the socekt.
>> What this discussion really comes down to is the difference between
>> initiator
>> offload and what a target does.
>>
>> The initiator offloads the "full" i/o from the users - e.g. send command,
>> get response. In the initiator case, the user isn't aware of each and
>> every IU that makes up the i/o. As it's on an i/o basis, the LLDD doing
>> the offload needs the full buffer sitting and ready. DMA is preferred so
>> the buffer doesn't have to be consuming socket/kernel/driver buffers while
>> it's pending - plus speed.
>>
>> In the target case, the target controls each IU and it's size, thus it
>> only has to have access to as much buffer space as it wants to push the
>> next
>> IU. The i/o can be "paced" by the target. Unfortunately, this is an
>> entirely
>> different use model than users of a scsi initiator expect, and it won't map
>> well into replacing things like our sg_io ioctls.
> 
> 
> I am not talking about the target here. For the open-iscsi initiator
> that is in mainline that I referecnced in the example we send pdus from
> userpsace to the LLD. In the future, initaitors that offload some iscsi
> processing and will login from userspace or have userspace monitor the
> transport by doing iscsi pings, we need to be able to send these pdus.
> And the iscsi pdu cannot be broken up at the iscsi level (they can at
> the interconect level though). From the iscsi host level they have to go
> out like a scsi command would in that the LLD cannot decide to send out
> mutiple pdus for he pdu that userspace sends down.
> 
> I do agree with you that targets can break down a scsi command into
> multiple transport level packets as it sees fit.
> 

Oh yeah is

FC IU == iscsi tcp packet
or
FC IU == iscsi pdu
?
