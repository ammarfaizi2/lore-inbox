Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUJVGLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUJVGLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269692AbUJVGIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 02:08:45 -0400
Received: from fmr04.intel.com ([143.183.121.6]:42476 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269527AbUJVGFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 02:05:54 -0400
Message-Id: <200410220603.i9M63Dq25144@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "William Lee Irwin III" <wli@holomorphy.com>, <raybry@sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Hugepages demand paging V1 [4/4]: Numa patch
Date: Thu, 21 Oct 2004 23:05:19 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcS39jdfU1LNc3nQSNO8wr+eEA7USgABhM/Q
In-Reply-To: <Pine.LNX.4.58.0410212158290.3524@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, October 21, 2004 9:59 PM
> Changelog
> 	* NUMA enhancements (rough first implementation)
> 	* Do not begin search for huge page memory at the first node
> 	  but start at the current node and then search previous and
> 	  the following nodes for memory.
>
> -static struct page *dequeue_huge_page(void)
> +static struct page *dequeue_huge_page(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	int nid = numa_node_id();
> +	int tid, nid2;
>  	struct page *page = NULL;
>
>  	if (list_empty(&hugepage_freelists[nid])) {
> -		for (nid = 0; nid < MAX_NUMNODES; ++nid)
> -			if (!list_empty(&hugepage_freelists[nid]))
> -				break;
> +		/* Prefer the neighboring nodes */
> +		for (tid =1 ; tid < MAX_NUMNODES; tid++) {
> +
> +			/* Is there space in a following node ? */
> +			nid2 = (nid + tid) % MAX_NUMNODES;
> +			if (mpol_node_valid(nid2, vma, addr) &&
> +				!list_empty(&hugepage_freelists[nid2]))
> +					break;
> +
> +			/* or in an previous node ? */
> +			if (tid > nid) continue;
> +			nid2 = nid - tid;
> +			if (mpol_node_valid(nid2, vma, addr) &&
> +				!list_empty(&hugepage_freelists[nid2]))
> +					break;

Are you sure about this?  Looked flawed to me.  Logical node number
does not directly correlate to numa memory hierarchy.

- Ken


