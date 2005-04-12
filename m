Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVDLLKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVDLLKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbVDLLKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:10:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:21706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262249AbVDLKdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:04 -0400
Message-Id: <200504121032.j3CAWwfR005732@shell0.pdx.osdl.net>
Subject: [patch 146/198] pci enumeration on ixp2000: overflow in kernel/resource.c
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, buytenh@wantstofly.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Lennert Buytenhek <buytenh@wantstofly.org>

IXP2000 (ARM-based) platforms use a separate 'struct resource' for PCI MEM
space.  Resource allocation for PCI BARs always fails because the 'root'
resource (the IXP2000 PCI MEM resource) always has the entire address space
(00000000-ffffffff) free, and find_resource() calculates the size of that
range as ffffffff-00000000+1=0, so all allocations fail because it thinks
there is no space.

(akpm: pls. double-check)

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/resource.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/resource.c~pci-enumeration-on-ixp2000-overflow-in-kernel-resourcec kernel/resource.c
--- 25/kernel/resource.c~pci-enumeration-on-ixp2000-overflow-in-kernel-resourcec	2005-04-12 03:21:38.435293848 -0700
+++ 25-akpm/kernel/resource.c	2005-04-12 03:21:38.438293392 -0700
@@ -266,7 +266,7 @@ static int find_resource(struct resource
 		new->start = (new->start + align - 1) & ~(align - 1);
 		if (alignf)
 			alignf(alignf_data, new, size, align);
-		if (new->start < new->end && new->end - new->start + 1 >= size) {
+		if (new->start < new->end && new->end - new->start >= size - 1) {
 			new->end = new->start + size - 1;
 			return 0;
 		}
_
