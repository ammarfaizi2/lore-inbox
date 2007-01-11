Return-Path: <linux-kernel-owner+w=401wt.eu-S1751450AbXAKTzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbXAKTzB (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbXAKTzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:55:01 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:45403 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbXAKTzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:55:00 -0500
X-IronPort-AV: i="4.13,174,1167638400"; 
   d="scan'208"; a="100631194:sNHT56073330"
To: Christoph Hellwig <hch@infradead.org>
Cc: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21 2/5] ehca: ehca_uverbs.c: "proper" use of mmap
X-Message-Flag: Warning: May contain useful information
References: <200701112008.15841.hnguyen@linux.vnet.ibm.com>
	<20070111194000.GE24623@infradead.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 11 Jan 2007 11:54:58 -0800
In-Reply-To: <20070111194000.GE24623@infradead.org> (Christoph Hellwig's message of "Thu, 11 Jan 2007 19:40:00 +0000")
Message-ID: <adaslehibjh.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Jan 2007 19:54:59.0093 (UTC) FILETIME=[5FCEDC50:01C735BA]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > >  int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 > >  {
 > 
 > Can you split this monster routine into individual functions for
 > each type of mmap please?  With two helpers to get and verify the cq/qp
 > shared by the individual sub-variants, that would also help to get rid
 > of all those magic offsets.
 > 
 > Actually, this routine directly comes from ib_device.mmap - Roland,
 > can you shed some light on what's going on here?

Each userspace-accessible IB device gets a single device node like
/dev/infiniband/uverbsX.  Opening that gives userspace a "context".
One of the things userspace can do with that fd is mmap() on it --
that was originally envisioned as a way to map a page of hardware
registers directly in to the userspace process.

It seems ehca needs to allocate lots of different things in the kernel
via mmap().  What you're saying I guess is that ideally each of these
would be mmap() on a different fd rather than using different
offsets.  It's a little awkward to open multiple device nodes to get
multiple fds, since there's not a good way to attach them all to the
same context.  I guess we could create some hack to return more file
handles, but I think that cure is worse than the disease of using
magic offsets...

Maybe longer term we need to look at a scheme like cell's spufs but
I'm still not confident we have the RDMA interface quite ready to
freeze at the system call level.

 - R.
