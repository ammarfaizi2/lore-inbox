Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVHBVxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVHBVxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVHBVxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:53:03 -0400
Received: from fmr13.intel.com ([192.55.52.67]:61842 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261838AbVHBVvH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:51:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] optimize writer path in time_interpolator_get_counter()
Date: Tue, 2 Aug 2005 14:50:57 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F040BF5AD@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] optimize writer path in time_interpolator_get_counter()
Thread-Index: AcWXp/wgMfPTOyufSOqwkbBXjyz8PAAAOVKw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Christoph Lameter" <clameter@engr.sgi.com>
Cc: "Alex Williamson" <alex.williamson@hp.com>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
X-OriginalArrivalTime: 02 Aug 2005 21:50:57.0119 (UTC) FILETIME=[436B1EF0:01C597AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm still seeing the asymmetric behavior where cpu3 sees the really high times,
>> while cpu0,1,2 are seeing peaks of 170us, which is still not pretty.
>
>Is this an SMP system? Updates are performed by cpu0 and therefore the 
>cacheline is mostly exclusively owned by that processor and then later 
>forced to become shared by processors 1,2,3.

Yes this is an SMP system (Intel Tiger4).  Cpu0 is the boot cpu, and is
indeed the one that takes the write lock, and thus the fast-return from
the get_counter() code.  I'm just very confused as to why I only see these
10X worse outliers on cpu3.  There doesn't seem to be anything special
about it (/proc/interrupts shows similar stuff happening on each cpu).

>We can still switch on the nojitter by default if the ITC's are guaranteed 
>to be properly synchronized which will make all this ugliness go away. 

What do you mean by "properly synchronized"?  We can't get them
completely in step ... but we do know that they are very close.
Closer than the microsecond granularity that most users (gettimeofday)
are going to pass back to the caller.  But running with "nojitter" will
occasionally result in time (as seen on two different processors) sometimes
jumping back by a microsecond.  How bad is this in practice?  I can
see that a user that simply subtracts two times may sometimes see an
answer of minus one micro-second ... but does this hurt?

-Tony
