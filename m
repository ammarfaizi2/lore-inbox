Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWCPXvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWCPXvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWCPXvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:51:54 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:17967 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751227AbWCPXvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:51:53 -0500
X-IronPort-AV: i="4.03,103,1141632000"; 
   d="scan'208"; a="416773138:sNHT26129488"
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, "Bryan O'Sullivan" <bos@pathscale.com>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Remapping pages mapped to userspace (was: [PATCH 10 of 20] ipath - support for userspace apps using core driver)
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org>
	<Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Mar 2006 15:51:51 -0800
In-Reply-To: <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com> (Hugh Dickins's message of "Thu, 16 Mar 2006 14:24:47 +0000 (GMT)")
Message-ID: <adad5gmne20.fsf_-_@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Mar 2006 23:51:52.0575 (UTC) FILETIME=[995D58F0:01C64954]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Err, sorry about the empty mail...]

Anyway, I'd like to hijack this thread slightly, since we are close to
a subject that I've been thinking about lately, and I'd like to take
advantage of the expert's attention...

My mthca driver (drivers/infiniband/hw/mthca) supports mapping some
MMIO registers into userspace via io_remap_pfn_range() in a .mmap
method.  I think I have that pretty well under control.

However, on a hot unplug event, when the underlying PCI device is
going away, I would like to replace that mapping with a mapping (with
a mapping to the zero page?), so that userspace accesses after the
device is gone don't explode.  What's the "right" way to do that?

Presumably it would be something like zeromap_page_range(), but that's
not exported to modules.  Exporting that would be one option, but in a
way that's overkill for me: I only have a single page to deal with, so
I could also do something like

	vm_insert_page(vma, addr, ZERO_PAGE(addr));

But do I have to do anything to kill the old mapping coming from
remap_pfn_range()?  What's the exported API to do that?

I can keep a list of vmas that have registers mapped to userspace and
iterate through it on hot unplug.  The only question is what to do
with those vmas.

Thanks,
  Roland
