Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVHHUTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVHHUTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVHHUTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:19:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17625
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932247AbVHHUTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:19:13 -0400
Date: Mon, 08 Aug 2005 13:19:08 -0700 (PDT)
Message-Id: <20050808.131908.59030011.davem@davemloft.net>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PCI PATCH]: Make sparc64 use setup-res.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050808200251.GA2046@kroah.com>
References: <20050808194249.GA6729@kroah.com>
	<20050808.125432.74747546.davem@davemloft.net>
	<20050808200251.GA2046@kroah.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Mon, 8 Aug 2005 13:02:52 -0700

> On Mon, Aug 08, 2005 at 12:54:32PM -0700, David S. Miller wrote:
> > I even have a patch I'll submit to you which will get sparc64
> > converted over to using drivers/pci/setup-res.c so that none
> > of this kind of non-sense will occur in the future.
> 
> That sounds even better.

Ok, here is the patch.

There were three changes necessary in order to allow
sparc64 to use setup-res.c:

1) Sparc64 roots the PCI I/O and MEM address space using
   parent resources contained in the PCI controller structure.
   I'm actually surprised no other platforms do this, especially
   ones like Alpha and PPC{,64}.  These resources get linked into the
   iomem/ioport tree when PCI controllers are probed.

   So the hierarchy looks like this:

   iomem --|
	   PCI controller 1 MEM space --|
				        device 1
					device 2
					etc.
	   PCI controller 2 MEM space --|
				        ...
   ioport --|
            PCI controller 1 IO space --|
					...
            PCI controller 2 IO space --|
					...

   You get the idea.  The drivers/pci/setup-res.c code allocates
   using plain iomem_space and ioport_space as the root, so that
   wouldn't work with the above setup.

   So I added a pcibios_select_root() that is used to handle this.
   It uses the PCI controller struct's io_space and mem_space on
   sparc64, and io{port,mem}_resource on every other platform to
   keep current behavior.

2) quirk_io_region() is buggy.  It takes in raw BUS view addresses
   and tries to use them as a PCI resource.

   pci_claim_resource() expects the resource to be fully formed when
   it gets called.  The sparc64 implementation would do the translation
   but that's absolutely wrong, because if the same resource gets
   released then re-claimed we'll adjust things twice.

   So I fixed up quirk_io_region() to do the proper pcibios_bus_to_resource()
   conversion before passing it on to pci_claim_resource().

3) I was mistakedly __init'ing the function methods the PCI controller
   drivers provide on sparc64 to implement some parts of these
   routines.  This was, of course, easy to fix.

So we end up with the following, and that nasty SPARC64 makefile
ifdef in drivers/pci/Makefile is finally zapped.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -359,140 +359,17 @@ void pcibios_fixup_bus(struct pci_bus *p
 	pbus->resource[1] = &pbm->mem_space;
 }
 
-int pci_claim_resource(struct pci_dev *pdev, int resource)
+struct resource *pcibios_select_root(struct pci_dev *pdev, struct resource *r)
 {
 	struct pci_pbm_info *pbm = pdev->bus->sysdata;
-	struct resource *res = &pdev->resource[resource];
-	struct resource *root;
-
-	if (!pbm)
-		return -EINVAL;
+	struct resource *root = NULL;
 
-	if (res->flags & IORESOURCE_IO)
+	if (r->flags & IORESOURCE_IO)
 		root = &pbm->io_space;
-	else
+	if (r->flags & IORESOURCE_MEM)
 		root = &pbm->mem_space;
 
-	pbm->parent->resource_adjust(pdev, res, root);
-
-	return request_resource(root, res);
-}
-
-/*
- * Given the PCI bus a device resides on, try to
- * find an acceptable resource allocation for a
- * specific device resource..
- */
-static int pci_assign_bus_resource(const struct pci_bus *bus,
-	struct pci_dev *dev,
-	struct resource *res,
-	unsigned long size,
-	unsigned long min,
-	int resno)
-{
-	unsigned int type_mask;
-	int i;
-
-	type_mask = IORESOURCE_IO | IORESOURCE_MEM;
-	for (i = 0 ; i < 4; i++) {
-		struct resource *r = bus->resource[i];
-		if (!r)
-			continue;
-
-		/* type_mask must match */
-		if ((res->flags ^ r->flags) & type_mask)
-			continue;
-
-		/* Ok, try it out.. */
-		if (allocate_resource(r, res, size, min, -1, size, NULL, NULL) < 0)
-			continue;
-
-		/* PCI config space updated by caller.  */
-		return 0;
-	}
-	return -EBUSY;
-}
-
-void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno)
-{
-	/* Not implemented for sparc64... */
-	BUG();
-}
-
-int pci_assign_resource(struct pci_dev *pdev, int resource)
-{
-	struct pcidev_cookie *pcp = pdev->sysdata;
-	struct pci_pbm_info *pbm = pcp->pbm;
-	struct resource *res = &pdev->resource[resource];
-	unsigned long min, size;
-	int err;
-
-	if (res->flags & IORESOURCE_IO)
-		min = pbm->io_space.start + 0x400UL;
-	else
-		min = pbm->mem_space.start;
-
-	size = res->end - res->start + 1;
-
-	err = pci_assign_bus_resource(pdev->bus, pdev, res, size, min, resource);
-
-	if (err < 0) {
-		printk("PCI: Failed to allocate resource %d for %s\n",
-		       resource, pci_name(pdev));
-	} else {
-		/* Update PCI config space. */
-		pbm->parent->base_address_update(pdev, resource);
-	}
-
-	return err;
-}
-
-/* Sort resources by alignment */
-void pdev_sort_resources(struct pci_dev *dev, struct resource_list *head)
-{
-	int i;
-
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *r;
-		struct resource_list *list, *tmp;
-		unsigned long r_align;
-
-		r = &dev->resource[i];
-		r_align = r->end - r->start;
-		
-		if (!(r->flags) || r->parent)
-			continue;
-		if (!r_align) {
-			printk(KERN_WARNING "PCI: Ignore bogus resource %d "
-					    "[%lx:%lx] of %s\n",
-					    i, r->start, r->end, pci_name(dev));
-			continue;
-		}
-		r_align = (i < PCI_BRIDGE_RESOURCES) ? r_align + 1 : r->start;
-		for (list = head; ; list = list->next) {
-			unsigned long align = 0;
-			struct resource_list *ln = list->next;
-			int idx;
-
-			if (ln) {
-				idx = ln->res - &ln->dev->resource[0];
-				align = (idx < PCI_BRIDGE_RESOURCES) ?
-					ln->res->end - ln->res->start + 1 :
-					ln->res->start;
-			}
-			if (r_align > align) {
-				tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
-				if (!tmp)
-					panic("pdev_sort_resources(): "
-					      "kmalloc() failed!\n");
-				tmp->next = ln;
-				tmp->res = r;
-				tmp->dev = dev;
-				list->next = tmp;
-				break;
-			}
-		}
-	}
+	return root;
 }
 
 void pcibios_update_irq(struct pci_dev *pdev, int irq)
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -307,7 +307,7 @@ static unsigned char psycho_pil_table[] 
 /*0x32*/15,		/* Power Management		*/
 };
 
-static int __init psycho_ino_to_pil(struct pci_dev *pdev, unsigned int ino)
+static int psycho_ino_to_pil(struct pci_dev *pdev, unsigned int ino)
 {
 	int ret;
 
@@ -344,9 +344,9 @@ static int __init psycho_ino_to_pil(stru
 	return ret;
 }
 
-static unsigned int __init psycho_irq_build(struct pci_pbm_info *pbm,
-					    struct pci_dev *pdev,
-					    unsigned int ino)
+static unsigned int psycho_irq_build(struct pci_pbm_info *pbm,
+				     struct pci_dev *pdev,
+				     unsigned int ino)
 {
 	struct ino_bucket *bucket;
 	unsigned long imap, iclr;
@@ -1024,7 +1024,7 @@ static irqreturn_t psycho_pcierr_intr(in
 #define PSYCHO_CE_INO		0x2f
 #define PSYCHO_PCIERR_A_INO	0x30
 #define PSYCHO_PCIERR_B_INO	0x31
-static void __init psycho_register_error_handlers(struct pci_controller_info *p)
+static void psycho_register_error_handlers(struct pci_controller_info *p)
 {
 	struct pci_pbm_info *pbm = &p->pbm_A; /* arbitrary */
 	unsigned long base = p->pbm_A.controller_regs;
@@ -1091,15 +1091,15 @@ static void __init psycho_register_error
 }
 
 /* PSYCHO boot time probing and initialization. */
-static void __init psycho_resource_adjust(struct pci_dev *pdev,
-					  struct resource *res,
-					  struct resource *root)
+static void psycho_resource_adjust(struct pci_dev *pdev,
+				   struct resource *res,
+				   struct resource *root)
 {
 	res->start += root->start;
 	res->end += root->start;
 }
 
-static void __init psycho_base_address_update(struct pci_dev *pdev, int resource)
+static void psycho_base_address_update(struct pci_dev *pdev, int resource)
 {
 	struct pcidev_cookie *pcp = pdev->sysdata;
 	struct pci_pbm_info *pbm = pcp->pbm;
@@ -1144,7 +1144,7 @@ static void __init psycho_base_address_u
 		pci_write_config_dword(pdev, where + 4, 0);
 }
 
-static void __init pbm_config_busmastering(struct pci_pbm_info *pbm)
+static void pbm_config_busmastering(struct pci_pbm_info *pbm)
 {
 	u8 *addr;
 
@@ -1161,8 +1161,8 @@ static void __init pbm_config_busmasteri
 	pci_config_write8(addr, 64);
 }
 
-static void __init pbm_scan_bus(struct pci_controller_info *p,
-				struct pci_pbm_info *pbm)
+static void pbm_scan_bus(struct pci_controller_info *p,
+			 struct pci_pbm_info *pbm)
 {
 	struct pcidev_cookie *cookie = kmalloc(sizeof(*cookie), GFP_KERNEL);
 
@@ -1189,7 +1189,7 @@ static void __init pbm_scan_bus(struct p
 	pci_setup_busmastering(pbm, pbm->pci_bus);
 }
 
-static void __init psycho_scan_bus(struct pci_controller_info *p)
+static void psycho_scan_bus(struct pci_controller_info *p)
 {
 	pbm_config_busmastering(&p->pbm_B);
 	p->pbm_B.is_66mhz_capable = 0;
@@ -1204,7 +1204,7 @@ static void __init psycho_scan_bus(struc
 	psycho_register_error_handlers(p);
 }
 
-static void __init psycho_iommu_init(struct pci_controller_info *p)
+static void psycho_iommu_init(struct pci_controller_info *p)
 {
 	struct pci_iommu *iommu = p->pbm_A.iommu;
 	unsigned long tsbbase, i;
@@ -1327,8 +1327,8 @@ static void psycho_controller_hwinit(str
 	psycho_write(p->pbm_A.controller_regs + PSYCHO_PCIB_DIAG, tmp);
 }
 
-static void __init pbm_register_toplevel_resources(struct pci_controller_info *p,
-						   struct pci_pbm_info *pbm)
+static void pbm_register_toplevel_resources(struct pci_controller_info *p,
+					    struct pci_pbm_info *pbm)
 {
 	char *name = pbm->name;
 
@@ -1481,7 +1481,7 @@ static void psycho_pbm_init(struct pci_c
 
 #define PSYCHO_CONFIGSPACE	0x001000000UL
 
-void __init psycho_init(int node, char *model_name)
+void psycho_init(int node, char *model_name)
 {
 	struct linux_prom64_registers pr_regs[3];
 	struct pci_controller_info *p;
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -554,7 +554,7 @@ static unsigned char sabre_pil_table[] =
 /*0x32*/15,		/* Power Management		*/
 };
 
-static int __init sabre_ino_to_pil(struct pci_dev *pdev, unsigned int ino)
+static int sabre_ino_to_pil(struct pci_dev *pdev, unsigned int ino)
 {
 	int ret;
 
@@ -612,9 +612,9 @@ static void sabre_wsync_handler(struct i
 	sabre_read(sync_reg);
 }
 
-static unsigned int __init sabre_irq_build(struct pci_pbm_info *pbm,
-					   struct pci_dev *pdev,
-					   unsigned int ino)
+static unsigned int sabre_irq_build(struct pci_pbm_info *pbm,
+				    struct pci_dev *pdev,
+				    unsigned int ino)
 {
 	struct ino_bucket *bucket;
 	unsigned long imap, iclr;
@@ -1009,7 +1009,7 @@ static irqreturn_t sabre_pcierr_intr(int
 #define SABRE_UE_INO		0x2e
 #define SABRE_CE_INO		0x2f
 #define SABRE_PCIERR_INO	0x30
-static void __init sabre_register_error_handlers(struct pci_controller_info *p)
+static void sabre_register_error_handlers(struct pci_controller_info *p)
 {
 	struct pci_pbm_info *pbm = &p->pbm_A; /* arbitrary */
 	unsigned long base = pbm->controller_regs;
@@ -1056,9 +1056,9 @@ static void __init sabre_register_error_
 	sabre_write(base + SABRE_PCICTRL, tmp);
 }
 
-static void __init sabre_resource_adjust(struct pci_dev *pdev,
-					 struct resource *res,
-					 struct resource *root)
+static void sabre_resource_adjust(struct pci_dev *pdev,
+				  struct resource *res,
+				  struct resource *root)
 {
 	struct pci_pbm_info *pbm = pdev->bus->sysdata;
 	unsigned long base;
@@ -1072,7 +1072,7 @@ static void __init sabre_resource_adjust
 	res->end += base;
 }
 
-static void __init sabre_base_address_update(struct pci_dev *pdev, int resource)
+static void sabre_base_address_update(struct pci_dev *pdev, int resource)
 {
 	struct pcidev_cookie *pcp = pdev->sysdata;
 	struct pci_pbm_info *pbm = pcp->pbm;
@@ -1118,7 +1118,7 @@ static void __init sabre_base_address_up
 		pci_write_config_dword(pdev, where + 4, 0);
 }
 
-static void __init apb_init(struct pci_controller_info *p, struct pci_bus *sabre_bus)
+static void apb_init(struct pci_controller_info *p, struct pci_bus *sabre_bus)
 {
 	struct pci_dev *pdev;
 
@@ -1181,7 +1181,7 @@ static struct pcidev_cookie *alloc_bridg
 	return cookie;
 }
 
-static void __init sabre_scan_bus(struct pci_controller_info *p)
+static void sabre_scan_bus(struct pci_controller_info *p)
 {
 	static int once;
 	struct pci_bus *sabre_bus, *pbus;
@@ -1262,9 +1262,9 @@ static void __init sabre_scan_bus(struct
 	sabre_register_error_handlers(p);
 }
 
-static void __init sabre_iommu_init(struct pci_controller_info *p,
-				    int tsbsize, unsigned long dvma_offset,
-				    u32 dma_mask)
+static void sabre_iommu_init(struct pci_controller_info *p,
+			     int tsbsize, unsigned long dvma_offset,
+			     u32 dma_mask)
 {
 	struct pci_iommu *iommu = p->pbm_A.iommu;
 	unsigned long tsbbase, i, order;
@@ -1345,8 +1345,8 @@ static void __init sabre_iommu_init(stru
 	}
 }
 
-static void __init pbm_register_toplevel_resources(struct pci_controller_info *p,
-						   struct pci_pbm_info *pbm)
+static void pbm_register_toplevel_resources(struct pci_controller_info *p,
+					    struct pci_pbm_info *pbm)
 {
 	char *name = pbm->name;
 	unsigned long ibase = p->pbm_A.controller_regs + SABRE_IOSPACE;
@@ -1415,7 +1415,7 @@ static void __init pbm_register_toplevel
 					    &pbm->mem_space);
 }
 
-static void __init sabre_pbm_init(struct pci_controller_info *p, int sabre_node, u32 dma_begin)
+static void sabre_pbm_init(struct pci_controller_info *p, int sabre_node, u32 dma_begin)
 {
 	struct pci_pbm_info *pbm;
 	char namebuf[128];
@@ -1552,7 +1552,7 @@ static void __init sabre_pbm_init(struct
 	}
 }
 
-void __init sabre_init(int pnode, char *model_name)
+void sabre_init(int pnode, char *model_name)
 {
 	struct linux_prom64_registers pr_regs[2];
 	struct pci_controller_info *p;
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -285,7 +285,7 @@ static unsigned char schizo_pil_table[] 
 /*0x3f*/0,		/* Reserved for NewLink		*/
 };
 
-static int __init schizo_ino_to_pil(struct pci_dev *pdev, unsigned int ino)
+static int schizo_ino_to_pil(struct pci_dev *pdev, unsigned int ino)
 {
 	int ret;
 
@@ -1221,7 +1221,7 @@ static irqreturn_t schizo_safarierr_intr
  * PCI bus units of the same Tomatillo.  I still have not really
  * figured this out...
  */
-static void __init tomatillo_register_error_handlers(struct pci_controller_info *p)
+static void tomatillo_register_error_handlers(struct pci_controller_info *p)
 {
 	struct pci_pbm_info *pbm;
 	unsigned int irq;
@@ -1359,7 +1359,7 @@ static void __init tomatillo_register_er
 		     (SCHIZO_SAFIRQCTRL_EN | (BUS_ERROR_UNMAP)));
 }
 
-static void __init schizo_register_error_handlers(struct pci_controller_info *p)
+static void schizo_register_error_handlers(struct pci_controller_info *p)
 {
 	struct pci_pbm_info *pbm;
 	unsigned int irq;
@@ -1505,7 +1505,7 @@ static void __init schizo_register_error
 		     (SCHIZO_SAFIRQCTRL_EN | (BUS_ERROR_UNMAP)));
 }
 
-static void __init pbm_config_busmastering(struct pci_pbm_info *pbm)
+static void pbm_config_busmastering(struct pci_pbm_info *pbm)
 {
 	u8 *addr;
 
@@ -1522,8 +1522,8 @@ static void __init pbm_config_busmasteri
 	pci_config_write8(addr, 64);
 }
 
-static void __init pbm_scan_bus(struct pci_controller_info *p,
-				struct pci_pbm_info *pbm)
+static void pbm_scan_bus(struct pci_controller_info *p,
+			 struct pci_pbm_info *pbm)
 {
 	struct pcidev_cookie *cookie = kmalloc(sizeof(*cookie), GFP_KERNEL);
 
@@ -1550,8 +1550,8 @@ static void __init pbm_scan_bus(struct p
 	pci_setup_busmastering(pbm, pbm->pci_bus);
 }
 
-static void __init __schizo_scan_bus(struct pci_controller_info *p,
-				     int chip_type)
+static void __schizo_scan_bus(struct pci_controller_info *p,
+			      int chip_type)
 {
 	if (!p->pbm_B.prom_node || !p->pbm_A.prom_node) {
 		printk("PCI: Only one PCI bus module of controller found.\n");
@@ -1577,17 +1577,17 @@ static void __init __schizo_scan_bus(str
 		schizo_register_error_handlers(p);
 }
 
-static void __init schizo_scan_bus(struct pci_controller_info *p)
+static void schizo_scan_bus(struct pci_controller_info *p)
 {
 	__schizo_scan_bus(p, PBM_CHIP_TYPE_SCHIZO);
 }
 
-static void __init tomatillo_scan_bus(struct pci_controller_info *p)
+static void tomatillo_scan_bus(struct pci_controller_info *p)
 {
 	__schizo_scan_bus(p, PBM_CHIP_TYPE_TOMATILLO);
 }
 
-static void __init schizo_base_address_update(struct pci_dev *pdev, int resource)
+static void schizo_base_address_update(struct pci_dev *pdev, int resource)
 {
 	struct pcidev_cookie *pcp = pdev->sysdata;
 	struct pci_pbm_info *pbm = pcp->pbm;
@@ -1632,9 +1632,9 @@ static void __init schizo_base_address_u
 		pci_write_config_dword(pdev, where + 4, 0);
 }
 
-static void __init schizo_resource_adjust(struct pci_dev *pdev,
-					  struct resource *res,
-					  struct resource *root)
+static void schizo_resource_adjust(struct pci_dev *pdev,
+				   struct resource *res,
+				   struct resource *root)
 {
 	res->start += root->start;
 	res->end += root->start;
@@ -1702,8 +1702,8 @@ static void schizo_determine_mem_io_spac
 	       pbm->mem_space.start);
 }
 
-static void __init pbm_register_toplevel_resources(struct pci_controller_info *p,
-						   struct pci_pbm_info *pbm)
+static void pbm_register_toplevel_resources(struct pci_controller_info *p,
+					    struct pci_pbm_info *pbm)
 {
 	pbm->io_space.name = pbm->mem_space.name = pbm->name;
 
@@ -1932,7 +1932,7 @@ static void schizo_pbm_iommu_init(struct
 #define TOMATILLO_PCI_IOC_TDIAG		(0x2250UL)
 #define TOMATILLO_PCI_IOC_DDIAG		(0x2290UL)
 
-static void __init schizo_pbm_hw_init(struct pci_pbm_info *pbm)
+static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 {
 	u64 tmp;
 
@@ -1986,9 +1986,9 @@ static void __init schizo_pbm_hw_init(st
 	}
 }
 
-static void __init schizo_pbm_init(struct pci_controller_info *p,
-				   int prom_node, u32 portid,
-				   int chip_type)
+static void schizo_pbm_init(struct pci_controller_info *p,
+			    int prom_node, u32 portid,
+			    int chip_type)
 {
 	struct linux_prom64_registers pr_regs[4];
 	unsigned int busrange[2];
@@ -2145,7 +2145,7 @@ static inline int portid_compare(u32 x, 
 	return (x == y);
 }
 
-static void __init __schizo_init(int node, char *model_name, int chip_type)
+static void __schizo_init(int node, char *model_name, int chip_type)
 {
 	struct pci_controller_info *p;
 	struct pci_iommu *iommu;
@@ -2213,17 +2213,17 @@ static void __init __schizo_init(int nod
 	schizo_pbm_init(p, node, portid, chip_type);
 }
 
-void __init schizo_init(int node, char *model_name)
+void schizo_init(int node, char *model_name)
 {
 	__schizo_init(node, model_name, PBM_CHIP_TYPE_SCHIZO);
 }
 
-void __init schizo_plus_init(int node, char *model_name)
+void schizo_plus_init(int node, char *model_name)
 {
 	__schizo_init(node, model_name, PBM_CHIP_TYPE_SCHIZO_PLUS);
 }
 
-void __init tomatillo_init(int node, char *model_name)
+void tomatillo_init(int node, char *model_name)
 {
 	__schizo_init(node, model_name, PBM_CHIP_TYPE_TOMATILLO);
 }
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -4,13 +4,9 @@
 
 obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
 			names.o pci-driver.o search.o pci-sysfs.o \
-			rom.o
+			rom.o setup-res.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
-ifndef CONFIG_SPARC64
-obj-y += setup-res.o
-endif
-
 obj-$(CONFIG_HOTPLUG) += hotplug.o
 
 # Build the PCI Hotplug drivers if we were asked to
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -245,12 +245,19 @@ static void __devinit quirk_io_region(st
 {
 	region &= ~(size-1);
 	if (region) {
+		struct pci_bus_region bus_region;
 		struct resource *res = dev->resource + nr;
 
 		res->name = pci_name(dev);
 		res->start = region;
 		res->end = region + size - 1;
 		res->flags = IORESOURCE_IO;
+
+		/* Convert from PCI bus to resource space.  */
+		bus_region.start = res->start;
+		bus_region.end = res->end;
+		pcibios_bus_to_resource(dev, res, &bus_region);
+
 		pci_claim_resource(dev, nr);
 	}
 }	
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -95,10 +95,7 @@ pci_claim_resource(struct pci_dev *dev, 
 	char *dtype = resource < PCI_BRIDGE_RESOURCES ? "device" : "bridge";
 	int err;
 
-	if (res->flags & IORESOURCE_IO)
-		root = &ioport_resource;
-	if (res->flags & IORESOURCE_MEM)
-		root = &iomem_resource;
+	root = pcibios_select_root(dev, res);
 
 	err = -EINVAL;
 	if (root != NULL)
diff --git a/include/asm-alpha/pci.h b/include/asm-alpha/pci.h
--- a/include/asm-alpha/pci.h
+++ b/include/asm-alpha/pci.h
@@ -254,6 +254,19 @@ extern void pcibios_resource_to_bus(stru
 extern void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 				    struct pci_bus_region *region);
 
+static inline struct resource *
+pcibios_select_root(struct pci_dev *pdev, struct resource *res)
+{
+	struct resource *root = NULL;
+
+	if (res->flags & IORESOURCE_IO)
+		root = &ioport_resource;
+	if (res->flags & IORESOURCE_MEM)
+		root = &iomem_resource;
+
+	return root;
+}
+
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 static inline int pci_proc_domain(struct pci_bus *bus)
diff --git a/include/asm-arm/pci.h b/include/asm-arm/pci.h
--- a/include/asm-arm/pci.h
+++ b/include/asm-arm/pci.h
@@ -64,6 +64,19 @@ extern void
 pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			struct pci_bus_region *region);
 
+static inline struct resource *
+pcibios_select_root(struct pci_dev *pdev, struct resource *res)
+{
+	struct resource *root = NULL;
+
+	if (res->flags & IORESOURCE_IO)
+		root = &ioport_resource;
+	if (res->flags & IORESOURCE_MEM)
+		root = &iomem_resource;
+
+	return root;
+}
+
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
 {
 }
diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -30,6 +30,19 @@ pcibios_bus_to_resource(struct pci_dev *
 	res->end = region->end;
 }
 
+static inline struct resource *
+pcibios_select_root(struct pci_dev *pdev, struct resource *res)
+{
+	struct resource *root = NULL;
+
+	if (res->flags & IORESOURCE_IO)
+		root = &ioport_resource;
+	if (res->flags & IORESOURCE_MEM)
+		root = &iomem_resource;
+
+	return root;
+}
+
 #define pcibios_scan_all_fns(a, b)	0
 
 #ifndef HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
diff --git a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h
+++ b/include/asm-ia64/pci.h
@@ -156,6 +156,19 @@ extern void pcibios_resource_to_bus(stru
 extern void pcibios_bus_to_resource(struct pci_dev *dev,
 		struct resource *res, struct pci_bus_region *region);
 
+static inline struct resource *
+pcibios_select_root(struct pci_dev *pdev, struct resource *res)
+{
+	struct resource *root = NULL;
+
+	if (res->flags & IORESOURCE_IO)
+		root = &ioport_resource;
+	if (res->flags & IORESOURCE_MEM)
+		root = &iomem_resource;
+
+	return root;
+}
+
 #define pcibios_scan_all_fns(a, b)	0
 
 #endif /* _ASM_IA64_PCI_H */
diff --git a/include/asm-parisc/pci.h b/include/asm-parisc/pci.h
--- a/include/asm-parisc/pci.h
+++ b/include/asm-parisc/pci.h
@@ -257,6 +257,19 @@ extern void
 pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			struct pci_bus_region *region);
 
+static inline struct resource *
+pcibios_select_root(struct pci_dev *pdev, struct resource *res)
+{
+	struct resource *root = NULL;
+
+	if (res->flags & IORESOURCE_IO)
+		root = &ioport_resource;
+	if (res->flags & IORESOURCE_MEM)
+		root = &iomem_resource;
+
+	return root;
+}
+
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
 {
 }
diff --git a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
--- a/include/asm-ppc/pci.h
+++ b/include/asm-ppc/pci.h
@@ -109,6 +109,19 @@ extern void
 pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			struct pci_bus_region *region);
 
+static inline struct resource *
+pcibios_select_root(struct pci_dev *pdev, struct resource *res)
+{
+	struct resource *root = NULL;
+
+	if (res->flags & IORESOURCE_IO)
+		root = &ioport_resource;
+	if (res->flags & IORESOURCE_MEM)
+		root = &iomem_resource;
+
+	return root;
+}
+
 extern void pcibios_add_platform_entries(struct pci_dev *dev);
 
 struct file;
diff --git a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h
+++ b/include/asm-ppc64/pci.h
@@ -138,6 +138,19 @@ extern void
 pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			struct pci_bus_region *region);
 
+static inline struct resource *
+pcibios_select_root(struct pci_dev *pdev, struct resource *res)
+{
+	struct resource *root = NULL;
+
+	if (res->flags & IORESOURCE_IO)
+		root = &ioport_resource;
+	if (res->flags & IORESOURCE_MEM)
+		root = &iomem_resource;
+
+	return root;
+}
+
 extern int
 unmap_bus_range(struct pci_bus *bus);
 
diff --git a/include/asm-sparc64/pci.h b/include/asm-sparc64/pci.h
--- a/include/asm-sparc64/pci.h
+++ b/include/asm-sparc64/pci.h
@@ -269,6 +269,8 @@ extern void
 pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			struct pci_bus_region *region);
 
+extern struct resource *pcibios_select_root(struct pci_dev *, struct resource *);
+
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
 {
 }
