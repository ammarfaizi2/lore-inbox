Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWIMUu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWIMUu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWIMUu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:50:57 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:49856 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751184AbWIMUu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:50:56 -0400
Message-ID: <45086F16.9030307@cs.wisc.edu>
Date: Wed, 13 Sep 2006 15:50:30 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>
Subject: Re: [PATCH 20/20] iscsi: support for swapping over iSCSI.
References: <20060912143049.278065000@chello.nl> <20060912144905.201160000@chello.nl>
In-Reply-To: <20060912144905.201160000@chello.nl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> Implement sht->swapdev() for iSCSI. This method takes care of reserving
> the extra memory needed and marking all relevant sockets with SOCK_VMIO.
> 
> When used for swapping, TCP socket creation is done under GFP_MEMALLOC and
> the TCP connect is done with SOCK_VMIO to ensure their success. Also the
> netlink userspace interface is marked SOCK_VMIO, this will ensure that even
> under pressure we can still communicate with the daemon (which runs as
> mlockall() and needs no additional memory to operate).
> 
> Netlink requests are handled under the new PF_MEM_NOWAIT when a swapper is
> present. This ensures that the netlink socket will not block. User-space will
> need to retry failed requests.
> 
> The TCP receive path is handled under PF_MEMALLOC for SOCK_VMIO sockets.
> This makes sure we do not block the critical socket, and that we do not
> fail to process incomming data.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> CC: Mike Christie <michaelc@cs.wisc.edu>
> ---
>  drivers/scsi/iscsi_tcp.c            |  103 +++++++++++++++++++++++++++++++-----
>  drivers/scsi/scsi_transport_iscsi.c |   23 +++++++-
>  include/scsi/libiscsi.h             |    1 
>  include/scsi/scsi_transport_iscsi.h |    2 
>  4 files changed, 113 insertions(+), 16 deletions(-)
> 
> Index: linux-2.6/drivers/scsi/iscsi_tcp.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/iscsi_tcp.c
> +++ linux-2.6/drivers/scsi/iscsi_tcp.c
> @@ -42,6 +42,7 @@
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_transport_iscsi.h>
> +#include <scsi/scsi_device.h>
>  
>  #include "iscsi_tcp.h"
>  
> @@ -845,9 +846,13 @@ iscsi_tcp_data_recv(read_descriptor_t *r
>  	int rc;
>  	struct iscsi_conn *conn = rd_desc->arg.data;
>  	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
> -	int processed;
> +	int processed = 0;
>  	char pad[ISCSI_PAD_LEN];
>  	struct scatterlist sg;
> +	unsigned long pflags = current->flags;
> +
> +	if (sk_has_vmio(tcp_conn->sock->sk))
> +		current->flags |= PF_MEMALLOC;
>  

Is this too late or not needed or what is it for? This function gets run
from the network layer's softirq and at this point we have a skbuff with
data that we want to process. The iscsi layer also does not allocate
memory for read or write IO in this path.

I think we would want to set this flag at a lower level. Something
closer to where the skbuf is allocated?
