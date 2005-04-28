Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVD1G7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVD1G7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 02:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVD1G7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 02:59:46 -0400
Received: from ozlabs.org ([203.10.76.45]:8592 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261711AbVD1G7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 02:59:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17008.35464.113904.303794@cargo.ozlabs.ibm.com>
Date: Thu, 28 Apr 2005 17:02:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org, olh@suse.de
Subject: [PATCH] ppc64: tell firmware about kernel capabilities
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On pSeries systems, according to the platform architecture specs, we
are supposed to be supplying a structure to firmware that tells
firmware about our capabilities, such as which version of the data
structures that describe available memory we are expecting to see.
The way we end up having to supply this data structure is a bit gross,
since it was designed for AIX and doesn't suit us very well.  This
patch adds the code to supply this data structure to the firmware.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -urN linux-2.6/arch/ppc64/boot/addnote.c g5-ppc64/arch/ppc64/boot/addnote.c
--- linux-2.6/arch/ppc64/boot/addnote.c	2005-04-26 15:37:55.000000000 +1000
+++ g5-ppc64/arch/ppc64/boot/addnote.c	2005-04-27 11:43:20.000000000 +1000
@@ -19,6 +19,7 @@
 #include <unistd.h>
 #include <string.h>
 
+/* CHRP note section */
 char arch[] = "PowerPC";
 
 #define N_DESCR	6
@@ -31,6 +32,29 @@
 	0x4000,			/* load-base */
 };
 
+/* RPA note section */
+char rpaname[] = "IBM,RPA-Client-Config";
+
+/*
+ * Note: setting ignore_my_client_config *should* mean that OF ignores
+ * all the other fields, but there is a firmware bug which means that
+ * it looks at the splpar field at least.  So these values need to be
+ * reasonable.
+ */
+#define N_RPA_DESCR	8
+unsigned int rpanote[N_RPA_DESCR] = {
+	0,			/* lparaffinity */
+	64,			/* min_rmo_size */
+	0,			/* min_rmo_percent */
+	40,			/* max_pft_size */
+	1,			/* splpar */
+	-1,			/* min_load */
+	0,			/* new_mem_def */
+	1,			/* ignore_my_client_config */
+};
+
+#define ROUNDUP(len)	(((len) + 3) & ~3)
+
 unsigned char buf[512];
 
 #define GET_16BE(off)	((buf[off] << 8) + (buf[(off)+1]))
@@ -69,7 +93,7 @@
 {
 	int fd, n, i;
 	int ph, ps, np;
-	int nnote, ns;
+	int nnote, nnote2, ns;
 
 	if (ac != 2) {
 		fprintf(stderr, "Usage: %s elf-file\n", av[0]);
@@ -81,7 +105,8 @@
 		exit(1);
 	}
 
-	nnote = strlen(arch) + 1 + (N_DESCR + 3) * 4;
+	nnote = 12 + ROUNDUP(strlen(arch) + 1) + sizeof(descr);
+	nnote2 = 12 + ROUNDUP(strlen(rpaname) + 1) + sizeof(rpanote);
 
 	n = read(fd, buf, sizeof(buf));
 	if (n < 0) {
@@ -104,7 +129,7 @@
 	np = GET_16BE(E_PHNUM);
 	if (ph < E_HSIZE || ps < PH_HSIZE || np < 1)
 		goto notelf;
-	if (ph + (np + 1) * ps + nnote > n)
+	if (ph + (np + 2) * ps + nnote + nnote2 > n)
 		goto nospace;
 
 	for (i = 0; i < np; ++i) {
@@ -117,12 +142,12 @@
 	}
 
 	/* XXX check that the area we want to use is all zeroes */
-	for (i = 0; i < ps + nnote; ++i)
+	for (i = 0; i < 2 * ps + nnote + nnote2; ++i)
 		if (buf[ph + i] != 0)
 			goto nospace;
 
 	/* fill in the program header entry */
-	ns = ph + ps;
+	ns = ph + 2 * ps;
 	PUT_32BE(ph + PH_TYPE, PT_NOTE);
 	PUT_32BE(ph + PH_OFFSET, ns);
 	PUT_32BE(ph + PH_FILESZ, nnote);
@@ -134,11 +159,26 @@
 	PUT_32BE(ns + 8, 0x1275);
 	strcpy(&buf[ns + 12], arch);
 	ns += 12 + strlen(arch) + 1;
-	for (i = 0; i < N_DESCR; ++i)
-		PUT_32BE(ns + i * 4, descr[i]);
+	for (i = 0; i < N_DESCR; ++i, ns += 4)
+		PUT_32BE(ns, descr[i]);
+
+	/* fill in the second program header entry and the RPA note area */
+	ph += ps;
+	PUT_32BE(ph + PH_TYPE, PT_NOTE);
+	PUT_32BE(ph + PH_OFFSET, ns);
+	PUT_32BE(ph + PH_FILESZ, nnote2);
+
+	/* fill in the note area we point to */
+	PUT_32BE(ns, strlen(rpaname) + 1);
+	PUT_32BE(ns + 4, sizeof(rpanote));
+	PUT_32BE(ns + 8, 0x12759999);
+	strcpy(&buf[ns + 12], rpaname);
+	ns += 12 + ROUNDUP(strlen(rpaname) + 1);
+	for (i = 0; i < N_RPA_DESCR; ++i, ns += 4)
+		PUT_32BE(ns, rpanote[i]);
 
 	/* Update the number of program headers */
-	PUT_16BE(E_PHNUM, np + 1);
+	PUT_16BE(E_PHNUM, np + 2);
 
 	/* write back */
 	lseek(fd, (long) 0, SEEK_SET);
@@ -155,11 +195,11 @@
 	exit(0);
 
  notelf:
-	fprintf(stderr, "%s does not appear to be an ELF file\n", av[0]);
+	fprintf(stderr, "%s does not appear to be an ELF file\n", av[1]);
 	exit(1);
 
  nospace:
 	fprintf(stderr, "sorry, I can't find space in %s to put the note\n",
-		av[0]);
+		av[1]);
 	exit(1);
 }
diff -urN linux-2.6/arch/ppc64/kernel/prom_init.c g5-ppc64/arch/ppc64/kernel/prom_init.c
--- linux-2.6/arch/ppc64/kernel/prom_init.c	2005-04-26 15:37:55.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/prom_init.c	2005-04-27 11:43:20.000000000 +1000
@@ -493,6 +493,113 @@
 }
 
 /*
+ * To tell the firmware what our capabilities are, we have to pass
+ * it a fake 32-bit ELF header containing a couple of PT_NOTE sections
+ * that contain structures that contain the actual values.
+ */
+static struct fake_elf {
+	Elf32_Ehdr	elfhdr;
+	Elf32_Phdr	phdr[2];
+	struct chrpnote {
+		u32	namesz;
+		u32	descsz;
+		u32	type;
+		char	name[8];	/* "PowerPC" */
+		struct chrpdesc {
+			u32	real_mode;
+			u32	real_base;
+			u32	real_size;
+			u32	virt_base;
+			u32	virt_size;
+			u32	load_base;
+		} chrpdesc;
+	} chrpnote;
+	struct rpanote {
+		u32	namesz;
+		u32	descsz;
+		u32	type;
+		char	name[24];	/* "IBM,RPA-Client-Config" */
+		struct rpadesc {
+			u32	lpar_affinity;
+			u32	min_rmo_size;
+			u32	min_rmo_percent;
+			u32	max_pft_size;
+			u32	splpar;
+			u32	min_load;
+			u32	new_mem_def;
+			u32	ignore_me;
+		} rpadesc;
+	} rpanote;
+} fake_elf = {
+	.elfhdr = {
+		.e_ident = { 0x7f, 'E', 'L', 'F',
+			     ELFCLASS32, ELFDATA2MSB, EV_CURRENT },
+		.e_type = ET_EXEC,	/* yeah right */
+		.e_machine = EM_PPC,
+		.e_version = EV_CURRENT,
+		.e_phoff = offsetof(struct fake_elf, phdr),
+		.e_phentsize = sizeof(Elf32_Phdr),
+		.e_phnum = 2
+	},
+	.phdr = {
+		[0] = {
+			.p_type = PT_NOTE,
+			.p_offset = offsetof(struct fake_elf, chrpnote),
+			.p_filesz = sizeof(struct chrpnote)
+		}, [1] = {
+			.p_type = PT_NOTE,
+			.p_offset = offsetof(struct fake_elf, rpanote),
+			.p_filesz = sizeof(struct rpanote)
+		}
+	},
+	.chrpnote = {
+		.namesz = sizeof("PowerPC"),
+		.descsz = sizeof(struct chrpdesc),
+		.type = 0x1275,
+		.name = "PowerPC",
+		.chrpdesc = {
+			.real_mode = ~0U,	/* ~0 means "don't care" */
+			.real_base = ~0U,
+			.real_size = ~0U,
+			.virt_base = ~0U,
+			.virt_size = ~0U,
+			.load_base = ~0U
+		},
+	},
+	.rpanote = {
+		.namesz = sizeof("IBM,RPA-Client-Config"),
+		.descsz = sizeof(struct rpadesc),
+		.type = 0x12759999,
+		.name = "IBM,RPA-Client-Config",
+		.rpadesc = {
+			.lpar_affinity = 0,
+			.min_rmo_size = 64,	/* in megabytes */
+			.min_rmo_percent = 0,
+			.max_pft_size = 48,	/* 2^48 bytes max PFT size */
+			.splpar = 1,
+			.min_load = ~0U,
+			.new_mem_def = 0
+		}
+	}
+};
+
+static void __init prom_send_capabilities(void)
+{
+	unsigned long offset = reloc_offset();
+	ihandle elfloader;
+	int ret;
+
+	elfloader = call_prom("open", 1, 1, ADDR("/packages/elf-loader"));
+	if (elfloader == 0) {
+		prom_printf("couldn't open /packages/elf-loader\n");
+		return;
+	}
+	ret = call_prom("call-method", 3, 1, ADDR("process-elf-header"),
+			elfloader, ADDR(&fake_elf));
+	call_prom("close", 1, 0, elfloader);
+}
+
+/*
  * Memory allocation strategy... our layout is normally:
  *
  *  at 14Mb or more we vmlinux, then a gap and initrd. In some rare cases, initrd
