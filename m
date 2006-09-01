Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWIAVFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWIAVFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWIAVFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:05:42 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:3930 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1750888AbWIAVFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:05:41 -0400
X-IronPort-AV: i="4.08,201,1154934000"; 
   d="scan'208"; a="1851737366:sNHT33800102"
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Adrian Bunk <bunk@stusta.de>,
       Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile error
X-Message-Flag: Warning: May contain useful information
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org> <adak64nij8f.fsf@cisco.com>
	<20060901112312.5ff0dd8d.akpm@osdl.org> <ada8xl3ics4.fsf@cisco.com>
	<20060901130444.48f19457.akpm@osdl.org>
	<20060901204343.GA4979@flint.arm.linux.org.uk>
	<20060901135911.bc53d89a.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 01 Sep 2006 14:05:36 -0700
In-Reply-To: <20060901135911.bc53d89a.akpm@osdl.org> (Andrew Morton's message of "Fri, 1 Sep 2006 13:59:11 -0700")
Message-ID: <adar6yvguvz.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2006 21:05:37.0574 (UTC) FILETIME=[5F9CBC60:01C6CE0A]
Authentication-Results: sj-dkim-8.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> If the hardware/driver absolutely requires that the 64-bit
    Andrew> write be atomic on-the-bus then sure, the fix is to
    Andrew> disable that driver on that architecture in Kconfig.

    Andrew> If, however, the atomicity requirement is a software thing
    Andrew> (we need to be atomic against other CPU reads and writes)
    Andrew> then that can be solved with locking, and we can design
    Andrew> APIs for this which can be implemented efficiently on all
    Andrew> architectures.

It seems that there are cases of both.  ipath needs actual 64-bit bus
transactions to work properly.  mthca needs to make sure that if
doorbell writes are split into two 32-bit halves, then no other writes
go to the same MMIO page in between the halves.

What do you think the API would look like?  Something along the lines
of mthca_doorbell.h, where we have macros for

DECLARE_WRITEQ_LOCK()
INIT_WRITEQ_LOCK()
GET_WRITEQ_LOCK()

which get stubbed out on architectures where writeq is already atomic,
and then pass the lock into writeq()?

But then you probably need some Kconfig symbol to say if writeq() is
really atomic or just software atomic (for ipath et al to depend on).

 - R.

-- 
VGER BF report: H 0
