Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVCRTrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVCRTrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVCRTpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:45:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:63122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262011AbVCRTkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:40:15 -0500
Date: Fri, 18 Mar 2005 11:25:45 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: akpm <akpm@osdl.org>, davem@davemloft.net, wli <wli@holomorphy.com>,
       riel@redhat.com, kurt@garloff.de, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: [PATCH 0/4] io_remap_pfn_range: intro.
Message-Id: <20050318112545.6f5f7635.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a combination of io_remap_pfn_range patches posted in the
last week or so by Keir Fraser and me.

This description is mostly from Keir's original post.


This patch introduces a new interface function for mapping bus/device
memory: io_remap_pfn_range. This accepts the same parameters as
remap_pfn_range and io_remap_page_range but should be used in any
situation where the caller is not simply remapping ordinary RAM.
For example, when mapping device registers the new function should be used.

The distinction between remapping device memory and ordinary RAM is
critical for the Xen hypervisor.

This patch series also cleans up the remaining users of
io_remap_page_range (in particular, the several sparc-specific
sections in various drivers that use a special form of io_remap_page_range:
an extra <iospace> argument for SPARC arch.) by converting them to
use io_remap_pfn_range(), where io_remap_pfn_range() supports
passing <iospace> as part of the pfn argument.

The sparc32 & sparc64 code needs live testing.


(from Keir:)
I have audited the drivers/ and sound/ directories. Most uses of
remap_pfn_range are okay, but there are a small handful that are
remapping device memory (mostly AGP and DRM drivers).

Of particular driver is the HPET driver, whose mmap function is broken
even for native (non-Xen) builds. If nothing else, vmalloc_to_phys
should be used instead of __pa to convert an ioremapped virtual
address to a valid physical address. The fix in this patch is to
remember the original bus address as probed at boot time and to pass
this to io_remap_pfn_range.


---
~Randy
