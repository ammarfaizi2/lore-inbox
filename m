Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVITSsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVITSsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVITSsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:48:15 -0400
Received: from ppp-62-11-78-183.dialup.tiscali.it ([62.11.78.183]:13248 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965071AbVITSsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:48:14 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 7/7] Add a note about partially hardcoded VM_* flags
Date: Tue, 20 Sep 2005 20:46:03 +0200
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050920184602.14557.43517.stgit@zion.home.lan>
In-Reply-To: <20050920184513.14557.8152.stgit@zion.home.lan>
References: <20050920184513.14557.8152.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Hugh made me note this line for permission checking in mprotect():

		if ((newflags & ~(newflags >> 4)) & 0xf) {

after figuring out what's that about, I decided it's nasty enough. Btw Hugh
itself didn't like the 0xf.

We can safely change it to VM_READ|VM_WRITE|VM_EXEC because we never change
VM_SHARED, so no need to check that.

CC: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/linux/mm.h |    1 +
 mm/mprotect.c      |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -136,6 +136,7 @@ extern unsigned int kobjsize(const void 
 #define VM_EXEC		0x00000004
 #define VM_SHARED	0x00000008
 
+/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
 #define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
 #define VM_MAYWRITE	0x00000020
 #define VM_MAYEXEC	0x00000040
diff --git a/mm/mprotect.c b/mm/mprotect.c
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -248,7 +248,8 @@ sys_mprotect(unsigned long start, size_t
 
 		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC));
 
-		if ((newflags & ~(newflags >> 4)) & 0xf) {
+		/* newflags >> 4 shift VM_MAY% in place of VM_% */
+		if ((newflags & ~(newflags >> 4)) & (VM_READ | VM_WRITE | VM_EXEC)) {
 			error = -EACCES;
 			goto out;
 		}

