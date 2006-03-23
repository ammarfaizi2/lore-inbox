Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWCWULp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWCWULp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWCWULp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:11:45 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:24271 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964935AbWCWULo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:11:44 -0500
Date: Thu, 23 Mar 2006 15:11:34 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 10/10] i386: export memory more than 4G through /proc/iomem
Message-ID: <20060323201134.GN7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <20060323200119.GF7175@in.ibm.com> <20060323200227.GG7175@in.ibm.com> <20060323200342.GH7175@in.ibm.com> <20060323200451.GI7175@in.ibm.com> <20060323200610.GJ7175@in.ibm.com> <20060323200744.GK7175@in.ibm.com> <20060323200902.GL7175@in.ibm.com> <20060323201018.GM7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323201018.GM7175@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Currently /proc/iomem exports physical memory also apart from io device
  memory. But on i386, it truncates any memory more than 4GB. This leads
  to problems for kexec/kdump.

o Kexec reads /proc/iomem to determine the system memory layout and prepares
  a memory map based on that and passes it to the kernel being kexeced. Given
  the fact that memory more than 4GB has been truncated, new kernel never
  gets to see and use that memory.

o Kdump also reads /proc/iomem to determine the physical memory layout of
  the system and encodes this informaiton in ELF headers. After a crash
  new kernel parses these ELF headers being used by previous kernel and
  vmcore is prepared accordingly. As memory more than 4GB has been truncated,
  kdump never sees that memory and never prepares ELF headers for it. Hence
  vmcore is truncated and limited to 4GB even if there is more physical
  memory in the system.

o This patch exports memory more than 4GB through /proc/iomem on i386.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/setup.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN arch/i386/kernel/setup.c~i386-export-mem-more-than-4G-through-proc-iomem arch/i386/kernel/setup.c
--- linux-2.6.16-mm1/arch/i386/kernel/setup.c~i386-export-mem-more-than-4G-through-proc-iomem	2006-03-23 11:39:24.000000000 -0500
+++ linux-2.6.16-mm1-root/arch/i386/kernel/setup.c	2006-03-23 11:39:24.000000000 -0500
@@ -1295,8 +1295,6 @@ legacy_init_iomem_resources(struct resou
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
-		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
-			continue;
 		res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
 		switch (e820.map[i].type) {
 		case E820_RAM:	res->name = "System RAM"; break;
_
