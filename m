Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVIJSGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVIJSGg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVIJSEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:04:43 -0400
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]:33960 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932251AbVIJSEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:04:36 -0400
Message-Id: <20050910174629.286344000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
Date: Sat, 10 Sep 2005 19:44:57 +0200
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: [patch 5/7] uml: fix fault handler on write
Content-Disposition: inline; filename=uml-fix-fault-handler-on-write
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The UML fault handler was recently changed to enforce PROT_NONE protections,
by requiring VM_READ or VM_EXEC on VMA's.

However, by mistake, things were changed such that VM_READ is always checked,
also on write faults; so a VMA mapped with only PROT_WRITE is not readable
(unless it's prefaulted with MAP_POPULATE or with a write), which is different
from i386.

Discovered while testing remap_file_pages protection support.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/trap_kern.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -57,7 +57,8 @@ good_area:
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
 
-        if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
+	/* Don't require VM_READ|VM_EXEC for write faults! */
+        if(!is_write && !(vma->vm_flags & (VM_READ | VM_EXEC)))
                 goto out;
 
 	do {

--
