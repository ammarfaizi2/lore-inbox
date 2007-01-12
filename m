Return-Path: <linux-kernel-owner+w=401wt.eu-S1750997AbXALMZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbXALMZo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 07:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbXALMZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 07:25:44 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:23509 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbXALMZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 07:25:43 -0500
In-Reply-To: <adaslehibjh.fsf@cisco.com>
Subject: Re: [PATCH/RFC 2.6.21 2/5] ehca: ehca_uverbs.c: "proper" use of mmap
To: Roland Dreier <rdreier@cisco.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OFF6353D7D.25679E15-ONC1257261.00429991-C1257261.0044415A@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 12 Jan 2007 13:25:31 +0100
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF882 | September 26, 2006) at
 12/01/2007 13:25:39
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roland Dreier wrote on 11.01.2007 20:54:58:

>  > >  int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct
*vma)
>  > >  {
>  >
>  > Can you split this monster routine into individual functions for
>  > each type of mmap please?  With two helpers to get and verify the
cq/qp
>  > shared by the individual sub-variants, that would also help to get rid
>  > of all those magic offsets.
>  >
>  > Actually, this routine directly comes from ib_device.mmap - Roland,
>  > can you shed some light on what's going on here?
>
> Each userspace-accessible IB device gets a single device node like
> /dev/infiniband/uverbsX.  Opening that gives userspace a "context".
> One of the things userspace can do with that fd is mmap() on it --
> that was originally envisioned as a way to map a page of hardware
> registers directly in to the userspace process.
>
> It seems ehca needs to allocate lots of different things in the kernel
> via mmap().  What you're saying I guess is that ideally each of these
> would be mmap() on a different fd rather than using different
> offsets.  It's a little awkward to open multiple device nodes to get
> multiple fds, since there's not a good way to attach them all to the
> same context.  I guess we could create some hack to return more file
> handles, but I think that cure is worse than the disease of using
> magic offsets...
>
> Maybe longer term we need to look at a scheme like cell's spufs but
> I'm still not confident we have the RDMA interface quite ready to
> freeze at the system call level.
>
>  - R.

...as Roland mentions, we're not completely free to change the filehandle
usage,
it's shared by ~5 drivers now.

I'd say lets investigate the direction of an own filesystem unless
there's no other clean solution.
We can polish the current version a bit, but that won't change the "magic
offsets".

Roland, could you take this patchset into your tree?
We hope it adresses the major security concern and vm_insert_page.

We're preparing the next patch for the yield deadlock topic with this
patchset as prereq.

Gruss / Regards . . . Christoph Raisch

