Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWHEV66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWHEV66 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 17:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWHEV66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 17:58:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932531AbWHEV65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 17:58:57 -0400
Date: Sat, 5 Aug 2006 14:58:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: jeremy@xensource.com, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, chrisw@sous-sol.org
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
 space.
Message-Id: <20060805145840.653912a2.akpm@osdl.org>
In-Reply-To: <44D1BAB8.8070509@vmware.com>
References: <20060803002510.634721860@xensource.com>
	<20060803002518.595166293@xensource.com>
	<20060802231912.ed77f930.akpm@osdl.org>
	<44D1A6B6.8040003@vmware.com>
	<20060803004144.554d9882.akpm@osdl.org>
	<44D1BAB8.8070509@vmware.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2006 01:58:32 -0700
Zachary Amsden <zach@vmware.com> wrote:

> Add a bootparameter to reserve high linear address space for hypervisors.
> This is necessary to allow dynamically loaded hypervisor modules, which
> might not happen until userspace is already running, and also provides a
> useful tool to benchmark the performance impact of reduced lowmem address
> space.

Andi has gone and rotorooted the x86 boot parameter handling in there. 
This patch now looks like this:


From: Zachary Amsden <zach@vmware.com>

Add a boot parameter to reserve high linear address space for hypervisors. 
This is necessary to allow dynamically loaded hypervisor modules, which might
not happen until userspace is already running, and also provides a useful tool
to benchmark the performance impact of reduced lowmem address space.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/kernel-parameters.txt |    5 +++++
 arch/i386/kernel/setup.c            |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff -puN arch/i386/kernel/setup.c~x86-add-a-bootparameter-to-reserve-high-linear-address-space arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c~x86-add-a-bootparameter-to-reserve-high-linear-address-space
+++ a/arch/i386/kernel/setup.c
@@ -149,6 +149,12 @@ static char command_line[COMMAND_LINE_SI
 
 unsigned char __initdata boot_params[PARAM_SIZE];
 
+static int __init setup_reservetop(char *s)
+{
+	return 1;
+}
+__setup("reservetop", setup_reservetop);
+
 static struct resource data_resource = {
 	.name	= "Kernel data",
 	.start	= 0,
@@ -814,6 +820,24 @@ static int __init parse_vmalloc(char *ar
 early_param("vmalloc", parse_vmalloc);
 
 /*
+ * reservetop=size reserves a hole at the top of the kernel address space which
+ * a hypervisor can load into later.  Needed for dynamically loaded hypervisors,
+ * so relocating the fixmap can be done before paging initialization.
+ */
+static int __init parse_reservetop(char *arg)
+{
+	unsigned long address;
+
+	if (!arg)
+		return -EINVAL;
+
+	address = memparse(arg, &arg);
+	reserve_top_address(address);
+	return 0;
+}
+early_param("reservetop", parse_reservetop);
+
+/*
  * Callback for efi_memory_walk.
  */
 static int __init
diff -puN Documentation/kernel-parameters.txt~x86-add-a-bootparameter-to-reserve-high-linear-address-space Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt~x86-add-a-bootparameter-to-reserve-high-linear-address-space
+++ a/Documentation/kernel-parameters.txt
@@ -1357,6 +1357,11 @@ running once the system is up.
 
 	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 
+	reservetop=	[IA-32]
+			Format: nn[KMG]
+			Reserves a hole at the top of the kernel virtual
+			address space.
+
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
 
_

