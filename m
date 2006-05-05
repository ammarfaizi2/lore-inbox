Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWEEOtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWEEOtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWEEOtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:49:15 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:39089 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751572AbWEEOtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:49:14 -0400
X-IronPort-AV: i="4.05,93,1146466800"; 
   d="scan'208"; a="426534853:sNHT25013272"
To: Heiko J Schick <schihei@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
X-Message-Flag: Warning: May contain useful information
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com>
	<445B4DA9.9040601@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 05 May 2006 07:49:10 -0700
In-Reply-To: <445B4DA9.9040601@de.ibm.com> (Heiko J. Schick's message of "Fri, 05 May 2006 15:05:45 +0200")
Message-ID: <adafyjomsrd.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 May 2006 14:49:11.0943 (UTC) FILETIME=[125EB170:01C67053]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Heiko> Originaly, we had the same idea as you mentioned, that it
    Heiko> would be better to do this in the higher levels. The point
    Heiko> is that we can't see so far any simple posibility how this
    Heiko> can done in the OpenIB stack, the TCP/IP network layer or
    Heiko> somewhere in the Linux kernel.

    Heiko> For example: For IPoIB we get the best throughput when we
    Heiko> do the CQ callbacks on different CPUs and not to stay on
    Heiko> the same CPU.

So why not do it in IPoIB then?  This approach is not optimal
globally.  For example, uverbs event dispatch is just going to queue
an event and wake up the process waiting for events, and doing this on
some random CPU not related to the where the process will run is
clearly the worst possible way to dispatch the event.

    Heiko> In other papers and slides (see [1]) you can see similar
    Heiko> approaches.

    Heiko> [1]: Speeding up Networking, Van Jacobson and Bob
    Heiko> Felderman,
    Heiko> http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf

I think you've misunderstood this paper.  It's about maximizing CPU
locality and pushing processing directly into the consumer.  In the
context of slide 9, what you've done is sort of like adding another
control loop inside the kernel, since you dispatch from interrupt
handler to driver thread to final consumer.  So I would argue that
your approach is exactly the opposite of what VJ is advocating.

 - R.
