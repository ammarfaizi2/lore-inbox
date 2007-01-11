Return-Path: <linux-kernel-owner+w=401wt.eu-S1751407AbXAKTLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbXAKTLT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXAKTLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:11:19 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:42308 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbXAKTLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:11:18 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH/RFC 2.6.21 0/5] ehca: remove use of do_mmap() from kernel space
Date: Thu, 11 Jan 2007 20:07:33 +0100
User-Agent: KMail/1.8.2
Cc: raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701112007.33854.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland and Christoph H.!
Here is a set of patches for ehca, whose main purpose is to remove unproper use of
do_mmap() in ehca kernel space as suggested by Christoph H. Other "small" changes
are:
* Remove "dead" prototype declarations (those without code implementation)

Now detail on mmap() rework:
- For eHCA hardware register block we use remap_pfn_range() as previously.
- For queue pages we call pattern vm_insert_page() to register each allocated
kernel page.
- For each mmap-ed resource (hardware register block, send/recv and completion
queue) we introduce a use counter that is incremented and decremented by
the call-backs open()/close(). Destroying a completion queue or queue pair
will succeed only if all associated counters are zero. That means those resources
must be mmap-ed and munmap-ed properly in user space.
The actual calls of mmap64() and munmap() are done then in ehca user space lib,
ie. libehca, for which I will send a separate patch for another review (by ofed
group).

Thanks
Nam


 ehca_classes.h |   29 +-----
 ehca_cq.c      |   65 +++-----------
 ehca_iverbs.h  |   10 --
 ehca_main.c    |    6 -
 ehca_qp.c      |   78 +++--------------
 ehca_uverbs.c  |  253 ++++++++++++++++++---------------------------------------
 6 files changed, 121 insertions(+), 320 deletions(-)
