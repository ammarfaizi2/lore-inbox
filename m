Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbUK3DIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUK3DIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbUK3DIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:08:46 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:40926 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261933AbUK3DIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:08:42 -0500
Date: Tue, 30 Nov 2004 04:08:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN
Message-ID: <20041130030812.GN4365@dualathlon.random>
References: <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> <E1CVI5c-0004bf-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVI5c-0004bf-00@mta1.cl.cam.ac.uk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 11:22:51PM +0000, Ian Pratt wrote:
> 
> This patch modifies /dev/mem to call io_remap_page_range rather than
> remap_pfn_range under CONFIG_XEN.  This is required because in arch

Why don't we change /dev/mem to use io_remap_page_range unconditionally
for ranges above high_memory? Clearly io_remap_page_range can map device
space, and I guess that's what io_remap_page_range is there for. sparc
and sparc64 are the only two ones implementing io_remap_page_range, so
maybe Dave or Wli can tell us if there's any penalty in using
io_remap_page_range in mmap(/dev/mmap) for phys ranges above
high_memory. I don't know the sparc architectural details of mk_pte_io
invoked by io_remap_page_range of the sparc arch.

There's also an issue with io_remap_page_range where sparc has 6 args
while everyone else has 5 args. It's perfectly fine that sparc will be
the only one parsing the last value, but we should pass that last value
to all archs, so that people can avoid writing code like the below
(drivers/char/drm):

#ifdef __sparc__
		if (io_remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
					VM_OFFSET(vma) + offset,
					vma->vm_end - vma->vm_start,
					vma->vm_page_prot, 0))
#else
		if (remap_pfn_range(DRM_RPR_ARG(vma) vma->vm_start,
				     (VM_OFFSET(vma) + offset) >> PAGE_SHIFT,
				     vma->vm_end - vma->vm_start,
				     vma->vm_page_prot))
#endif

Thanks.
