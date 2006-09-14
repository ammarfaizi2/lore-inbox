Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWINUpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWINUpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWINUpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:45:13 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.16]:51296 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751155AbWINUpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:45:11 -0400
Subject: Re: [PATCH 20/20] iscsi: support for swapping over iSCSI.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>
In-Reply-To: <1158266150.30737.92.camel@taijtu>
References: <20060912143049.278065000@chello.nl>
	 <20060912144905.201160000@chello.nl>  <45086F16.9030307@cs.wisc.edu>
	 <1158214650.13665.27.camel@twins>  <4509ABE5.2080904@cs.wisc.edu>
	 <1158266150.30737.92.camel@taijtu>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 22:46:56 +0200
Message-Id: <1158266816.30737.99.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 22:35 +0200, Peter Zijlstra wrote:
> On Thu, 2006-09-14 at 14:22 -0500, Mike Christie wrote:

> > > I thought I found allocations in that path, lemme search...
> > > found this:
> > > 
> > > iscsi_tcp_data_recv()
> > >   iscsi_data_rescv()
> > >     iscsi_complete_pdu()
> > >       __iscsi_complete_pdu()
> > >         iscsi_recv_pdu()
> > >           alloc_skb( GFP_ATOMIC);
> > > 
> > 
> > You are right that is for the netlink interface. Could we move the
> > PF_MEMALLOC setting and clearing to iscsi_recv_pdu and and add it to
> > iscsi_conn_error in scsi_transport_iscsi.c so that iscsi_iser and
> > qla4xxx will have it set when they need it. I will send a patch for this
> > along with a way to have the netlink sock vmio set for all iscsi drivers
> > that need it.
> 
> I already have such a patch, look at:
> http://programming.kicks-ass.net/kernel-patches/vm_deadlock/current/iscsi_vmio.patch
> 
> but what conditional do you want to use for PF_MEMALLOC, an
> unconditional setting will be highly unpopular.
> 
> Hmm, perhaps you could key it of sk_has_vmio(nls)...

On second thought, not such a good idea, that will still be too course.
You only want to force feed stuff originating from
sk_has_vmio(iscsi_tcp_conn->sock->sk) connections, not all
connectections as soon as there is a swapper in the system.

In order to preserve that information you need extra state, abusing this
process flags is as good as propagating __GFP_EMERGENCY down the call
chain with extra gfp_t arguments, perhaps even better, since it will
make sure we catch all allocations.



