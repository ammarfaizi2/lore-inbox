Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVLOVQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVLOVQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVLOVQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:16:35 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:1378 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751090AbVLOVQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:16:34 -0500
X-IronPort-AV: i="3.99,258,1131350400"; 
   d="scan'208"; a="378856971:sNHT1615907338"
To: Keith Owens <kaos@sgi.com>
Cc: paulmck@us.ibm.com, Andi Kleen <ak@suse.de>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb()
X-Message-Flag: Warning: May contain useful information
References: <17158.1134512861@ocs3.ocs.com.au>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 15 Dec 2005 13:15:38 -0800
In-Reply-To: <17158.1134512861@ocs3.ocs.com.au> (Keith Owens's message of
 "Wed, 14 Dec 2005 09:27:41 +1100")
Message-ID: <adairtqnjt1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 15 Dec 2005 21:15:39.0025 (UTC) FILETIME=[B2B3E010:01C601BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Keith> Why does mmiowb() map to empty on most systems, including
    Keith> Alpha?  Should it not map to wmb() for everything except
    Keith> IA64 and MIPS?

I think the intention (as spelled out in Documentation/DocBook/deviceiobook.tmpl)
is that mmiowb() must be used in conjunction with spinlocks or some
other SMP synchronization mechanism.  The locks themselves are
sufficient ordering on the archs where mmiowb() is a NOP.

One way of thinking about this is that the usually barrier operations
like wmb() affect the order of a single CPU's operations -- that is,
wmb() is saying that all writes from the current thread of execution
before the wmb() become visible before any of the writes from the
current after the wmb().  But wmb() doesn't say anything about how one
CPU's writes are ordered against anything a different CPU does.

mmiowb() is something else -- it controls the visibility of writes
from different CPUs.  It says that all writes before the mmiowb()
become visible before any writes from any CPU after the mmiowb().
However, this isn't sensible unless we can order the writes between
CPUs, and that only makes sense if there's a lock that lets us say
that one CPU is executing something after the mmiowb().

 - R.
