Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbWCWUG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWCWUG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWCWUG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:06:27 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:13268 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422666AbWCWUG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:06:26 -0500
Date: Thu, 23 Mar 2006 15:06:10 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 6/10] 64 bit resources drivers pcmcia changes
Message-ID: <20060323200610.GJ7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <20060323200119.GF7175@in.ibm.com> <20060323200227.GG7175@in.ibm.com> <20060323200342.GH7175@in.ibm.com> <20060323200451.GI7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323200451.GI7175@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes required in drivers/pcmcia/* to support 64 bit resources.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/pcmcia/i82365.c         |    5 +++--
 drivers/pcmcia/pd6729.c         |    3 ++-
 drivers/pcmcia/rsrc_nonstatic.c |   25 +++++++++++++------------
 drivers/pcmcia/tcic.c           |    5 +++--
 4 files changed, 21 insertions(+), 17 deletions(-)

diff -puN drivers/pcmcia/i82365.c~64bit-resources-drivers-pcmcia-changes drivers/pcmcia/i82365.c
--- linux-2.6.16-mm1/drivers/pcmcia/i82365.c~64bit-resources-drivers-pcmcia-changes	2006-03-23 11:39:11.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pcmcia/i82365.c	2006-03-23 11:39:11.000000000 -0500
@@ -1083,9 +1083,10 @@ static int i365_set_mem_map(u_short sock
     u_short base, i;
     u_char map;
     
-    debug(1, "SetMemMap(%d, %d, %#2.2x, %d ns, %#lx-%#lx, "
+    debug(1, "SetMemMap(%d, %d, %#2.2x, %d ns, %#llx-%#llx, "
 	  "%#x)\n", sock, mem->map, mem->flags, mem->speed,
-	  mem->res->start, mem->res->end, mem->card_start);
+	  (unsigned long long)mem->res->start,
+	  (unsigned long long)mem->res->end, mem->card_start);
 
     map = mem->map;
     if ((map > 4) || (mem->card_start > 0x3ffffff) ||
diff -puN drivers/pcmcia/pd6729.c~64bit-resources-drivers-pcmcia-changes drivers/pcmcia/pd6729.c
--- linux-2.6.16-mm1/drivers/pcmcia/pd6729.c~64bit-resources-drivers-pcmcia-changes	2006-03-23 11:39:11.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pcmcia/pd6729.c	2006-03-23 11:39:11.000000000 -0500
@@ -642,7 +642,8 @@ static int __devinit pd6729_pci_probe(st
 		goto err_out_free_mem;
 
 	printk(KERN_INFO "pd6729: Cirrus PD6729 PCI to PCMCIA Bridge "
-		"at 0x%lx on irq %d\n",	pci_resource_start(dev, 0), dev->irq);
+		"at 0x%llx on irq %d\n",
+		(unsigned long long)pci_resource_start(dev, 0), dev->irq);
  	/*
 	 * Since we have no memory BARs some firmware may not
 	 * have had PCI_COMMAND_MEMORY enabled, yet the device needs it.
diff -puN drivers/pcmcia/rsrc_nonstatic.c~64bit-resources-drivers-pcmcia-changes drivers/pcmcia/rsrc_nonstatic.c
--- linux-2.6.16-mm1/drivers/pcmcia/rsrc_nonstatic.c~64bit-resources-drivers-pcmcia-changes	2006-03-23 11:39:11.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pcmcia/rsrc_nonstatic.c	2006-03-23 11:39:11.000000000 -0500
@@ -72,7 +72,7 @@ static DEFINE_MUTEX(rsrc_mutex);
 ======================================================================*/
 
 static struct resource *
-make_resource(unsigned long b, unsigned long n, int flags, char *name)
+make_resource(u64 b, u64 n, int flags, char *name)
 {
 	struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
 
@@ -86,8 +86,7 @@ make_resource(unsigned long b, unsigned 
 }
 
 static struct resource *
-claim_region(struct pcmcia_socket *s, unsigned long base, unsigned long size,
-	     int type, char *name)
+claim_region(struct pcmcia_socket *s, u64 base, u64 size, int type, char *name)
 {
 	struct resource *res, *parent;
 
@@ -518,11 +517,10 @@ struct pcmcia_align_data {
 };
 
 static void
-pcmcia_common_align(void *align_data, struct resource *res,
-		    unsigned long size, unsigned long align)
+pcmcia_common_align(void *align_data, struct resource *res, u64 size, u64 align)
 {
 	struct pcmcia_align_data *data = align_data;
-	unsigned long start;
+	u64 start;
 	/*
 	 * Ensure that we have the correct start address
 	 */
@@ -533,8 +531,7 @@ pcmcia_common_align(void *align_data, st
 }
 
 static void
-pcmcia_align(void *align_data, struct resource *res,
-	     unsigned long size, unsigned long align)
+pcmcia_align(void *align_data, struct resource *res, u64 size, u64 align)
 {
 	struct pcmcia_align_data *data = align_data;
 	struct resource_map *m;
@@ -808,8 +805,10 @@ static int nonstatic_autoadd_resources(s
 		if (res->flags & IORESOURCE_IO) {
 			if (res == &ioport_resource)
 				continue;
-			printk(KERN_INFO "pcmcia: parent PCI bridge I/O window: 0x%lx - 0x%lx\n",
-			       res->start, res->end);
+			printk(KERN_INFO "pcmcia: parent PCI bridge I/O "
+				"window: 0x%llx - 0x%llx\n",
+				(unsigned long long)res->start,
+				(unsigned long long)res->end);
 			if (!adjust_io(s, ADD_MANAGED_RESOURCE, res->start, res->end))
 				done |= IORESOURCE_IO;
 
@@ -818,8 +817,10 @@ static int nonstatic_autoadd_resources(s
 		if (res->flags & IORESOURCE_MEM) {
 			if (res == &iomem_resource)
 				continue;
-			printk(KERN_INFO "pcmcia: parent PCI bridge Memory window: 0x%lx - 0x%lx\n",
-			       res->start, res->end);
+			printk(KERN_INFO "pcmcia: parent PCI bridge Memory "
+				"window: 0x%llx - 0x%llx\n",
+				(unsigned long long)res->start,
+				(unsigned long long)res->end);
 			if (!adjust_memory(s, ADD_MANAGED_RESOURCE, res->start, res->end))
 				done |= IORESOURCE_MEM;
 		}
diff -puN drivers/pcmcia/tcic.c~64bit-resources-drivers-pcmcia-changes drivers/pcmcia/tcic.c
--- linux-2.6.16-mm1/drivers/pcmcia/tcic.c~64bit-resources-drivers-pcmcia-changes	2006-03-23 11:39:11.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/pcmcia/tcic.c	2006-03-23 11:39:11.000000000 -0500
@@ -756,8 +756,9 @@ static int tcic_set_mem_map(struct pcmci
     u_long base, len, mmap;
 
     debug(1, "SetMemMap(%d, %d, %#2.2x, %d ns, "
-	  "%#lx-%#lx, %#x)\n", psock, mem->map, mem->flags,
-	  mem->speed, mem->res->start, mem->res->end, mem->card_start);
+	  "%#llx-%#llx, %#x)\n", psock, mem->map, mem->flags,
+	  mem->speed, (unsigned long long)mem->res->start,
+	  (unsigned long long)mem->res->end, mem->card_start);
     if ((mem->map > 3) || (mem->card_start > 0x3ffffff) ||
 	(mem->res->start > 0xffffff) || (mem->res->end > 0xffffff) ||
 	(mem->res->start > mem->res->end) || (mem->speed > 1000))
_
