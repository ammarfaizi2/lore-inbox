Return-Path: <linux-kernel-owner+w=401wt.eu-S932473AbXAHILK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbXAHILK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXAHILJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:11:09 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:48567 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbXAHILH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:11:07 -0500
Date: Mon, 8 Jan 2007 13:41:04 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/4] make initkmem_list3 non init data to fix modpost warning
Message-ID: <20070108081104.GD7889@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o MODPOST generates warning for i386 if kernel is compiled with
  CONFIG_RELOCATABLE=y

WARNING: vmlinux - Section mismatch: reference to .init.data:initkmem_list3 from .text between 'set_up_list3s' (at offset 0xc01536d9) and 's_start'

o I don't know the code well but looks like this is a bug.  initkmem_list3
  is of type __initdata, and it is accessed by non init functions.

	kmem_cache_create()
		setup_cpu_cache()
			set_up_list3s()
				{
					Accesses initkmem_list3[]
				}

o Somebody who knows this code well needs to review and ack.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 mm/slab.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN mm/slab.c~make-initkmem_list3-non-init mm/slab.c
--- linux-2.6.20-rc2-mm1-reloc/mm/slab.c~make-initkmem_list3-non-init	2007-01-04 16:51:02.000000000 +0530
+++ linux-2.6.20-rc2-mm1-reloc-root/mm/slab.c	2007-01-04 16:51:02.000000000 +0530
@@ -305,7 +305,7 @@ struct kmem_list3 {
  * Need this for bootstrapping a per node allocator.
  */
 #define NUM_INIT_LISTS (2 * MAX_NUMNODES + 1)
-struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
+struct kmem_list3 initkmem_list3[NUM_INIT_LISTS];
 #define	CACHE_CACHE 0
 #define	SIZE_AC 1
 #define	SIZE_L3 (1 + MAX_NUMNODES)
_
