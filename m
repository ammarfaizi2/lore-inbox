Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWCOTbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWCOTbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 14:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWCOTbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 14:31:35 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:42155 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751224AbWCOTbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 14:31:34 -0500
Date: Wed, 15 Mar 2006 14:31:14 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Message-ID: <20060315193114.GA7465@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Is there a reason why "start" and "end" field of "struct resource" are of
type unsigned long. My understanding is that "struct resource" can be used
to represent any system resource including physical memory. But unsigned
long is not suffcient to represent memory more than 4GB on PAE systems. 

Currently /proc/iomem exports physical memory also apart from io device
memory. But on i386, it truncates any memory more than 4GB. This leads
to problems for kexec/kdump.

- Kexec reads /proc/iomem to determine the system memory layout and prepares
  a memory map based on that and passes it to the kernel being kexeced. Given
  the fact that memory more than 4GB has been truncated, new kernel never
  gets to see and use that memory.

- Kdump also reads /proc/iomem to determine the physical memory layout of
  the system and encodes this informaiton in ELF headers. After a crash
  new kernel parses these ELF headers being used by previous kernel and
  vmcore is prepared accordingly. As memory more than 4GB has been truncated,
  kdump never sees that memory and never prepares ELF headers for it. Hence
  vmcore is truncated and limited to 4GB even if there is more physical
  memory in the system.

One of the possible solutions to this problem is that expand the size
of "start" and "end" to "unsigned long long". But whole of the PCI and
driver code has been written assuming start and end to be unsigned long
and compiler starts throwing warnings. 
 
I am attaching a prototype patch which does minimal changes to make memory
more than 4GB appear in /proc/iomem. It does not take care of modifying
in tree drivers to supress warnings. 

Looking for your suggestion what's the best way to handle this issue. If
above approach seems reasonable then I can go ahead and do the changes 
for in tree drivers to handle the warnings.

Thanks
Vivek
-   


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="struct-resource-start-field-expansion.patch"



Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/setup.c |    2 --
 include/linux/ioport.h   |    2 +-
 kernel/resource.c        |    8 ++++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff -puN include/linux/ioport.h~struct-resource-start-field-expansion include/linux/ioport.h
--- linux-2.6.16-rc6-1M/include/linux/ioport.h~struct-resource-start-field-expansion	2006-03-15 14:25:46.000000000 -0500
+++ linux-2.6.16-rc6-1M-root/include/linux/ioport.h	2006-03-15 14:25:46.000000000 -0500
@@ -15,7 +15,7 @@
  */
 struct resource {
 	const char *name;
-	unsigned long start, end;
+	unsigned long long start, end;
 	unsigned long flags;
 	struct resource *parent, *sibling, *child;
 };
diff -puN kernel/resource.c~struct-resource-start-field-expansion kernel/resource.c
--- linux-2.6.16-rc6-1M/kernel/resource.c~struct-resource-start-field-expansion	2006-03-15 14:25:46.000000000 -0500
+++ linux-2.6.16-rc6-1M-root/kernel/resource.c	2006-03-15 14:25:46.000000000 -0500
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(ioport_resource);
 struct resource iomem_resource = {
 	.name	= "PCI mem",
 	.start	= 0UL,
-	.end	= ~0UL,
+	.end	= ~0ULL,
 	.flags	= IORESOURCE_MEM,
 };
 
@@ -83,7 +83,7 @@ static int r_show(struct seq_file *m, vo
 	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
 		if (p->parent == root)
 			break;
-	seq_printf(m, "%*s%0*lx-%0*lx : %s\n",
+	seq_printf(m, "%*s%0*Lx-%0*Lx : %s\n",
 			depth * 2, "",
 			width, r->start,
 			width, r->end,
@@ -151,8 +151,8 @@ __initcall(ioresources_init);
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
-	unsigned long start = new->start;
-	unsigned long end = new->end;
+	unsigned long long start = new->start;
+	unsigned long long end = new->end;
 	struct resource *tmp, **p;
 
 	if (end < start)
diff -puN arch/i386/kernel/setup.c~struct-resource-start-field-expansion arch/i386/kernel/setup.c
--- linux-2.6.16-rc6-1M/arch/i386/kernel/setup.c~struct-resource-start-field-expansion	2006-03-15 14:25:46.000000000 -0500
+++ linux-2.6.16-rc6-1M-root/arch/i386/kernel/setup.c	2006-03-15 14:25:46.000000000 -0500
@@ -1286,8 +1286,6 @@ legacy_init_iomem_resources(struct resou
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
-		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
-			continue;
 		res = alloc_bootmem_low(sizeof(struct resource));
 		switch (e820.map[i].type) {
 		case E820_RAM:	res->name = "System RAM"; break;
_

--UlVJffcvxoiEqYs2--
