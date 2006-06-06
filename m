Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWFFRk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWFFRk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFFRk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:40:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32390 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750726AbWFFRkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:40:55 -0400
Date: Tue, 6 Jun 2006 10:39:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, mbligh@google.com, apw@shadowen.org,
       mbligh@mbligh.org, linux-kernel@vger.kernel.org, ak@suse.de,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <Pine.LNX.4.64.0606061805380.28806@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0606061023080.27969@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <44848DD2.7010506@shadowen.org> <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
 <20060605135812.30138205.akpm@osdl.org> <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606061805380.28806@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006, Hugh Dickins wrote:

> I'll go mad if I try to work it out again: I was as worried as you
> when I discovered that test in sys_swapon a year or so ago, apparently
> without any check on MAX_SWAPFILES; and went moaning to Andrew.  But
> once I'd worked through swp_type, pte_to_swp_entry, swp_entry_to_pte,
> swp_entry, I did come to the conclusion that the MAX_SWAPFILES bound
> was actually safely built in there.

I do not think we want anyone go mad so could be simplify this whole m***
so that mere mortals can comprehend what is going on while reading the 
source?

> Have you no mercy?  Oh, wasn't it rendered safe by the:

Ok. So we have a mystical expression here that needs to be explained:

swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))

swp_entry(~0L,0) ->
swp_entry(0xffffffffffffffff, 0) ->
0xfffffffffffffff << SWP_TYPE_SHIFT ->
0x1f

Ok we got the highest swap type and this encodes MAX_SWAPFILES_SHIFT and 
therefore limits the number of swap 

But now we convert this to a arch specific pte. The hope is that the arch
will mask off any unsupported bits? This is done by s390?

Then we convert the result back into a swap entry and take its type which 
will hopefully give us the maximum number of swap devices supported by the 
arch?

Would it not be better for an arch to explicitly tell us how many swap 
devices are supported? Then we could make the swap_info array shorter and 
get rid of this cryptic test.

This test also creates a problem for the migration entries: It is really 
not clear until runtime how many swap devices are supported so we cannot 
take the last 2 for page migration. In order for page migration to work 
all NUMA arches that do not support 32 swap devices need to define 
CONFIG_MIGRATION=n. Seems that this is only s390?



