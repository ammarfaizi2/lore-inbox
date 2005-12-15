Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVLOHZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVLOHZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 02:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVLOHZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 02:25:15 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:63301 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S965161AbVLOHZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 02:25:14 -0500
Date: Thu, 15 Dec 2005 16:25:11 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] mark TAINT_FORCED_RMMOD correctly
Message-ID: <20051215072511.GA6624@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently TAINT_FORCED_RMMOD is totally unused.
Because it is marked as TAINT_FORCED_MODULE instead when user
forced a module unload.
This patch marks it correctly

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

--- 2.6-rc/kernel/module.c.orig	2005-12-15 15:38:49.000000000 +0900
+++ 2.6-rc/kernel/module.c	2005-12-15 15:41:48.000000000 +0900
@@ -496,15 +496,15 @@ static void module_unload_free(struct mo
 }
 
 #ifdef CONFIG_MODULE_FORCE_UNLOAD
-static inline int try_force(unsigned int flags)
+static inline int try_force_unload(unsigned int flags)
 {
 	int ret = (flags & O_TRUNC);
 	if (ret)
-		add_taint(TAINT_FORCED_MODULE);
+		add_taint(TAINT_FORCED_RMMOD);
 	return ret;
 }
 #else
-static inline int try_force(unsigned int flags)
+static inline int try_force_unload(unsigned int flags)
 {
 	return 0;
 }
@@ -524,7 +524,7 @@ static int __try_stop_module(void *_sref
 
 	/* If it's not unused, quit unless we are told to block. */
 	if ((sref->flags & O_NONBLOCK) && module_refcount(sref->mod) != 0) {
-		if (!(*sref->forced = try_force(sref->flags)))
+		if (!(*sref->forced = try_force_unload(sref->flags)))
 			return -EWOULDBLOCK;
 	}
 
@@ -609,7 +609,7 @@ sys_delete_module(const char __user *nam
 	/* If it has an init func, it must have an exit func to unload */
 	if ((mod->init != NULL && mod->exit == NULL)
 	    || mod->unsafe) {
-		forced = try_force(flags);
+		forced = try_force_unload(flags);
 		if (!forced) {
 			/* This module can't be removed */
 			ret = -EBUSY;
