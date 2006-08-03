Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWHCI6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWHCI6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 04:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWHCI6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 04:58:34 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:44182 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932403AbWHCI6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 04:58:33 -0400
Message-ID: <44D1BAB8.8070509@vmware.com>
Date: Thu, 03 Aug 2006 01:58:32 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: jeremy@xensource.com, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, chrisw@sous-sol.org
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
 space.
References: <20060803002510.634721860@xensource.com>	<20060803002518.595166293@xensource.com>	<20060802231912.ed77f930.akpm@osdl.org>	<44D1A6B6.8040003@vmware.com> <20060803004144.554d9882.akpm@osdl.org>
In-Reply-To: <20060803004144.554d9882.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040401020401080801010806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040401020401080801010806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> The comment says "must".  If that's true then printing a what-you-did-wrong
> message and halting is appropriate.
>
> But whatever.  The issue is flagged and I'm happy to leave it in Jeremy's
> lap. 

Considering I wrote that patch, I think I should fix it -- here you go

--------------040401020401080801010806
Content-Type: text/plain;
 name="fixmap-bootparam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fixmap-bootparam.patch"

Subject: Add a bootparameter to reserve high linear address space.

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

diff -r 5bb2fc59943d Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Thu Aug 03 01:36:13 2006 -0700
+++ b/Documentation/kernel-parameters.txt	Thu Aug 03 01:36:13 2006 -0700
@@ -1357,6 +1357,11 @@ running once the system is up.
 
 	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 
+	reservetop=	[IA-32]
+			Format: nn[KMG]
+			Reserves a hole at the top of the kernel virtual
+			address space.
+
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
 
diff -r 5bb2fc59943d arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Thu Aug 03 01:36:13 2006 -0700
+++ b/arch/i386/kernel/setup.c	Thu Aug 03 01:36:52 2006 -0700
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
@@ -917,6 +923,17 @@ static void __init parse_cmdline_early (
 		else if (!memcmp(from, "vmalloc=", 8))
 			__VMALLOC_RESERVE = memparse(from+8, &from);
 
+		/*
+		 * reservetop=size reserves a hole at the top of the kernel
+		 * address space which a hypervisor can load into later.
+		 * Needed for dynamically loaded hypervisors, so relocating
+		 * the fixmap can be done before paging initialization.
+		 */
+		else if (!memcmp(from, "reservetop=", 11)) {
+			unsigned long reserve = memparse(from+11, &from);
+			reserve_top_address(reserve);
+		}
+
 	next_char:
 		c = *(from++);
 		if (!c)

--------------040401020401080801010806--
