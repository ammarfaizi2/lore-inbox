Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWDTUSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWDTUSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWDTUSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:18:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59869 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751250AbWDTUSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:18:23 -0400
Message-ID: <4447EC84.7030502@torque.net>
Date: Thu, 20 Apr 2006 16:18:12 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Christie <michaelc@cs.wisc.edu>
CC: James.Smart@Emulex.Com, linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com> <444633B5.5030208@emulex.com> <4446AC80.6040604@cs.wisc.edu> <44479BA8.1000405@emulex.com> <4447C8C2.30909@cs.wisc.edu>
In-Reply-To: <4447C8C2.30909@cs.wisc.edu>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie wrote:
> James Smart wrote:
> 
>>Mike Christie wrote:
>>
>>>For the tasks you want to do for the fc class is performance critical?
>>
>>No, it should not be.
>>
>>
>>>If not, you could do what the iscsi class (for the netdev people this is
>>>drivers/scsi/scsi_transport_iscsi.c) does and just suffer a couple
>>>copies. For iscsi we do this in userspace to send down a login pdu:
>>>
>>>    /*
>>>     * xmitbuf is a buffer that is large enough for the iscsi_event,
>>>     * iscsi pdu (hdr_size) and iscsi pdu data (data_size)
>>>     */
>>
>>Well, the real difference is that the payload of the "message" is actually
>>the payload of the SCSI command or ELS/CT Request. Thus, the payload may
> 
> 
> I am not sure I follow. For iscsi, everything after the iscsi_event
> struct can be the iscsi request that is to be transmitted. The payload
> will not normally be Mbytes but it is not a couple if bytes.
> 
> 
>>range in size from a few hundred bytes to several kbytes (> 1 page) to
>>Mbyte's in size. Rather than buffer all of this, and push it over the
>>socket,
>>thus the extra copies - it would best to have the LLDD simply DMA the
>>payload like on a typical SCSI command.  Additionally, there will be
>>response data that can be several kbytes in length.
>>
> 
> 
> Once you have got the buffer to the class, the class can create a
> scatterlist to DMA from for the LLD. I thought. iscsi does not do this
> just because it is software right now. For qla4xxx we do not need
> something like what you are talking about (see below for what I was
> thinking about for the initiators). If you are saying the extra step of
> the copy is plain dumb, I agree, but this happens (you have to suffer
> some copy and cannot do dio) for sg io as well in some cases. I think
> for the sg driver the copy_*_user is the default.

Mike,
Indirect IO is the default in the sg driver because:
  - it has always been thus
  - the sg driver is less constrained (e.g. max number
    of scatg elements is a bigger issue with dio)
  - the only alignment to worry about is byte
    alignment (some folks would like bit alignment
    but you can't please everybody)
  - there is no need for the sg driver to pin user
    pages in memory (as there is with direct IO and
    mmaped-IO)

> Instead of netlink for scsi commands and transport requests....

With a netlink based pass through one might:
  - improve on the SG_IO ioctl and add things like
    tags that are currently missing
  - introduce a proper SCSI task management function
    pass through (no request queue please)
  - make other pass throughs for SAS: SMP and STP
  - have an alternative to sysfs for various control
    functions in a HBA (e.g. in SAS: link and hard
    reset) and fetching performance data from a HBA

Apart from how to get data efficiently between the HBA
and the user space, another major issue is the flexibility
of the bind() in s_netlink (storage netlink??).

> For scsi commands could we just use sg io, or is there something special
> about the command you want to send? If you can use sg io for scsi
> commands, maybe for transport level requests (in my example iscsi pdu)
> we could modify something like sg/bsg/block layer scsi_ioctl.c to send
> down transport requests to the classes and encapsulate them in some new
> struct transport_requests or use the existing struct request but do that
> thing people keep taling about using the request/request_queue for
> message passing.

Some SG_IO ioctl users want up to 32 MB in one transaction
and others want their data fast. Many pass through users
view the kernel as an impediment (not so much as "the way"
as "in the way").

Doug Gilbert
