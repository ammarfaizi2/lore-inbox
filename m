Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161160AbWGNBLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbWGNBLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 21:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbWGNBLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 21:11:32 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:5511 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1161160AbWGNBLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 21:11:31 -0400
X-IronPort-AV: i="4.06,238,1149490800"; 
   d="scan'208"; a="305708532:sNHT12076888254"
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, mingo@elte.hu, zach.brown@oracle.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu> <adaveq2v9gn.fsf@cisco.com>
	<20060712183049.bcb6c404.akpm@osdl.org> <adau05ltsso.fsf@cisco.com>
	<20060713135446.5e2c6dd5.akpm@osdl.org> <adau05lrzdy.fsf@cisco.com>
	<20060713144341.97d4f771.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 13 Jul 2006 18:08:17 -0700
Message-ID: <adazmfdq9ha.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Jul 2006 01:08:19.0489 (UTC) FILETIME=[FE892110:01C6A6E1]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Good point, a try-again loop would work.  Do we really need the caller to
 > maintain a cache?  I suspect something like
 > 
 > drat:
 > 	if (idr_pre_get(GFP_KERNEL) == ENOMEM)
 > 		give_up();
 > 	spin_lock();
 > 	ret = idr_get_new();
 > 	spin_unlock();
 > 	if (ret == ENOMEM)
 > 		goto drat;
 > 
 > would do it.

The problem (for my tiny brain at least) is that I don't know where
idr_pre_get() can put the memory it allocates if there's no lock in
the idr structure -- how do you maintain internal consistency if no
locks are held when filling the cache?

Having the caller hold a chunk of memory in a stack variable was the
trick I came up with to get around that.

 - R.
