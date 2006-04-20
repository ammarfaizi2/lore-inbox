Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWDTR7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWDTR7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWDTR7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:59:05 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:38546 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751206AbWDTR7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:59:03 -0400
Message-ID: <4447CBDC.6010002@cs.wisc.edu>
Date: Thu, 20 Apr 2006 12:58:52 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: James.Smart@Emulex.Com
CC: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com> <444633B5.5030208@emulex.com> <4446AC80.6040604@cs.wisc.edu> <44479BA8.1000405@emulex.com> <4447C8C2.30909@cs.wisc.edu>
In-Reply-To: <4447C8C2.30909@cs.wisc.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
>> range in size from a few hundred bytes to several kbytes (> 1 page) to
>> Mbyte's in size. Rather than buffer all of this, and push it over the
>> socket,
>> thus the extra copies - it would best to have the LLDD simply DMA the
>> payload like on a typical SCSI command.  Additionally, there will be
>> response data that can be several kbytes in length.
>>
> 
> Once you have got the buffer to the class, the class can create a
> scatterlist to DMA from for the LLD. I thought. iscsi does not do this
> just because it is software right now. For qla4xxx we do not need
> something like what you are talking about (see below for what I was
> thinking about for the initiators). If you are saying the extra step of
> the copy is plain dumb, I agree, but this happens (you have to suffer
> some copy and cannot do dio) for sg io as well in some cases. I think
> for the sg driver the copy_*_user is the default.
> 
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

And just to be complete, the problem with this is that it is tied to the
request queue and so you cannot just send a transport level request
unless it is tied to the device. But for the target stuff we added a
request queue to the host so we could inject requests (the idea was to
send down those magic message requests) at a higher level.  To be able
to use that for sg io though it would require some more code and magic
as you know.
