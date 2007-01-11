Return-Path: <linux-kernel-owner+w=401wt.eu-S1751436AbXAKTkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbXAKTkS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbXAKTkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:40:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50259 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbXAKTkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:40:02 -0500
Date: Thu, 11 Jan 2007 19:40:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21 2/5] ehca: ehca_uverbs.c: "proper" use of mmap
Message-ID: <20070111194000.GE24623@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
	openib-general@openib.org, raisch@de.ibm.com
References: <200701112008.15841.hnguyen@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701112008.15841.hnguyen@linux.vnet.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 08:08:15PM +0100, Hoang-Nam Nguyen wrote:
> +static void mm_open(struct vm_area_struct *vma)

This should be name ehca_vma_open, dito for mm_close/ehca_vma_close and
vm_ops/ehca_vm_ops.

> +	u32 *count = (u32*)vma->vm_private_data;

No need for the cast here (both in the open and close routine)

> +	for (ofs = 0; ofs < queue->queue_length; ofs += PAGE_SIZE) {
> +		u64 virt_addr = (u64)ipz_qeit_calc(queue, ofs);
> +		page = virt_to_page(virt_addr);
> +		rc = vm_insert_page(vma, start, page);
> +		if (unlikely(rc)) {
> +			ehca_gen_err("vm_insert_page() failed rc=%x", rc);
> +			return rc;
> +		}
> +		start +=  PAGE_SIZE;

Not required for now, but long term you really should rework your
whole queue abstraction to operate on an array of struct pages, that
makes things like this and various other bits in ipz_pt_fn.[ch] a lot
simpler.

>  int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>  {

Can you split this monster routine into individual functions for
each type of mmap please?  With two helpers to get and verify the cq/qp
shared by the individual sub-variants, that would also help to get rid
of all those magic offsets.

Actually, this routine directly comes from ib_device.mmap - Roland,
can you shed some light on what's going on here?

Also after applying this patch I have a prototype and various callers
for ehca_mmap_nopage but no actual implementation.  Could it be that
there are some bits missing?
