Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWFFRUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWFFRUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWFFRUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:20:50 -0400
Received: from gold.veritas.com ([143.127.12.110]:7841 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750719AbWFFRUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:20:50 -0400
X-IronPort-AV: i="4.05,214,1146466800"; 
   d="scan'208"; a="60258233:sNHT31772632"
Date: Tue, 6 Jun 2006 18:20:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Christoph Lameter <clameter@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, mbligh@google.com, apw@shadowen.org,
       mbligh@mbligh.org, linux-kernel@vger.kernel.org, ak@suse.de,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606061805380.28806@blonde.wat.veritas.com>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Jun 2006 17:20:49.0621 (UTC) FILETIME=[8E3A3050:01C6898D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006, Christoph Lameter wrote:
> On Tue, 6 Jun 2006, Hugh Dickins wrote:
> 
> > Not really (though the clarity and reassurance of the additional
> > MAX_SWAPFILES test is good).  We went over it a year or two back,
> > and the macro contortions do involve MAX_SWAPFILES_SHIFT: which
> > up to and including 2.6.17 has enforced the MAX_SWAPFILES limit.
> 
> It looks though as if the testers were able to define more than 32 swap 
> devices. So there is the danger of overwriting the memory 
> following the swap info if we do not fix this.
> 
> Where are the macro contortions? No arch uses MAX_SWAPFILES_SHIFT for its 
> definitions and the only other significant use is in swapops.h to 
> determine the shift.

I'll go mad if I try to work it out again: I was as worried as you
when I discovered that test in sys_swapon a year or so ago, apparently
without any check on MAX_SWAPFILES; and went moaning to Andrew.  But
once I'd worked through swp_type, pte_to_swp_entry, swp_entry_to_pte,
swp_entry, I did come to the conclusion that the MAX_SWAPFILES bound
was actually safely built in there.

It's those four in swapops.h, and their concatenation in sys_swapon,
that I meant by "macro contortions"; and I think they are safe (or
were prior to swapless migration's -2), whatever the arch does for
the __ones (which drive me even further insane).

Have you no mercy?  Oh, wasn't it rendered safe by the:

#define SWP_TYPE_SHIFT(e) (sizeof(e.val) * 8 - MAX_SWAPFILES_SHIFT)
static inline unsigned swp_type(swp_entry_t entry)
{
	return (entry.val >> SWP_TYPE_SHIFT(entry));
}

Hugh
