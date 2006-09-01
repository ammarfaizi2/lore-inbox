Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWIAU7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWIAU7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 16:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWIAU7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 16:59:32 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:17725 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750833AbWIAU7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 16:59:31 -0400
X-IronPort-AV: i="4.08,201,1154934000"; 
   d="scan'208"; a="316994029:sNHT33342476"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Adrian Bunk <bunk@stusta.de>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [openib-general] 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile error
X-Message-Flag: Warning: May contain useful information
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org> <adak64nij8f.fsf@cisco.com>
	<20060901112312.5ff0dd8d.akpm@osdl.org> <ada8xl3ics4.fsf@cisco.com>
	<1157143527.20958.8.camel@chalcedony.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 01 Sep 2006 13:59:26 -0700
In-Reply-To: <1157143527.20958.8.camel@chalcedony.pathscale.com> (Bryan O'Sullivan's message of "Fri, 01 Sep 2006 13:45:27 -0700")
Message-ID: <adaveo7gv69.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2006 20:59:29.0928 (UTC) FILETIME=[847A6880:01C6CE09]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> Yes, I agree that's a good plan, especially the
    Roland> documentation part.  However I would argue that what's in
    Roland> drivers/infiniband/hw/mthca/mthca_doorbell.h is
    Roland> legitimate: the driver uses __raw_writeq() when it exists
    Roland> and uses two __raw_writel()s properly serialized with a
    Roland> device-specific lock to get exactly the atomicity it needs
    Roland> on 32-bit archs.

    Bryan> On the off chance that you might be arguing that
    Bryan> mthca_write64 could be a candidate drop-in for writeq on
    Bryan> 32-bit arches:

No, quite the opposite.  I'm arguing that the wrappers in mthca do
legitimately belong in a device driver, since they encapsulate
device-specific knowledge about what serialization suffices when an
atomic __raw_writeq() is not available.

    Bryan> That approach might work on mthca hardware, but it's not
    Bryan> safe in general.  The ipath driver requires a proper
    Bryan> writeq(), for example, because the hardware will quite
    Bryan> legitimately treat 32-bit writes to some registers as
    Bryan> separate accesses, and screw things up royally.

Yes, that's an unfortunate feature of the ipath hardware that
apparently makes it impossible to drive on a generic 32-bit architecture.

So perhaps writeq()/__raw_writeq() need to be defined to generate a
single bus cycle to the extent that makes sense.  Which would mean
that it's not possible to implement on all architectures.

 - R.

-- 
VGER BF report: H 0
