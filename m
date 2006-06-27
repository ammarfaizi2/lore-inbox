Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWF0QjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWF0QjB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWF0QiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:38:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:46314 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161180AbWF0QiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:38:02 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 17/17] [PATCH] i386: export memory more than 4G through /proc/iomem
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:53 -0700
Message-Id: <11514260903519-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260871162-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com> <11514260483754-git-send-email-greg@kroah.com> <11514260513485-git-send-email-greg@kroah.com> <11514260543854-git-send-email-greg@kroah.com> <11514260583661-git-send-email-greg@kroah.com> <11514260612035-git-send-email-greg@kroah.com> <11514260651070-git-send-email-greg@kroah.com> <11514260692919-git-send-email-greg@kroah.com> <11514260722341-git-send-email-greg@kroah.com> <11514260761750-git-send-email-greg@kroah.com> <115142608072-git-send-email-greg@kroah.com> <11514260843959-git-send-email-greg@kroah.com> <11514260871162-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Goyal <vgoyal@in.ibm.com>

Currently /proc/iomem exports physical memory also apart from io device
memory.  But on i386, it truncates any memory more than 4GB.  This leads to
problems for kexec/kdump.

Kexec reads /proc/iomem to determine the system memory layout and prepares a
memory map based on that and passes it to the kernel being kexeced.  Given the
fact that memory more than 4GB has been truncated, new kernel never gets to
see and use that memory.

Kdump also reads /proc/iomem to determine the physical memory layout of the
system and encodes this informaiton in ELF headers.  After a crash new kernel
parses these ELF headers being used by previous kernel and vmcore is prepared
accordingly.  As memory more than 4GB has been truncated, kdump never sees
that memory and never prepares ELF headers for it.  Hence vmcore is truncated
and limited to 4GB even if there is more physical memory in the system.

This patch exports memory more than 4GB through /proc/iomem on i386.

Cc: Maneesh Soni <maneesh@in.ibm.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/i386/kernel/setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 4a65040..6712f0d 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -1314,8 +1314,10 @@ legacy_init_iomem_resources(struct resou
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
+#ifndef CONFIG_RESOURCES_64BIT
 		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
 			continue;
+#endif
 		res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
 		switch (e820.map[i].type) {
 		case E820_RAM:	res->name = "System RAM"; break;
-- 
1.4.0

