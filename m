Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWGMVDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWGMVDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWGMVDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:03:24 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:16970 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1030390AbWGMVDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:03:23 -0400
X-IronPort-AV: i="4.06,238,1149490800"; 
   d="scan'208"; a="1838321346:sNHT26397756"
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, mingo@elte.hu, zach.brown@oracle.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu> <adaveq2v9gn.fsf@cisco.com>
	<20060712183049.bcb6c404.akpm@osdl.org> <adau05ltsso.fsf@cisco.com>
	<20060713135446.5e2c6dd5.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 13 Jul 2006 14:03:21 -0700
In-Reply-To: <20060713135446.5e2c6dd5.akpm@osdl.org> (Andrew Morton's message of "Thu, 13 Jul 2006 13:54:46 -0700")
Message-ID: <adau05lrzdy.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Jul 2006 21:03:22.0530 (UTC) FILETIME=[C6772820:01C6A6BF]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I suspect it'll get really ugly.  It's a container library which needs to
 > allocate memory when items are added, like the radix-tree.  Either it needs
 > to assume GFP_ATOMIC, which is bad and can easily fail or it does weird
 > things like radix_tree_preload().

Actually I don't think it has to be too bad.  We could tweak the
interface a little bit so that consumers do something like:

	struct idr_layer *layer = NULL;	/* opaque */

retry:
        spin_lock(&my_idr_lock);
	ret = idr_get_new(&my_idr, ptr, &id, layer);
        spin_unlock(&my_idr_lock);

        if (ret == -EAGAIN) {
		layer = idr_alloc_layer(&my_idr, GFP_KERNEL);
		if (!IS_ERR(layer))
			goto retry;
	}

in other words make the consumer responsible for passing in new memory
that can be used for a new entry (or freed if other entries have
become free in the meantime).

 - R.
