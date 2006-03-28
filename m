Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWC2ABk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWC2ABk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWC2ABk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:01:40 -0500
Received: from [151.97.230.9] ([151.97.230.9]:29377 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964859AbWC2ABj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:01:39 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/7] uml idle thread needn't take access to init_mm
Date: Wed, 29 Mar 2006 01:56:50 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060328235650.13838.60908.stgit@zion.home.lan>
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Comparing this code which is the actual body of the arch-independent cpu_idle(),
it is clear that it's unnecessary to set ->mm and ->active_mm; beyond that, a
kernel thread is not supposed to have ->mm != NULL, only active_mm.

This showed up because I used the assumption (which is IMHO valid) that kernel
thread have their ->mm == NULL, and it failed for this thread.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/process_kern.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
index 3113cab..f9948fd 100644
--- a/arch/um/kernel/process_kern.c
+++ b/arch/um/kernel/process_kern.c
@@ -185,10 +185,6 @@ void default_idle(void)
 {
 	CHOOSE_MODE(uml_idle_timer(), (void) 0);
 
-	atomic_inc(&init_mm.mm_count);
-	current->mm = &init_mm;
-	current->active_mm = &init_mm;
-
 	while(1){
 		/* endless idle loop with no priority at all */
 
