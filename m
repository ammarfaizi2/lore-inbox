Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWGMGYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWGMGYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWGMGYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:24:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11490
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932559AbWGMGYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:24:23 -0400
Date: Wed, 12 Jul 2006 23:24:19 -0700 (PDT)
Message-Id: <20060712.232419.41633769.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607091040.k69AewNu019891@harpo.it.uu.se>
References: <200607091040.k69AewNu019891@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sun, 9 Jul 2006 12:40:58 +0200 (MEST)

> 2.6.17-git16 to 2.6.18-rc1 partially boot but crash and burn in
> different places depending on kernel configuration: my standard
> config got alignment exceptions in the floppy driver followed by
> (sabre?) PCI errors and a hang; a minimal kernel gets further but
> fails "su" probe and then oopses hard when the /dev/hda partition
> table is about to be printed.

Several bugs operating here, all of which should be addressed by this
patch below.  I was able to bootup my ultra5 fully, use the keyboard
to login, etc. etc.

Let me know if you have any remaining problems.  If you do,
try to get me the full bootup logs witih "of_debug=3" specified
on the boot command line.

Thanks.

commit a12765ec0e91b5844628b886fc8d5ddbd0a433da
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Jul 12 23:19:31 2006 -0700

    [SPARC]: Fix OF register translations under sub-PCI busses.
    
    There is an implicit assumption in the code that ranges will translate
    to something that can fit in 2 32-bit cells, or a 64-bit value.  For
    certain kinds of things below PCI this isn't necessarily true.
    
    Here is what the relevant OF device hierarchy looks like for one of
    the serial controllers on an Ultra5:
    
        Node 0xf005f1e0
            ranges:      00000000.00000000.00000000.000001fe.01000000.00000000.01000000
                         01000000.00000000.00000000.000001fe.02000000.00000000.01000000
                         02000000.00000000.00000000.000001ff.00000000.00000001.00000000
                         03000000.00000000.00000000.000001ff.00000000.00000001.00000000
            device_type:  'pci'
            model:  'SUNW,sabre'
    
            Node 0xf005f9d4
                device_type:  'pci'
                model:  'SUNW,simba'
    
               Node 0xf0060d24
                    ranges:  00000010.00000000 82010810.00000000.f0000000 01000000
    			 00000014.00000000 82010814.00000000.f1000000 00800000
                    name:  'ebus'
    
                    Node 0xf0062dac
                        reg:  00000014.003083f8.00000008 --> 0x1ff.f13083f8
                        device_type:  'serial'
                        name:  'su'
    
    So the correct translation here is:
    
    1) Match "su" register to second ranges entry of 'ebus', which translates
       into a PCI triplet "82010814.00000000.f1000000" of size 00800000, which
       gives us "82010814.00000000.f13083f8".
    
    2) Pass-through "SUNW,simba" since it lacks ranges property
    
    3) Match "82010814.00000000.f13083f8" to third ranges property of PCI
       controller node 'SUNW,sabre', and we arrive at the final physical
       MMIO address of "0x1fff13083f8".
    
    Due to the 2-cell assumption, we couldn't translate to a PCI 3-cell
    value, and we couldn't perform a pass-thru on it either.
    
    It was easiest to just stop splitting the ranges application operation
    between two methods, ->map and ->translate, and just let ->map do all
    the work.  That way it would work purely on 32-bit cell arrays instead
    of having to "return" some value like a u64.
    
    It's still not %100 correct because the out-of-range check is still
    done using the 64 least significant bits of the range and address.
    But it does work for all the cases I've thrown at it so far.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

commit f3d35c85a67a7dbf775362d712addee7bc2b590c
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Jul 12 21:16:07 2006 -0700

    [SPARC64]: Refine Sabre wsync logic.
    
    It is only needed when there is a PCI-PCI bridge sitting
    between the device and the PCI host controller which is
    not a Simba APB bridge.
    
    Add logic to handle two special cases:
    
    1) device behind EBUS, which sits on PCI
    2) PCI controller interrupts
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

commit 9255b2f09513f66d001fdb39c0466d90f51af29a
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Jul 12 21:04:21 2006 -0700

    [SERIAL] sunsu: Handle keyboard and mouse ports directly.
    
    The sunsu_ports[] array exists merely to be able to easily
    use an integer index to get at the proper serial console
    port struct.
    
    We size this only for real ports, not for the keyboard and
    mouse, and thus keyboard and mouse port registration would
    fail.
    
    Fix this by dynamically allocating the port struct for the
    keyboard and mouse, instead of using the sunsu_ports[]
    array.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

commit 81704bcc0bf340b29e09087b0817d06c709e41db
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Jul 12 15:59:53 2006 -0700

    [SPARC64]: Fix 2 bugs in sabre_irq_build()
    
    When installing the IRQ pre-handler, we were not setting up the second
    argument correctly.  It should be a pointer to the sabre_irq_data, not
    the config space PIO address.
    
    Furthermore, we only need this pre-handler installed if the device
    sits behind a PCI bridge that is not Sabre or Simba/APB.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

commit 11add86eb8ebf58849a729f5dd537991e408aca3
Author: Andrew Morton <akpm@osdl.org>
Date:   Mon Jul 10 15:28:54 2006 -0700

    [SPARC64]: of_device_register() error checking fix
    
    device_create_file() can fail.  This causes the sparc64 compile to
    fail when my fanatical __must_check patch is applied, due to -Werror.
    
    [ Added necessary identical fix for sparc32. -DaveM]
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index bc956c5..5a2faad 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -183,7 +183,7 @@ struct bus_type of_bus_type = {
 };
 EXPORT_SYMBOL(of_bus_type);
 
-static inline u64 of_read_addr(u32 *cell, int size)
+static inline u64 of_read_addr(const u32 *cell, int size)
 {
 	u64 r = 0;
 	while (size--)
@@ -209,8 +209,8 @@ struct of_bus {
 	int		(*match)(struct device_node *parent);
 	void		(*count_cells)(struct device_node *child,
 				       int *addrc, int *sizec);
-	u64		(*map)(u32 *addr, u32 *range, int na, int ns, int pna);
-	int		(*translate)(u32 *addr, u64 offset, int na);
+	int		(*map)(u32 *addr, const u32 *range,
+			       int na, int ns, int pna);
 	unsigned int	(*get_flags)(u32 *addr);
 };
 
@@ -224,27 +224,49 @@ static void of_bus_default_count_cells(s
 	get_cells(dev, addrc, sizec);
 }
 
-static u64 of_bus_default_map(u32 *addr, u32 *range, int na, int ns, int pna)
+/* Make sure the least significant 64-bits are in-range.  Even
+ * for 3 or 4 cell values it is a good enough approximation.
+ */
+static int of_out_of_range(const u32 *addr, const u32 *base,
+			   const u32 *size, int na, int ns)
 {
-	u64 cp, s, da;
+	u64 a = of_read_addr(addr, na);
+	u64 b = of_read_addr(base, na);
+
+	if (a < b)
+		return 1;
 
-	cp = of_read_addr(range, na);
-	s  = of_read_addr(range + na + pna, ns);
-	da = of_read_addr(addr, na);
+	b += of_read_addr(size, ns);
+	if (a >= b)
+		return 1;
 
-	if (da < cp || da >= (cp + s))
-		return OF_BAD_ADDR;
-	return da - cp;
+	return 0;
 }
 
-static int of_bus_default_translate(u32 *addr, u64 offset, int na)
+static int of_bus_default_map(u32 *addr, const u32 *range,
+			      int na, int ns, int pna)
 {
-	u64 a = of_read_addr(addr, na);
-	memset(addr, 0, na * 4);
-	a += offset;
-	if (na > 1)
-		addr[na - 2] = a >> 32;
-	addr[na - 1] = a & 0xffffffffu;
+	u32 result[OF_MAX_ADDR_CELLS];
+	int i;
+
+	if (ns > 2) {
+		printk("of_device: Cannot handle size cells (%d) > 2.", ns);
+		return -EINVAL;
+	}
+
+	if (of_out_of_range(addr, range, range + na + pna, na, ns))
+		return -EINVAL;
+
+	/* Start with the parent range base.  */
+	memcpy(result, range + na, pna * 4);
+
+	/* Add in the child address offset.  */
+	for (i = 0; i < na; i++)
+		result[pna - 1 - i] +=
+			(addr[na - 1 - i] -
+			 range[na - 1 - i]);
+
+	memcpy(addr, result, pna * 4);
 
 	return 0;
 }
@@ -254,14 +276,26 @@ static unsigned int of_bus_default_get_f
 	return IORESOURCE_MEM;
 }
 
-
 /*
  * PCI bus specific translator
  */
 
 static int of_bus_pci_match(struct device_node *np)
 {
-	return !strcmp(np->type, "pci") || !strcmp(np->type, "pciex");
+	if (!strcmp(np->type, "pci") || !strcmp(np->type, "pciex")) {
+		/* Do not do PCI specific frobbing if the
+		 * PCI bridge lacks a ranges property.  We
+		 * want to pass it through up to the next
+		 * parent as-is, not with the PCI translate
+		 * method which chops off the top address cell.
+		 */
+		if (!of_find_property(np, "ranges", NULL))
+			return 0;
+
+		return 1;
+	}
+
+	return 0;
 }
 
 static void of_bus_pci_count_cells(struct device_node *np,
@@ -273,27 +307,32 @@ static void of_bus_pci_count_cells(struc
 		*sizec = 2;
 }
 
-static u64 of_bus_pci_map(u32 *addr, u32 *range, int na, int ns, int pna)
+static int of_bus_pci_map(u32 *addr, const u32 *range,
+			  int na, int ns, int pna)
 {
-	u64 cp, s, da;
+	u32 result[OF_MAX_ADDR_CELLS];
+	int i;
 
 	/* Check address type match */
 	if ((addr[0] ^ range[0]) & 0x03000000)
-		return OF_BAD_ADDR;
+		return -EINVAL;
 
-	/* Read address values, skipping high cell */
-	cp = of_read_addr(range + 1, na - 1);
-	s  = of_read_addr(range + na + pna, ns);
-	da = of_read_addr(addr + 1, na - 1);
+	if (of_out_of_range(addr + 1, range + 1, range + na + pna,
+			    na - 1, ns))
+		return -EINVAL;
+
+	/* Start with the parent range base.  */
+	memcpy(result, range + na, pna * 4);
+
+	/* Add in the child address offset, skipping high cell.  */
+	for (i = 0; i < na - 1; i++)
+		result[pna - 1 - i] +=
+			(addr[na - 1 - i] -
+			 range[na - 1 - i]);
 
-	if (da < cp || da >= (cp + s))
-		return OF_BAD_ADDR;
-	return da - cp;
-}
+	memcpy(addr, result, pna * 4);
 
-static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
-{
-	return of_bus_default_translate(addr + 1, offset, na - 1);
+	return 0;
 }
 
 static unsigned int of_bus_pci_get_flags(u32 *addr)
@@ -332,16 +371,11 @@ static void of_bus_sbus_count_cells(stru
 		*sizec = 1;
 }
 
-static u64 of_bus_sbus_map(u32 *addr, u32 *range, int na, int ns, int pna)
+static int of_bus_sbus_map(u32 *addr, const u32 *range, int na, int ns, int pna)
 {
 	return of_bus_default_map(addr, range, na, ns, pna);
 }
 
-static int of_bus_sbus_translate(u32 *addr, u64 offset, int na)
-{
-	return of_bus_default_translate(addr, offset, na);
-}
-
 static unsigned int of_bus_sbus_get_flags(u32 *addr)
 {
 	return IORESOURCE_MEM;
@@ -360,7 +394,6 @@ static struct of_bus of_busses[] = {
 		.match = of_bus_pci_match,
 		.count_cells = of_bus_pci_count_cells,
 		.map = of_bus_pci_map,
-		.translate = of_bus_pci_translate,
 		.get_flags = of_bus_pci_get_flags,
 	},
 	/* SBUS */
@@ -370,7 +403,6 @@ static struct of_bus of_busses[] = {
 		.match = of_bus_sbus_match,
 		.count_cells = of_bus_sbus_count_cells,
 		.map = of_bus_sbus_map,
-		.translate = of_bus_sbus_translate,
 		.get_flags = of_bus_sbus_get_flags,
 	},
 	/* Default */
@@ -380,7 +412,6 @@ static struct of_bus of_busses[] = {
 		.match = NULL,
 		.count_cells = of_bus_default_count_cells,
 		.map = of_bus_default_map,
-		.translate = of_bus_default_translate,
 		.get_flags = of_bus_default_get_flags,
 	},
 };
@@ -405,33 +436,34 @@ static int __init build_one_resource(str
 	u32 *ranges;
 	unsigned int rlen;
 	int rone;
-	u64 offset = OF_BAD_ADDR;
 
 	ranges = of_get_property(parent, "ranges", &rlen);
 	if (ranges == NULL || rlen == 0) {
-		offset = of_read_addr(addr, na);
-		memset(addr, 0, pna * 4);
-		goto finish;
+		u32 result[OF_MAX_ADDR_CELLS];
+		int i;
+
+		memset(result, 0, pna * 4);
+		for (i = 0; i < na; i++)
+			result[pna - 1 - i] =
+				addr[na - 1 - i];
+
+		memcpy(addr, result, pna * 4);
+		return 0;
 	}
 
 	/* Now walk through the ranges */
 	rlen /= 4;
 	rone = na + pna + ns;
 	for (; rlen >= rone; rlen -= rone, ranges += rone) {
-		offset = bus->map(addr, ranges, na, ns, pna);
-		if (offset != OF_BAD_ADDR)
-			break;
+		if (!bus->map(addr, ranges, na, ns, pna))
+			return 0;
 	}
-	if (offset == OF_BAD_ADDR)
-		return 1;
-
-	memcpy(addr, ranges + na, 4 * pna);
 
-finish:
-	/* Translate it into parent bus space */
-	return pbus->translate(addr, offset, pna);
+	return 1;
 }
 
+static int of_resource_verbose;
+
 static void __init build_device_resources(struct of_device *op,
 					  struct device *parent)
 {
@@ -497,7 +529,8 @@ static void __init build_device_resource
 			pbus = of_match_bus(pp);
 			pbus->count_cells(dp, &pna, &pns);
 
-			if (build_one_resource(dp, bus, pbus, addr, dna, dns, pna))
+			if (build_one_resource(dp, bus, pbus, addr,
+					       dna, dns, pna))
 				break;
 
 			dna = pna;
@@ -507,6 +540,12 @@ static void __init build_device_resource
 
 	build_res:
 		memset(r, 0, sizeof(*r));
+
+		if (of_resource_verbose)
+			printk("%s reg[%d] -> %llx\n",
+			       op->node->full_name, index,
+			       result);
+
 		if (result != OF_BAD_ADDR) {
 			r->start = result & 0xffffffff;
 			r->end = result + size - 1;
@@ -643,6 +682,18 @@ static int __init of_bus_driver_init(voi
 
 postcore_initcall(of_bus_driver_init);
 
+static int __init of_debug(char *str)
+{
+	int val = 0;
+
+	get_option(&str, &val);
+	if (val & 1)
+		of_resource_verbose = 1;
+	return 1;
+}
+
+__setup("of_debug=", of_debug);
+
 int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
 {
 	/* initialize common driver fields */
@@ -695,9 +746,11 @@ int of_device_register(struct of_device 
 	if (rc)
 		return rc;
 
-	device_create_file(&ofdev->dev, &dev_attr_devspec);
+	rc = device_create_file(&ofdev->dev, &dev_attr_devspec);
+	if (rc)
+		device_unregister(&ofdev->dev);
 
-	return 0;
+	return rc;
 }
 
 void of_device_unregister(struct of_device *ofdev)
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 169b017..7064cee 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -210,7 +210,7 @@ struct bus_type of_bus_type = {
 };
 EXPORT_SYMBOL(of_bus_type);
 
-static inline u64 of_read_addr(u32 *cell, int size)
+static inline u64 of_read_addr(const u32 *cell, int size)
 {
 	u64 r = 0;
 	while (size--)
@@ -236,8 +236,8 @@ struct of_bus {
 	int		(*match)(struct device_node *parent);
 	void		(*count_cells)(struct device_node *child,
 				       int *addrc, int *sizec);
-	u64		(*map)(u32 *addr, u32 *range, int na, int ns, int pna);
-	int		(*translate)(u32 *addr, u64 offset, int na);
+	int		(*map)(u32 *addr, const u32 *range,
+			       int na, int ns, int pna);
 	unsigned int	(*get_flags)(u32 *addr);
 };
 
@@ -251,27 +251,49 @@ static void of_bus_default_count_cells(s
 	get_cells(dev, addrc, sizec);
 }
 
-static u64 of_bus_default_map(u32 *addr, u32 *range, int na, int ns, int pna)
+/* Make sure the least significant 64-bits are in-range.  Even
+ * for 3 or 4 cell values it is a good enough approximation.
+ */
+static int of_out_of_range(const u32 *addr, const u32 *base,
+			   const u32 *size, int na, int ns)
 {
-	u64 cp, s, da;
+	u64 a = of_read_addr(addr, na);
+	u64 b = of_read_addr(base, na);
 
-	cp = of_read_addr(range, na);
-	s  = of_read_addr(range + na + pna, ns);
-	da = of_read_addr(addr, na);
+	if (a < b)
+		return 1;
 
-	if (da < cp || da >= (cp + s))
-		return OF_BAD_ADDR;
-	return da - cp;
+	b += of_read_addr(size, ns);
+	if (a >= b)
+		return 1;
+
+	return 0;
 }
 
-static int of_bus_default_translate(u32 *addr, u64 offset, int na)
+static int of_bus_default_map(u32 *addr, const u32 *range,
+			      int na, int ns, int pna)
 {
-	u64 a = of_read_addr(addr, na);
-	memset(addr, 0, na * 4);
-	a += offset;
-	if (na > 1)
-		addr[na - 2] = a >> 32;
-	addr[na - 1] = a & 0xffffffffu;
+	u32 result[OF_MAX_ADDR_CELLS];
+	int i;
+
+	if (ns > 2) {
+		printk("of_device: Cannot handle size cells (%d) > 2.", ns);
+		return -EINVAL;
+	}
+
+	if (of_out_of_range(addr, range, range + na + pna, na, ns))
+		return -EINVAL;
+
+	/* Start with the parent range base.  */
+	memcpy(result, range + na, pna * 4);
+
+	/* Add in the child address offset.  */
+	for (i = 0; i < na; i++)
+		result[pna - 1 - i] +=
+			(addr[na - 1 - i] -
+			 range[na - 1 - i]);
+
+	memcpy(addr, result, pna * 4);
 
 	return 0;
 }
@@ -287,7 +309,20 @@ static unsigned int of_bus_default_get_f
 
 static int of_bus_pci_match(struct device_node *np)
 {
-	return !strcmp(np->type, "pci") || !strcmp(np->type, "pciex");
+	if (!strcmp(np->type, "pci") || !strcmp(np->type, "pciex")) {
+		/* Do not do PCI specific frobbing if the
+		 * PCI bridge lacks a ranges property.  We
+		 * want to pass it through up to the next
+		 * parent as-is, not with the PCI translate
+		 * method which chops off the top address cell.
+		 */
+		if (!of_find_property(np, "ranges", NULL))
+			return 0;
+
+		return 1;
+	}
+
+	return 0;
 }
 
 static void of_bus_pci_count_cells(struct device_node *np,
@@ -299,27 +334,32 @@ static void of_bus_pci_count_cells(struc
 		*sizec = 2;
 }
 
-static u64 of_bus_pci_map(u32 *addr, u32 *range, int na, int ns, int pna)
+static int of_bus_pci_map(u32 *addr, const u32 *range,
+			  int na, int ns, int pna)
 {
-	u64 cp, s, da;
+	u32 result[OF_MAX_ADDR_CELLS];
+	int i;
 
 	/* Check address type match */
 	if ((addr[0] ^ range[0]) & 0x03000000)
-		return OF_BAD_ADDR;
+		return -EINVAL;
 
-	/* Read address values, skipping high cell */
-	cp = of_read_addr(range + 1, na - 1);
-	s  = of_read_addr(range + na + pna, ns);
-	da = of_read_addr(addr + 1, na - 1);
+	if (of_out_of_range(addr + 1, range + 1, range + na + pna,
+			    na - 1, ns))
+		return -EINVAL;
+
+	/* Start with the parent range base.  */
+	memcpy(result, range + na, pna * 4);
+
+	/* Add in the child address offset, skipping high cell.  */
+	for (i = 0; i < na - 1; i++)
+		result[pna - 1 - i] +=
+			(addr[na - 1 - i] -
+			 range[na - 1 - i]);
 
-	if (da < cp || da >= (cp + s))
-		return OF_BAD_ADDR;
-	return da - cp;
-}
+	memcpy(addr, result, pna * 4);
 
-static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
-{
-	return of_bus_default_translate(addr + 1, offset, na - 1);
+	return 0;
 }
 
 static unsigned int of_bus_pci_get_flags(u32 *addr)
@@ -340,59 +380,6 @@ static unsigned int of_bus_pci_get_flags
 }
 
 /*
- * ISA bus specific translator
- */
-
-static int of_bus_isa_match(struct device_node *np)
-{
-	return !strcmp(np->name, "isa");
-}
-
-static void of_bus_isa_count_cells(struct device_node *child,
-				   int *addrc, int *sizec)
-{
-	if (addrc)
-		*addrc = 2;
-	if (sizec)
-		*sizec = 1;
-}
-
-static u64 of_bus_isa_map(u32 *addr, u32 *range, int na, int ns, int pna)
-{
-	u64 cp, s, da;
-
-	/* Check address type match */
-	if ((addr[0] ^ range[0]) & 0x00000001)
-		return OF_BAD_ADDR;
-
-	/* Read address values, skipping high cell */
-	cp = of_read_addr(range + 1, na - 1);
-	s  = of_read_addr(range + na + pna, ns);
-	da = of_read_addr(addr + 1, na - 1);
-
-	if (da < cp || da >= (cp + s))
-		return OF_BAD_ADDR;
-	return da - cp;
-}
-
-static int of_bus_isa_translate(u32 *addr, u64 offset, int na)
-{
-	return of_bus_default_translate(addr + 1, offset, na - 1);
-}
-
-static unsigned int of_bus_isa_get_flags(u32 *addr)
-{
-	unsigned int flags = 0;
-	u32 w = addr[0];
-
-	if (w & 1)
-		flags |= IORESOURCE_IO;
-	else
-		flags |= IORESOURCE_MEM;
-	return flags;
-}
-
-/*
  * SBUS bus specific translator
  */
 
@@ -411,16 +398,11 @@ static void of_bus_sbus_count_cells(stru
 		*sizec = 1;
 }
 
-static u64 of_bus_sbus_map(u32 *addr, u32 *range, int na, int ns, int pna)
+static int of_bus_sbus_map(u32 *addr, const u32 *range, int na, int ns, int pna)
 {
 	return of_bus_default_map(addr, range, na, ns, pna);
 }
 
-static int of_bus_sbus_translate(u32 *addr, u64 offset, int na)
-{
-	return of_bus_default_translate(addr, offset, na);
-}
-
 static unsigned int of_bus_sbus_get_flags(u32 *addr)
 {
 	return IORESOURCE_MEM;
@@ -439,19 +421,8 @@ static struct of_bus of_busses[] = {
 		.match = of_bus_pci_match,
 		.count_cells = of_bus_pci_count_cells,
 		.map = of_bus_pci_map,
-		.translate = of_bus_pci_translate,
 		.get_flags = of_bus_pci_get_flags,
 	},
-	/* ISA */
-	{
-		.name = "isa",
-		.addr_prop_name = "reg",
-		.match = of_bus_isa_match,
-		.count_cells = of_bus_isa_count_cells,
-		.map = of_bus_isa_map,
-		.translate = of_bus_isa_translate,
-		.get_flags = of_bus_isa_get_flags,
-	},
 	/* SBUS */
 	{
 		.name = "sbus",
@@ -459,7 +430,6 @@ static struct of_bus of_busses[] = {
 		.match = of_bus_sbus_match,
 		.count_cells = of_bus_sbus_count_cells,
 		.map = of_bus_sbus_map,
-		.translate = of_bus_sbus_translate,
 		.get_flags = of_bus_sbus_get_flags,
 	},
 	/* Default */
@@ -469,7 +439,6 @@ static struct of_bus of_busses[] = {
 		.match = NULL,
 		.count_cells = of_bus_default_count_cells,
 		.map = of_bus_default_map,
-		.translate = of_bus_default_translate,
 		.get_flags = of_bus_default_get_flags,
 	},
 };
@@ -494,33 +463,62 @@ static int __init build_one_resource(str
 	u32 *ranges;
 	unsigned int rlen;
 	int rone;
-	u64 offset = OF_BAD_ADDR;
 
 	ranges = of_get_property(parent, "ranges", &rlen);
 	if (ranges == NULL || rlen == 0) {
-		offset = of_read_addr(addr, na);
-		memset(addr, 0, pna * 4);
-		goto finish;
+		u32 result[OF_MAX_ADDR_CELLS];
+		int i;
+
+		memset(result, 0, pna * 4);
+		for (i = 0; i < na; i++)
+			result[pna - 1 - i] =
+				addr[na - 1 - i];
+
+		memcpy(addr, result, pna * 4);
+		return 0;
 	}
 
 	/* Now walk through the ranges */
 	rlen /= 4;
 	rone = na + pna + ns;
 	for (; rlen >= rone; rlen -= rone, ranges += rone) {
-		offset = bus->map(addr, ranges, na, ns, pna);
-		if (offset != OF_BAD_ADDR)
-			break;
+		if (!bus->map(addr, ranges, na, ns, pna))
+			return 0;
 	}
-	if (offset == OF_BAD_ADDR)
+
+	return 1;
+}
+
+static int __init use_1to1_mapping(struct device_node *pp)
+{
+	char *model;
+
+	/* If this is on the PMU bus, don't try to translate it even
+	 * if a ranges property exists.
+	 */
+	if (!strcmp(pp->name, "pmu"))
 		return 1;
 
-	memcpy(addr, ranges + na, 4 * pna);
+	/* If we have a ranges property in the parent, use it.  */
+	if (of_find_property(pp, "ranges", NULL) != NULL)
+		return 0;
+
+	/* If the parent is the dma node of an ISA bus, pass
+	 * the translation up to the root.
+	 */
+	if (!strcmp(pp->name, "dma"))
+		return 0;
 
-finish:
-	/* Translate it into parent bus space */
-	return pbus->translate(addr, offset, pna);
+	/* Similarly for Simba PCI bridges.  */
+	model = of_get_property(pp, "model", NULL);
+	if (model && !strcmp(model, "SUNW,simba"))
+		return 0;
+
+	return 1;
 }
 
+static int of_resource_verbose;
+
 static void __init build_device_resources(struct of_device *op,
 					  struct device *parent)
 {
@@ -564,15 +562,7 @@ static void __init build_device_resource
 
 		memcpy(addr, reg, na * 4);
 
-		/* If the immediate parent has no ranges property to apply,
-		 * just use a 1<->1 mapping.  Unless it is the 'dma' child
-		 * of an isa bus, which must be passed up towards the root.
-		 *
-		 * Also, don't try to translate PMU bus device registers.
-		 */
-		if ((of_find_property(pp, "ranges", NULL) == NULL &&
-		     strcmp(pp->name, "dma") != 0) ||
-		    !strcmp(pp->name, "pmu")) {
+		if (use_1to1_mapping(pp)) {
 			result = of_read_addr(addr, na);
 			goto build_res;
 		}
@@ -591,7 +581,8 @@ static void __init build_device_resource
 			pbus = of_match_bus(pp);
 			pbus->count_cells(dp, &pna, &pns);
 
-			if (build_one_resource(dp, bus, pbus, addr, dna, dns, pna))
+			if (build_one_resource(dp, bus, pbus, addr,
+					       dna, dns, pna))
 				break;
 
 			dna = pna;
@@ -601,6 +592,12 @@ static void __init build_device_resource
 
 	build_res:
 		memset(r, 0, sizeof(*r));
+
+		if (of_resource_verbose)
+			printk("%s reg[%d] -> %lx\n",
+			       op->node->full_name, index,
+			       result);
+
 		if (result != OF_BAD_ADDR) {
 			if (tlb_type == hypervisor)
 				result &= 0x0fffffffffffffffUL;
@@ -684,6 +681,8 @@ static unsigned int __init pci_irq_swizz
 	return ret;
 }
 
+static int of_irq_verbose;
+
 static unsigned int __init build_one_device_irq(struct of_device *op,
 						struct device *parent,
 						unsigned int irq)
@@ -698,10 +697,11 @@ static unsigned int __init build_one_dev
 	if (dp->irq_trans) {
 		irq = dp->irq_trans->irq_build(dp, irq,
 					       dp->irq_trans->data);
-#if 1
-		printk("%s: direct translate %x --> %x\n",
-		       dp->full_name, orig_irq, irq);
-#endif
+
+		if (of_irq_verbose)
+			printk("%s: direct translate %x --> %x\n",
+			       dp->full_name, orig_irq, irq);
+
 		return irq;
 	}
 
@@ -728,12 +728,13 @@ static unsigned int __init build_one_dev
 			iret = apply_interrupt_map(dp, pp,
 						   imap, imlen, imsk,
 						   &irq);
-#if 1
-			printk("%s: Apply [%s:%x] imap --> [%s:%x]\n",
-			       op->node->full_name,
-			       pp->full_name, this_orig_irq,
-			       (iret ? iret->full_name : "NULL"), irq);
-#endif
+
+			if (of_irq_verbose)
+				printk("%s: Apply [%s:%x] imap --> [%s:%x]\n",
+				       op->node->full_name,
+				       pp->full_name, this_orig_irq,
+				       (iret ? iret->full_name : "NULL"), irq);
+
 			if (!iret)
 				break;
 
@@ -747,11 +748,13 @@ static unsigned int __init build_one_dev
 				unsigned int this_orig_irq = irq;
 
 				irq = pci_irq_swizzle(dp, pp, irq);
-#if 1
-				printk("%s: PCI swizzle [%s] %x --> %x\n",
-				       op->node->full_name,
-				       pp->full_name, this_orig_irq, irq);
-#endif
+				if (of_irq_verbose)
+					printk("%s: PCI swizzle [%s] "
+					       "%x --> %x\n",
+					       op->node->full_name,
+					       pp->full_name, this_orig_irq,
+					       irq);
+
 			}
 
 			if (pp->irq_trans) {
@@ -767,10 +770,9 @@ static unsigned int __init build_one_dev
 
 	irq = ip->irq_trans->irq_build(op->node, irq,
 				       ip->irq_trans->data);
-#if 1
-	printk("%s: Apply IRQ trans [%s] %x --> %x\n",
-	       op->node->full_name, ip->full_name, orig_irq, irq);
-#endif
+	if (of_irq_verbose)
+		printk("%s: Apply IRQ trans [%s] %x --> %x\n",
+		       op->node->full_name, ip->full_name, orig_irq, irq);
 
 	return irq;
 }
@@ -870,6 +872,20 @@ static int __init of_bus_driver_init(voi
 
 postcore_initcall(of_bus_driver_init);
 
+static int __init of_debug(char *str)
+{
+	int val = 0;
+
+	get_option(&str, &val);
+	if (val & 1)
+		of_resource_verbose = 1;
+	if (val & 2)
+		of_irq_verbose = 1;
+	return 1;
+}
+
+__setup("of_debug=", of_debug);
+
 int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
 {
 	/* initialize common driver fields */
@@ -922,9 +938,11 @@ int of_device_register(struct of_device 
 	if (rc)
 		return rc;
 
-	device_create_file(&ofdev->dev, &dev_attr_devspec);
+	rc = device_create_file(&ofdev->dev, &dev_attr_devspec);
+	if (rc)
+		device_unregister(&ofdev->dev);
 
-	return 0;
+	return rc;
 }
 
 void of_device_unregister(struct of_device *ofdev)
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index 99daeee..c86007a 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -539,6 +539,45 @@ static unsigned long __sabre_onboard_ima
 	((ino & 0x20) ? (SABRE_ICLR_SCSI + (((ino) & 0x1f) << 3)) :  \
 			(SABRE_ICLR_A_SLOT0 + (((ino) & 0x1f)<<3)))
 
+static int sabre_device_needs_wsync(struct device_node *dp)
+{
+	struct device_node *parent = dp->parent;
+	char *parent_model, *parent_compat;
+
+	/* This traversal up towards the root is meant to
+	 * handle two cases:
+	 *
+	 * 1) non-PCI bus sitting under PCI, such as 'ebus'
+	 * 2) the PCI controller interrupts themselves, which
+	 *    will use the sabre_irq_build but do not need
+	 *    the DMA synchronization handling
+	 */
+	while (parent) {
+		if (!strcmp(parent->type, "pci"))
+			break;
+		parent = parent->parent;
+	}
+
+	if (!parent)
+		return 0;
+
+	parent_model = of_get_property(parent,
+				       "model", NULL);
+	if (parent_model &&
+	    (!strcmp(parent_model, "SUNW,sabre") ||
+	     !strcmp(parent_model, "SUNW,simba")))
+		return 0;
+
+	parent_compat = of_get_property(parent,
+					"compatible", NULL);
+	if (parent_compat &&
+	    (!strcmp(parent_compat, "pci108e,a000") ||
+	     !strcmp(parent_compat, "pci108e,a001")))
+		return 0;
+
+	return 1;
+}
+
 static unsigned int sabre_irq_build(struct device_node *dp,
 				    unsigned int ino,
 				    void *_data)
@@ -577,15 +616,17 @@ static unsigned int sabre_irq_build(stru
 
 	virt_irq = build_irq(inofixup, iclr, imap);
 
+	/* If the parent device is a PCI<->PCI bridge other than
+	 * APB, we have to install a pre-handler to ensure that
+	 * all pending DMA is drained before the interrupt handler
+	 * is run.
+	 */
 	regs = of_get_property(dp, "reg", NULL);
-	if (regs &&
-	    ((regs->phys_hi >> 16) & 0xff) != irq_data->pci_first_busno) {
+	if (regs && sabre_device_needs_wsync(dp)) {
 		irq_install_pre_handler(virt_irq,
 					sabre_wsync_handler,
 					(void *) (long) regs->phys_hi,
-					(void *)
-					controller_regs +
-					SABRE_WRSYNC);
+					(void *) irq_data);
 	}
 
 	return virt_irq;
diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index f9013ba..93bdaa3 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1406,25 +1406,35 @@ static int __devinit su_probe(struct of_
 	struct device_node *dp = op->node;
 	struct uart_sunsu_port *up;
 	struct resource *rp;
+	enum su_type type;
 	int err;
 
-	if (inst >= UART_NR)
-		return -EINVAL;
+	type = su_get_type(dp);
+	if (type == SU_PORT_PORT) {
+		if (inst >= UART_NR)
+			return -EINVAL;
+		up = &sunsu_ports[inst];
+	} else {
+		up = kzalloc(sizeof(*up), GFP_KERNEL);
+		if (!up)
+			return -ENOMEM;
+	}
 
-	up = &sunsu_ports[inst];
 	up->port.line = inst;
 
 	spin_lock_init(&up->port.lock);
 
-	up->su_type = su_get_type(dp);
+	up->su_type = type;
 
 	rp = &op->resource[0];
-	up->port.mapbase = op->resource[0].start;
-
+	up->port.mapbase = rp->start;
 	up->reg_size = (rp->end - rp->start) + 1;
 	up->port.membase = of_ioremap(rp, 0, up->reg_size, "su");
-	if (!up->port.membase)
+	if (!up->port.membase) {
+		if (type != SU_PORT_PORT)
+			kfree(up);
 		return -ENOMEM;
+	}
 
 	up->port.irq = op->irqs[0];
 
@@ -1436,8 +1446,11 @@ static int __devinit su_probe(struct of_
 	err = 0;
 	if (up->su_type == SU_PORT_KBD || up->su_type == SU_PORT_MS) {
 		err = sunsu_kbd_ms_init(up);
-		if (err)
+		if (err) {
+			kfree(up);
 			goto out_unmap;
+		}
+		dev_set_drvdata(&op->dev, up);
 
 		return 0;
 	}
@@ -1476,8 +1489,12 @@ static int __devexit su_remove(struct of
 #ifdef CONFIG_SERIO
 		serio_unregister_port(&up->serio);
 #endif
-	} else if (up->port.type != PORT_UNKNOWN)
+		kfree(up);
+	} else if (up->port.type != PORT_UNKNOWN) {
 		uart_remove_one_port(&sunsu_reg, &up->port);
+	}
+
+	dev_set_drvdata(&dev->dev, NULL);
 
 	return 0;
 }
