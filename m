Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWCTSrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWCTSrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWCTSrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:47:46 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:818 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751255AbWCTSrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:47:45 -0500
X-IronPort-AV: i="4.03,111,1141632000"; 
   d="scan'208"; a="418347970:sNHT26789054"
To: Andrew Morton <akpm@osdl.org>
Cc: "Sean Hefty" <sean.hefty@intel.com>, bunk@stusta.de,
       linux-kernel@vger.kernel.org, rolandd@cisco.com,
       openib-general@openib.org
Subject: Re: 2.6.16-rc6-mm2: new RDMA CM EXPORT_SYMBOL's
X-Message-Flag: Warning: May contain useful information
References: <20060318172507.GC14608@stusta.de>
	<ORSMSX401FRaqbC8wSA00000004@orsmsx401.amr.corp.intel.com>
	<20060318171926.7cb182fb.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 20 Mar 2006 10:47:41 -0800
In-Reply-To: <20060318171926.7cb182fb.akpm@osdl.org> (Andrew Morton's message of "Sat, 18 Mar 2006 17:19:26 -0800")
Message-ID: <ada64m9eywi.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Mar 2006 18:47:43.0061 (UTC) FILETIME=[C5758050:01C64C4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Putting this in -mm has generated more discussion than three postings
of the complete patch series to lkml.  Andrew, please don't ever turn
your powers to evil ;)

    Andrew> What code will use them?
    Andrew> Is it planned that this code be merged?

Anyway, there are three main users of these APIs:

 - A kernel module that allows userspace to use this IP-based RDMA
   connection abstraction.  It's my fault that this didn't make it
   into -mm: I didn't think it was quite as baked as the kernel side,
   and it's also more important to have the userspace interface stable
   before merging it upstream, so I didn't put it in my git tree.
   However, it should go into -mm, so I'll include it for next time.

 - iSER ("iSCSI over IB").  The feeling I get from Christoph et al is
   that this is pretty much ready to merge as well, but I'm not sure
   if it's being staged anywhere.

 - NFS/RDMA.  This is not ready to merge yet but it is being worked on
   with the idea of going upstream as soon as it's ready.

Looking at this list of exports, I do see a couple of things that
could maybe be improved:

    > +EXPORT_SYMBOL(rdma_wq);
    > +EXPORT_SYMBOL(rdma_translate_ip);
    > +EXPORT_SYMBOL(rdma_resolve_ip);
    > +EXPORT_SYMBOL(rdma_addr_cancel);

First, rdma_wq seems like a strange internal thing to be exporting.
Sean, why does more than one module need to use the same workqueue?

Second, the naming of rdma_addr_cancel() is not that symmetric with
the rdma_{translate,resolve}_ip() functions.  Unfortunately I'm just
clever enough to criticize, not clever enough to come up with a better
suggestion.

    Andrew> Please explain the thinking behind the choice of a non-GPL
    Andrew> export.  (Yes, we discussed this when inifiniband was
    Andrew> first merged, but it doesn't hurt to reiterate).

I don't think there's any deep thought behind it, except that these
exports (for the most part) form a high-level coherent API and there's
no desire by the original author to restrict things.

ip_dev_find() was originally a non-GPL export, then removed for a
while.  So it makes sense to just revert the first change.

 - R.
