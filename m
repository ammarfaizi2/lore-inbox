Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161309AbWHJOWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbWHJOWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbWHJOWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:22:32 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48295 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1161309AbWHJOWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:22:25 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-kernel@vger.kernel.org
Reply-To: catalin.marinas@gmail.com
Subject: [PATCH] Fix memory leak in vc_resize/vc_allocate
Date: Thu, 10 Aug 2006 15:22:21 +0100
Message-Id: <20060810142221.31793.20635.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
X-OriginalArrivalTime: 10 Aug 2006 14:22:22.0329 (UTC) FILETIME=[6508D690:01C6BC88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

Memory leaks can happen in the vc_resize() function in drivers/char/vt.c
because of the vc->vc_screenbuf variable overriding in vc_allocate(). The
kmemleak reported trace is as follows:

  <__kmalloc>
  <vc_resize>
  <fbcon_init>
  <visual_init>
  <vc_allocate>
  <con_open>
  <tty_open>
  <chrdev_open>

This patch no longer allocates a screen buffer in vc_allocate() if it was
already allocated by vc_resize().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 drivers/char/vt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index da7e66a..31c8b32 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -730,7 +730,8 @@ int vc_allocate(unsigned int currcons)	/
 	    visual_init(vc, currcons, 1);
 	    if (!*vc->vc_uni_pagedir_loc)
 		con_set_default_unimap(vc);
-	    vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
+	    if (!vc->vc_kmalloced)
+		vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
 	    if (!vc->vc_screenbuf) {
 		kfree(vc);
 		vc_cons[currcons].d = NULL;
