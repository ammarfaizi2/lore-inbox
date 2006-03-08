Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWCHBRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWCHBRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWCHBRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:17:36 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:42848 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750952AbWCHBRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:17:35 -0500
X-IronPort-AV: i="4.02,173,1139212800"; 
   d="scan'208"; a="260258587:sNHT45303676"
To: "David S. Miller" <davem@davemloft.net>
Cc: mlleinin@hpcn.ca.sandia.gov, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       shemminger@osdl.org
Subject: Re: [openib-general] Re: TSO and IPoIB performance degradation
X-Message-Flag: Warning: May contain useful information
References: <1141767891.6119.903.camel@localhost>
	<20060307134907.733d3d27@localhost.localdomain>
	<1141776697.6119.938.camel@localhost>
	<20060307.161808.60227862.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 07 Mar 2006 17:17:30 -0800
In-Reply-To: <20060307.161808.60227862.davem@davemloft.net> (David S. Miller's message of "Tue, 07 Mar 2006 16:18:08 -0800 (PST)")
Message-ID: <adaacc1raz9.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Mar 2006 01:17:31.0954 (UTC) FILETIME=[12F49920:01C6424E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> How limited are the IPoIB devices, TX descriptor wise?

    David> One side effect of the TSO changes is that one extra
    David> descriptor will be used for outgoing packets.  This is
    David> because we have to put the headers as well as the user
    David> data, into page based buffers now.

We have essentially no limit on TX descriptors.  However I think
there's some confusion about TSO: IPoIB does _not_ do TSO -- generic
InfiniBand hardware does not have any TSO capability.  In the future
we might be able to implement TSO for certain hardware that does have
support, but even that requires some firmware help from the from the
HCA vendors, etc.  So right now the IPoIB driver does not do TSO.

The reason TSO comes up is that reverting the patch described below
helps (or helped at some point at least) IPoIB throughput quite a bit.
Clearly this was a bug fix so we can't revert it in general but I
think what Michael Tsirkin was suggesting at the beginning of this
thread is to do what the last paragraph of the changelog says -- find
some way to re-enable the trick.

diff-tree 3143241... (from e16fa6b...)
Author: David S. Miller <davem@davemloft.net>
Date:   Mon May 23 12:03:06 2005 -0700

    [TCP]: Fix stretch ACK performance killer when doing ucopy.

    When we are doing ucopy, we try to defer the ACK generation to
    cleanup_rbuf().  This works most of the time very well, but if the
    ucopy prequeue is large, this ACKing behavior kills performance.

    With TSO, it is possible to fill the prequeue so large that by the
    time the ACK is sent and gets back to the sender, most of the window
    has emptied of data and performance suffers significantly.

    This behavior does help in some cases, so we should think about
    re-enabling this trick in the future, using some kind of limit in
    order to avoid the bug case.

 - R.
