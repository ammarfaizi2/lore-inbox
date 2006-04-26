Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWDZWMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWDZWMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 18:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWDZWMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 18:12:19 -0400
Received: from amdext4.amd.com ([163.181.251.6]:46798 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S964896AbWDZWMR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 18:12:17 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] i386: PAE entries must have their low word cleared
 first
Date: Wed, 26 Apr 2006 17:11:19 -0500
Message-ID: <99F8FA0D1537DC4EB2A639E8E60D782A6288D0@SAUSEXMB3.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] i386: PAE entries must have their low word cleared
 first
Thread-Index: AcZpcKae7BtFqFoyQDmNUHL28drdpQACiB5Q
From: "Brunner, Richard" <Richard.Brunner@amd.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Keir Fraser" <Keir.Fraser@cl.cam.ac.uk>
cc: "Hugh Dickins" <hugh@veritas.com>, "Jan Beulich" <jbeulich@novell.com>,
       "Zachary Amsden" <zach@vmware.com>, linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 26 Apr 2006 22:11:22.0224 (UTC)
 FILETIME=[59EE8F00:01C6697E]
X-WSS-ID: 68512F834KW4350472-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 

> Nick Piggin wrote
> 
> Keir Fraser wrote:
> > 
> > [snip]
> > 
> > In more detail the problem is that, since we're still running on the 
> > page tables while clearing them, the CPU may choose to prefetch a 
> > half-cleared pte into its TLB, and then execute speculative memory 
> > accesses based on that mapping (including ones that may write-allocate 
> > cachelines, leading to problems like the AMD AGP GART deadlock Linux had 
> > a year or so back).
> 
> What do you mean, you're still running on the page tables? The CPU can
> still walk the pagetables?
> 
> Because if ptep_get_and_clear_full is passed non zero in the full
> argument, then that specific translation should never see another
> access. I didn't know CPUs now actually resolve TLB misses as part of
> speculative prefetching... does this really happen?

Yes, on AMD processors, speculative execution is allowed to install TLB translations. Assuming you are not in 64-bit mode, and can not use
mmx or sse instructions to zero out the naturally aligned 64-bit pte,
then what is being suggested makes sense: clear out the valid bit
first by writing the low 32-bits. No invalid translations are ever 
installed in the TLB.


> Do you have a pointer to where the AMD AGP GART deadlock was 
> discussed? Google is having some trouble finding it.

http://marc.theaimsgroup.com/?l=linux-kernel&m=102376926732464&w=2


> > The barrier is needed to ensure that the bottom half is  cleared before 
> > the top half. In fact it probably ought to be wmb() -- 
> that's clearer in intent and actually reduces to barrier() on all PAE capable platforms.

Maybe the barrier is needed for other architectures, but two writes
to WB memory are not going to happen out of order and so no
barrier is needed on x86 to the best of my knowledge.
 

	-Rich Brunner, AMD


