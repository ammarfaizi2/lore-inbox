Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVCQQV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVCQQV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 11:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVCQQV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 11:21:58 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:26899 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261941AbVCQQVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 11:21:55 -0500
Message-ID: <4239AE80.1070403@shadowen.org>
Date: Thu, 17 Mar 2005 16:21:20 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Hansen <haveblue@us.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH 0/4] sparsemem intro patches
References: <1110834883.19340.47.camel@localhost> <20050314183042.7e7087a2.akpm@osdl.org>
In-Reply-To: <20050314183042.7e7087a2.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> 
>> The following four patches provide the last needed changes before the
>> introduction of sparsemem.  For a more complete description of what this
>> will do, please see this patch:
>>
>> http://www.sr71.net/patches/2.6.11/2.6.11-bk7-mhp1/broken-out/B-sparse-150-sparsemem.patch

> I don't know what to think about this.  Can you describe sparsemem a little
> further, differentiate it from discontigmem and tell us why we want one? 
> Is it for memory hotplug?  If so, how does it support hotplug?

SPARSEMEM was born out of discussions which followed the OLS last year 
over the NONLINEAR memory model which was being proposed for hotplug. 
We got interested as it appeared that a simple form of NONLINEAR memory 
could help us handle some problematics cases with DISCONTIG memory. 
Particularly the case where we have large intra-node memory holes.

The DISCONTIGMEM memory model appears to have been designed to handle 
discontiguous UMA configuration.  It was subsequently put into service 
to provide node support under NUMA configurations.  This dual use seems 
to have led to confusing code and compromises on functionality.  In its 
current form we can only express inter-node memory spaces, making it 
majorly inefficient for NUMA systems with sparse physical inter-node 
memory maps, effectivly not supporting some configurations.  Also, 
although DISCONTIGMEM is a common model between a number of 
architectures there is almost no code overlap.

SPARSEMEM essentially is a replacement for DISCONTIGMEM providing 
support for non-contigious memory but with the advantage of handling 
both inter- and intra-node memory holes.  The goal of the implementation 
was to design a clean memory memory model covering the needs of both UMA 
and NUMA discontigouos memory layouts whilst providing a basis for 
hotplug.  This should allow us to consolidate the implementation of 
various "discontiguous" memory model whilst trying to fix its short comings.

Hotplug at its most complex puts two requirements on the memory model. 
Firstly, It requires the arbirary replacement of physical memory with 
memory which may be at a different address (the breaking of V=P+c) to 
cope with the case of memory replacement under unmovable kernel objects. 
  Secondly, it requires we cope with memory "all over" the physical map. 
  SPARSEMEM is geared towards providing the required infrastructure for 
NONLINEAR memory needed in hotplug.  The idea being that NONLINEAR would 
be layered on top of it and share its implementation.

-apw.
