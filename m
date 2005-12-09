Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVLISVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVLISVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVLISUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:20:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:65229 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964850AbVLIST6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:19:58 -0500
Message-Id: <20051209182053.486222000@localhost>
References: <20051209180414.872465000@localhost>
Date: Fri, 09 Dec 2005 19:04:15 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 1/8] spufs: fix module refcount race
Content-Disposition: inline; filename=spufs-modcount-fix.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the two users of spufs_calls.owner still has a race
when calling try_module_get while the module is removed.
This makes it use the correct instance of owner.

Noticed by Milton Miller.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_syscalls.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spu_syscalls.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -40,7 +40,7 @@ asmlinkage long sys_spu_create(const cha
 	struct module *owner = spufs_calls.owner;
 
 	ret = -ENOSYS;
-	if (owner && try_module_get(spufs_calls.owner)) {
+	if (owner && try_module_get(owner)) {
 		ret = spufs_calls.create_thread(name, flags, mode);
 		module_put(owner);
 	}

--

