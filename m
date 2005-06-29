Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVF2QHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVF2QHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVF2QGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:06:30 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:2359 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S261541AbVF2QGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:06:21 -0400
X-IronPort-AV: i="3.93,242,1115017200"; 
   d="scan'208"; a="284267467:sNHT28326744"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 06/16] IB uverbs: memory pinning implementation
X-Message-Flag: Warning: May contain useful information
References: <2005628163.jfSiMqRcI78iLMJP@cisco.com>
	<2005628163.qcqYIUxXOrm3IH43@cisco.com>
	<20050628170212.24623191.akpm@osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 29 Jun 2005 09:06:18 -0700
Message-ID: <524qbhgnb9.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> Add support for pinning userspace memory regions and
    Roland> returning a list of pages in the region.  This includes
    Roland> tracking pinned memory against vm_locked and preventing
    Roland> unprivileged users from exceeding RLIMIT_MEMLOCK.

    Andrew> Can you tell us a bit more about the design ideas here?
    Andrew> What's it doing, how and why?

The idea is that allowing userspace to handle initiating IO directly
requires the kernel to make sure the memory targeted by that IO is
kept pinned.  This is done by requiring userspace to register the
memory regions it will use for IO in advance.

The code in uverbs_mem.c helps handle this by providing a function
ib_umem_get(), which wraps up calling get_user_pages() and
dma_map_sg() for a given piece of userspace address space, and returns
a data structure with DMA addresses for region.

Since userspace can potentially register huge chunks of memory, the
code breaks up the calls to get_user_pages() and dma_map_sg() into
chunks, and the umem data structure has a linked list of these chunks.

    Andrew> We should look at these things and also decide whether
    Andrew> some of this should live in mm/*.

I thought about that a little while I was writing the code.  The only
thing that seemed generic enough was the logic for vm_locked
accounting and checking against RLIMIT_MEMLOCK.  I wasn't smart enough
to come up with a way to encapsulate it that seemed any easier to read
or maintain than just spelling the logic out.

iWARP (basically RDMA over TCP) will also want to use the memory
pinning code here, but I think the best plan for handling iWARP is to
evolve drivers/infiniband into a more generic drivers/rdma -- in which
case, this code is fine where it is.

So... no objection to making it generic or putting it somewhere else,
but there's not anything deep going on here.

 - R.
