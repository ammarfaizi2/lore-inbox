Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWINV3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWINV3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWINV3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:29:13 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:12232 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751205AbWINV3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:29:12 -0400
Message-ID: <4509C997.4070006@cs.wisc.edu>
Date: Thu, 14 Sep 2006 16:28:55 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>
Subject: Re: [PATCH 20/20] iscsi: support for swapping over iSCSI.
References: <20060912143049.278065000@chello.nl>	 <20060912144905.201160000@chello.nl>  <45086F16.9030307@cs.wisc.edu>	 <1158214650.13665.27.camel@twins>  <4509ABE5.2080904@cs.wisc.edu>	 <1158266150.30737.92.camel@taijtu> <1158266816.30737.99.camel@taijtu> <4509C4ED.9080508@cs.wisc.edu>
In-Reply-To: <4509C4ED.9080508@cs.wisc.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie wrote:
> Peter Zijlstra wrote:
>> On Thu, 2006-09-14 at 22:35 +0200, Peter Zijlstra wrote:
>>> On Thu, 2006-09-14 at 14:22 -0500, Mike Christie wrote:
>>>>> I thought I found allocations in that path, lemme search...
>>>>> found this:
>>>>>
>>>>> iscsi_tcp_data_recv()
>>>>>   iscsi_data_rescv()
>>>>>     iscsi_complete_pdu()
>>>>>       __iscsi_complete_pdu()
>>>>>         iscsi_recv_pdu()
>>>>>           alloc_skb( GFP_ATOMIC);
>>>>>
>>>> You are right that is for the netlink interface. Could we move the
>>>> PF_MEMALLOC setting and clearing to iscsi_recv_pdu and and add it to
>>>> iscsi_conn_error in scsi_transport_iscsi.c so that iscsi_iser and
>>>> qla4xxx will have it set when they need it. I will send a patch for this
>>>> along with a way to have the netlink sock vmio set for all iscsi drivers
>>>> that need it.
>>> I already have such a patch, look at:
>>> http://programming.kicks-ass.net/kernel-patches/vm_deadlock/current/iscsi_vmio.patch
>>>
>>> but what conditional do you want to use for PF_MEMALLOC, an
>>> unconditional setting will be highly unpopular.
>>>
>>> Hmm, perhaps you could key it of sk_has_vmio(nls)...
>> On second thought, not such a good idea, that will still be too course.
>> You only want to force feed stuff originating from
>> sk_has_vmio(iscsi_tcp_conn->sock->sk) connections, not all
>> connectections as soon as there is a swapper in the system.
>>
> 
> You can move the iscsi_session->swapper field to the iscsi_cls_session
> and have iscsi_swapdev take a iscsi_cls_session and set that flag.
> iscsi_recv_pdu and iscsi_conn_error and all the llds can then access
> this bit.
> 
>> In order to preserve that information you need extra state, abusing this
>> process flags is as good as propagating __GFP_EMERGENCY down the call
>> chain with extra gfp_t arguments, perhaps even better, since it will
>> make sure we catch all allocations.
>>

Oh yeah, on the send side we also allocate some memory for the netlink
interface if there is a connection error (iscsi_conn_failure ->
iscsi_conn_error). And when that is called from the transmit side we can
change the GFP_ATOMICs to GFP_NOIOs since we have process context.

So I am just saying we need to set that flag in a couple more places (if
you set it in iscsi_conn_error if iscsi_cls_session->swapper is set then
don't worry about it), and that I need to change iscsi_conn_failure and
iscsi_conn_error to take a gfp_t as an argument (or do a in_interrupt or
something) so we can use GFP_NOIO in the transmit code.
