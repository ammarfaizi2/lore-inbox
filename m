Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbUDOHF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 03:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbUDOHF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 03:05:58 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:41965 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S263843AbUDOHEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 03:04:43 -0400
Subject: [PATCH] Reorder arch/ppc64/kernel/prom.c
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Cc: Anton Blanchard <anton@samba.org>
Content-Type: text/plain
Message-Id: <1082012627.17782.163.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 17:03:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Clean Up Select prom.c Prototypes
Status: Trivial
Version: ppc64

prom.c pre-declares various static functions.  This makes it a PITA to
navigate and alter.

Rearrange them as a C programmer would.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17232-linux-ppc64-2.5/arch/ppc64/kernel/prom.c .17232-linux-ppc64-2.5.updated/arch/ppc64/kernel/prom.c
--- .17232-linux-ppc64-2.5/arch/ppc64/kernel/prom.c	2004-04-13 18:06:15.000000000 +1000
+++ .17232-linux-ppc64-2.5.updated/arch/ppc64/kernel/prom.c	2004-04-15 16:58:25.000000000 +1000
@@ -161,25 +161,6 @@ struct device_node *allnodes = 0;
  */
 static rwlock_t devtree_lock = RW_LOCK_UNLOCKED;
 
-static unsigned long call_prom(const char *service, int nargs, int nret, ...);
-static void prom_panic(const char *reason);
-static unsigned long copy_device_tree(unsigned long);
-static unsigned long inspect_node(phandle, struct device_node *, unsigned long,
-				  unsigned long, struct device_node ***);
-static unsigned long finish_node(struct device_node *, unsigned long,
-				 interpret_func *, int, int);
-static unsigned long finish_node_interrupts(struct device_node *, unsigned long);
-static unsigned long check_display(unsigned long);
-static int prom_next_node(phandle *);
-static struct bi_record * prom_bi_rec_verify(struct bi_record *);
-static unsigned long prom_bi_rec_reserve(unsigned long);
-static struct device_node *find_phandle(phandle);
-static void of_node_cleanup(struct device_node *);
-static struct device_node *derive_parent(const char *);
-static void add_node_proc_entries(struct device_node *);
-static void remove_node_proc_entries(struct device_node *);
-static int of_finish_dynamic_node(struct device_node *);
-
 #ifdef DEBUG_PROM
 void prom_dump_lmb(void);
 #endif
@@ -304,6 +285,24 @@ prom_print_nl(void)
 	prom_print(RELOC("\n"));
 }
 
+static int __init
+prom_next_node(phandle *nodep)
+{
+	phandle node;
+	unsigned long offset = reloc_offset();
+
+	if ((node = *nodep) != 0
+	    && (*nodep = call_prom(RELOC("child"), 1, 1, node)) != 0)
+		return 1;
+	if ((*nodep = call_prom(RELOC("peer"), 1, 1, node)) != 0)
+		return 1;
+	for (;;) {
+		if ((node = call_prom(RELOC("parent"), 1, 1, node)) == 0)
+			return 0;
+		if ((*nodep = call_prom(RELOC("peer"), 1, 1, node)) != 0)
+			return 1;
+	}
+}
 
 static unsigned long
 prom_initialize_naca(unsigned long mem)
@@ -1441,170 +1440,186 @@ static int __init prom_find_machine_type
 	return PLATFORM_PSERIES;
 }
 
-/*
- * We enter here early on, when the Open Firmware prom is still
- * handling exceptions and the MMU hash table for us.
- */
-
-unsigned long __init
-prom_init(unsigned long r3, unsigned long r4, unsigned long pp,
-	  unsigned long r6, unsigned long r7)
+static unsigned long __init
+inspect_node(phandle node, struct device_node *dad,
+	     unsigned long mem_start, unsigned long mem_end,
+	     struct device_node ***allnextpp)
 {
-	unsigned long mem;
-	ihandle prom_cpu;
-	phandle cpu_pkg;
+	int l;
+	phandle child;
+	struct device_node *np;
+	struct property *pp, **prev_propp;
+	char *prev_name, *namep;
+	unsigned char *valp;
 	unsigned long offset = reloc_offset();
-	long l;
-	char *p, *d;
-	unsigned long phys;
-	u32 getprop_rval;
-	struct systemcfg *_systemcfg;
-	struct paca_struct *_xPaca = PTRRELOC(&paca[0]);
-	struct prom_t *_prom = PTRRELOC(&prom);
-
-	/* First zero the BSS -- use memset, some arches don't have
-	 * caches on yet */
-	memset(PTRRELOC(&__bss_start), 0, __bss_stop - __bss_start);
 
-	/* Setup systemcfg and NACA pointers now */
-	RELOC(systemcfg) = _systemcfg = (struct systemcfg *)(SYSTEMCFG_VIRT_ADDR - offset);
-	RELOC(naca) = (struct naca_struct *)(NACA_VIRT_ADDR - offset);
-
-	/* Init interface to Open Firmware and pickup bi-recs */
-	prom_init_client_services(pp);
-
-	/* Init prom stdout device */
-	prom_init_stdout();
-
-	/* check out if we have bi_recs */
-	_prom->bi_recs = prom_bi_rec_verify((struct bi_record *)r6);
-	if ( _prom->bi_recs != NULL )
-		RELOC(klimit) = PTRUNRELOC((unsigned long)_prom->bi_recs +
-					   _prom->bi_recs->data[1]);
-
-	/* Default machine type. */
-	_systemcfg->platform = prom_find_machine_type();
-
-	/* On pSeries, copy the CPU hold code */
-	if (_systemcfg->platform == PLATFORM_PSERIES)
-		copy_and_flush(0, KERNELBASE - offset, 0x100, 0);
-
-	/* Start storing things at klimit */
-      	mem = RELOC(klimit) - offset; 
+	np = (struct device_node *) mem_start;
+	mem_start += sizeof(struct device_node);
+	memset(np, 0, sizeof(*np));
+	np->node = node;
+	**allnextpp = PTRUNRELOC(np);
+	*allnextpp = &np->allnext;
+	if (dad != 0) {
+		np->parent = PTRUNRELOC(dad);
+		/* we temporarily use the `next' field as `last_child'. */
+		if (dad->next == 0)
+			dad->child = PTRUNRELOC(np);
+		else
+			dad->next->sibling = PTRUNRELOC(np);
+		dad->next = np;
+	}
 
-	/* Get the full OF pathname of the stdout device */
-	p = (char *) mem;
-	memset(p, 0, 256);
-	call_prom(RELOC("instance-to-path"), 3, 1, _prom->stdout, p, 255);
-	RELOC(of_stdout_device) = PTRUNRELOC(p);
-	mem += strlen(p) + 1;
+	/* get and store all properties */
+	prev_propp = &np->properties;
+	prev_name = RELOC("");
+	for (;;) {
+		pp = (struct property *) mem_start;
+		namep = (char *) (pp + 1);
+		pp->name = PTRUNRELOC(namep);
+		if ((long) call_prom(RELOC("nextprop"), 3, 1, node, prev_name,
+				    namep) <= 0)
+			break;
+		mem_start = DOUBLEWORD_ALIGN((unsigned long)namep + strlen(namep) + 1);
+		prev_name = namep;
+		valp = (unsigned char *) mem_start;
+		pp->value = PTRUNRELOC(valp);
+		pp->length = (int)(long)
+			call_prom(RELOC("getprop"), 4, 1, node, namep,
+				  valp, mem_end - mem_start);
+		if (pp->length < 0)
+			continue;
+		if (pp->length > MAX_PROPERTY_LENGTH) {
+			char path[128];
 
-	getprop_rval = 1;
-	call_prom(RELOC("getprop"), 4, 1,
-		  _prom->root, RELOC("#size-cells"),
-		  &getprop_rval, sizeof(getprop_rval));
-	_prom->encode_phys_size = (getprop_rval == 1) ? 32 : 64;
+			prom_print(RELOC("WARNING: ignoring large property "));
+			/* It seems OF doesn't null-terminate the path :-( */
+			memset(path, 0, sizeof(path));
+			if (call_prom(RELOC("package-to-path"), 3, 1, node,
+                            path, sizeof(path)-1) > 0)
+				prom_print(path);
+			prom_print(namep);
+			prom_print(RELOC(" length 0x"));
+			prom_print_hex(pp->length);
+			prom_print_nl();
 
-	/* Determine which cpu is actually running right _now_ */
-        if ((long)call_prom(RELOC("getprop"), 4, 1, _prom->chosen,
-			    RELOC("cpu"), &getprop_rval,
-			    sizeof(getprop_rval)) <= 0)
-                prom_panic(RELOC("cannot find boot cpu"));
+			continue;
+		}
+		mem_start = DOUBLEWORD_ALIGN(mem_start + pp->length);
+		*prev_propp = PTRUNRELOC(pp);
+		prev_propp = &pp->next;
+	}
 
-	prom_cpu = (ihandle)(unsigned long)getprop_rval;
-	cpu_pkg = call_prom(RELOC("instance-to-package"), 1, 1, prom_cpu);
-	call_prom(RELOC("getprop"), 4, 1,
-		cpu_pkg, RELOC("reg"),
-		&getprop_rval, sizeof(getprop_rval));
-	_prom->cpu = (int)(unsigned long)getprop_rval;
-	_xPaca[0].xHwProcNum = _prom->cpu;
+	/* Add a "linux_phandle" value */
+        if (np->node) {
+		u32 ibm_phandle = 0;
+		int len;
 
-	RELOC(boot_cpuid) = 0;
+                /* First see if "ibm,phandle" exists and use its value */
+                len = (int)
+                        call_prom(RELOC("getprop"), 4, 1, node, RELOC("ibm,phandle"),
+                                  &ibm_phandle, sizeof(ibm_phandle));
+                if (len < 0) {
+                        np->linux_phandle = np->node;
+                } else {
+                        np->linux_phandle = ibm_phandle;
+		}
+	}
 
-#ifdef DEBUG_PROM
-  	prom_print(RELOC("Booting CPU hw index = 0x"));
-  	prom_print_hex(_prom->cpu);
-  	prom_print_nl();
-#endif
+	*prev_propp = 0;
 
-	/* Get the boot device and translate it to a full OF pathname. */
-	p = (char *) mem;
-	l = (long) call_prom(RELOC("getprop"), 4, 1, _prom->chosen,
-			    RELOC("bootpath"), p, 1<<20);
-	if (l > 0) {
-		p[l] = 0;	/* should already be null-terminated */
-		RELOC(bootpath) = PTRUNRELOC(p);
-		mem += l + 1;
-		d = (char *) mem;
-		*d = 0;
-		call_prom(RELOC("canon"), 3, 1, p, d, 1<<20);
-		RELOC(bootdevice) = PTRUNRELOC(d);
-		mem = DOUBLEWORD_ALIGN(mem + strlen(d) + 1);
+	/* get the node's full name */
+	l = (long) call_prom(RELOC("package-to-path"), 3, 1, node,
+			    (char *) mem_start, mem_end - mem_start);
+	if (l >= 0) {
+		np->full_name = PTRUNRELOC((char *) mem_start);
+		*(char *)(mem_start + l) = 0;
+		mem_start = DOUBLEWORD_ALIGN(mem_start + l + 1);
 	}
 
-	RELOC(cmd_line[0]) = 0;
-	if ((long)_prom->chosen > 0) {
-		call_prom(RELOC("getprop"), 4, 1, _prom->chosen, 
-			  RELOC("bootargs"), p, sizeof(cmd_line));
-		if (p != NULL && p[0] != 0)
-			strlcpy(RELOC(cmd_line), p, sizeof(cmd_line));
+	/* do all our children */
+	child = call_prom(RELOC("child"), 1, 1, node);
+	while (child != (phandle)0) {
+		mem_start = inspect_node(child, np, mem_start, mem_end,
+					 allnextpp);
+		child = call_prom(RELOC("peer"), 1, 1, child);
 	}
 
-	early_cmdline_parse();
-
-	mem = prom_initialize_lmb(mem);
+	return mem_start;
+}
 
-	mem = prom_bi_rec_reserve(mem);
+/*
+ * Make a copy of the device tree from the PROM.
+ */
+static unsigned long __init
+copy_device_tree(unsigned long mem_start)
+{
+	phandle root;
+	unsigned long new_start;
+	struct device_node **allnextp;
+	unsigned long offset = reloc_offset();
+	unsigned long mem_end = mem_start + (8<<20);
 
-	mem = check_display(mem);
+	root = call_prom(RELOC("peer"), 1, 1, (phandle)0);
+	if (root == (phandle)0) {
+		prom_panic(RELOC("couldn't get device tree root\n"));
+	}
+	allnextp = &RELOC(allnodes);
+	mem_start = DOUBLEWORD_ALIGN(mem_start);
+	new_start = inspect_node(root, 0, mem_start, mem_end, &allnextp);
+	*allnextp = 0;
+	return new_start;
+}
 
-	if (_systemcfg->platform != PLATFORM_POWERMAC)
-		prom_instantiate_rtas();
-        
-        /* Initialize some system info into the Naca early... */
-        mem = prom_initialize_naca(mem);
+/* Verify bi_recs are good */
+static struct bi_record *
+prom_bi_rec_verify(struct bi_record *bi_recs)
+{
+	struct bi_record *first, *last;
 
-	smt_setup();
-	
-        /* If we are on an SMP machine, then we *MUST* do the
-         * following, regardless of whether we have an SMP
-         * kernel or not.
-         */
-	prom_hold_cpus(mem);
+	if ( bi_recs == NULL || bi_recs->tag != BI_FIRST )
+		return NULL;
 
-#ifdef DEBUG_PROM
-	prom_print(RELOC("copying OF device tree...\n"));
-#endif
-	mem = copy_device_tree(mem);
+	last = (struct bi_record *)(long)bi_recs->data[0];
+	if ( last == NULL || last->tag != BI_LAST )
+		return NULL;
 
-	RELOC(klimit) = mem + offset;
+	first = (struct bi_record *)(long)last->data[0];
+	if ( first == NULL || first != bi_recs )
+		return NULL;
 
-	lmb_reserve(0, __pa(RELOC(klimit)));
+	return bi_recs;
+}
 
-	if (_systemcfg->platform == PLATFORM_PSERIES)
-		prom_initialize_tce_table();
+static unsigned long
+prom_bi_rec_reserve(unsigned long mem)
+{
+	unsigned long offset = reloc_offset();
+	struct prom_t *_prom = PTRRELOC(&prom);
+	struct bi_record *rec;
 
-#ifdef CONFIG_PMAC_DART
-	if (_systemcfg->platform == PLATFORM_POWERMAC)
-		prom_initialize_dart_table();
-#endif
+	if ( _prom->bi_recs != NULL) {
 
-#ifdef CONFIG_BOOTX_TEXT
-	if(_prom->disp_node) {
-		prom_print(RELOC("Setting up bi display...\n"));
-		setup_disp_fake_bi(_prom->disp_node);
+		for ( rec=_prom->bi_recs;
+		      rec->tag != BI_LAST;
+		      rec=bi_rec_next(rec) ) {
+			switch (rec->tag) {
+#ifdef CONFIG_BLK_DEV_INITRD
+			case BI_INITRD:
+				lmb_reserve(rec->data[0], rec->data[1]);
+				break;
+#endif /* CONFIG_BLK_DEV_INITRD */
+			}
+		}
+		/* The next use of this field will be after relocation
+	 	 * is enabled, so convert this physical address into a
+	 	 * virtual address.
+	 	 */
+		_prom->bi_recs = PTRUNRELOC(_prom->bi_recs);
 	}
-#endif /* CONFIG_BOOTX_TEXT */
 
-	prom_print(RELOC("Calling quiesce ...\n"));
-	call_prom(RELOC("quiesce"), 0, 0);
-	phys = KERNELBASE - offset;
-
-	prom_print(RELOC("returning from prom_init\n"));
-	return phys;
+	return mem;
 }
 
-
 static int
 prom_set_color(ihandle ih, int i, int r, int g, int b)
 {
@@ -1742,237 +1757,185 @@ check_display(unsigned long mem)
 	return DOUBLEWORD_ALIGN(mem);
 }
 
+/*
+ * We enter here early on, when the Open Firmware prom is still
+ * handling exceptions and the MMU hash table for us.
+ */
 
-static int __init
-prom_next_node(phandle *nodep)
+unsigned long __init
+prom_init(unsigned long r3, unsigned long r4, unsigned long pp,
+	  unsigned long r6, unsigned long r7)
 {
-	phandle node;
+	unsigned long mem;
+	ihandle prom_cpu;
+	phandle cpu_pkg;
 	unsigned long offset = reloc_offset();
+	long l;
+	char *p, *d;
+	unsigned long phys;
+	u32 getprop_rval;
+	struct systemcfg *_systemcfg;
+	struct paca_struct *_xPaca = PTRRELOC(&paca[0]);
+	struct prom_t *_prom = PTRRELOC(&prom);
 
-	if ((node = *nodep) != 0
-	    && (*nodep = call_prom(RELOC("child"), 1, 1, node)) != 0)
-		return 1;
-	if ((*nodep = call_prom(RELOC("peer"), 1, 1, node)) != 0)
-		return 1;
-	for (;;) {
-		if ((node = call_prom(RELOC("parent"), 1, 1, node)) == 0)
-			return 0;
-		if ((*nodep = call_prom(RELOC("peer"), 1, 1, node)) != 0)
-			return 1;
-	}
-}
+	/* First zero the BSS -- use memset, some arches don't have
+	 * caches on yet */
+	memset(PTRRELOC(&__bss_start), 0, __bss_stop - __bss_start);
 
-/*
- * Make a copy of the device tree from the PROM.
- */
-static unsigned long __init
-copy_device_tree(unsigned long mem_start)
-{
-	phandle root;
-	unsigned long new_start;
-	struct device_node **allnextp;
-	unsigned long offset = reloc_offset();
-	unsigned long mem_end = mem_start + (8<<20);
+	/* Setup systemcfg and NACA pointers now */
+	RELOC(systemcfg) = _systemcfg = (struct systemcfg *)(SYSTEMCFG_VIRT_ADDR - offset);
+	RELOC(naca) = (struct naca_struct *)(NACA_VIRT_ADDR - offset);
 
-	root = call_prom(RELOC("peer"), 1, 1, (phandle)0);
-	if (root == (phandle)0) {
-		prom_panic(RELOC("couldn't get device tree root\n"));
-	}
-	allnextp = &RELOC(allnodes);
-	mem_start = DOUBLEWORD_ALIGN(mem_start);
-	new_start = inspect_node(root, 0, mem_start, mem_end, &allnextp);
-	*allnextp = 0;
-	return new_start;
-}
+	/* Init interface to Open Firmware and pickup bi-recs */
+	prom_init_client_services(pp);
 
-static unsigned long __init
-inspect_node(phandle node, struct device_node *dad,
-	     unsigned long mem_start, unsigned long mem_end,
-	     struct device_node ***allnextpp)
-{
-	int l;
-	phandle child;
-	struct device_node *np;
-	struct property *pp, **prev_propp;
-	char *prev_name, *namep;
-	unsigned char *valp;
-	unsigned long offset = reloc_offset();
+	/* Init prom stdout device */
+	prom_init_stdout();
 
-	np = (struct device_node *) mem_start;
-	mem_start += sizeof(struct device_node);
-	memset(np, 0, sizeof(*np));
-	np->node = node;
-	**allnextpp = PTRUNRELOC(np);
-	*allnextpp = &np->allnext;
-	if (dad != 0) {
-		np->parent = PTRUNRELOC(dad);
-		/* we temporarily use the `next' field as `last_child'. */
-		if (dad->next == 0)
-			dad->child = PTRUNRELOC(np);
-		else
-			dad->next->sibling = PTRUNRELOC(np);
-		dad->next = np;
-	}
+	/* check out if we have bi_recs */
+	_prom->bi_recs = prom_bi_rec_verify((struct bi_record *)r6);
+	if ( _prom->bi_recs != NULL )
+		RELOC(klimit) = PTRUNRELOC((unsigned long)_prom->bi_recs +
+					   _prom->bi_recs->data[1]);
 
-	/* get and store all properties */
-	prev_propp = &np->properties;
-	prev_name = RELOC("");
-	for (;;) {
-		pp = (struct property *) mem_start;
-		namep = (char *) (pp + 1);
-		pp->name = PTRUNRELOC(namep);
-		if ((long) call_prom(RELOC("nextprop"), 3, 1, node, prev_name,
-				    namep) <= 0)
-			break;
-		mem_start = DOUBLEWORD_ALIGN((unsigned long)namep + strlen(namep) + 1);
-		prev_name = namep;
-		valp = (unsigned char *) mem_start;
-		pp->value = PTRUNRELOC(valp);
-		pp->length = (int)(long)
-			call_prom(RELOC("getprop"), 4, 1, node, namep,
-				  valp, mem_end - mem_start);
-		if (pp->length < 0)
-			continue;
-		if (pp->length > MAX_PROPERTY_LENGTH) {
-			char path[128];
+	/* Default machine type. */
+	_systemcfg->platform = prom_find_machine_type();
 
-			prom_print(RELOC("WARNING: ignoring large property "));
-			/* It seems OF doesn't null-terminate the path :-( */
-			memset(path, 0, sizeof(path));
-			if (call_prom(RELOC("package-to-path"), 3, 1, node,
-                            path, sizeof(path)-1) > 0)
-				prom_print(path);
-			prom_print(namep);
-			prom_print(RELOC(" length 0x"));
-			prom_print_hex(pp->length);
-			prom_print_nl();
+	/* On pSeries, copy the CPU hold code */
+	if (_systemcfg->platform == PLATFORM_PSERIES)
+		copy_and_flush(0, KERNELBASE - offset, 0x100, 0);
 
-			continue;
-		}
-		mem_start = DOUBLEWORD_ALIGN(mem_start + pp->length);
-		*prev_propp = PTRUNRELOC(pp);
-		prev_propp = &pp->next;
-	}
+	/* Start storing things at klimit */
+      	mem = RELOC(klimit) - offset; 
 
-	/* Add a "linux_phandle" value */
-        if (np->node) {
-		u32 ibm_phandle = 0;
-		int len;
+	/* Get the full OF pathname of the stdout device */
+	p = (char *) mem;
+	memset(p, 0, 256);
+	call_prom(RELOC("instance-to-path"), 3, 1, _prom->stdout, p, 255);
+	RELOC(of_stdout_device) = PTRUNRELOC(p);
+	mem += strlen(p) + 1;
 
-                /* First see if "ibm,phandle" exists and use its value */
-                len = (int)
-                        call_prom(RELOC("getprop"), 4, 1, node, RELOC("ibm,phandle"),
-                                  &ibm_phandle, sizeof(ibm_phandle));
-                if (len < 0) {
-                        np->linux_phandle = np->node;
-                } else {
-                        np->linux_phandle = ibm_phandle;
-		}
-	}
+	getprop_rval = 1;
+	call_prom(RELOC("getprop"), 4, 1,
+		  _prom->root, RELOC("#size-cells"),
+		  &getprop_rval, sizeof(getprop_rval));
+	_prom->encode_phys_size = (getprop_rval == 1) ? 32 : 64;
 
-	*prev_propp = 0;
+	/* Determine which cpu is actually running right _now_ */
+        if ((long)call_prom(RELOC("getprop"), 4, 1, _prom->chosen,
+			    RELOC("cpu"), &getprop_rval,
+			    sizeof(getprop_rval)) <= 0)
+                prom_panic(RELOC("cannot find boot cpu"));
 
-	/* get the node's full name */
-	l = (long) call_prom(RELOC("package-to-path"), 3, 1, node,
-			    (char *) mem_start, mem_end - mem_start);
-	if (l >= 0) {
-		np->full_name = PTRUNRELOC((char *) mem_start);
-		*(char *)(mem_start + l) = 0;
-		mem_start = DOUBLEWORD_ALIGN(mem_start + l + 1);
+	prom_cpu = (ihandle)(unsigned long)getprop_rval;
+	cpu_pkg = call_prom(RELOC("instance-to-package"), 1, 1, prom_cpu);
+	call_prom(RELOC("getprop"), 4, 1,
+		cpu_pkg, RELOC("reg"),
+		&getprop_rval, sizeof(getprop_rval));
+	_prom->cpu = (int)(unsigned long)getprop_rval;
+	_xPaca[0].xHwProcNum = _prom->cpu;
+
+	RELOC(boot_cpuid) = 0;
+
+#ifdef DEBUG_PROM
+  	prom_print(RELOC("Booting CPU hw index = 0x"));
+  	prom_print_hex(_prom->cpu);
+  	prom_print_nl();
+#endif
+
+	/* Get the boot device and translate it to a full OF pathname. */
+	p = (char *) mem;
+	l = (long) call_prom(RELOC("getprop"), 4, 1, _prom->chosen,
+			    RELOC("bootpath"), p, 1<<20);
+	if (l > 0) {
+		p[l] = 0;	/* should already be null-terminated */
+		RELOC(bootpath) = PTRUNRELOC(p);
+		mem += l + 1;
+		d = (char *) mem;
+		*d = 0;
+		call_prom(RELOC("canon"), 3, 1, p, d, 1<<20);
+		RELOC(bootdevice) = PTRUNRELOC(d);
+		mem = DOUBLEWORD_ALIGN(mem + strlen(d) + 1);
 	}
 
-	/* do all our children */
-	child = call_prom(RELOC("child"), 1, 1, node);
-	while (child != (phandle)0) {
-		mem_start = inspect_node(child, np, mem_start, mem_end,
-					 allnextpp);
-		child = call_prom(RELOC("peer"), 1, 1, child);
+	RELOC(cmd_line[0]) = 0;
+	if ((long)_prom->chosen > 0) {
+		call_prom(RELOC("getprop"), 4, 1, _prom->chosen, 
+			  RELOC("bootargs"), p, sizeof(cmd_line));
+		if (p != NULL && p[0] != 0)
+			strlcpy(RELOC(cmd_line), p, sizeof(cmd_line));
 	}
 
-	return mem_start;
-}
+	early_cmdline_parse();
 
-/*
- * finish_device_tree is called once things are running normally
- * (i.e. with text and data mapped to the address they were linked at).
- * It traverses the device tree and fills in the name, type,
- * {n_}addrs and {n_}intrs fields of each node.
- */
-void __init
-finish_device_tree(void)
-{
-	unsigned long mem = klimit;
+	mem = prom_initialize_lmb(mem);
 
-	virt_irq_init();
+	mem = prom_bi_rec_reserve(mem);
 
-	mem = finish_node(allnodes, mem, NULL, 0, 0);
-	dev_tree_size = mem - (unsigned long) allnodes;
+	mem = check_display(mem);
 
-	mem = _ALIGN(mem, PAGE_SIZE);
-	lmb_reserve(__pa(klimit), mem-klimit);
+	if (_systemcfg->platform != PLATFORM_POWERMAC)
+		prom_instantiate_rtas();
+        
+        /* Initialize some system info into the Naca early... */
+        mem = prom_initialize_naca(mem);
 
-	klimit = mem;
+	smt_setup();
+	
+        /* If we are on an SMP machine, then we *MUST* do the
+         * following, regardless of whether we have an SMP
+         * kernel or not.
+         */
+	prom_hold_cpus(mem);
 
-	rtas.dev = of_find_node_by_name(NULL, "rtas");
-}
+#ifdef DEBUG_PROM
+	prom_print(RELOC("copying OF device tree...\n"));
+#endif
+	mem = copy_device_tree(mem);
 
-static unsigned long __init
-finish_node(struct device_node *np, unsigned long mem_start,
-	    interpret_func *ifunc, int naddrc, int nsizec)
-{
-	struct device_node *child;
-	int *ip;
+	RELOC(klimit) = mem + offset;
 
-	np->name = get_property(np, "name", 0);
-	np->type = get_property(np, "device_type", 0);
+	lmb_reserve(0, __pa(RELOC(klimit)));
 
-	/* get the device addresses and interrupts */
-	if (ifunc != NULL)
-		mem_start = ifunc(np, mem_start, naddrc, nsizec);
+	if (_systemcfg->platform == PLATFORM_PSERIES)
+		prom_initialize_tce_table();
 
-	mem_start = finish_node_interrupts(np, mem_start);
+#ifdef CONFIG_PMAC_DART
+	if (_systemcfg->platform == PLATFORM_POWERMAC)
+		prom_initialize_dart_table();
+#endif
 
-	/* Look for #address-cells and #size-cells properties. */
-	ip = (int *) get_property(np, "#address-cells", 0);
-	if (ip != NULL)
-		naddrc = *ip;
-	ip = (int *) get_property(np, "#size-cells", 0);
-	if (ip != NULL)
-		nsizec = *ip;
+#ifdef CONFIG_BOOTX_TEXT
+	if(_prom->disp_node) {
+		prom_print(RELOC("Setting up bi display...\n"));
+		setup_disp_fake_bi(_prom->disp_node);
+	}
+#endif /* CONFIG_BOOTX_TEXT */
 
-	/* the f50 sets the name to 'display' and 'compatible' to what we
-	 * expect for the name -- Cort
-	 */
-	if (!strcmp(np->name, "display"))
-		np->name = get_property(np, "compatible", 0);
+	prom_print(RELOC("Calling quiesce ...\n"));
+	call_prom(RELOC("quiesce"), 0, 0);
+	phys = KERNELBASE - offset;
 
-	if (!strcmp(np->name, "device-tree") || np->parent == NULL)
-		ifunc = interpret_root_props;
-	else if (np->type == 0)
-		ifunc = NULL;
-	else if (!strcmp(np->type, "pci") || !strcmp(np->type, "vci"))
-		ifunc = interpret_pci_props;
-	else if (!strcmp(np->type, "dbdma"))
-		ifunc = interpret_dbdma_props;
-	else if (!strcmp(np->type, "mac-io") || ifunc == interpret_macio_props)
-		ifunc = interpret_macio_props;
-	else if (!strcmp(np->type, "isa"))
-		ifunc = interpret_isa_props;
-	else if (!strcmp(np->name, "uni-n") || !strcmp(np->name, "u3"))
-		ifunc = interpret_root_props;
-	else if (!((ifunc == interpret_dbdma_props
-		    || ifunc == interpret_macio_props)
-		   && (!strcmp(np->type, "escc")
-		       || !strcmp(np->type, "media-bay"))))
-		ifunc = NULL;
+	prom_print(RELOC("returning from prom_init\n"));
+	return phys;
+}
 
-	for (child = np->child; child != NULL; child = child->sibling)
-		mem_start = finish_node(child, mem_start, ifunc,
-					naddrc, nsizec);
 
-	return mem_start;
+/*
+ * Find the device_node with a given phandle.
+ */
+static struct device_node * __devinit
+find_phandle(phandle ph)
+{
+	struct device_node *np;
+
+	for (np = allnodes; np != 0; np = np->allnext)
+		if (np->linux_phandle == ph)
+			return np;
+	return NULL;
 }
 
+
 /*
  * Find the interrupt parent of a node.
  */
@@ -1988,34 +1951,6 @@ intr_parent(struct device_node *p)
 }
 
 /*
- * Find out the size of each entry of the interrupts property
- * for a node.
- */
-static int __devinit
-prom_n_intr_cells(struct device_node *np)
-{
-	struct device_node *p;
-	unsigned int *icp;
-
-	for (p = np; (p = intr_parent(p)) != NULL; ) {
-		icp = (unsigned int *)
-			get_property(p, "#interrupt-cells", NULL);
-		if (icp != NULL)
-			return *icp;
-		if (get_property(p, "interrupt-controller", NULL) != NULL
-		    || get_property(p, "interrupt-map", NULL) != NULL) {
-			printk("oops, node %s doesn't have #interrupt-cells\n",
-			       p->full_name);
-		return 1;
-		}
-	}
-#ifdef DEBUG_IRQ
-	printk("prom_n_intr_cells failed for %s\n", np->full_name);
-#endif
-	return 1;
-}
-
-/*
  * Map an interrupt from a device up to the platform interrupt
  * descriptor.
  */
@@ -2114,8 +2049,33 @@ map_interrupt(unsigned int **irq, struct
 }
 
 /*
- * New version of finish_node_interrupts.
+ * Find out the size of each entry of the interrupts property
+ * for a node.
  */
+static int __devinit
+prom_n_intr_cells(struct device_node *np)
+{
+	struct device_node *p;
+	unsigned int *icp;
+
+	for (p = np; (p = intr_parent(p)) != NULL; ) {
+		icp = (unsigned int *)
+			get_property(p, "#interrupt-cells", NULL);
+		if (icp != NULL)
+			return *icp;
+		if (get_property(p, "interrupt-controller", NULL) != NULL
+		    || get_property(p, "interrupt-map", NULL) != NULL) {
+			printk("oops, node %s doesn't have #interrupt-cells\n",
+			       p->full_name);
+		return 1;
+		}
+	}
+#ifdef DEBUG_IRQ
+	printk("prom_n_intr_cells failed for %s\n", np->full_name);
+#endif
+	return 1;
+}
+
 static unsigned long __init
 finish_node_interrupts(struct device_node *np, unsigned long mem_start)
 {
@@ -2168,6 +2128,87 @@ finish_node_interrupts(struct device_nod
 	return mem_start;
 }
 
+static unsigned long __init
+finish_node(struct device_node *np, unsigned long mem_start,
+	    interpret_func *ifunc, int naddrc, int nsizec)
+{
+	struct device_node *child;
+	int *ip;
+
+	np->name = get_property(np, "name", 0);
+	np->type = get_property(np, "device_type", 0);
+
+	/* get the device addresses and interrupts */
+	if (ifunc != NULL)
+		mem_start = ifunc(np, mem_start, naddrc, nsizec);
+
+	mem_start = finish_node_interrupts(np, mem_start);
+
+	/* Look for #address-cells and #size-cells properties. */
+	ip = (int *) get_property(np, "#address-cells", 0);
+	if (ip != NULL)
+		naddrc = *ip;
+	ip = (int *) get_property(np, "#size-cells", 0);
+	if (ip != NULL)
+		nsizec = *ip;
+
+	/* the f50 sets the name to 'display' and 'compatible' to what we
+	 * expect for the name -- Cort
+	 */
+	if (!strcmp(np->name, "display"))
+		np->name = get_property(np, "compatible", 0);
+
+	if (!strcmp(np->name, "device-tree") || np->parent == NULL)
+		ifunc = interpret_root_props;
+	else if (np->type == 0)
+		ifunc = NULL;
+	else if (!strcmp(np->type, "pci") || !strcmp(np->type, "vci"))
+		ifunc = interpret_pci_props;
+	else if (!strcmp(np->type, "dbdma"))
+		ifunc = interpret_dbdma_props;
+	else if (!strcmp(np->type, "mac-io") || ifunc == interpret_macio_props)
+		ifunc = interpret_macio_props;
+	else if (!strcmp(np->type, "isa"))
+		ifunc = interpret_isa_props;
+	else if (!strcmp(np->name, "uni-n") || !strcmp(np->name, "u3"))
+		ifunc = interpret_root_props;
+	else if (!((ifunc == interpret_dbdma_props
+		    || ifunc == interpret_macio_props)
+		   && (!strcmp(np->type, "escc")
+		       || !strcmp(np->type, "media-bay"))))
+		ifunc = NULL;
+
+	for (child = np->child; child != NULL; child = child->sibling)
+		mem_start = finish_node(child, mem_start, ifunc,
+					naddrc, nsizec);
+
+	return mem_start;
+}
+
+/*
+ * finish_device_tree is called once things are running normally
+ * (i.e. with text and data mapped to the address they were linked at).
+ * It traverses the device tree and fills in the name, type,
+ * {n_}addrs and {n_}intrs fields of each node.
+ */
+void __init
+finish_device_tree(void)
+{
+	unsigned long mem = klimit;
+
+	virt_irq_init();
+
+	mem = finish_node(allnodes, mem, NULL, 0, 0);
+	dev_tree_size = mem - (unsigned long) allnodes;
+
+	mem = _ALIGN(mem, PAGE_SIZE);
+	lmb_reserve(__pa(klimit), mem-klimit);
+
+	klimit = mem;
+
+	rtas.dev = of_find_node_by_name(NULL, "rtas");
+}
+
 int
 prom_n_addr_cells(struct device_node* np)
 {
@@ -2719,6 +2760,29 @@ struct device_node *of_node_get(struct d
 EXPORT_SYMBOL(of_node_get);
 
 /**
+ *	of_node_cleanup - release a dynamically allocated node
+ *	@arg:  Node to be released
+ */
+static void of_node_cleanup(struct device_node *node)
+{
+	struct property *prop = node->properties;
+
+	if (!OF_IS_DYNAMIC(node))
+		return;
+	while (prop) {
+		struct property *next = prop->next;
+		kfree(prop->name);
+		kfree(prop->value);
+		kfree(prop);
+		prop = next;
+	}
+	kfree(node->intrs);
+	kfree(node->addrs);
+	kfree(node->full_name);
+	kfree(node);
+}
+
+/**
  *	of_node_put - Decrement refcount of a node
  *	@node:	Node to dec refcount, NULL is supported to
  *		simplify writing of callers
@@ -2743,29 +2807,6 @@ void of_node_put(struct device_node *nod
 EXPORT_SYMBOL(of_node_put);
 
 /**
- *	of_node_cleanup - release a dynamically allocated node
- *	@arg:  Node to be released
- */
-static void of_node_cleanup(struct device_node *node)
-{
-	struct property *prop = node->properties;
-
-	if (!OF_IS_DYNAMIC(node))
-		return;
-	while (prop) {
-		struct property *next = prop->next;
-		kfree(prop->name);
-		kfree(prop->value);
-		kfree(prop);
-		prop = next;
-	}
-	kfree(node->intrs);
-	kfree(node->addrs);
-	kfree(node->full_name);
-	kfree(node);
-}
-
-/**
  *	derive_parent - basically like dirname(1)
  *	@path:  the full_name of a node to be added to the tree
  *
@@ -2798,104 +2839,6 @@ static struct device_node *derive_parent
 /*
  * Routines for "runtime" addition and removal of device tree nodes.
  */
-
-/*
- * Given a path and a property list, construct an OF device node, add
- * it to the device tree and global list, and place it in
- * /proc/device-tree.  This function may sleep.
- */
-int of_add_node(const char *path, struct property *proplist)
-{
-	struct device_node *np;
-	int err = 0;
-
-	np = kmalloc(sizeof(struct device_node), GFP_KERNEL);
-	if (!np)
-		return -ENOMEM;
-
-	memset(np, 0, sizeof(*np));
-
-	np->full_name = kmalloc(strlen(path) + 1, GFP_KERNEL);
-	if (!np->full_name) {
-		kfree(np);
-		return -ENOMEM;
-	}
-	strcpy(np->full_name, path);
-
-	np->properties = proplist;
-	OF_MARK_DYNAMIC(np);
-	of_node_get(np);
-	np->parent = derive_parent(path);
-	if (!np->parent) {
-		kfree(np);
-		return -EINVAL; /* could also be ENOMEM, though */
-	}
-
-	if (0 != (err = of_finish_dynamic_node(np))) {
-		kfree(np);
-		return err;
-	}
-
-	write_lock(&devtree_lock);
-	np->sibling = np->parent->child;
-	np->allnext = allnodes;
-	np->parent->child = np;
-	allnodes = np;
-	write_unlock(&devtree_lock);
-
-	add_node_proc_entries(np);
-
-	of_node_put(np->parent);
-	of_node_put(np);
-	return 0;
-}
-
-/*
- * Remove an OF device node from the system.
- * Caller should have already "gotten" np.
- */
-int of_remove_node(struct device_node *np)
-{
-	struct device_node *parent, *child;
-
-	parent = of_get_parent(np);
-	if (!parent)
-		return -EINVAL;
-
-	if ((child = of_get_next_child(np, NULL))) {
-		of_node_put(child);
-		return -EBUSY;
-	}
-
-	write_lock(&devtree_lock);
-	OF_MARK_STALE(np);
-	remove_node_proc_entries(np);
-	if (allnodes == np)
-		allnodes = np->allnext;
-	else {
-		struct device_node *prev;
-		for (prev = allnodes;
-		     prev->allnext != np;
-		     prev = prev->allnext)
-			;
-		prev->allnext = np->allnext;
-	}
-
-	if (parent->child == np)
-		parent->child = np->sibling;
-	else {
-		struct device_node *prevsib;
-		for (prevsib = np->parent->child;
-		     prevsib->sibling != np;
-		     prevsib = prevsib->sibling)
-			;
-		prevsib->sibling = np->sibling;
-	}
-	write_unlock(&devtree_lock);
-	of_node_put(parent);
-	return 0;
-}
-
 #ifdef CONFIG_PROC_DEVICETREE
 /*
  * Add a node to /proc/device-tree.
@@ -2941,6 +2884,7 @@ static void remove_node_proc_entries(str
 }
 #endif /* CONFIG_PROC_DEVICETREE */
 
+
 /*
  * Fix up n_intrs and intrs fields in a new device node
  *
@@ -3087,17 +3031,100 @@ out:
 }
 
 /*
- * Find the device_node with a given phandle.
+ * Given a path and a property list, construct an OF device node, add
+ * it to the device tree and global list, and place it in
+ * /proc/device-tree.  This function may sleep.
  */
-static struct device_node * __devinit
-find_phandle(phandle ph)
+int of_add_node(const char *path, struct property *proplist)
 {
 	struct device_node *np;
+	int err = 0;
 
-	for (np = allnodes; np != 0; np = np->allnext)
-		if (np->linux_phandle == ph)
-			return np;
-	return NULL;
+	np = kmalloc(sizeof(struct device_node), GFP_KERNEL);
+	if (!np)
+		return -ENOMEM;
+
+	memset(np, 0, sizeof(*np));
+
+	np->full_name = kmalloc(strlen(path) + 1, GFP_KERNEL);
+	if (!np->full_name) {
+		kfree(np);
+		return -ENOMEM;
+	}
+	strcpy(np->full_name, path);
+
+	np->properties = proplist;
+	OF_MARK_DYNAMIC(np);
+	of_node_get(np);
+	np->parent = derive_parent(path);
+	if (!np->parent) {
+		kfree(np);
+		return -EINVAL; /* could also be ENOMEM, though */
+	}
+
+	if (0 != (err = of_finish_dynamic_node(np))) {
+		kfree(np);
+		return err;
+	}
+
+	write_lock(&devtree_lock);
+	np->sibling = np->parent->child;
+	np->allnext = allnodes;
+	np->parent->child = np;
+	allnodes = np;
+	write_unlock(&devtree_lock);
+
+	add_node_proc_entries(np);
+
+	of_node_put(np->parent);
+	of_node_put(np);
+	return 0;
+}
+
+/*
+ * Remove an OF device node from the system.
+ * Caller should have already "gotten" np.
+ */
+int of_remove_node(struct device_node *np)
+{
+	struct device_node *parent, *child;
+
+	parent = of_get_parent(np);
+	if (!parent)
+		return -EINVAL;
+
+	if ((child = of_get_next_child(np, NULL))) {
+		of_node_put(child);
+		return -EBUSY;
+	}
+
+	write_lock(&devtree_lock);
+	OF_MARK_STALE(np);
+	remove_node_proc_entries(np);
+	if (allnodes == np)
+		allnodes = np->allnext;
+	else {
+		struct device_node *prev;
+		for (prev = allnodes;
+		     prev->allnext != np;
+		     prev = prev->allnext)
+			;
+		prev->allnext = np->allnext;
+	}
+
+	if (parent->child == np)
+		parent->child = np->sibling;
+	else {
+		struct device_node *prevsib;
+		for (prevsib = np->parent->child;
+		     prevsib->sibling != np;
+		     prevsib = prevsib->sibling)
+			;
+		prevsib->sibling = np->sibling;
+	}
+	write_unlock(&devtree_lock);
+	of_node_put(parent);
+	return 0;
 }
 
 /*
@@ -3183,55 +3210,3 @@ print_properties(struct device_node *np)
 	}
 }
 #endif
-
-
-/* Verify bi_recs are good */
-static struct bi_record *
-prom_bi_rec_verify(struct bi_record *bi_recs)
-{
-	struct bi_record *first, *last;
-
-	if ( bi_recs == NULL || bi_recs->tag != BI_FIRST )
-		return NULL;
-
-	last = (struct bi_record *)(long)bi_recs->data[0];
-	if ( last == NULL || last->tag != BI_LAST )
-		return NULL;
-
-	first = (struct bi_record *)(long)last->data[0];
-	if ( first == NULL || first != bi_recs )
-		return NULL;
-
-	return bi_recs;
-}
-
-static unsigned long
-prom_bi_rec_reserve(unsigned long mem)
-{
-	unsigned long offset = reloc_offset();
-	struct prom_t *_prom = PTRRELOC(&prom);
-	struct bi_record *rec;
-
-	if ( _prom->bi_recs != NULL) {
-
-		for ( rec=_prom->bi_recs;
-		      rec->tag != BI_LAST;
-		      rec=bi_rec_next(rec) ) {
-			switch (rec->tag) {
-#ifdef CONFIG_BLK_DEV_INITRD
-			case BI_INITRD:
-				lmb_reserve(rec->data[0], rec->data[1]);
-				break;
-#endif /* CONFIG_BLK_DEV_INITRD */
-			}
-		}
-		/* The next use of this field will be after relocation
-	 	 * is enabled, so convert this physical address into a
-	 	 * virtual address.
-	 	 */
-		_prom->bi_recs = PTRUNRELOC(_prom->bi_recs);
-	}
-
-	return mem;
-}
-

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

