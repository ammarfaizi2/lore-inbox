Return-Path: <linux-kernel-owner+w=401wt.eu-S1750847AbXAKRKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbXAKRKy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbXAKRKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:10:54 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:60668 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbXAKRKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:10:53 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH 2.6.21 0/8] ehca: remove use of do_mmap() from kernel space and minor cleanup
Date: Thu, 11 Jan 2007 18:07:08 +0100
User-Agent: KMail/1.8.2
Cc: raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701111807.08593.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland and Christoph H.!
Here is a set of patches for ehca, whose main purpose is to remove unproper use of
do_mmap() in ehca kernel space as suggested by Christoph H. Other "small" changes
are:
* Remove "dead" prototype declarations (those without code implementation)
* Use SLAB_ defines instead GFP_ ones when allocating memory from slab cache

Actually I should separate those patches for more clarity. Unfortunately that
code cleanup above has been incorporated much earlier in our repository, and
I had not paid attention on when I started to rework the mmap() stuff. Sorry
for this inconvenience!

Now more detail on mmap() rework:
- For eHCA hardware register block we use remap_pfn_range() as previously.
- For queue pages we call pattern vm_insert_page() to register each allocated
kernel page.
- For each mmap-ed resource (hardware register block, send/recv and completion
queue) we introduce a use counter that is incremented and decremented by
the call-backs open()/close(). Destroying a completion queue or queue pair
will succeed only if all associated counters are zero. That means those resources
must be mmap-ed resp. munmap-ed properly by user space.

Thanks
Nam
