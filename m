Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWINUeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWINUeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWINUeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:34:07 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:62612 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751152AbWINUeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:34:05 -0400
Subject: Re: [PATCH 20/20] iscsi: support for swapping over iSCSI.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>
In-Reply-To: <4509ABE5.2080904@cs.wisc.edu>
References: <20060912143049.278065000@chello.nl>
	 <20060912144905.201160000@chello.nl>  <45086F16.9030307@cs.wisc.edu>
	 <1158214650.13665.27.camel@twins>  <4509ABE5.2080904@cs.wisc.edu>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 22:35:50 +0200
Message-Id: <1158266150.30737.92.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 14:22 -0500, Mike Christie wrote:
> Peter Zijlstra wrote:
> > On Wed, 2006-09-13 at 15:50 -0500, Mike Christie wrote:
> >> Peter Zijlstra wrote:
> >>> Implement sht->swapdev() for iSCSI. This method takes care of reserving
> >>> the extra memory needed and marking all relevant sockets with SOCK_VMIO.
> >>>
> >>> When used for swapping, TCP socket creation is done under GFP_MEMALLOC and
> >>> the TCP connect is done with SOCK_VMIO to ensure their success. Also the
> >>> netlink userspace interface is marked SOCK_VMIO, this will ensure that even
> >>> under pressure we can still communicate with the daemon (which runs as
> >>> mlockall() and needs no additional memory to operate).
> >>>
> >>> Netlink requests are handled under the new PF_MEM_NOWAIT when a swapper is
> >>> present. This ensures that the netlink socket will not block. User-space will
> >>> need to retry failed requests.
> >>>
> >>> The TCP receive path is handled under PF_MEMALLOC for SOCK_VMIO sockets.
> >>> This makes sure we do not block the critical socket, and that we do not
> >>> fail to process incomming data.
> >>>
> >>> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> >>> CC: Mike Christie <michaelc@cs.wisc.edu>
> >>> ---
> >>>  drivers/scsi/iscsi_tcp.c            |  103 +++++++++++++++++++++++++++++++-----
> >>>  drivers/scsi/scsi_transport_iscsi.c |   23 +++++++-
> >>>  include/scsi/libiscsi.h             |    1 
> >>>  include/scsi/scsi_transport_iscsi.h |    2 
> >>>  4 files changed, 113 insertions(+), 16 deletions(-)
> >>>
> >>> Index: linux-2.6/drivers/scsi/iscsi_tcp.c
> >>> ===================================================================
> >>> --- linux-2.6.orig/drivers/scsi/iscsi_tcp.c
> >>> +++ linux-2.6/drivers/scsi/iscsi_tcp.c
> >>> @@ -42,6 +42,7 @@
> >>>  #include <scsi/scsi_host.h>
> >>>  #include <scsi/scsi.h>
> >>>  #include <scsi/scsi_transport_iscsi.h>
> >>> +#include <scsi/scsi_device.h>
> >>>  
> >>>  #include "iscsi_tcp.h"
> >>>  
> >>> @@ -845,9 +846,13 @@ iscsi_tcp_data_recv(read_descriptor_t *r
> >>>  	int rc;
> >>>  	struct iscsi_conn *conn = rd_desc->arg.data;
> >>>  	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
> >>> -	int processed;
> >>> +	int processed = 0;
> >>>  	char pad[ISCSI_PAD_LEN];
> >>>  	struct scatterlist sg;
> >>> +	unsigned long pflags = current->flags;
> >>> +
> >>> +	if (sk_has_vmio(tcp_conn->sock->sk))
> >>> +		current->flags |= PF_MEMALLOC;
> >>>  
> >> Is this too late or not needed or what is it for? This function gets run
> >> from the network layer's softirq and at this point we have a skbuff with
> >> data that we want to process. The iscsi layer also does not allocate
> >> memory for read or write IO in this path.
> > 
> > I thought I found allocations in that path, lemme search...
> > found this:
> > 
> > iscsi_tcp_data_recv()
> >   iscsi_data_rescv()
> >     iscsi_complete_pdu()
> >       __iscsi_complete_pdu()
> >         iscsi_recv_pdu()
> >           alloc_skb( GFP_ATOMIC);
> > 
> 
> You are right that is for the netlink interface. Could we move the
> PF_MEMALLOC setting and clearing to iscsi_recv_pdu and and add it to
> iscsi_conn_error in scsi_transport_iscsi.c so that iscsi_iser and
> qla4xxx will have it set when they need it. I will send a patch for this
> along with a way to have the netlink sock vmio set for all iscsi drivers
> that need it.

I already have such a patch, look at:
http://programming.kicks-ass.net/kernel-patches/vm_deadlock/current/iscsi_vmio.patch

but what conditional do you want to use for PF_MEMALLOC, an
unconditional setting will be highly unpopular.

Hmm, perhaps you could key it of sk_has_vmio(nls)...

> >> I think we would want to set this flag at a lower level. Something
> >> closer to where the skbuf is allocated?
> > 
> > Is that the skbuff you were talking about? If so, I'd need to carve a
> > path to pass the swapper information. I had that in a previous patch,
> > but that was large and ugly. I had to go carrying gfp_t flags all
> > through that call chain.
> > 
> 
> In my original post I was just concerned about the sk_buff that gets
> passed to the iscsi layer in iscsi_tcp_data_recv. I was wondering if the
> chunk of code in the network layer or network driver that allocated that
> skbuff needed to set PF_MEMALLOC.

(yeah I got that)

No, that got allocated because its a receive skb and !sk_vmio_socks(),
and got passed up because sk_has_vmio(iscsi_tcp_conn->sock->sk).


