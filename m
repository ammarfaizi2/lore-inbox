Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265972AbRGGDbn>; Fri, 6 Jul 2001 23:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265978AbRGGDbe>; Fri, 6 Jul 2001 23:31:34 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:32265 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S265972AbRGGDbQ>;
	Fri, 6 Jul 2001 23:31:16 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.33315.268878.263612@tango.paulus.ozlabs.org>
Date: Sat, 7 Jul 2001 13:29:39 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH] PPC interrupt mapping fix
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The patch below fixes the interrupt assignments on PPC machines that
use Open Firmware, in the case where we have devices behind a PCI-PCI
bridge and multiple PCI host bridges.  The patch is moderately large
because I rewrote the procedure that parsed the open firmware
interrupt tree.  The previous routine was monolithic and almost
unreadable - I wrote a new version which uses several subroutines and
should be much more readable.  There are also some fixes to allow us
to use the interrupt tree on powermacs when booted with BootX, which
we couldn't do previously.

Please apply to your tree.

Paul.

diff -urN linux/arch/ppc/kernel/prom.c pmac/arch/ppc/kernel/prom.c
--- linux/arch/ppc/kernel/prom.c	Wed Jul  4 14:33:18 2001
+++ pmac/arch/ppc/kernel/prom.c	Wed Jul  4 22:53:29 2001
@@ -116,8 +116,11 @@
 unsigned int rtas_size;
 unsigned int old_rtas;
 
-/* Set for a newworld machine */
+/* Set for a newworld or CHRP machine */
 int use_of_interrupt_tree;
+struct device_node *dflt_interrupt_controller;
+int num_interrupt_controllers;
+
 int pmac_newworld;
 
 static struct device_node *allnodes;
@@ -1153,7 +1156,19 @@
 		*prev_propp = PTRUNRELOC(pp);
 		prev_propp = &pp->next;
 	}
-	*prev_propp = 0;
+	if (np->node != NULL) {
+		/* Add a "linux,phandle" property" */
+		pp = (struct property *) mem_start;
+		*prev_propp = PTRUNRELOC(pp);
+		prev_propp = &pp->next;
+		namep = (char *) (pp + 1);
+		pp->name = PTRUNRELOC(namep);
+		strcpy(namep, RELOC("linux,phandle"));
+		mem_start = ALIGN((unsigned long)namep + strlen(namep) + 1);
+		pp->value = (unsigned char *) PTRUNRELOC(&np->node);
+		pp->length = sizeof(np->node);
+	}
+	*prev_propp = NULL;
 
 	/* get the node's full name */
 	l = (int) call_prom(RELOC("package-to-path"), 3, 1, node,
@@ -1186,19 +1201,46 @@
 finish_device_tree(void)
 {
 	unsigned long mem = (unsigned long) klimit;
+	struct device_node *np;
 
-	/* All newworld machines now use the interrupt tree */
-	struct device_node *np = allnodes;
-
-	while(np && (_machine == _MACH_Pmac)) {
+	/* All newworld pmac machines and CHRPs now use the interrupt tree */
+	for (np = allnodes; np != NULL; np = np->allnext) {
 		if (get_property(np, "interrupt-parent", 0)) {
-			pmac_newworld = 1;
+			use_of_interrupt_tree = 1;
 			break;
 		}
-		np = np->allnext;
 	}
-	if ((_machine == _MACH_chrp) || (boot_infos == 0 && pmac_newworld))
-		use_of_interrupt_tree = 1;
+	if (_machine == _MACH_Pmac && use_of_interrupt_tree)
+		pmac_newworld = 1;
+
+#ifdef CONFIG_BOOTX_TEXT
+	if (boot_infos && pmac_newworld) {
+		prom_print("WARNING ! BootX/miBoot booting is not supported on this machine\n");
+		prom_print("          You should use an Open Firmware bootloader\n");
+	}
+#endif /* CONFIG_BOOTX_TEXT */
+
+	if (use_of_interrupt_tree) {
+		/*
+		 * We want to find out here how many interrupt-controller
+		 * nodes there are, and if we are booted from BootX,
+		 * we need a pointer to the first (and hopefully only)
+		 * such node.  But we can't use find_devices here since
+		 * np->name has not been set yet.  -- paulus
+		 */
+		int n = 0;
+		char *name;
+
+		for (np = allnodes; np != NULL; np = np->allnext) {
+			if ((name = get_property(np, "name", NULL)) == NULL
+			    || strcmp(name, "interrupt-controller") != 0)
+				continue;
+			if (n == 0)
+				dflt_interrupt_controller = np;
+			++n;
+		}
+		num_interrupt_controllers = n;
+	}
 
 	mem = finish_node(allnodes, mem, NULL, 1, 1);
 	dev_tree_size = mem - (unsigned long) allnodes;
@@ -1240,9 +1282,8 @@
 	if (ifunc != NULL) {
 		mem_start = ifunc(np, mem_start, naddrc, nsizec);
 	}
-	if (use_of_interrupt_tree) {
+	if (use_of_interrupt_tree)
 		mem_start = finish_node_interrupts(np, mem_start);
-	}
 
 	/* Look for #address-cells and #size-cells properties. */
 	ip = (int *) get_property(np, "#address-cells", 0);
@@ -1298,141 +1339,210 @@
 	return mem_start;
 }
 
-/* This routine walks the interrupt tree for a given device node and gather 
- * all necessary informations according to the draft interrupt mapping
- * for CHRP. The current version was only tested on Apple "Core99" machines
- * and may not handle cascaded controllers correctly.
+/*
+ * Find the interrupt parent of a node.
+ */
+static struct device_node *intr_parent(struct device_node *p)
+{
+	phandle *parp;
+
+	parp = (phandle *) get_property(p, "interrupt-parent", NULL);
+	if (parp == NULL)
+		return p->parent;
+	p = find_phandle(*parp);
+	if (p != NULL)
+		return p;
+	/*
+	 * On a powermac booted with BootX, we don't get to know the
+	 * phandles for any nodes, so find_phandle will return NULL.
+	 * Fortunately these machines only have one interrupt controller
+	 * so there isn't in fact any ambiguity.  -- paulus
+	 */
+	if (num_interrupt_controllers == 1)
+		p = dflt_interrupt_controller;
+	return p;
+}
+
+/*
+ * Find out the size of each entry of the interrupts property
+ * for a node.
  */
-__init
-static unsigned long
-finish_node_interrupts(struct device_node *np, unsigned long mem_start)
+static int
+prom_n_intr_cells(struct device_node *np)
 {
-	/* Finish this node */
-	unsigned int *isizep, *asizep, *interrupts, *map, *map_mask, *reg;
-	phandle *parent;
-	struct device_node *node, *parent_node;
-	int l, isize, ipsize, asize, map_size, regpsize;
-
-	/* Currently, we don't look at all nodes with no "interrupts" property */
-	interrupts = (unsigned int *)get_property(np, "interrupts", &l);
-	if (interrupts == NULL)
-		return mem_start;
-	ipsize = l>>2;
+	struct device_node *p;
+	unsigned int *icp;
 
-	reg = (unsigned int *)get_property(np, "reg", &l);
-	regpsize = l>>2;
+	for (p = np; (p = intr_parent(p)) != NULL; ) {
+		icp = (unsigned int *)
+			get_property(p, "#interrupt-cells", NULL);
+		if (icp != NULL)
+			return *icp;
+		if (get_property(p, "interrupt-controller", NULL) != NULL
+		    || get_property(p, "interrupt-map", NULL) != NULL) {
+			printk("oops, node %s doesn't have #interrupt-cells\n",
+			       p->full_name);
+			return 1;
+		}
+	}
+	printk("prom_n_intr_cells failed for %s\n", np->full_name);
+	return 1;
+}
 
-	/* We assume default interrupt cell size is 1 (bugus ?) */
-	isize = 1;
-	node = np;
-	
-	do {
-	    /* We adjust the cell size if the current parent contains an #interrupt-cells
-	     * property */
-	    isizep = (unsigned int *)get_property(node, "#interrupt-cells", &l);
-	    if (isizep)
-	    	isize = *isizep;
-
-	    /* We don't do interrupt cascade (ISA) for now, we stop on the first 
-	     * controller found
-	     */
-	    if (get_property(node, "interrupt-controller", &l)) {
-	    	int i,j;
-		int cvt_irq;
-
-		/* XXX on chrp, offset interrupt numbers for the
-		   8259 by 0, those for the openpic by 16 */
-		cvt_irq = _machine == _MACH_chrp
-			&& get_property(node, "interrupt-parent", NULL) == 0;
-	    	np->intrs = (struct interrupt_info *) mem_start;
-		np->n_intrs = ipsize / isize;
-		mem_start += np->n_intrs * sizeof(struct interrupt_info);
-		for (i = 0; i < np->n_intrs; ++i) {
-		    np->intrs[i].line = *interrupts++;
-		    if (cvt_irq)
-			np->intrs[i].line = openpic_to_irq(np->intrs[i].line);
-		    np->intrs[i].sense = 1;
-		    if (isize > 1)
-		        np->intrs[i].sense = *interrupts++;
-		    for (j=2; j<isize; j++)
-		    	interrupts++;
+/*
+ * Map an interrupt from a device up to the platform interrupt
+ * descriptor.
+ */
+static int
+map_interrupt(unsigned int **irq, struct device_node **ictrler,
+	      struct device_node *np, unsigned int *ints, int nintrc)
+{
+	struct device_node *p, *ipar;
+	unsigned int *imap, *imask, *ip;
+	int i, imaplen, match;
+	int newintrc, newaddrc;
+	unsigned int *reg;
+	int naddrc;
+
+	reg = (unsigned int *) get_property(np, "reg", NULL);
+	naddrc = prom_n_addr_cells(np);
+	p = intr_parent(np);
+	while (p != NULL) {
+		if (get_property(p, "interrupt-controller", NULL) != NULL)
+			/* this node is an interrupt controller, stop here */
+			break;
+		imap = (unsigned int *)
+			get_property(p, "interrupt-map", &imaplen);
+		if (imap == NULL) {
+			p = intr_parent(p);
+			continue;
 		}
+		imask = (unsigned int *)
+			get_property(p, "interrupt-map-mask", NULL);
+		if (imask == NULL) {
+			printk("oops, %s has interrupt-map but no mask\n",
+			       p->full_name);
+			return 0;
+		}
+		imaplen /= sizeof(unsigned int);
+		match = 0;
+		ipar = NULL;
+		while (imaplen > 0 && !match) {
+			/* check the child-interrupt field */
+			match = 1;
+			for (i = 0; i < naddrc && match; ++i)
+				match = ((reg[i] ^ imap[i]) & imask[i]) == 0;
+			for (; i < naddrc + nintrc && match; ++i)
+				match = ((ints[i-naddrc] ^ imap[i]) & imask[i]) == 0;
+			imap += naddrc + nintrc;
+			imaplen -= naddrc + nintrc;
+			/* grab the interrupt parent */
+			ipar = find_phandle((phandle) *imap++);
+			--imaplen;
+			if (ipar == NULL && num_interrupt_controllers == 1)
+				/* cope with BootX not giving us phandles */
+				ipar = dflt_interrupt_controller;
+			if (ipar == NULL) {
+				printk("oops, no int parent %x in map of %s\n",
+				       imap[-1], p->full_name);
+				return 0;
+			}
+			/* find the parent's # addr and intr cells */
+			ip = (unsigned int *)
+				get_property(ipar, "#interrupt-cells", NULL);
+			if (ip == NULL) {
+				printk("oops, no #interrupt-cells on %s\n",
+				       ipar->full_name);
+				return 0;
+			}
+			newintrc = *ip;
+			ip = (unsigned int *)
+				get_property(ipar, "#address-cells", NULL);
+			newaddrc = (ip == NULL)? 0: *ip;
+			imap += newaddrc + newintrc;
+			imaplen -= newaddrc + newintrc;
+		}
+		if (imaplen < 0) {
+			printk("oops, error decoding int-map on %s, len=%d\n",
+			       p->full_name, imaplen);
+			return 0;
+		}
+		if (!match) {
+			printk("oops, no match in %s int-map for %s\n",
+			       p->full_name, np->full_name);
+			return 0;
+		}
+		p = ipar;
+		naddrc = newaddrc;
+		nintrc = newintrc;
+		ints = imap - nintrc;
+		reg = ints - naddrc;
+	}
+	if (p == NULL)
+		printk("hmmm, int tree for %s doesn't have ctrler\n",
+		       np->full_name);
+	*irq = ints;
+	*ictrler = p;
+	return nintrc;
+}
+
+/*
+ * New version of finish_node_interrupts.
+ */
+static unsigned long
+finish_node_interrupts(struct device_node *np, unsigned long mem_start)
+{
+	unsigned int *ints;
+	int intlen, intrcells;
+	int i, j, n, offset;
+	unsigned int *irq;
+	struct device_node *ic;
+
+	ints = (unsigned int *) get_property(np, "interrupts", &intlen);
+	if (ints == NULL)
 		return mem_start;
-	    }
-	    /* We lookup for an interrupt-map. This code can only handle one interrupt
-	     * per device in the map. We also don't handle #address-cells in the parent
-	     * I skip the pci node itself here, may not be necessary but I don't like it's
-	     * reg property.
-	     */
-	    if (np != node)
-	        map = (unsigned int *)get_property(node, "interrupt-map", &l);
-	     else
-	     	map = NULL;
-	    if (map && l) {
-	    	int i, found, temp_isize;
-	        map_size = l>>2;
-	        map_mask = (unsigned int *)get_property(node, "interrupt-map-mask", &l);
-	        asizep = (unsigned int *)get_property(node, "#address-cells", &l);
-	        if (asizep && l == sizeof(unsigned int))
-	            asize = *asizep;
-	        else
-	            asize = 0;
-	        found = 0;
-	        while(map_size>0 && !found) {
-	            found = 1;
-	            for (i=0; i<asize; i++) {
-	            	unsigned int mask = map_mask ? map_mask[i] : 0xffffffff;
-	            	if (!reg || (i>=regpsize) || ((mask & *map) != (mask & reg[i])))
-	           	    found = 0;
-	           	map++;
-	           	map_size--;
-	            }
-	            for (i=0; i<isize; i++) {
-	            	unsigned int mask = map_mask ? map_mask[i+asize] : 0xffffffff;
-	            	if ((mask & *map) != (mask & interrupts[i]))
-	            	    found = 0;
-	            	map++;
-	            	map_size--;
-	            }
-	            parent = *((phandle *)(map));
-	            map+=1; map_size-=1;
-	            parent_node = find_phandle(parent);
-	            temp_isize = isize;
-	            if (parent_node) {
-			isizep = (unsigned int *)get_property(parent_node, "#interrupt-cells", &l);
-	    		if (isizep)
-	    		    temp_isize = *isizep;
-	            }
-	            if (!found) {
-	            	map += temp_isize;
-	            	map_size-=temp_isize;
-	            }
-	        }
-	        if (found) {
-	            node = parent_node;
-	            reg = NULL;
-	            regpsize = 0;
-	            interrupts = (unsigned int *)map;
-	            ipsize = temp_isize*1;
-		    continue;
-	        }
-	    }
-	    /* We look for an explicit interrupt-parent.
-	     */
-	    parent = (phandle *)get_property(node, "interrupt-parent", &l);
-	    if (parent && (l == sizeof(phandle)) &&
-	    	(parent_node = find_phandle(*parent))) {
-	    	node = parent_node;
-	    	continue;
-	    }
-	    /* Default, get real parent */
-	    node = node->parent;
-	} while(node);
+	intrcells = prom_n_intr_cells(np);
+	intlen /= intrcells * sizeof(unsigned int);
+	np->n_intrs = intlen;
+	np->intrs = (struct interrupt_info *) mem_start;
+	mem_start += intlen * sizeof(struct interrupt_info);
+
+	for (i = 0; i < intlen; ++i) {
+		np->intrs[i].line = 0;
+		np->intrs[i].sense = 1;
+		n = map_interrupt(&irq, &ic, np, ints, intrcells);
+		if (n <= 0)
+			continue;
+		offset = 0;
+		/*
+		 * On a CHRP we have an 8259 which is subordinate to
+		 * the openpic in the interrupt tree, but we want the
+		 * openpic's interrupt numbers offsetted, not the 8259's.
+		 * So we apply the offset if the controller is at the
+		 * root of the interrupt tree, i.e. has no interrupt-parent.
+		 * This doesn't cope with the general case of multiple
+		 * cascaded interrupt controllers, but then neither will
+		 * irq.c at the moment either.  -- paulus
+		 */
+		if (num_interrupt_controllers > 1 && ic != NULL
+		    && get_property(ic, "interrupt-parent", NULL) == NULL)
+			offset = 16;
+		np->intrs[i].line = irq[0] + offset;
+		if (n > 1)
+			np->intrs[i].sense = irq[1];
+		if (n > 2) {
+			printk("hmmm, got %d intr cells for %s:", n,
+			       np->full_name);
+			for (j = 0; j < n; ++j)
+				printk(" %d", irq[j]);
+			printk("\n");
+		}
+		ints += intrcells;
+	}
 
 	return mem_start;
 }
 
-
 /*
  * When BootX makes a copy of the device tree from the MacOS
  * Name Registry, it is in the format we use but all of the pointers
@@ -1475,7 +1585,7 @@
 		ip = (int *) get_property(np, "#address-cells", 0);
 		if (ip != NULL)
 			return *ip;
-	} while(np->parent);
+	} while (np->parent);
 	/* No #address-cells property for the root node, default to 1 */
 	return 1;
 }
@@ -1490,7 +1600,7 @@
 		ip = (int *) get_property(np, "#size-cells", 0);
 		if (ip != NULL)
 			return *ip;
-	} while(np->parent);
+	} while (np->parent);
 	/* No #size-cells property for the root node, default to 1 */
 	return 1;
 }
@@ -1502,8 +1612,7 @@
 {
 	struct address_range *adr;
 	struct pci_reg_property *pci_addrs;
-	int i, l, *ip, ml;
-	struct pci_intr_map *imp;
+	int i, l, *ip;
 
 	pci_addrs = (struct pci_reg_property *)
 		get_property(np, "assigned-addresses", &l);
@@ -1525,44 +1634,6 @@
 	if (use_of_interrupt_tree)
 		return mem_start;
 
-	/*
-	 * If the pci host bridge has an interrupt-map property,
-	 * look for our node in it.
-	 */
-	if (np->parent != 0 && pci_addrs != 0
-	    && (imp = (struct pci_intr_map *)
-		get_property(np->parent, "interrupt-map", &ml)) != 0
-	    && (ip = (int *) get_property(np, "interrupts", &l)) != 0) {
-		unsigned int devfn = pci_addrs[0].addr.a_hi & 0xff00;
-		unsigned int cell_size;
-		struct device_node* np2;
-		/* This is hackish, but is only used for BootX booting */
-		cell_size = sizeof(struct pci_intr_map);
-		np2 = np->parent;
-		while(np2) {
-			if (device_is_compatible(np2, "uni-north")) {
-				cell_size += 4;
-				break;
-			}
-			np2 = np2->parent;
-		}
-		np->n_intrs = 0;
-		np->intrs = (struct interrupt_info *) mem_start;
-		for (i = 0; (ml -= cell_size) >= 0; ++i) {
-			if (imp->addr.a_hi == devfn) {
-				np->intrs[np->n_intrs].line = imp->intr;
-				np->intrs[np->n_intrs].sense = 1; /* FIXME */
-				++np->n_intrs;
-			}
-			imp = (struct pci_intr_map *)(((unsigned int)imp)
-				+ cell_size);
-		}
-		if (np->n_intrs == 0)
-			np->intrs = 0;
-		mem_start += np->n_intrs * sizeof(struct interrupt_info);
-		return mem_start;
-	}
-
 	ip = (int *) get_property(np, "AAPL,interrupts", &l);
 	if (ip == 0 && np->parent)
 		ip = (int *) get_property(np->parent, "AAPL,interrupts", &l);
@@ -1677,26 +1748,10 @@
 		ip = (int *) get_property(np, "AAPL,interrupts", &l);
 	if (ip != 0) {
 		np->intrs = (struct interrupt_info *) mem_start;
-		if (_machine == _MACH_Pmac) {
-			/* for the iMac */
-			np->n_intrs = l / sizeof(int);
-			/* Hack for BootX on Core99 */
-			if (keylargo)
-				np->n_intrs = np->n_intrs/2;
-			for (i = 0; i < np->n_intrs; ++i) {
-				np->intrs[i].line = *ip++;
-				if (keylargo)
-					np->intrs[i].sense = *ip++;
-				else
-					np->intrs[i].sense = 1;
-			}
-		} else {
-			/* CHRP machines */
-			np->n_intrs = l / (2 * sizeof(int));
-			for (i = 0; i < np->n_intrs; ++i) {
-				np->intrs[i].line = openpic_to_irq(*ip++);
-				np->intrs[i].sense = *ip++;
-			}
+		np->n_intrs = l / sizeof(int);
+		for (i = 0; i < np->n_intrs; ++i) {
+			np->intrs[i].line = *ip++;
+			np->intrs[i].sense = 1;
 		}
 		mem_start += np->n_intrs * sizeof(struct interrupt_info);
 	}
@@ -1978,13 +2033,12 @@
 {
 	struct property *pp;
 
-	for (pp = np->properties; pp != 0; pp = pp->next) {
+	for (pp = np->properties; pp != 0; pp = pp->next)
 		if (pp->name != NULL && strcmp(pp->name, name) == 0) {
 			if (lenp != 0)
 				*lenp = pp->length;
 			return pp->value;
 		}
-	}
 	return 0;
 }
 
