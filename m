Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUJYVMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUJYVMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUJYVKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:10:40 -0400
Received: from fmr03.intel.com ([143.183.121.5]:58596 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262009AbUJYVGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:06:36 -0400
Message-Id: <200410252103.i9PL3Mq08901@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@SGI.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Hugepages demand paging V1 [4/4]: Numa patch
Date: Mon, 25 Oct 2004 14:05:56 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcS4b6KYBIroaEV4S/mU/jIdbX9V5QCYvIAg
In-Reply-To: <Pine.LNX.4.58.0410221235300.9549@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Friday, October 22, 2004 12:37 PM
> > On Thu, Oct 21, 2004 at 09:58:54PM -0700, Christoph Lameter wrote:
> > > Changelog
> > > 	* NUMA enhancements (rough first implementation)
> > > 	* Do not begin search for huge page memory at the first node
> > > 	  but start at the current node and then search previous and
> > > 	  the following nodes for memory.
> > > Signed-off-by: Christoph Lameter <clameter@sgi.com>
> >
> > dequeue_huge_page() seems to want a nodemask, not a vma, though I
> > suppose it's not particularly pressing.
>
> How about this variation following __alloc_page:
>
> @@ -32,14 +32,17 @@
> +	struct zonelist *zonelist = NODE_DATA(nid)->node_zonelists;
> +	struct zone **zones = zonelist->zones;
> +	struct zone *z;
> +	int i;
> +
> +	for(i=0; (z = zones[i])!= NULL; i++) {
> +		nid = z->zone_pgdat->node_id;
> +		if (list_empty(&hugepage_freelists[node_id]))
> +			break;
>  	}

Must be typos in the if statement.  Two fatal errors here:  You don't
really mean to break out of the for loop if there are no hugetlb page
on that node, do you?  The variable name to index into the freelist is
wrong, should be nid, otherwise this code won't compile.  That line
should be this:

+		if (!list_empty(&hugepage_freelists[nid]))


Also this is generic code, we should consider scanning ZONE_HIGHMEM
zonelist. Otherwise, this will likely screw up x86 numa machine.

- Ken


