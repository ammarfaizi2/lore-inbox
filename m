Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWHCA0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWHCA0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWHCAZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:25:57 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:51673 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1750961AbWHCAZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:25:50 -0400
Message-Id: <20060803002518.595166293@xensource.com>
References: <20060803002510.634721860@xensource.com>
User-Agent: quilt/0.45-1
Date: Wed, 02 Aug 2006 17:25:17 -0700
From: Jeremy Fitzhardinge <jeremy@xensource.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>
Subject: [patch 7/8] Add a bootparameter to reserve high linear address space.
Content-Disposition: inline; filename=fixmap-bootparam.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bootparameter to reserve high linear address space for hypervisors.
This is necessary to allow dynamically loaded hypervisor modules, which
might not happen until userspace is already running, and also provides a
useful tool to benchmark the performance impact of reduced lowmem address
space.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 Documentation/kernel-parameters.txt |    5 +++++
 arch/i386/kernel/setup.c            |   19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

===================================================================
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1357,6 +1357,11 @@ running once the system is up.
 
 	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 
+	reservetop=	[IA-32]
+			Format: nn[KMG]
+			Reserves a hole at the top of the kernel virtual
+			address space.
+
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
 
===================================================================
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -160,6 +160,12 @@ static char command_line[COMMAND_LINE_SI
 static char command_line[COMMAND_LINE_SIZE];
 
 unsigned char __initdata boot_params[PARAM_SIZE];
+
+static int __init setup_reservetop(char *s)
+{
+	return 1;
+}
+__setup("reservetop", setup_reservetop);
 
 static struct resource data_resource = {
 	.name	= "Kernel data",
@@ -917,6 +923,19 @@ static void __init parse_cmdline_early (
 		else if (!memcmp(from, "vmalloc=", 8))
 			__VMALLOC_RESERVE = memparse(from+8, &from);
 
+		/*
+		 * reservetop=size reserves a hole at the top of the kernel
+		 * address space which a hypervisor can load into later.
+		 * Needed for dynamically loaded hypervisors, so relocating
+		 * the fixmap can be done before paging initialization.
+		 * This hole must be a multiple of 4M.
+		 */
+		else if (!memcmp(from, "reservetop=", 11)) {
+			unsigned long reserve = memparse(from+11, &from);
+			reserve &= ~0x3fffff;
+			reserve_top_address(reserve);
+		}
+
 	next_char:
 		c = *(from++);
 		if (!c)

--

