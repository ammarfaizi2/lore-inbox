Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUFXLtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUFXLtS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 07:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUFXLtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 07:49:17 -0400
Received: from ozlabs.org ([203.10.76.45]:33930 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264286AbUFXLqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 07:46:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16602.46168.19368.443882@cargo.ozlabs.ibm.com>
Date: Thu, 24 Jun 2004 21:00:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Clean up prom.c and related files
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somebody back in the mists of time decided that call_prom and
rtas_call should return longs even though both of those bits of
firmware run in 32-bit mode and produce a 32-bit result.  To make life
more interesting, the 32-bit result gets zero-extended to 64 bits,
which makes checking for a -1 return value more complicated than it
should be.

This patch changes call_prom and rtas_call to return an int, and makes
the corresponding changes to use ints for the variables used to hold
those return values.

While I was doing this I finally got annoyed enough with the strings
of prom_print() and prom_print_hex() calls that we do to write a
simple prom_printf.  I deliberately didn't use snprintf because the
execution environment is weird at this point - we aren't running at
the address we are linked at just yet - and I didn't want to inflict
that on any code outside this file.  I also did a prom_debug() macro,
which eliminated a few ifdefs.

There are also a bunch of other minor cleanups.  This patch makes
very few algorithmic changes but does get rid of a lot of casts. :)

I have been running with this patch for a couple of weeks, and Anton
has tested it too.  Please apply.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/eeh.c prom-cleanup/arch/ppc64/kernel/eeh.c
--- linux-2.5/arch/ppc64/kernel/eeh.c	2004-06-04 07:19:00.000000000 +1000
+++ prom-cleanup/arch/ppc64/kernel/eeh.c	2004-06-24 21:40:35.648000832 +1000
@@ -365,7 +365,8 @@
 	unsigned long addr;
 	struct pci_dev *dev;
 	struct device_node *dn;
-	unsigned long ret, rets[2];
+	unsigned long ret;
+	int rets[2];
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
 	/* dont want this on the stack */
 	static unsigned char slot_err_buf[RTAS_ERROR_LOG_MAX];
@@ -444,11 +445,11 @@
 		 * can use it here.
 		 */
 		if (panic_on_oops) {
-			panic("EEH: MMIO failure (%ld) on device:%s %s\n",
+			panic("EEH: MMIO failure (%d) on device:%s %s\n",
 			      rets[0], pci_name(dev), pci_pretty_name(dev));
 		} else {
 			__get_cpu_var(ignored_failures)++;
-			printk(KERN_INFO "EEH: MMIO failure (%ld) on device:%s %s\n",
+			printk(KERN_INFO "EEH: MMIO failure (%d) on device:%s %s\n",
 			       rets[0], pci_name(dev), pci_pretty_name(dev));
 		}
 	} else {
diff -urN linux-2.5/arch/ppc64/kernel/pSeries_nvram.c prom-cleanup/arch/ppc64/kernel/pSeries_nvram.c
--- linux-2.5/arch/ppc64/kernel/pSeries_nvram.c	2004-05-15 13:32:15.000000000 +1000
+++ prom-cleanup/arch/ppc64/kernel/pSeries_nvram.c	2004-05-28 14:02:22.000000000 +1000
@@ -37,7 +37,8 @@
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
 {
 	unsigned int i;
-	unsigned long len, done;
+	unsigned long len;
+	int done;
 	unsigned long flags;
 	char *p = buf;
 
@@ -80,7 +81,8 @@
 static ssize_t pSeries_nvram_write(char *buf, size_t count, loff_t *index)
 {
 	unsigned int i;
-	unsigned long len, done;
+	unsigned long len;
+	int done;
 	unsigned long flags;
 	const char *p = buf;
 
diff -urN linux-2.5/arch/ppc64/kernel/pSeries_pci.c prom-cleanup/arch/ppc64/kernel/pSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/pSeries_pci.c	2004-04-13 09:25:09.000000000 +1000
+++ prom-cleanup/arch/ppc64/kernel/pSeries_pci.c	2004-05-28 14:02:22.000000000 +1000
@@ -62,7 +62,7 @@
 
 static int rtas_read_config(struct device_node *dn, int where, int size, u32 *val)
 {
-	unsigned long returnval = ~0L;
+	int returnval = -1;
 	unsigned long buid, addr;
 	int ret;
 
@@ -72,7 +72,8 @@
 	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
 	buid = dn->phb->buid;
 	if (buid) {
-		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval, addr, buid >> 32, buid & 0xffffffff, size);
+		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
+				addr, buid >> 32, buid & 0xffffffff, size);
 	} else {
 		ret = rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
 	}
diff -urN linux-2.5/arch/ppc64/kernel/prom.c prom-cleanup/arch/ppc64/kernel/prom.c
--- linux-2.5/arch/ppc64/kernel/prom.c	2004-06-04 07:19:00.000000000 +1000
+++ prom-cleanup/arch/ppc64/kernel/prom.c	2004-06-04 09:10:15.000000000 +1000
@@ -15,9 +15,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#if 0
-#define DEBUG_PROM
-#endif
+#undef DEBUG_PROM
 
 #include <stdarg.h>
 #include <linux/config.h>
@@ -91,15 +89,17 @@
  */
 
 
-#define PROM_BUG() do { \
-        prom_print(RELOC("kernel BUG at ")); \
-        prom_print(RELOC(__FILE__)); \
-        prom_print(RELOC(":")); \
-        prom_print_hex(__LINE__); \
-        prom_print(RELOC("!\n")); \
-        __asm__ __volatile__(".long " BUG_ILLEGAL_INSTR); \
+#define PROM_BUG() do {						\
+        prom_printf("kernel BUG at %s line 0x%x!\n",		\
+		    RELOC(__FILE__), __LINE__);			\
+        __asm__ __volatile__(".long " BUG_ILLEGAL_INSTR);	\
 } while (0)
 
+#ifdef DEBUG_PROM
+#define prom_debug(x...)	prom_printf(x)
+#else
+#define prom_debug(x...)
+#endif
 
 
 struct pci_reg_property {
@@ -178,29 +178,36 @@
 
 char testString[] = "LINUX\n"; 
 
+/*
+ * This are used in calls to call_prom.  The 4th and following
+ * arguments to call_prom should be 32-bit values.  64 bit values
+ * are truncated to 32 bits (and fortunately don't get interpreted
+ * as two arguments).
+ */
+#define ADDR(x)		(u32) ((unsigned long)(x) - offset)
 
 /* This is the one and *ONLY* place where we actually call open
  * firmware from, since we need to make sure we're running in 32b
  * mode when we do.  We switch back to 64b mode upon return.
  */
 
-#define PROM_ERROR	(0x00000000fffffffful)
+#define PROM_ERROR	(-1)
 
-static unsigned long __init call_prom(const char *service, int nargs, int nret, ...)
+static int __init call_prom(const char *service, int nargs, int nret, ...)
 {
 	int i;
 	unsigned long offset = reloc_offset();
 	struct prom_t *_prom = PTRRELOC(&prom);
 	va_list list;
         
-	_prom->args.service = (u32)LONG_LSW(service);
+	_prom->args.service = ADDR(service);
 	_prom->args.nargs = nargs;
 	_prom->args.nret = nret;
         _prom->args.rets = (prom_arg_t *)&(_prom->args.args[nargs]);
 
         va_start(list, nret);
-	for (i=0; i < nargs ;i++)
-		_prom->args.args[i] = (prom_arg_t)LONG_LSW(va_arg(list, unsigned long));
+	for (i=0; i < nargs; i++)
+		_prom->args.args[i] = va_arg(list, prom_arg_t);
         va_end(list);
 
 	for (i=0; i < nret ;i++)
@@ -208,7 +215,7 @@
 
 	enter_prom(&_prom->args);
 
-	return (unsigned long)((nret > 0) ? _prom->args.rets[0] : 0);
+	return (nret > 0)? _prom->args.rets[0]: 0;
 }
 
 
@@ -225,21 +232,21 @@
 		for (q = p; *q != 0 && *q != '\n'; ++q)
 			;
 		if (q > p)
-			call_prom(RELOC("write"), 3, 1, _prom->stdout,
-				  p, q - p);
-		if (*q != 0) {
-			++q;
-			call_prom(RELOC("write"), 3, 1, _prom->stdout,
-				  RELOC("\r\n"), 2);
-		}
+			call_prom("write", 3, 1, _prom->stdout, p, q - p);
+		if (*q == 0)
+			break;
+		++q;
+		call_prom("write", 3, 1, _prom->stdout, ADDR("\r\n"), 2);
 	}
 }
 
 
 static void __init prom_print_hex(unsigned long val)
 {
+	unsigned long offset = reloc_offset();
         int i, nibbles = sizeof(val)*2;
         char buf[sizeof(val)*2+1];
+	struct prom_t *_prom = PTRRELOC(&prom);
 
         for (i = nibbles-1;  i >= 0;  i--) {
                 buf[i] = (val & 0xf) + '0';
@@ -248,24 +255,58 @@
                 val >>= 4;
         }
         buf[nibbles] = '\0';
-	prom_print(buf);
+	call_prom("write", 3, 1, _prom->stdout, buf, nibbles);
 }
 
 
-static void __init prom_print_nl(void)
+static void __init prom_printf(const char *format, ...)
 {
 	unsigned long offset = reloc_offset();
-	prom_print(RELOC("\n"));
+	const char *p, *q, *s;
+	va_list args;
+	unsigned long v;
+	struct prom_t *_prom = PTRRELOC(&prom);
+
+	va_start(args, format);
+	for (p = PTRRELOC(format); *p != 0; p = q) {
+		for (q = p; *q != 0 && *q != '\n' && *q != '%'; ++q)
+			;
+		if (q > p)
+			call_prom("write", 3, 1, _prom->stdout, p, q - p);
+		if (*q == 0)
+			break;
+		if (*q == '\n') {
+			++q;
+			call_prom("write", 3, 1, _prom->stdout,
+				  ADDR("\r\n"), 2);
+			continue;
+		}
+		++q;
+		if (*q == 0)
+			break;
+		switch (*q) {
+		case 's':
+			++q;
+			s = va_arg(args, const char *);
+			prom_print(s);
+			break;
+		case 'x':
+			++q;
+			v = va_arg(args, unsigned long);
+			prom_print_hex(v);
+			break;
+		}
+	}
 }
 
 
-static void __init prom_panic(const char *reason)
+static void __init __attribute__((noreturn)) prom_panic(const char *reason)
 {
 	unsigned long offset = reloc_offset();
 
-	prom_print(reason);
+	prom_print(PTRRELOC(reason));
 	/* ToDo: should put up an SRC here */
-	call_prom(RELOC("exit"), 0, 0);
+	call_prom("exit", 0, 0);
 
 	for (;;)			/* should never get here */
 		;
@@ -275,21 +316,28 @@
 static int __init prom_next_node(phandle *nodep)
 {
 	phandle node;
-	unsigned long offset = reloc_offset();
 
 	if ((node = *nodep) != 0
-	    && (*nodep = call_prom(RELOC("child"), 1, 1, node)) != 0)
+	    && (*nodep = call_prom("child", 1, 1, node)) != 0)
 		return 1;
-	if ((*nodep = call_prom(RELOC("peer"), 1, 1, node)) != 0)
+	if ((*nodep = call_prom("peer", 1, 1, node)) != 0)
 		return 1;
 	for (;;) {
-		if ((node = call_prom(RELOC("parent"), 1, 1, node)) == 0)
+		if ((node = call_prom("parent", 1, 1, node)) == 0)
 			return 0;
-		if ((*nodep = call_prom(RELOC("peer"), 1, 1, node)) != 0)
+		if ((*nodep = call_prom("peer", 1, 1, node)) != 0)
 			return 1;
 	}
 }
 
+static int __init prom_getprop(phandle node, const char *pname,
+			       void *value, size_t valuelen)
+{
+	unsigned long offset = reloc_offset();
+
+	return call_prom("getprop", 4, 1, node, ADDR(pname),
+			 (u32)(unsigned long) value, (u32) valuelen);
+}
 
 static void __init prom_initialize_naca(void)
 {
@@ -302,16 +350,13 @@
         struct systemcfg *_systemcfg = RELOC(systemcfg);
 
 	/* NOTE: _naca->debug_switch is already initialized. */
-#ifdef DEBUG_PROM
-	prom_print(RELOC("prom_initialize_naca: start...\n"));
-#endif
+	prom_debug("prom_initialize_naca: start...\n");
 
 	_naca->pftSize = 0;	/* ilog2 of htab size.  computed below. */
 
         for (node = 0; prom_next_node(&node); ) {
                 type[0] = 0;
-                call_prom(RELOC("getprop"), 4, 1, node, RELOC("device_type"),
-                          type, sizeof(type));
+		prom_getprop(node, "device_type", type, sizeof(type));
 
                 if (!strcmp(type, RELOC("cpu"))) {
 			num_cpus += 1;
@@ -321,37 +366,30 @@
 			 */
 			if ( num_cpus == 1 ) {
 				u32 size, lsize;
+				const char *dc, *ic;
 
-				call_prom(RELOC("getprop"), 4, 1, node,
-					  RELOC("d-cache-size"),
-					  &size, sizeof(size));
-
-				if (_systemcfg->platform == PLATFORM_POWERMAC)
-					call_prom(RELOC("getprop"), 4, 1, node,
-						  RELOC("d-cache-block-size"),
-						  &lsize, sizeof(lsize));
-				else
-					call_prom(RELOC("getprop"), 4, 1, node,
-						  RELOC("d-cache-line-size"),
-						  &lsize, sizeof(lsize));
+				if (_systemcfg->platform == PLATFORM_POWERMAC){
+					dc = "d-cache-block-size";
+					ic = "i-cache-block-size";
+				} else {
+					dc = "d-cache-line-size";
+					ic = "i-cache-line-size";
+				}
+
+				prom_getprop(node, "d-cache-size",
+					     &size, sizeof(size));
+
+				prom_getprop(node, dc, &lsize, sizeof(lsize));
 
 				_systemcfg->dCacheL1Size = size;
 				_systemcfg->dCacheL1LineSize = lsize;
 				_naca->dCacheL1LogLineSize = __ilog2(lsize);
 				_naca->dCacheL1LinesPerPage = PAGE_SIZE/lsize;
 
-				call_prom(RELOC("getprop"), 4, 1, node,
-					  RELOC("i-cache-size"),
-					  &size, sizeof(size));
-
-				if (_systemcfg->platform == PLATFORM_POWERMAC)
-					call_prom(RELOC("getprop"), 4, 1, node,
-						  RELOC("i-cache-block-size"),
-						  &lsize, sizeof(lsize));
-				else
-					call_prom(RELOC("getprop"), 4, 1, node,
-						  RELOC("i-cache-line-size"),
-						  &lsize, sizeof(lsize));
+				prom_getprop(node, "i-cache-size",
+					     &size, sizeof(size));
+
+				prom_getprop(node, ic, &lsize, sizeof(lsize));
 
 				_systemcfg->iCacheL1Size = size;
 				_systemcfg->iCacheL1LineSize = lsize;
@@ -360,9 +398,8 @@
 
 				if (_systemcfg->platform == PLATFORM_PSERIES_LPAR) {
 					u32 pft_size[2];
-					call_prom(RELOC("getprop"), 4, 1, node, 
-						  RELOC("ibm,pft-size"),
-						  &pft_size, sizeof(pft_size));
+					prom_getprop(node, "ibm,pft-size",
+						&pft_size, sizeof(pft_size));
 				/* pft_size[0] is the NUMA CEC cookie */
 					_naca->pftSize = pft_size[1];
 				}
@@ -375,24 +412,21 @@
 			if (_systemcfg->platform == PLATFORM_POWERMAC)
 				continue;
 			type[0] = 0;
-			call_prom(RELOC("getprop"), 4, 1, node,
-				  RELOC("ibm,aix-loc"), type, sizeof(type));
+			prom_getprop(node, "ibm,aix-loc", type, sizeof(type));
 
 			if (strcmp(type, RELOC("S1")))
 				continue;
 
-			call_prom(RELOC("getprop"), 4, 1, node, RELOC("reg"),
-				  &reg, sizeof(reg));
+			prom_getprop(node, "reg", &reg, sizeof(reg));
 
-			isa = call_prom(RELOC("parent"), 1, 1, node);
+			isa = call_prom("parent", 1, 1, node);
 			if (!isa)
 				PROM_BUG();
-			pci = call_prom(RELOC("parent"), 1, 1, isa);
+			pci = call_prom("parent", 1, 1, isa);
 			if (!pci)
 				PROM_BUG();
 
-			call_prom(RELOC("getprop"), 4, 1, pci, RELOC("ranges"),
-				  &ranges, sizeof(ranges));
+			prom_getprop(pci, "ranges", &ranges, sizeof(ranges));
 
 			if ( _prom->encode_phys_size == 32 )
 				_naca->serialPortAddr = ranges.pci32.phys+reg.address;
@@ -410,25 +444,23 @@
 		_naca->interrupt_controller = IC_INVALID;
 		for (node = 0; prom_next_node(&node); ) {
 			type[0] = 0;
-			call_prom(RELOC("getprop"), 4, 1, node, RELOC("name"),
-				  type, sizeof(type));
+			prom_getprop(node, "name", type, sizeof(type));
 			if (strcmp(type, RELOC("interrupt-controller")))
 				continue;
-			call_prom(RELOC("getprop"), 4, 1, node, RELOC("compatible"),
-				  type, sizeof(type));
+			prom_getprop(node, "compatible", type, sizeof(type));
 			if (strstr(type, RELOC("open-pic")))
 				_naca->interrupt_controller = IC_OPEN_PIC;
 			else if (strstr(type, RELOC("ppc-xicp")))
 				_naca->interrupt_controller = IC_PPC_XIC;
 			else
-				prom_print(RELOC("prom: failed to recognize"
-						 " interrupt-controller\n"));
+				prom_printf("prom: failed to recognize"
+					    " interrupt-controller\n");
 			break;
 		}
 	}
 
 	if (_naca->interrupt_controller == IC_INVALID) {
-		prom_print(RELOC("prom: failed to find interrupt-controller\n"));
+		prom_printf("prom: failed to find interrupt-controller\n");
 		PROM_BUG();
 	}
 
@@ -454,7 +486,7 @@
 	}
 
 	if (_naca->pftSize == 0) {
-		prom_print(RELOC("prom: failed to compute pftSize!\n"));
+		prom_printf("prom: failed to compute pftSize!\n");
 		PROM_BUG();
 	}
 
@@ -464,41 +496,23 @@
 	_systemcfg->version.minor = SYSTEMCFG_MINOR;
 	_systemcfg->processor = _get_PVR();
 
-#ifdef DEBUG_PROM
-        prom_print(RELOC("systemcfg->processorCount       = 0x"));
-        prom_print_hex(_systemcfg->processorCount);
-        prom_print_nl();
-
-        prom_print(RELOC("systemcfg->physicalMemorySize   = 0x"));
-        prom_print_hex(_systemcfg->physicalMemorySize);
-        prom_print_nl();
-
-        prom_print(RELOC("naca->pftSize                   = 0x"));
-        prom_print_hex(_naca->pftSize);
-        prom_print_nl();
-
-        prom_print(RELOC("systemcfg->dCacheL1LineSize     = 0x"));
-        prom_print_hex(_systemcfg->dCacheL1LineSize);
-        prom_print_nl();
-
-        prom_print(RELOC("systemcfg->iCacheL1LineSize     = 0x"));
-        prom_print_hex(_systemcfg->iCacheL1LineSize);
-        prom_print_nl();
-
-        prom_print(RELOC("naca->serialPortAddr            = 0x"));
-        prom_print_hex(_naca->serialPortAddr);
-        prom_print_nl();
-
-        prom_print(RELOC("naca->interrupt_controller      = 0x"));
-        prom_print_hex(_naca->interrupt_controller);
-        prom_print_nl();
-
-        prom_print(RELOC("systemcfg->platform             = 0x"));
-        prom_print_hex(_systemcfg->platform);
-        prom_print_nl();
-
-	prom_print(RELOC("prom_initialize_naca: end...\n"));
-#endif
+        prom_debug("systemcfg->processorCount       = 0x%x\n",
+		   _systemcfg->processorCount);
+        prom_debug("systemcfg->physicalMemorySize   = 0x%x\n",
+		   _systemcfg->physicalMemorySize);
+        prom_debug("naca->pftSize                   = 0x%x\n",
+		   _naca->pftSize);
+        prom_debug("systemcfg->dCacheL1LineSize     = 0x%x\n",
+		   _systemcfg->dCacheL1LineSize);
+        prom_debug("systemcfg->iCacheL1LineSize     = 0x%x\n",
+		   _systemcfg->iCacheL1LineSize);
+        prom_debug("naca->serialPortAddr            = 0x%x\n",
+		   _naca->serialPortAddr);
+        prom_debug("naca->interrupt_controller      = 0x%x\n",
+		   _naca->interrupt_controller);
+        prom_debug("systemcfg->platform             = 0x%x\n",
+		   _systemcfg->platform);
+	prom_debug("prom_initialize_naca: end...\n");
 }
 
 
@@ -512,9 +526,7 @@
 
 	opt = strstr(RELOC(cmd_line), RELOC("iommu="));
 	if (opt) {
-		prom_print(RELOC("opt is:"));
-		prom_print(opt);
-		prom_print(RELOC("\n"));
+		prom_printf("opt is:%s\n", opt);
 		opt += 6;
 		while (*opt && *opt == ' ')
 			opt++;
@@ -527,7 +539,7 @@
 #ifndef CONFIG_PMAC_DART
 	if (_systemcfg->platform == PLATFORM_POWERMAC) {
 		RELOC(ppc64_iommu_off) = 1;
-		prom_print(RELOC("DART disabled on PowerMac !\n"));
+		prom_printf("DART disabled on PowerMac !\n");
 	}
 #endif
 }
@@ -539,46 +551,31 @@
         unsigned long offset = reloc_offset();
 	struct lmb *_lmb  = PTRRELOC(&lmb);
 
-        prom_print(RELOC("\nprom_dump_lmb:\n"));
-        prom_print(RELOC("    memory.cnt                  = 0x"));
-        prom_print_hex(_lmb->memory.cnt);
-	prom_print_nl();
-        prom_print(RELOC("    memory.size                 = 0x"));
-        prom_print_hex(_lmb->memory.size);
-	prom_print_nl();
+        prom_printf("\nprom_dump_lmb:\n");
+        prom_printf("    memory.cnt                  = 0x%x\n",
+		    _lmb->memory.cnt);
+        prom_printf("    memory.size                 = 0x%x\n",
+		    _lmb->memory.size);
         for (i=0; i < _lmb->memory.cnt ;i++) {
-                prom_print(RELOC("    memory.region[0x"));
-		prom_print_hex(i);
-		prom_print(RELOC("].base       = 0x"));
-                prom_print_hex(_lmb->memory.region[i].base);
-		prom_print_nl();
-                prom_print(RELOC("                      .physbase = 0x"));
-                prom_print_hex(_lmb->memory.region[i].physbase);
-		prom_print_nl();
-                prom_print(RELOC("                      .size     = 0x"));
-                prom_print_hex(_lmb->memory.region[i].size);
-		prom_print_nl();
+                prom_printf("    memory.region[0x%x].base       = 0x%x\n",
+			    i, _lmb->memory.region[i].base);
+                prom_printf("                      .physbase = 0x%x\n",
+			    _lmb->memory.region[i].physbase);
+                prom_printf("                      .size     = 0x%x\n",
+			    _lmb->memory.region[i].size);
         }
 
-	prom_print_nl();
-        prom_print(RELOC("    reserved.cnt                  = 0x"));
-        prom_print_hex(_lmb->reserved.cnt);
-	prom_print_nl();
-        prom_print(RELOC("    reserved.size                 = 0x"));
-        prom_print_hex(_lmb->reserved.size);
-	prom_print_nl();
+        prom_printf("\n    reserved.cnt                  = 0x%x\n",
+		    _lmb->reserved.cnt);
+        prom_printf("    reserved.size                 = 0x%x\n",
+		    _lmb->reserved.size);
         for (i=0; i < _lmb->reserved.cnt ;i++) {
-                prom_print(RELOC("    reserved.region[0x"));
-		prom_print_hex(i);
-		prom_print(RELOC("].base       = 0x"));
-                prom_print_hex(_lmb->reserved.region[i].base);
-		prom_print_nl();
-                prom_print(RELOC("                      .physbase = 0x"));
-                prom_print_hex(_lmb->reserved.region[i].physbase);
-		prom_print_nl();
-                prom_print(RELOC("                      .size     = 0x"));
-                prom_print_hex(_lmb->reserved.region[i].size);
-		prom_print_nl();
+                prom_printf("    reserved.region[0x%x\n].base       = 0x%x\n",
+			    i, _lmb->reserved.region[i].base);
+                prom_printf("                      .physbase = 0x%x\n",
+			    _lmb->reserved.region[i].physbase);
+                prom_printf("                      .size     = 0x%x\n",
+			    _lmb->reserved.region[i].size);
         }
 }
 #endif /* DEBUG_PROM */
@@ -604,14 +601,13 @@
 
         for (node = 0; prom_next_node(&node); ) {
                 type[0] = 0;
-                call_prom(RELOC("getprop"), 4, 1, node, RELOC("device_type"),
-                          type, sizeof(type));
+                prom_getprop(node, "device_type", type, sizeof(type));
 
                 if (strcmp(type, RELOC("memory")))
 			continue;
 
-		num_regs = call_prom(RELOC("getprop"), 4, 1, node, RELOC("reg"),
-			&reg, sizeof(reg)) / bytes_per_reg;
+		num_regs = prom_getprop(node, "reg", &reg, sizeof(reg))
+			/ bytes_per_reg;
 
 		for (i=0; i < num_regs ;i++) {
 			if (_systemcfg->platform == PLATFORM_POWERMAC) {
@@ -636,7 +632,7 @@
 			}
 
 			if (lmb_add(lmb_base, lmb_size) < 0)
-				prom_print(RELOC("Too many LMB's, discarding this one...\n"));
+				prom_printf("Too many LMB's, discarding this one...\n");
 		}
 
 	}
@@ -658,30 +654,23 @@
         u32 getprop_rval;
 	char hypertas_funcs[4];
 
-#ifdef DEBUG_PROM
-	prom_print(RELOC("prom_instantiate_rtas: start...\n"));
-#endif
-	prom_rtas = (ihandle)call_prom(RELOC("finddevice"), 1, 1, RELOC("/rtas"));
+	prom_debug("prom_instantiate_rtas: start...\n");
+
+	prom_rtas = call_prom("finddevice", 1, 1, ADDR("/rtas"));
 	if (prom_rtas != (ihandle) -1) {
 		unsigned long x;
-		x = call_prom(RELOC("getprop"),
-				  4, 1, prom_rtas,
-				  RELOC("ibm,hypertas-functions"), 
-				  hypertas_funcs, 
-			      sizeof(hypertas_funcs));
+		x = prom_getprop(prom_rtas, "ibm,hypertas-functions",
+				 hypertas_funcs, sizeof(hypertas_funcs));
 
 		if (x != PROM_ERROR) {
-			prom_print(RELOC("Hypertas detected, assuming LPAR !\n"));
+			prom_printf("Hypertas detected, assuming LPAR !\n");
 			_systemcfg->platform = PLATFORM_PSERIES_LPAR;
 		}
 
-		call_prom(RELOC("getprop"), 
-			  4, 1, prom_rtas,
-			  RELOC("rtas-size"), 
-			  &getprop_rval, 
-			  sizeof(getprop_rval));
+		prom_getprop(prom_rtas, "rtas-size",
+			     &getprop_rval, sizeof(getprop_rval));
 	        _rtas->size = getprop_rval;
-		prom_print(RELOC("instantiating rtas"));
+		prom_printf("instantiating rtas");
 		if (_rtas->size != 0) {
 			unsigned long rtas_region = RTAS_INSTANTIATE_MAX;
 
@@ -696,17 +685,15 @@
 
 			_rtas->base = lmb_alloc_base(_rtas->size, PAGE_SIZE, rtas_region);
 
-			prom_print(RELOC(" at 0x"));
-			prom_print_hex(_rtas->base);
+			prom_printf(" at 0x%x", _rtas->base);
+
+			prom_rtas = call_prom("open", 1, 1, ADDR("/rtas"));
+			prom_printf("...");
 
-			prom_rtas = (ihandle)call_prom(RELOC("open"), 
-					      	1, 1, RELOC("/rtas"));
-			prom_print(RELOC("..."));
-
-			if (call_prom(RELOC("call-method"), 3, 2,
-						      RELOC("instantiate-rtas"),
-						      prom_rtas,
-						      _rtas->base) != PROM_ERROR) {
+			if (call_prom("call-method", 3, 2,
+				      ADDR("instantiate-rtas"),
+				      prom_rtas,
+				      _rtas->base) != PROM_ERROR) {
 				_rtas->entry = (long)_prom->args.rets[1];
 			}
 			RELOC(rtas_rmo_buf)
@@ -715,26 +702,16 @@
 		}
 
 		if (_rtas->entry <= 0) {
-			prom_print(RELOC(" failed\n"));
+			prom_printf(" failed\n");
 		} else {
-			prom_print(RELOC(" done\n"));
+			prom_printf(" done\n");
 		}
 
-#ifdef DEBUG_PROM
-        	prom_print(RELOC("rtas->base                 = 0x"));
-        	prom_print_hex(_rtas->base);
-        	prom_print_nl();
-        	prom_print(RELOC("rtas->entry                = 0x"));
-        	prom_print_hex(_rtas->entry);
-        	prom_print_nl();
-        	prom_print(RELOC("rtas->size                 = 0x"));
-        	prom_print_hex(_rtas->size);
-        	prom_print_nl();
-#endif
+        	prom_debug("rtas->base                = 0x%x\n", _rtas->base);
+        	prom_debug("rtas->entry               = 0x%x\n", _rtas->entry);
+        	prom_debug("rtas->size                = 0x%x\n", _rtas->size);
 	}
-#ifdef DEBUG_PROM
-	prom_print(RELOC("prom_instantiate_rtas: end...\n"));
-#endif
+	prom_debug("prom_instantiate_rtas: end...\n");
 }
 
 
@@ -759,9 +736,7 @@
 	RELOC(dart_tablebase) = (unsigned long)
 		abs_to_virt(lmb_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
 
-	prom_print(RELOC("Dart at: "));
-	prom_print_hex(RELOC(dart_tablebase));
-	prom_print(RELOC("\n"));
+	prom_printf("Dart at: %x\n", RELOC(dart_tablebase));
 }
 #endif /* CONFIG_PMAC_DART */
 
@@ -780,27 +755,23 @@
 	if (RELOC(ppc64_iommu_off))
 		return;
 
-#ifdef DEBUG_PROM
-	prom_print(RELOC("starting prom_initialize_tce_table\n"));
-#endif
+	prom_debug("starting prom_initialize_tce_table\n");
 
 	/* Search all nodes looking for PHBs. */
 	for (node = 0; prom_next_node(&node); ) {
 		if (table == MAX_PHB) {
-			prom_print(RELOC("WARNING: PCI host bridge ignored, "
-				         "need to increase MAX_PHB\n"));
+			prom_printf("WARNING: PCI host bridge ignored, "
+				    "need to increase MAX_PHB\n");
 			continue;
 		}
 
 		compatible[0] = 0;
 		type[0] = 0;
 		model[0] = 0;
-		call_prom(RELOC("getprop"), 4, 1, node, RELOC("compatible"),
-			  compatible, sizeof(compatible));
-		call_prom(RELOC("getprop"), 4, 1, node, RELOC("device_type"),
-			  type, sizeof(type));
-		call_prom(RELOC("getprop"), 4, 1, node, RELOC("model"),
-			  model, sizeof(model));
+		prom_getprop(node, "compatible",
+			     compatible, sizeof(compatible));
+		prom_getprop(node, "device_type", type, sizeof(type));
+		prom_getprop(node, "model", model, sizeof(model));
 
 		/* Keep the old logic in tack to avoid regression. */
 		if (compatible[0] != 0) {
@@ -819,15 +790,13 @@
 			continue;
 		}
 
-		if (call_prom(RELOC("getprop"), 4, 1, node, 
-			     RELOC("tce-table-minalign"), &minalign, 
-			     sizeof(minalign)) == PROM_ERROR) {
+		if (prom_getprop(node, "tce-table-minalign", &minalign,
+				 sizeof(minalign)) == PROM_ERROR) {
 			minalign = 0;
 		}
 
-		if (call_prom(RELOC("getprop"), 4, 1, node, 
-			     RELOC("tce-table-minsize"), &minsize, 
-			     sizeof(minsize)) == PROM_ERROR) {
+		if (prom_getprop(node, "tce-table-minsize", &minsize,
+				 sizeof(minsize)) == PROM_ERROR) {
 			minsize = 4UL << 20;
 		}
 
@@ -854,7 +823,7 @@
 		base = lmb_alloc(minsize, align);
 
 		if ( !base ) {
-			prom_panic(RELOC("ERROR, cannot find space for TCE table.\n"));
+			prom_panic("ERROR, cannot find space for TCE table.\n");
 		}
 
 		vbase = (unsigned long)abs_to_virt(base);
@@ -864,23 +833,10 @@
 		prom_tce_table[table].base = vbase;
 		prom_tce_table[table].size = minsize;
 
-#ifdef DEBUG_PROM
-		prom_print(RELOC("TCE table: 0x"));
-		prom_print_hex(table);
-		prom_print_nl();
-
-		prom_print(RELOC("\tnode = 0x"));
-		prom_print_hex(node);
-		prom_print_nl();
-
-		prom_print(RELOC("\tbase = 0x"));
-		prom_print_hex(vbase);
-		prom_print_nl();
-
-		prom_print(RELOC("\tsize = 0x"));
-		prom_print_hex(minsize);
-		prom_print_nl();
-#endif
+		prom_debug("TCE table: 0x%x\n", table);
+		prom_debug("\tnode = 0x%x\n", node);
+		prom_debug("\tbase = 0x%x\n", vbase);
+		prom_debug("\tsize = 0x%x\n", minsize);
 
 		/* Initialize the table to have a one-to-one mapping
 		 * over the allocated size.
@@ -895,37 +851,30 @@
 		/* It seems OF doesn't null-terminate the path :-( */
 		memset(path, 0, sizeof(path));
 		/* Call OF to setup the TCE hardware */
-		if (call_prom(RELOC("package-to-path"), 3, 1, node,
-                             path, sizeof(path)-1) == PROM_ERROR) {
-                        prom_print(RELOC("package-to-path failed\n"));
+		if (call_prom("package-to-path", 3, 1, node,
+			      path, sizeof(path)-1) == PROM_ERROR) {
+                        prom_printf("package-to-path failed\n");
                 } else {
-                        prom_print(RELOC("opening PHB "));
-                        prom_print(path);
+                        prom_printf("opening PHB %s", path);
                 }
 
-                phb_node = (ihandle)call_prom(RELOC("open"), 1, 1, path);
+                phb_node = call_prom("open", 1, 1, path);
                 if ( (long)phb_node <= 0) {
-                        prom_print(RELOC("... failed\n"));
+                        prom_printf("... failed\n");
                 } else {
-                        prom_print(RELOC("... done\n"));
+                        prom_printf("... done\n");
                 }
-                call_prom(RELOC("call-method"), 6, 0,
-                             RELOC("set-64-bit-addressing"),
-			     phb_node,
-			     -1,
-                             minsize, 
-                             base & 0xffffffff,
-                             (base >> 32) & 0xffffffff);
-                call_prom(RELOC("close"), 1, 0, phb_node);
+                call_prom("call-method", 6, 0, ADDR("set-64-bit-addressing"),
+			  phb_node, -1, minsize,
+			  (u32) base, (u32) (base >> 32));
+                call_prom("close", 1, 0, phb_node);
 
 		table++;
 	}
 
 	/* Flag the first invalid entry */
 	prom_tce_table[table].node = 0;
-#ifdef DEBUG_PROM
-	prom_print(RELOC("ending prom_initialize_tce_table\n"));
-#endif
+	prom_debug("ending prom_initialize_tce_table\n");
 }
 
 /*
@@ -983,13 +932,11 @@
 	if (_systemcfg->platform == PLATFORM_POWERMAC) {
 		for (node = 0; prom_next_node(&node); ) {
 			type[0] = 0;
-			call_prom(RELOC("getprop"), 4, 1, node, RELOC("device_type"),
-				  type, sizeof(type));
+			prom_getprop(node, "device_type", type, sizeof(type));
 			if (strcmp(type, RELOC("cpu")) != 0)
 				continue;
 			reg = -1;
-			call_prom(RELOC("getprop"), 4, 1, node, RELOC("reg"),
-				  &reg, sizeof(reg));
+			prom_getprop(node, "reg", &reg, sizeof(reg));
 			_xPaca[cpuid].xHwProcNum = reg;
 
 #ifdef CONFIG_SMP
@@ -1007,24 +954,13 @@
 	/* Initially, we must have one active CPU. */
 	_systemcfg->processorCount = 1;
 
-#ifdef DEBUG_PROM
-	prom_print(RELOC("prom_hold_cpus: start...\n"));
-	prom_print(RELOC("    1) spinloop       = 0x"));
-	prom_print_hex((unsigned long)spinloop);
-	prom_print_nl();
-	prom_print(RELOC("    1) *spinloop      = 0x"));
-	prom_print_hex(*spinloop);
-	prom_print_nl();
-	prom_print(RELOC("    1) acknowledge    = 0x"));
-	prom_print_hex((unsigned long)acknowledge);
-	prom_print_nl();
-	prom_print(RELOC("    1) *acknowledge   = 0x"));
-	prom_print_hex(*acknowledge);
-	prom_print_nl();
-	prom_print(RELOC("    1) secondary_hold = 0x"));
-	prom_print_hex(secondary_hold);
-	prom_print_nl();
-#endif
+	prom_debug("prom_hold_cpus: start...\n");
+	prom_debug("    1) spinloop       = 0x%x\n", (unsigned long)spinloop);
+	prom_debug("    1) *spinloop      = 0x%x\n", *spinloop);
+	prom_debug("    1) acknowledge    = 0x%x\n",
+		   (unsigned long)acknowledge);
+	prom_debug("    1) *acknowledge   = 0x%x\n", *acknowledge);
+	prom_debug("    1) secondary_hold = 0x%x\n", secondary_hold);
 
         /* Set the common spinloop variable, so all of the secondary cpus
 	 * will block when they are awakened from their OF spinloop.
@@ -1041,36 +977,26 @@
 	/* look for cpus */
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
-		call_prom(RELOC("getprop"), 4, 1, node, RELOC("device_type"),
-			  type, sizeof(type));
+		prom_getprop(node, "device_type", type, sizeof(type));
 		if (strcmp(type, RELOC("cpu")) != 0)
 			continue;
 
 		/* Skip non-configured cpus. */
-		call_prom(RELOC("getprop"), 4, 1, node, RELOC("status"),
-			  type, sizeof(type));
+		prom_getprop(node, "status", type, sizeof(type));
 		if (strcmp(type, RELOC("okay")) != 0)
 			continue;
 
                 reg = -1;
-		call_prom(RELOC("getprop"), 4, 1, node, RELOC("reg"),
-			  &reg, sizeof(reg));
+		prom_getprop(node, "reg", &reg, sizeof(reg));
 
 		path = (char *) mem;
 		memset(path, 0, 256);
-		if ((long) call_prom(RELOC("package-to-path"), 3, 1,
-				     node, path, 255) == PROM_ERROR)
+		if (call_prom("package-to-path", 3, 1,
+			      node, path, 255) == PROM_ERROR)
 			continue;
 
-#ifdef DEBUG_PROM
-		prom_print_nl();
-		prom_print(RELOC("cpuid        = 0x"));
-		prom_print_hex(cpuid);
-		prom_print_nl();
-		prom_print(RELOC("cpu hw idx   = 0x"));
-		prom_print_hex(reg);
-		prom_print_nl();
-#endif
+		prom_debug("\ncpuid        = 0x%x\n", cpuid);
+		prom_debug("cpu hw idx   = 0x%x\n", reg);
 		_xPaca[cpuid].xHwProcNum = reg;
 
 		/* Init the acknowledge var which will be reset by
@@ -1079,10 +1005,9 @@
 		 */
 		*acknowledge = (unsigned long)-1;
 
-		propsize = call_prom(RELOC("getprop"), 4, 1, node,
-				     RELOC("ibm,ppc-interrupt-server#s"), 
-				     &interrupt_server, 
-				     sizeof(interrupt_server));
+		propsize = prom_getprop(node, "ibm,ppc-interrupt-server#s",
+					&interrupt_server,
+					sizeof(interrupt_server));
 		if (propsize < 0) {
 			/* no property.  old hardware has no SMT */
 			cpu_threads = 1;
@@ -1091,11 +1016,9 @@
 			/* We have a threaded processor */
 			cpu_threads = propsize / sizeof(u32);
 			if (cpu_threads > MAX_CPU_THREADS) {
-				prom_print(RELOC("SMT: too many threads!\nSMT: found "));
-				prom_print_hex(cpu_threads);
-				prom_print(RELOC(", max is "));
-				prom_print_hex(MAX_CPU_THREADS);
-				prom_print_nl();
+				prom_printf("SMT: too many threads!\n"
+					    "SMT: found %x, max is %x\n",
+					    cpu_threads, MAX_CPU_THREADS);
 				cpu_threads = 1; /* ToDo: panic? */
 			}
 		}
@@ -1103,18 +1026,15 @@
 		hw_cpu_num = interrupt_server[0];
 		if (hw_cpu_num != _prom->cpu) {
 			/* Primary Thread of non-boot cpu */
-			prom_print_hex(cpuid);
-			prom_print(RELOC(" : starting cpu "));
-			prom_print(path);
-			prom_print(RELOC("... "));
-			call_prom(RELOC("start-cpu"), 3, 0, node, 
+			prom_printf("%x : starting cpu %s... ", cpuid, path);
+			call_prom("start-cpu", 3, 0, node,
 				  secondary_hold, cpuid);
 
 			for ( i = 0 ; (i < 100000000) && 
 			      (*acknowledge == ((unsigned long)-1)); i++ ) ;
 
 			if (*acknowledge == cpuid) {
-				prom_print(RELOC("... done\n"));
+				prom_printf("... done\n");
 				/* We have to get every CPU out of OF,
 				 * even if we never start it. */
 				if (cpuid >= NR_CPUS)
@@ -1127,17 +1047,12 @@
 				cpu_set(cpuid, RELOC(cpu_present_at_boot));
 #endif
 			} else {
-				prom_print(RELOC("... failed: "));
-				prom_print_hex(*acknowledge);
-				prom_print_nl();
+				prom_printf("... failed: %x\n", *acknowledge);
 			}
 		}
 #ifdef CONFIG_SMP
 		else {
-			prom_print_hex(cpuid);
-			prom_print(RELOC(" : booting  cpu "));
-			prom_print(path);
-			prom_print_nl();
+			prom_printf("%x : booting  cpu %s\n", cpuid, path);
 			cpu_set(cpuid, RELOC(cpu_available_map));
 			cpu_set(cpuid, RELOC(cpu_possible_map));
 			cpu_set(cpuid, RELOC(cpu_online_map));
@@ -1152,16 +1067,15 @@
 			if (cpuid >= NR_CPUS)
 				continue;
 			_xPaca[cpuid].xHwProcNum = interrupt_server[i];
-			prom_print_hex(interrupt_server[i]);
-			prom_print(RELOC(" : preparing thread ... "));
+			prom_printf("%x : preparing thread ... ",
+				    interrupt_server[i]);
 			if (_naca->smt_state) {
 				cpu_set(cpuid, RELOC(cpu_available_map));
 				cpu_set(cpuid, RELOC(cpu_present_at_boot));
-				prom_print(RELOC("available"));
+				prom_printf("available\n");
 			} else {
-				prom_print(RELOC("not available"));
+				prom_printf("not available\n");
 			}
-			prom_print_nl();
 		}
 #endif
 		cpuid++;
@@ -1171,7 +1085,7 @@
 	if (__is_processor(PV_PULSAR) || 
 	    __is_processor(PV_ICESTAR) ||
 	    __is_processor(PV_SSTAR)) {
-		prom_print(RELOC("    starting secondary threads\n"));
+		prom_printf("    starting secondary threads\n");
 
 		for (i = 0; i < NR_CPUS; i += 2) {
 			if (!cpu_online(i))
@@ -1192,24 +1106,22 @@
 		}
 		_systemcfg->processorCount *= 2;
 	} else {
-		prom_print(RELOC("Processor is not HMT capable\n"));
+		prom_printf("Processor is not HMT capable\n");
 	}
 #endif
 
-	if (cpuid >= NR_CPUS)
-		prom_print(RELOC("WARNING: maximum CPUs (" __stringify(NR_CPUS)
-				 ") exceeded: ignoring extras\n"));
+	if (cpuid > NR_CPUS)
+		prom_printf("WARNING: maximum CPUs (" __stringify(NR_CPUS)
+			    ") exceeded: ignoring extras\n");
 
-#ifdef DEBUG_PROM
-	prom_print(RELOC("prom_hold_cpus: end...\n"));
-#endif
+	prom_debug("prom_hold_cpus: end...\n");
 }
 
 static void __init smt_setup(void)
 {
 	char *p, *q;
 	char my_smt_enabled = SMT_DYNAMIC;
-	ihandle prom_options = NULL;
+	ihandle prom_options = 0;
 	char option[9];
 	unsigned long offset = reloc_offset();
         struct naca_struct *_naca = RELOC(naca);
@@ -1233,13 +1145,10 @@
 		}
 	}
 	if (!found) {
-		prom_options = (ihandle)call_prom(RELOC("finddevice"), 1, 1, RELOC("/options"));
+		prom_options = call_prom("finddevice", 1, 1, ADDR("/options"));
 		if (prom_options != (ihandle) -1) {
-			call_prom(RELOC("getprop"), 
-				4, 1, prom_options,
-				RELOC("ibm,smt-enabled"), 
-				option, 
-				sizeof(option));
+			prom_getprop(prom_options, "ibm,smt-enabled",
+				     option, sizeof(option));
 			if (option[0] != 0) {
 				found = 1;
 				if (!strcmp(option, RELOC("off")))
@@ -1272,43 +1181,29 @@
 	int i, naddrs;
 	char name[64];
 	unsigned long offset = reloc_offset();
-	char *getprop = RELOC("getprop");
-
-	prom_print(RELOC("Initializing fake screen: "));
 
 	memset(name, 0, sizeof(name));
-	call_prom(getprop, 4, 1, dp, RELOC("name"), name, sizeof(name));
+	prom_getprop(dp, "name", name, sizeof(name));
 	name[sizeof(name)-1] = 0;
-	prom_print(name);
-	prom_print(RELOC("\n"));
-	call_prom(getprop, 4, 1, dp, RELOC("width"), &width, sizeof(width));
-	call_prom(getprop, 4, 1, dp, RELOC("height"), &height, sizeof(height));
-	call_prom(getprop, 4, 1, dp, RELOC("depth"), &depth, sizeof(depth));
+	prom_printf("Initializing fake screen: %s\n", name);
+
+	prom_getprop(dp, "width", &width, sizeof(width));
+	prom_getprop(dp, "height", &height, sizeof(height));
+	prom_getprop(dp, "depth", &depth, sizeof(depth));
 	pitch = width * ((depth + 7) / 8);
-	call_prom(getprop, 4, 1, dp, RELOC("linebytes"),
-		  &pitch, sizeof(pitch));
+	prom_getprop(dp, "linebytes", &pitch, sizeof(pitch));
 	if (pitch == 1)
 		pitch = 0x1000;		/* for strange IBM display */
 	address = 0;
 
-	prom_print(RELOC("width "));
-	prom_print_hex(width);
-	prom_print(RELOC(" height "));
-	prom_print_hex(height);
-	prom_print(RELOC(" depth "));
-	prom_print_hex(depth);
-	prom_print(RELOC(" linebytes "));
-	prom_print_hex(pitch);
-	prom_print(RELOC("\n"));
-
+	prom_printf("width %x height %x depth %x linebytes %x\n",
+		    width, height, depth, depth);
 
-	call_prom(getprop, 4, 1, dp, RELOC("address"),
-		  &address, sizeof(address));
+	prom_getprop(dp, "address", &address, sizeof(address));
 	if (address == 0) {
 		/* look for an assigned address with a size of >= 1MB */
-		naddrs = (int) call_prom(getprop, 4, 1, dp,
-				RELOC("assigned-addresses"),
-				addrs, sizeof(addrs));
+		naddrs = prom_getprop(dp, "assigned-addresses",
+				      addrs, sizeof(addrs));
 		naddrs /= sizeof(struct pci_reg_property);
 		for (i = 0; i < naddrs; ++i) {
 			if (addrs[i].size_lo >= (1 << 20)) {
@@ -1320,14 +1215,12 @@
 			}
 		}
 		if (address == 0) {
-			prom_print(RELOC("Failed to get address of frame buffer\n"));
+			prom_printf("Failed to get address of frame buffer\n");
 			return;
 		}
 	}
 	btext_setup_display(width, height, depth, pitch, address);
-	prom_print(RELOC("Addr of fb: "));
-	prom_print_hex(address);
-	prom_print_nl();
+	prom_printf("Addr of fb: %x\n", address);
 	RELOC(boot_text_mapped) = 0;
 }
 #endif /* CONFIG_BOOTX_TEXT */
@@ -1344,15 +1237,14 @@
 	_prom->encode_phys_size = 32;
 
 	/* get a handle for the stdout device */
-	_prom->chosen = (ihandle)call_prom(RELOC("finddevice"), 1, 1,
-				       RELOC("/chosen"));
+	_prom->chosen = call_prom("finddevice", 1, 1, ADDR("/chosen"));
 	if ((long)_prom->chosen <= 0)
-		prom_panic(RELOC("cannot find chosen")); /* msg won't be printed :( */
+		prom_panic("cannot find chosen"); /* msg won't be printed :( */
 
 	/* get device tree root */
-	_prom->root = (ihandle)call_prom(RELOC("finddevice"), 1, 1, RELOC("/"));
+	_prom->root = call_prom("finddevice", 1, 1, ADDR("/"));
 	if ((long)_prom->root <= 0)
-		prom_panic(RELOC("cannot find device tree root")); /* msg won't be printed :( */
+		prom_panic("cannot find device tree root"); /* msg won't be printed :( */
 }
 
 static void __init prom_init_stdout(void)
@@ -1361,12 +1253,10 @@
 	struct prom_t *_prom = PTRRELOC(&prom);
 	u32 val;
 
-        if ((long)call_prom(RELOC("getprop"), 4, 1, _prom->chosen,
-			    RELOC("stdout"), &val,
-			    sizeof(val)) <= 0)
-                prom_panic(RELOC("cannot find stdout"));
+        if (prom_getprop(_prom->chosen, "stdout", &val, sizeof(val)) <= 0)
+                prom_panic("cannot find stdout");
 
-        _prom->stdout = (ihandle)(unsigned long)val;
+        _prom->stdout = val;
 }
 
 static int __init prom_find_machine_type(void)
@@ -1376,9 +1266,8 @@
 	char compat[256];
 	int len, i = 0;
 
-	len = (int)(long)call_prom(RELOC("getprop"), 4, 1, _prom->root,
-				   RELOC("compatible"),
-				   compat, sizeof(compat)-1);
+	len = prom_getprop(_prom->root, "compatible",
+			   compat, sizeof(compat)-1);
 	if (len > 0) {
 		compat[len] = 0;
 		while (i < len) {
@@ -1400,13 +1289,7 @@
 {
 	unsigned long offset = reloc_offset();
 
-	return (int)(long)call_prom(RELOC("call-method"), 6, 1,
-		                    RELOC("color!"),
-                                    ih,
-                                    (void *)(long) i,
-                                    (void *)(long) b,
-                                    (void *)(long) g,
-                                    (void *)(long) r );
+	return call_prom("call-method", 6, 1, ADDR("color!"), ih, i, b, g, r);
 }
 
 /*
@@ -1447,16 +1330,13 @@
 
 	_prom->disp_node = 0;
 
-	prom_print(RELOC("Looking for displays\n"));
-	if (RELOC(of_stdout_device) != 0) {
-		prom_print(RELOC("OF stdout is    : "));
-		prom_print(PTRRELOC(RELOC(of_stdout_device)));
-		prom_print(RELOC("\n"));
-	}
+	prom_printf("Looking for displays\n");
+	if (RELOC(of_stdout_device) != 0)
+		prom_printf("OF stdout is    : %s\n",
+			    PTRRELOC(RELOC(of_stdout_device)));
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
-		call_prom(RELOC("getprop"), 4, 1, node, RELOC("device_type"),
-			  type, sizeof(type));
+		prom_getprop(node, "device_type", type, sizeof(type));
 		if (strcmp(type, RELOC("display")) != 0)
 			continue;
 		/* It seems OF doesn't null-terminate the path :-( */
@@ -1467,12 +1347,9 @@
 		 * leave some room at the end of the path for appending extra
 		 * arguments
 		 */
-		if ((long) call_prom(RELOC("package-to-path"), 3, 1,
-				    node, path, 250) < 0)
+		if (call_prom("package-to-path", 3, 1, node, path, 250) < 0)
 			continue;
-		prom_print(RELOC("found display   : "));
-		prom_print(path);
-		prom_print(RELOC("\n"));
+		prom_printf("found display   : %s\n", path);
 		
 		/*
 		 * If this display is the device that OF is using for stdout,
@@ -1489,27 +1366,26 @@
 				RELOC(prom_display_nodes[i])
 					= RELOC(prom_display_nodes[i-1]);
 			}
-			_prom->disp_node = (ihandle)(unsigned long)node;
+			_prom->disp_node = node;
 		}
 		RELOC(prom_display_paths[i]) = PTRUNRELOC(path);
 		RELOC(prom_display_nodes[i]) = node;
 		if (_prom->disp_node == 0)
-			_prom->disp_node = (ihandle)(unsigned long)node;
+			_prom->disp_node = node;
 		if (RELOC(prom_num_displays) >= FB_MAX)
 			break;
 	}
-	prom_print(RELOC("Opening displays...\n"));
+	prom_printf("Opening displays...\n");
 	for (j = RELOC(prom_num_displays) - 1; j >= 0; j--) {
 		path = PTRRELOC(RELOC(prom_display_paths[j]));
-		prom_print(RELOC("opening display : "));
-		prom_print(path);
-		ih = (ihandle)call_prom(RELOC("open"), 1, 1, path);
+		prom_printf("opening display : %s", path);
+		ih = call_prom("open", 1, 1, path);
 		if (ih == (ihandle)0 || ih == (ihandle)-1) {
-			prom_print(RELOC("... failed\n"));
+			prom_printf("... failed\n");
 			continue;
 		}
 
-		prom_print(RELOC("... done\n"));
+		prom_printf("... done\n");
 
 		/* Setup a useable color table when the appropriate
 		 * method is available. Should update this to set-colors */
@@ -1546,9 +1422,9 @@
 		unsigned long initrd_len;
 
 		if (*mem_end != RELOC(initrd_start))
-			prom_panic(RELOC("No memory for copy_device_tree"));
+			prom_panic("No memory for copy_device_tree");
 
-		prom_print(RELOC("Huge device_tree: moving initrd\n"));
+		prom_printf("Huge device_tree: moving initrd\n");
 		/* Move by 4M. */
 		initrd_len = RELOC(initrd_end) - RELOC(initrd_start);
 		*mem_end = RELOC(initrd_start) + 4 * 1024 * 1024;
@@ -1557,7 +1433,7 @@
 		RELOC(initrd_start) = *mem_end;
 		RELOC(initrd_end) = RELOC(initrd_start) + initrd_len;
 #else
-		prom_panic(RELOC("No memory for copy_device_tree"));
+		prom_panic("No memory for copy_device_tree");
 #endif
 	}
 
@@ -1606,8 +1482,7 @@
 	for (;;) {
 		/* 32 is max len of name including nul. */
 		namep = make_room(mem_start, mem_end, char[32]);
-		if ((long) call_prom(RELOC("nextprop"), 3, 1, node, prev_name,
-				     namep) <= 0) {
+		if (call_prom("nextprop", 3, 1, node, prev_name, namep) <= 0) {
 			/* No more nodes: unwind alloc */
 			*mem_start = (unsigned long)namep;
 			break;
@@ -1619,28 +1494,24 @@
 		pp->name = PTRUNRELOC(namep);
 		prev_name = namep;
 
-		pp->length = call_prom(RELOC("getproplen"), 2, 1, node, namep);
+		pp->length = call_prom("getproplen", 2, 1, node, namep);
 		if (pp->length < 0)
 			continue;
 		if (pp->length > MAX_PROPERTY_LENGTH) {
 			char path[128];
 
-			prom_print(RELOC("WARNING: ignoring large property "));
+			prom_printf("WARNING: ignoring large property ");
 			/* It seems OF doesn't null-terminate the path :-( */
 			memset(path, 0, sizeof(path));
-			if (call_prom(RELOC("package-to-path"), 3, 1, node,
-                            path, sizeof(path)-1) > 0)
-				prom_print(path);
-			prom_print(namep);
-			prom_print(RELOC(" length 0x"));
-			prom_print_hex(pp->length);
-			prom_print_nl();
-
+			if (call_prom("package-to-path", 3, 1, node,
+				      path, sizeof(path)-1) > 0)
+				prom_printf("[%s] ", path);
+			prom_printf("%s length 0x%x\n", namep, pp->length);
 			continue;
 		}
 		valp = __make_room(mem_start, mem_end, pp->length, 1);
 		pp->value = PTRUNRELOC(valp);
-		call_prom(RELOC("getprop"), 4, 1, node, namep,valp,pp->length);
+		call_prom("getprop", 4, 1, node, namep, valp, pp->length);
 		*prev_propp = PTRUNRELOC(pp);
 		prev_propp = &pp->next;
 	}
@@ -1660,19 +1531,19 @@
 	/* Set np->linux_phandle to the value of the ibm,phandle property
 	   if it exists, otherwise to the phandle for this node. */
 	np->linux_phandle = node;
-	if ((int)call_prom(RELOC("getprop"), 4, 1, node, RELOC("ibm,phandle"),
-			   &ibm_phandle, sizeof(ibm_phandle)) > 0)
+	if (prom_getprop(node, "ibm,phandle",
+			 &ibm_phandle, sizeof(ibm_phandle)) > 0)
 		np->linux_phandle = ibm_phandle;
 
 	/* get the node's full name */
 	namep = (char *)*mem_start;
-	l = (long) call_prom(RELOC("package-to-path"), 3, 1, node,
-			     namep, *mem_end - *mem_start);
+	l = call_prom("package-to-path", 3, 1, node,
+		      namep, *mem_end - *mem_start);
 	if (l >= 0) {
 		/* Didn't fit?  Get more room. */
 		if (l+1 > *mem_end - *mem_start) {
 			namep = __make_room(mem_start, mem_end, l+1, 1);
-			call_prom(RELOC("package-to-path"),3,1,node,namep,l);
+			call_prom("package-to-path", 3, 1, node, namep, l);
 		}
 		np->full_name = PTRUNRELOC(namep);
 		namep[l] = '\0';
@@ -1680,11 +1551,11 @@
 	}
 
 	/* do all our children */
-	child = call_prom(RELOC("child"), 1, 1, node);
+	child = call_prom("child", 1, 1, node);
 	while (child != (phandle)0) {
 		inspect_node(child, np, mem_start, mem_end,
 					 allnextpp);
-		child = call_prom(RELOC("peer"), 1, 1, child);
+		child = call_prom("peer", 1, 1, child);
 	}
 }
 
@@ -1706,9 +1577,9 @@
 		mem_end = RELOC(initrd_start);
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-	root = call_prom(RELOC("peer"), 1, 1, (phandle)0);
+	root = call_prom("peer", 1, 1, (phandle)0);
 	if (root == (phandle)0) {
-		prom_panic(RELOC("couldn't get device tree root\n"));
+		prom_panic("couldn't get device tree root\n");
 	}
 	allnextp = &RELOC(allnodes);
 	inspect_node(root, 0, &mem_start, &mem_end, &allnextp);
@@ -1720,44 +1591,25 @@
 static struct bi_record * __init prom_bi_rec_verify(struct bi_record *bi_recs)
 {
 	struct bi_record *first, *last;
-#ifdef DEBUG_PROM
-	unsigned long offset = reloc_offset();
 
-  	prom_print(RELOC("birec_verify: r6=0x"));
-  	prom_print_hex((unsigned long)bi_recs);
-  	prom_print_nl();
-	if (bi_recs != NULL) {
-		prom_print(RELOC("  tag=0x"));
-		prom_print_hex(bi_recs->tag);
-		prom_print_nl();
-	}
-#endif /* DEBUG_PROM */
+  	prom_debug("birec_verify: r6=0x%x\n", (unsigned long)bi_recs);
+	if (bi_recs != NULL)
+		prom_debug("  tag=0x%x\n", bi_recs->tag);
 
 	if ( bi_recs == NULL || bi_recs->tag != BI_FIRST )
 		return NULL;
 
 	last = (struct bi_record *)(long)bi_recs->data[0];
 
-#ifdef DEBUG_PROM
-  	prom_print(RELOC("  last=0x"));
-  	prom_print_hex((unsigned long)last);
-  	prom_print_nl();
-	if (last != NULL) {
-		prom_print(RELOC("  last_tag=0x"));
-		prom_print_hex(last->tag);
-		prom_print_nl();
-	}
-#endif /* DEBUG_PROM */
+  	prom_debug("  last=0x%x\n", (unsigned long)last);
+	if (last != NULL)
+		prom_debug("  last_tag=0x%x\n", last->tag);
 
 	if ( last == NULL || last->tag != BI_LAST )
 		return NULL;
 
 	first = (struct bi_record *)(long)last->data[0];
-#ifdef DEBUG_PROM
-  	prom_print(RELOC("  first=0x"));
-  	prom_print_hex((unsigned long)first);
-  	prom_print_nl();
-#endif /* DEBUG_PROM */
+  	prom_debug("  first=0x%x\n", (unsigned long)first);
 
 	if ( first == NULL || first != bi_recs )
 		return NULL;
@@ -1776,11 +1628,7 @@
 		for ( rec=_prom->bi_recs;
 		      rec->tag != BI_LAST;
 		      rec=bi_rec_next(rec) ) {
-#ifdef DEBUG_PROM
-			prom_print(RELOC("bi: 0x"));
-			prom_print_hex(rec->tag);
-			prom_print_nl();
-#endif /* DEBUG_PROM */
+			prom_debug("bi: 0x%x\n", rec->tag);
 			switch (rec->tag) {
 #ifdef CONFIG_BLK_DEV_INITRD
 			case BI_INITRD:
@@ -1833,31 +1681,17 @@
 	/* Init prom stdout device */
 	prom_init_stdout();
 
-#ifdef DEBUG_PROM
-  	prom_print(RELOC("klimit=0x"));
-  	prom_print_hex(RELOC(klimit));
-  	prom_print_nl();
-  	prom_print(RELOC("offset=0x"));
-  	prom_print_hex(offset);
-  	prom_print_nl();
-  	prom_print(RELOC("->mem=0x"));
-  	prom_print_hex(RELOC(klimit) - offset);
-  	prom_print_nl();
-#endif /* DEBUG_PROM */
+  	prom_debug("klimit=0x%x\n", RELOC(klimit));
+  	prom_debug("offset=0x%x\n", offset);
+  	prom_debug("->mem=0x%x\n", RELOC(klimit) - offset);
 
 	/* check out if we have bi_recs */
 	_prom->bi_recs = prom_bi_rec_verify((struct bi_record *)r6);
 	if ( _prom->bi_recs != NULL ) {
 		RELOC(klimit) = PTRUNRELOC((unsigned long)_prom->bi_recs +
 					   _prom->bi_recs->data[1]);
-#ifdef DEBUG_PROM
-		prom_print(RELOC("bi_recs=0x"));
-		prom_print_hex((unsigned long)_prom->bi_recs);
-		prom_print_nl();
-		prom_print(RELOC("new mem=0x"));
-		prom_print_hex(RELOC(klimit) - offset);
-		prom_print_nl();
-#endif /* DEBUG_PROM */
+		prom_debug("bi_recs=0x%x\n", (unsigned long)_prom->bi_recs);
+		prom_debug("new mem=0x%x\n", RELOC(klimit) - offset);
 	}
 
 	/* If we don't have birec's or didn't find them, check for an initrd
@@ -1884,57 +1718,46 @@
 	/* Get the full OF pathname of the stdout device */
 	p = (char *) mem;
 	memset(p, 0, 256);
-	call_prom(RELOC("instance-to-path"), 3, 1, _prom->stdout, p, 255);
+	call_prom("instance-to-path", 3, 1, _prom->stdout, p, 255);
 	RELOC(of_stdout_device) = PTRUNRELOC(p);
 	mem += strlen(p) + 1;
 
 	getprop_rval = 1;
-	call_prom(RELOC("getprop"), 4, 1,
-		  _prom->root, RELOC("#size-cells"),
-		  &getprop_rval, sizeof(getprop_rval));
+	prom_getprop(_prom->root, "#size-cells",
+		     &getprop_rval, sizeof(getprop_rval));
 	_prom->encode_phys_size = (getprop_rval == 1) ? 32 : 64;
 
 	/* Determine which cpu is actually running right _now_ */
-        if ((long)call_prom(RELOC("getprop"), 4, 1, _prom->chosen,
-			    RELOC("cpu"), &getprop_rval,
-			    sizeof(getprop_rval)) <= 0)
-                prom_panic(RELOC("cannot find boot cpu"));
-
-	prom_cpu = (ihandle)(unsigned long)getprop_rval;
-	cpu_pkg = call_prom(RELOC("instance-to-package"), 1, 1, prom_cpu);
-	call_prom(RELOC("getprop"), 4, 1,
-		cpu_pkg, RELOC("reg"),
-		&getprop_rval, sizeof(getprop_rval));
-	_prom->cpu = (int)(unsigned long)getprop_rval;
+        if (prom_getprop(_prom->chosen, "cpu",
+			 &prom_cpu, sizeof(prom_cpu)) <= 0)
+                prom_panic("cannot find boot cpu");
+
+	cpu_pkg = call_prom("instance-to-package", 1, 1, prom_cpu);
+	prom_getprop(cpu_pkg, "reg", &getprop_rval, sizeof(getprop_rval));
+	_prom->cpu = getprop_rval;
 	_xPaca[0].xHwProcNum = _prom->cpu;
 
 	RELOC(boot_cpuid) = 0;
 
-#ifdef DEBUG_PROM
-  	prom_print(RELOC("Booting CPU hw index = 0x"));
-  	prom_print_hex(_prom->cpu);
-  	prom_print_nl();
-#endif
+  	prom_debug("Booting CPU hw index = 0x%x\n", _prom->cpu);
 
 	/* Get the boot device and translate it to a full OF pathname. */
 	p = (char *) mem;
-	l = (long) call_prom(RELOC("getprop"), 4, 1, _prom->chosen,
-			    RELOC("bootpath"), p, 1<<20);
+	l = prom_getprop(_prom->chosen, "bootpath", p, 1<<20);
 	if (l > 0) {
 		p[l] = 0;	/* should already be null-terminated */
 		RELOC(bootpath) = PTRUNRELOC(p);
 		mem += l + 1;
 		d = (char *) mem;
 		*d = 0;
-		call_prom(RELOC("canon"), 3, 1, p, d, 1<<20);
+		call_prom("canon", 3, 1, p, d, 1<<20);
 		RELOC(bootdevice) = PTRUNRELOC(d);
 		mem = DOUBLEWORD_ALIGN(mem + strlen(d) + 1);
 	}
 
 	RELOC(cmd_line[0]) = 0;
 	if ((long)_prom->chosen > 0) {
-		call_prom(RELOC("getprop"), 4, 1, _prom->chosen,
-			  RELOC("bootargs"), p, sizeof(cmd_line));
+		prom_getprop(_prom->chosen, "bootargs", p, sizeof(cmd_line));
 		if (p != NULL && p[0] != 0)
 			strlcpy(RELOC(cmd_line), p, sizeof(cmd_line));
 	}
@@ -1961,33 +1784,20 @@
          */
 	prom_hold_cpus(mem);
 
-#ifdef DEBUG_PROM
-  	prom_print(RELOC("after basic inits, mem=0x"));
-  	prom_print_hex(mem);
-  	prom_print_nl();
+  	prom_debug("after basic inits, mem=0x%x\n", mem);
 #ifdef CONFIG_BLK_DEV_INITRD
-	prom_print(RELOC("initrd_start=0x"));
-	prom_print_hex(RELOC(initrd_start));
-	prom_print_nl();
-	prom_print(RELOC("initrd_end=0x"));
-	prom_print_hex(RELOC(initrd_end));
-	prom_print_nl();
+	prom_debug("initrd_start=0x%x\n", RELOC(initrd_start));
+	prom_debug("initrd_end=0x%x\n", RELOC(initrd_end));
 #endif /* CONFIG_BLK_DEV_INITRD */
-	prom_print(RELOC("copying OF device tree...\n"));
-#endif /* DEBUG_PROM */
+	prom_debug("copying OF device tree...\n");
+
 	mem = copy_device_tree(mem);
 
 	RELOC(klimit) = mem + offset;
 
-#ifdef DEBUG_PROM
-	prom_print(RELOC("new klimit is\n"));
-  	prom_print(RELOC("klimit=0x"));
-  	prom_print_hex(RELOC(klimit));
-	prom_print(RELOC(" ->mem=0x\n"));
-  	prom_print(RELOC("klimit=0x"));
-  	prom_print_hex(mem);
-  	prom_print_nl();
-#endif /* DEBUG_PROM */
+	prom_debug("new klimit is\n");
+  	prom_debug("klimit=0x%x\n", RELOC(klimit));
+	prom_debug(" ->mem=0x%x\n", mem);
 
 	lmb_reserve(0, __pa(RELOC(klimit)));
 
@@ -2017,14 +1827,14 @@
 #endif
 
 #ifdef CONFIG_BOOTX_TEXT
-	if(_prom->disp_node) {
-		prom_print(RELOC("Setting up bi display...\n"));
+	if (_prom->disp_node) {
+		prom_printf("Setting up bi display...\n");
 		setup_disp_fake_bi(_prom->disp_node);
 	}
 #endif /* CONFIG_BOOTX_TEXT */
 
-	prom_print(RELOC("Calling quiesce ...\n"));
-	call_prom(RELOC("quiesce"), 0, 0);
+	prom_printf("Calling quiesce ...\n");
+	call_prom("quiesce", 0, 0);
 	phys = KERNELBASE - offset;
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -2035,7 +1845,7 @@
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-	prom_print(RELOC("returning from prom_init\n"));
+	prom_printf("returning from prom_init\n");
 	return phys;
 }
 
diff -urN linux-2.5/arch/ppc64/kernel/rtas-proc.c prom-cleanup/arch/ppc64/kernel/rtas-proc.c
--- linux-2.5/arch/ppc64/kernel/rtas-proc.c	2004-05-28 07:16:52.000000000 +1000
+++ prom-cleanup/arch/ppc64/kernel/rtas-proc.c	2004-05-28 14:02:21.000000000 +1000
@@ -394,7 +394,7 @@
 		size_t count, loff_t *ppos)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	unsigned long *ret = kmalloc(4*8, GFP_KERNEL);
+	int ret[8];
 	int n, sn, error;
 	char stkbuf[40];  /* its small, its on stack */
 
@@ -411,7 +411,6 @@
 		n = scnprintf (stkbuf, sizeof(stkbuf), "%lu\n",
 				mktime(year, mon, day, hour, min, sec));
 	}
-	kfree(ret);
 
 	sn = strlen (stkbuf) +1;
 	if (*ppos >= sn)
@@ -434,7 +433,6 @@
 		int count, int *eof, void *data)
 {
 	int i,j,n;
-	unsigned long ret;
 	int state, error;
 	char *buffer;
 	int get_sensor_state = rtas_token("get-sensor-state");
@@ -464,11 +462,10 @@
 		/* A sensor may have multiple instances */
 		while (j >= 0) {
 
-			error =	rtas_call(get_sensor_state, 2, 2, &ret, 
+			error =	rtas_call(get_sensor_state, 2, 2, &state, 
 				  	  sensors.sensor[i].token, 
 				  	  sensors.sensor[i].quant - j);
 
-			state = (int) ret;
 			n += ppc_rtas_process_sensor(sensors.sensor[i], state, 
 					     	     error, buffer+n );
 			n += sprintf (buffer+n, "\n");
diff -urN linux-2.5/arch/ppc64/kernel/rtas.c prom-cleanup/arch/ppc64/kernel/rtas.c
--- linux-2.5/arch/ppc64/kernel/rtas.c	2004-06-08 20:35:54.318997968 +1000
+++ prom-cleanup/arch/ppc64/kernel/rtas.c	2004-06-08 15:55:07.000000000 +1000
@@ -139,15 +139,13 @@
 		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
 }
 
-long
-rtas_call(int token, int nargs, int nret,
-	  unsigned long *outputs, ...)
+int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 {
 	va_list list;
 	int i, logit = 0;
 	unsigned long s;
 	struct rtas_args *rtas_args;
-	long ret;
+	int ret;
 
 	PPCDBG(PPCDBG_RTAS, "Entering rtas_call\n");
 	PPCDBG(PPCDBG_RTAS, "\ttoken    = 0x%x\n", token);
@@ -167,8 +165,8 @@
 	rtas_args->rets  = (rtas_arg_t *)&(rtas_args->args[nargs]);
 	va_start(list, outputs);
 	for (i = 0; i < nargs; ++i) {
-		rtas_args->args[i] = (rtas_arg_t)LONG_LSW(va_arg(list, ulong));
-		PPCDBG(PPCDBG_RTAS, "\tnarg[%d] = 0x%lx\n", i, rtas_args->args[i]);
+		rtas_args->args[i] = va_arg(list, rtas_arg_t);
+		PPCDBG(PPCDBG_RTAS, "\tnarg[%d] = 0x%x\n", i, rtas_args->args[i]);
 	}
 	va_end(list);
 
@@ -191,7 +189,7 @@
 	if (nret > 1 && outputs != NULL)
 		for (i = 0; i < nret-1; ++i)
 			outputs[i] = rtas_args->rets[i+1];
-	ret = (ulong)((nret > 0) ? rtas_args->rets[0] : 0);
+	ret = (nret > 0)? rtas_args->rets[0]: 0;
 
 	/* Gotta do something different here, use global lock for now... */
 	spin_unlock_irqrestore(&rtas.lock, s);
@@ -227,20 +225,13 @@
 rtas_get_power_level(int powerdomain, int *level)
 {
 	int token = rtas_token("get-power-level");
-	long powerlevel;
 	int rc;
 
 	if (token == RTAS_UNKNOWN_SERVICE)
 		return RTAS_UNKNOWN_OP;
 
-	while(1) {
-		rc = (int) rtas_call(token, 1, 2, &powerlevel, powerdomain);
-		if (rc == RTAS_BUSY)
-			udelay(1);
-		else
-			break;
-	}
-	*level = (int) powerlevel;
+	while ((rc = rtas_call(token, 1, 2, level, powerdomain)) == RTAS_BUSY)
+		udelay(1);
 	return rc;
 }
 
@@ -249,25 +240,21 @@
 {
 	int token = rtas_token("set-power-level");
 	unsigned int wait_time;
-	long returned_level;
 	int rc;
 
 	if (token == RTAS_UNKNOWN_SERVICE)
 		return RTAS_UNKNOWN_OP;
 
 	while (1) {
-		rc = (int) rtas_call(token, 2, 2, &returned_level, powerdomain,
-					level);
+		rc = rtas_call(token, 2, 2, setlevel, powerdomain, level);
 		if (rc == RTAS_BUSY)
 			udelay(1);
 		else if (rtas_is_extended_busy(rc)) {
 			wait_time = rtas_extended_busy_delay_time(rc);
 			udelay(wait_time * 1000);
-		}
-		else
+		} else
 			break;
 	}
-	*setlevel = (int) returned_level;
 	return rc;
 }
 
@@ -276,25 +263,21 @@
 {
 	int token = rtas_token("get-sensor-state");
 	unsigned int wait_time;
-	long returned_state;
 	int rc;
 
 	if (token == RTAS_UNKNOWN_SERVICE)
 		return RTAS_UNKNOWN_OP;
 
 	while (1) {
-		rc = (int) rtas_call(token, 2, 2, &returned_state, sensor,
-					index);
+		rc = rtas_call(token, 2, 2, state, sensor, index);
 		if (rc == RTAS_BUSY)
 			udelay(1);
 		else if (rtas_is_extended_busy(rc)) {
 			wait_time = rtas_extended_busy_delay_time(rc);
 			udelay(wait_time * 1000);
-		}
-		else
+		} else
 			break;
 	}
-	*state = (int) returned_state;
 	return rc;
 }
 
@@ -309,8 +292,7 @@
 		return RTAS_UNKNOWN_OP;
 
 	while (1) {
-		rc = (int) rtas_call(token, 3, 1, NULL, indicator, index,
-					new_value);
+		rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);
 		if (rc == RTAS_BUSY)
 			udelay(1);
 		else if (rtas_is_extended_busy(rc)) {
@@ -409,7 +391,7 @@
 	if (rtas_firmware_flash_list.next)
 		rtas_flash_firmware();
 
-        printk("RTAS system-reboot returned %ld\n",
+        printk("RTAS system-reboot returned %d\n",
 	       rtas_call(rtas_token("system-reboot"), 0, 1, NULL));
         for (;;);
 }
@@ -420,8 +402,8 @@
 	if (rtas_firmware_flash_list.next)
 		rtas_flash_bypass_warning();
         /* allow power on only with power button press */
-        printk("RTAS power-off returned %ld\n",
-               rtas_call(rtas_token("power-off"), 2, 1, NULL,0xffffffff,0xffffffff));
+        printk("RTAS power-off returned %d\n",
+               rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1));
         for (;;);
 }
 
@@ -438,7 +420,7 @@
 
 void rtas_os_term(char *str)
 {
-	long status;
+	int status;
 
 	snprintf(rtas_os_term_buf, 2048, "OS panic: %s", str);
 
@@ -449,7 +431,7 @@
 		if (status == RTAS_BUSY)
 			udelay(1);
 		else if (status != 0)
-			printk(KERN_EMERG "ibm,os-term call failed %ld\n",
+			printk(KERN_EMERG "ibm,os-term call failed %d\n",
 			       status);
 	} while (status == RTAS_BUSY);
 }
diff -urN linux-2.5/arch/ppc64/kernel/rtas_flash.c prom-cleanup/arch/ppc64/kernel/rtas_flash.c
--- linux-2.5/arch/ppc64/kernel/rtas_flash.c	2004-05-20 08:06:38.000000000 +1000
+++ prom-cleanup/arch/ppc64/kernel/rtas_flash.c	2004-05-28 14:02:21.000000000 +1000
@@ -344,8 +344,8 @@
 	s32 rc;
 
 	while (1) {
-		rc = (s32) rtas_call(rtas_token("ibm,manage-flash-image"), 1, 
-				1, NULL, (long) args_buf->op);
+		rc = rtas_call(rtas_token("ibm,manage-flash-image"), 1, 
+			       1, NULL, args_buf->op);
 		if (rc == RTAS_RC_BUSY)
 			udelay(1);
 		else if (rtas_is_extended_busy(rc)) {
@@ -429,15 +429,15 @@
 {
 	int token = rtas_token("ibm,validate-flash-image");
 	unsigned int wait_time;
-	long update_results;
+	int update_results;
 	s32 rc;	
 
 	rc = 0;
 	while(1) {
 		spin_lock(&rtas_data_buf_lock);
 		memcpy(rtas_data_buf, args_buf->buf, VALIDATE_BUF_SIZE);
-		rc = (s32) rtas_call(token, 2, 2, &update_results, 
-				     __pa(rtas_data_buf), args_buf->buf_size);
+		rc = rtas_call(token, 2, 2, &update_results, 
+			       (u32) __pa(rtas_data_buf), args_buf->buf_size);
 		memcpy(args_buf->buf, rtas_data_buf, VALIDATE_BUF_SIZE);
 		spin_unlock(&rtas_data_buf_lock);
 			
@@ -451,7 +451,7 @@
 	}
 
 	args_buf->status = rc;
-	args_buf->update_results = (u32) update_results;
+	args_buf->update_results = update_results;
 }
 
 static int get_validate_flash_msg(struct rtas_validate_flash_t *args_buf, 
diff -urN linux-2.5/arch/ppc64/kernel/rtc.c prom-cleanup/arch/ppc64/kernel/rtc.c
--- linux-2.5/arch/ppc64/kernel/rtc.c	2004-01-20 19:23:10.000000000 +1100
+++ prom-cleanup/arch/ppc64/kernel/rtc.c	2004-05-28 14:02:20.000000000 +1000
@@ -346,13 +346,13 @@
 #define RTAS_CLOCK_BUSY (-2)
 void pSeries_get_boot_time(struct rtc_time *rtc_tm)
 {
-	unsigned long ret[8];
+	int ret[8];
 	int error, wait_time;
 	unsigned long max_wait_tb;
 
 	max_wait_tb = __get_tb() + tb_ticks_per_usec * 1000 * MAX_RTC_WAIT;
 	do {
-		error = rtas_call(rtas_token("get-time-of-day"), 0, 8, (void *)&ret);
+		error = rtas_call(rtas_token("get-time-of-day"), 0, 8, ret);
 		if (error == RTAS_CLOCK_BUSY || rtas_is_extended_busy(error)) {
 			wait_time = rtas_extended_busy_delay_time(error);
 			/* This is boot time so we spin. */
@@ -381,13 +381,13 @@
  */
 void pSeries_get_rtc_time(struct rtc_time *rtc_tm)
 {
-        unsigned long ret[8];
+        int ret[8];
 	int error, wait_time;
 	unsigned long max_wait_tb;
 
 	max_wait_tb = __get_tb() + tb_ticks_per_usec * 1000 * MAX_RTC_WAIT;
 	do {
-		error = rtas_call(rtas_token("get-time-of-day"), 0, 8, (void *)&ret);
+		error = rtas_call(rtas_token("get-time-of-day"), 0, 8, ret);
 		if (error == RTAS_CLOCK_BUSY || rtas_is_extended_busy(error)) {
 			if (in_interrupt()) {
 				printk(KERN_WARNING "error: reading clock would delay interrupt\n");
diff -urN linux-2.5/arch/ppc64/kernel/scanlog.c prom-cleanup/arch/ppc64/kernel/scanlog.c
--- linux-2.5/arch/ppc64/kernel/scanlog.c	2004-03-17 22:09:23.000000000 +1100
+++ prom-cleanup/arch/ppc64/kernel/scanlog.c	2004-05-28 14:02:20.000000000 +1000
@@ -49,7 +49,7 @@
         struct inode * inode = file->f_dentry->d_inode;
 	struct proc_dir_entry *dp;
 	unsigned int *data;
-	unsigned long status;
+	int status;
 	unsigned long len, off;
 	unsigned int wait_time;
 
@@ -81,11 +81,11 @@
 		spin_lock(&rtas_data_buf_lock);
 		memcpy(rtas_data_buf, data, RTAS_DATA_BUF_SIZE);
 		status = rtas_call(ibm_scan_log_dump, 2, 1, NULL,
-				   __pa(rtas_data_buf), count);
+				   (u32) __pa(rtas_data_buf), (u32) count);
 		memcpy(data, rtas_data_buf, RTAS_DATA_BUF_SIZE);
 		spin_unlock(&rtas_data_buf_lock);
 
-		DEBUG("status=%ld, data[0]=%x, data[1]=%x, data[2]=%x\n",
+		DEBUG("status=%d, data[0]=%x, data[1]=%x, data[2]=%x\n",
 		      status, data[0], data[1], data[2]);
 		switch (status) {
 		    case SCANLOG_COMPLETE:
@@ -133,7 +133,7 @@
 			     size_t count, loff_t *ppos)
 {
 	char stkbuf[20];
-	unsigned long status;
+	int status;
 
 	if (count > 19) count = 19;
 	if (copy_from_user (stkbuf, buf, count)) {
@@ -144,8 +144,8 @@
 	if (buf) {
 		if (strncmp(stkbuf, "reset", 5) == 0) {
 			DEBUG("reset scanlog\n");
-			status = rtas_call(ibm_scan_log_dump, 2, 1, NULL, NULL, 0);
-			DEBUG("rtas returns %ld\n", status);
+			status = rtas_call(ibm_scan_log_dump, 2, 1, NULL, 0, 0);
+			DEBUG("rtas returns %d\n", status);
 		} else if (strncmp(stkbuf, "debugon", 7) == 0) {
 			printk(KERN_ERR "scanlog: debug on\n");
 			scanlog_debug = 1;
diff -urN linux-2.5/arch/ppc64/kernel/setup.c prom-cleanup/arch/ppc64/kernel/setup.c
--- linux-2.5/arch/ppc64/kernel/setup.c	2004-05-26 07:58:59.000000000 +1000
+++ prom-cleanup/arch/ppc64/kernel/setup.c	2004-05-28 14:02:20.000000000 +1000
@@ -165,7 +165,7 @@
 		  unsigned long r6, unsigned long r7)
 {
 #if defined(CONFIG_SMP) && defined(CONFIG_PPC_PSERIES)
-	unsigned int ret, i;
+	int ret, i;
 #endif
 
 #ifdef CONFIG_XMON_DEFAULT
@@ -233,12 +233,11 @@
 #ifdef CONFIG_SMP
 		/* Start secondary threads on SMT systems */
 		for (i = 0; i < NR_CPUS; i++) {
-			if(cpu_available(i)  && !cpu_possible(i)) {
+			if (cpu_available(i) && !cpu_possible(i)) {
 				printk("%16.16x : starting thread\n", i);
-				rtas_call(rtas_token("start-cpu"), 3, 1, 
-					  (void *)&ret,
+				rtas_call(rtas_token("start-cpu"), 3, 1, &ret,
 					  get_hard_smp_processor_id(i), 
-					  *((unsigned long *)pseries_secondary_smp_init),
+					  (u32)*((unsigned long *)pseries_secondary_smp_init),
 					  i);
 				cpu_set(i, cpu_possible_map);
 				systemcfg->processorCount++;
diff -urN linux-2.5/arch/ppc64/kernel/smp.c prom-cleanup/arch/ppc64/kernel/smp.c
--- linux-2.5/arch/ppc64/kernel/smp.c	2004-06-04 07:19:00.000000000 +1000
+++ prom-cleanup/arch/ppc64/kernel/smp.c	2004-06-08 14:52:06.000000000 +1000
@@ -241,7 +241,7 @@
  */
 static int query_cpu_stopped(unsigned int pcpu)
 {
-	long cpu_status;
+	int cpu_status;
 	int status, qcss_tok;
 
 	qcss_tok = rtas_token("query-cpu-stopped-state");
diff -urN linux-2.5/arch/ppc64/kernel/traps.c prom-cleanup/arch/ppc64/kernel/traps.c
--- linux-2.5/arch/ppc64/kernel/traps.c	2004-06-08 21:20:55.814984072 +1000
+++ prom-cleanup/arch/ppc64/kernel/traps.c	2004-06-08 15:31:36.000000000 +1000
@@ -172,9 +172,9 @@
  */
 static void FWNMI_release_errinfo(void)
 {
-	unsigned long ret = rtas_call(rtas_token("ibm,nmi-interlock"), 0, 1, NULL);
+	int ret = rtas_call(rtas_token("ibm,nmi-interlock"), 0, 1, NULL);
 	if (ret != 0)
-		printk("FWNMI: nmi-interlock failed: %ld\n", ret);
+		printk("FWNMI: nmi-interlock failed: %d\n", ret);
 }
 #endif
 
diff -urN linux-2.5/arch/ppc64/kernel/xics.c prom-cleanup/arch/ppc64/kernel/xics.c
--- linux-2.5/arch/ppc64/kernel/xics.c	2004-05-27 09:21:20.000000000 +1000
+++ prom-cleanup/arch/ppc64/kernel/xics.c	2004-05-28 15:34:39.000000000 +1000
@@ -276,7 +276,7 @@
 static void xics_enable_irq(unsigned int virq)
 {
 	unsigned int irq;
-	long call_status;
+	int call_status;
 	unsigned int server;
 
 	irq = virt_irq_to_real(irq_offset_down(virq));
@@ -288,7 +288,7 @@
 				DEFAULT_PRIORITY);
 	if (call_status != 0) {
 		printk(KERN_ERR "xics_enable_irq: irq=%x: ibm_set_xive "
-		       "returned %lx\n", irq, call_status);
+		       "returned %x\n", irq, call_status);
 		return;
 	}
 
@@ -296,14 +296,14 @@
 	call_status = rtas_call(ibm_int_on, 1, 1, NULL, irq);
 	if (call_status != 0) {
 		printk(KERN_ERR "xics_enable_irq: irq=%x: ibm_int_on "
-		       "returned %lx\n", irq, call_status);
+		       "returned %x\n", irq, call_status);
 		return;
 	}
 }
 
 static void xics_disable_real_irq(unsigned int irq)
 {
-	long call_status;
+	int call_status;
 	unsigned int server;
 
 	if (irq == XICS_IPI)
@@ -312,7 +312,7 @@
 	call_status = rtas_call(ibm_int_off, 1, 1, NULL, irq);
 	if (call_status != 0) {
 		printk(KERN_ERR "xics_disable_real_irq: irq=%x: "
-		       "ibm_int_off returned %lx\n", irq, call_status);
+		       "ibm_int_off returned %x\n", irq, call_status);
 		return;
 	}
 
@@ -321,7 +321,7 @@
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server, 0xff);
 	if (call_status != 0) {
 		printk(KERN_ERR "xics_disable_irq: irq=%x: ibm_set_xive(0xff)"
-		       " returned %lx\n", irq, call_status);
+		       " returned %x\n", irq, call_status);
 		return;
 	}
 }
@@ -613,8 +613,8 @@
 static void xics_set_affinity(unsigned int virq, cpumask_t cpumask)
 {
 	unsigned int irq;
-	long status;
-	unsigned long xics_status[2];
+	int status;
+	int xics_status[2];
 	unsigned long newmask;
 	cpumask_t allcpus = CPU_MASK_ALL;
 	cpumask_t tmp = CPU_MASK_NONE;
@@ -623,11 +623,11 @@
 	if (irq == XICS_IPI || irq == NO_IRQ)
 		return;
 
-	status = rtas_call(ibm_get_xive, 1, 3, (void *)&xics_status, irq);
+	status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
 
 	if (status) {
 		printk(KERN_ERR "xics_set_affinity: irq=%d ibm,get-xive "
-		       "returns %ld\n", irq, status);
+		       "returns %d\n", irq, status);
 		return;
 	}
 
@@ -646,7 +646,7 @@
 
 	if (status) {
 		printk(KERN_ERR "xics_set_affinity irq=%d ibm,set-xive "
-		       "returns %ld\n", irq, status);
+		       "returns %d\n", irq, status);
 		return;
 	}
 }
@@ -657,10 +657,10 @@
 void xics_migrate_irqs_away(void)
 {
 	int set_indicator = rtas_token("set-indicator");
-	const unsigned long giqs = 9005UL; /* Global Interrupt Queue Server */
-	unsigned long status = 0;
+	const unsigned int giqs = 9005UL; /* Global Interrupt Queue Server */
+	int status = 0;
 	unsigned int irq, cpu = smp_processor_id();
-	unsigned long xics_status[2];
+	int xics_status[2];
 	unsigned long flags;
 
 	BUG_ON(set_indicator == RTAS_UNKNOWN_SERVICE);
@@ -671,7 +671,7 @@
 
 	/* Refuse any new interrupts... */
 	rtas_call(set_indicator, 3, 1, &status, giqs,
-		  hard_smp_processor_id(), 0UL);
+		  hard_smp_processor_id(), 0);
 	WARN_ON(status != 0);
 
 	/* Allow IPIs again... */
@@ -694,11 +694,10 @@
 
 		spin_lock_irqsave(&desc->lock, flags);
 
-		status = rtas_call(ibm_get_xive, 1, 3, (void *)&xics_status,
-				   irq);
+		status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
 		if (status) {
 			printk(KERN_ERR "migrate_irqs_away: irq=%d "
-					"ibm,get-xive returns %ld\n",
+					"ibm,get-xive returns %d\n",
 					irq, status);
 			goto unlock;
 		}
@@ -721,7 +720,7 @@
 				irq, xics_status[0], xics_status[1]);
 		if (status)
 			printk(KERN_ERR "migrate_irqs_away irq=%d "
-					"ibm,set-xive returns %ld\n",
+					"ibm,set-xive returns %d\n",
 					irq, status);
 
 unlock:
diff -urN linux-2.5/include/asm-ppc64/prom.h prom-cleanup/include/asm-ppc64/prom.h
--- linux-2.5/include/asm-ppc64/prom.h	2004-04-27 18:07:44.000000000 +1000
+++ prom-cleanup/include/asm-ppc64/prom.h	2004-05-28 11:37:20.000000000 +1000
@@ -25,7 +25,7 @@
 #define LONG_MSW(X) (((unsigned long)X) >> 32)
 
 typedef u32 phandle;
-typedef void *ihandle;
+typedef u32 ihandle;
 typedef u32 phandle32;
 typedef u32 ihandle32;
 
diff -urN linux-2.5/include/asm-ppc64/rtas.h prom-cleanup/include/asm-ppc64/rtas.h
--- linux-2.5/include/asm-ppc64/rtas.h	2004-05-22 09:08:54.000000000 +1000
+++ prom-cleanup/include/asm-ppc64/rtas.h	2004-05-28 15:21:20.000000000 +1000
@@ -37,7 +37,7 @@
  * Where n_in is the number of input parameters and
  *       n_out is the number of output parameters
  *
- * If the "string" is invalid on this system, RTAS_UNKOWN_SERVICE
+ * If the "string" is invalid on this system, RTAS_UNKNOWN_SERVICE
  * will be returned as a token.  rtas_call() does look for this
  * token and error out gracefully so rtas_call(rtas_token("str"), ...)
  * may be safely used for one-shot calls to RTAS.
@@ -168,7 +168,7 @@
 
 extern void enter_rtas(unsigned long);
 extern int rtas_token(const char *service);
-extern long rtas_call(int token, int, int, unsigned long *, ...);
+extern int rtas_call(int token, int, int, int *, ...);
 extern void call_rtas_display_status(char);
 extern void rtas_restart(char *cmd);
 extern void rtas_power_off(void);
