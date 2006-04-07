Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWDGSh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWDGSh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWDGSgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:36:39 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:31882 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964856AbWDGSgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:36:23 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
References: <20060407095132.455784000@sergelap>
To: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       devel@openvz.org, James Morris <jmorris@namei.org>
Subject: [RFC][PATCH 3/5] uts namespaces: Use init uts_namespace when appropriate
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: ~/Mail/SENT
Message-Id: <20060407183600.DB58F19B900@sergelap.hallyn.com>
Date: Fri,  7 Apr 2006 13:36:00 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some places, particularly drivers and __init code, the init uts namespace is the
appropriate one to use.  This patch replaces those with a direct reference to
init_uts_ns.name.  Note that we can drop this patch and simply
do #define system_utsname (init_uts_ns.name)
however by using this patch we make explicit, for the sake of review, those
places where we do and do not use the utsname namespace.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 arch/arm/kernel/setup.c                   |    2 +-
 arch/arm26/kernel/setup.c                 |    2 +-
 arch/cris/kernel/setup.c                  |    2 +-
 arch/i386/kernel/process.c                |    6 +++---
 arch/i386/kernel/traps.c                  |    6 +++---
 arch/powerpc/kernel/process.c             |    2 +-
 arch/powerpc/kernel/setup_64.c            |    2 +-
 arch/powerpc/platforms/pseries/setup.c    |    2 +-
 arch/sh/kernel/setup.c                    |    2 +-
 arch/um/kernel/um_arch.c                  |    6 +++---
 arch/um/sys-x86_64/sysrq.c                |    2 +-
 arch/x86_64/kernel/process.c              |    6 +++---
 drivers/infiniband/hw/ipath/ipath_verbs.c |    2 +-
 drivers/parisc/led.c                      |    2 +-
 drivers/scsi/lpfc/lpfc_ct.c               |    8 ++++----
 drivers/usb/core/hcd.c                    |    4 ++--
 drivers/usb/gadget/ether.c                |    2 +-
 drivers/usb/gadget/file_storage.c         |    2 +-
 drivers/usb/gadget/serial.c               |    2 +-
 drivers/usb/gadget/zero.c                 |    2 +-
 include/asm-i386/bugs.h                   |    2 +-
 include/asm-i386/elf.h                    |    2 +-
 include/asm-sh/bugs.h                     |    2 +-
 kernel/power/snapshot.c                   |   10 +++++-----
 net/ipv4/ipconfig.c                       |   16 ++++++++--------
 net/sunrpc/clnt.c                         |    4 ++--
 sound/core/info_oss.c                     |   10 +++++-----
 27 files changed, 55 insertions(+), 55 deletions(-)

ef54ab30a75ae83207b385090d3f1ff6c912f0d5
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 4375284..647c516 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -319,7 +319,7 @@ static void __init setup_processor(void)
 	       cpu_name, processor_id, (int)processor_id & 15,
 	       proc_arch[cpu_architecture()]);
 
-	sprintf(system_utsname.machine, "%s%c", list->arch_name, ENDIANNESS);
+	sprintf(init_uts_ns.name.machine, "%s%c", list->arch_name, ENDIANNESS);
 	sprintf(elf_platform, "%s%c", list->elf_name, ENDIANNESS);
 	elf_hwcap = list->elf_hwcap;
 
diff --git a/arch/arm26/kernel/setup.c b/arch/arm26/kernel/setup.c
index 4eb329e..6564e73 100644
--- a/arch/arm26/kernel/setup.c
+++ b/arch/arm26/kernel/setup.c
@@ -144,7 +144,7 @@ static void __init setup_processor(void)
 
 	dump_cpu_info();
 
-	sprintf(system_utsname.machine, "%s", list->arch_name);
+	sprintf(init_uts_ns.name.machine, "%s", list->arch_name);
 	sprintf(elf_platform, "%s", list->elf_name);
 	elf_hwcap = list->elf_hwcap;
 
diff --git a/arch/cris/kernel/setup.c b/arch/cris/kernel/setup.c
index 619a6ee..f9a29a4 100644
--- a/arch/cris/kernel/setup.c
+++ b/arch/cris/kernel/setup.c
@@ -161,7 +161,7 @@ setup_arch(char **cmdline_p)
 	show_etrax_copyright();
 
 	/* Setup utsname */
-	strcpy(system_utsname.machine, cris_machine_name);
+	strcpy(init_uts_ns.name.machine, cris_machine_name);
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
index 6259afe..89fac4c 100644
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -297,9 +297,9 @@ void show_regs(struct pt_regs * regs)
 	if (user_mode_vm(regs))
 		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
 	printk(" EFLAGS: %08lx    %s  (%s %.*s)\n",
-	       regs->eflags, print_tainted(), system_utsname.release,
-	       (int)strcspn(system_utsname.version, " "),
-	       system_utsname.version);
+	       regs->eflags, print_tainted(), init_uts_ns.name.release,
+	       (int)strcspn(init_uts_ns.name.version, " "),
+	       init_uts_ns.name.version);
 	printk("EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
 		regs->eax,regs->ebx,regs->ecx,regs->edx);
 	printk("ESI: %08lx EDI: %08lx EBP: %08lx",
diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
index e385279..addff65 100644
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -260,9 +260,9 @@ void show_registers(struct pt_regs *regs
 	printk(KERN_EMERG "CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\n"
 			"EFLAGS: %08lx   (%s %.*s) \n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
-		print_tainted(), regs->eflags, system_utsname.release,
-		(int)strcspn(system_utsname.version, " "),
-		system_utsname.version);
+		print_tainted(), regs->eflags, init_uts_ns.name.release,
+		(int)strcspn(init_uts_ns.name.version, " "),
+		init_uts_ns.name.version);
 	print_symbol(KERN_EMERG "EIP is at %s\n", regs->eip);
 	printk(KERN_EMERG "eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2dd47d2..7c21450 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -425,7 +425,7 @@ void show_regs(struct pt_regs * regs)
 	printk("NIP: "REG" LR: "REG" CTR: "REG"\n",
 	       regs->nip, regs->link, regs->ctr);
 	printk("REGS: %p TRAP: %04lx   %s  (%s)\n",
-	       regs, regs->trap, print_tainted(), system_utsname.release);
+	       regs, regs->trap, print_tainted(), init_uts_ns.name.release);
 	printk("MSR: "REG" ", regs->msr);
 	printbits(regs->msr, msr_bits);
 	printk("  CR: %08lX  XER: %08lX\n", regs->ccr, regs->xer);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 13e91c4..26f0477 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -435,7 +435,7 @@ void __init setup_system(void)
 	smp_release_cpus();
 #endif
 
-	printk("Starting Linux PPC64 %s\n", system_utsname.version);
+	printk("Starting Linux PPC64 %s\n", init_uts_ns.name.version);
 
 	printk("-----------------------------------------------------\n");
 	printk("ppc64_pft_size                = 0x%lx\n", ppc64_pft_size);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 5eb55ef..9df0d0e 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -255,7 +255,7 @@ static int __init pSeries_init_panel(voi
 {
 	/* Manually leave the kernel version on the panel. */
 	ppc_md.progress("Linux ppc64\n", 0);
-	ppc_md.progress(system_utsname.version, 0);
+	ppc_md.progress(init_uts_ns.name.version, 0);
 
 	return 0;
 }
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index bb229ef..fab811b 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -481,7 +481,7 @@ static int show_cpuinfo(struct seq_file 
 		seq_printf(m, "machine\t\t: %s\n", get_system_type());
 
 	seq_printf(m, "processor\t: %d\n", cpu);
-	seq_printf(m, "cpu family\t: %s\n", system_utsname.machine);
+	seq_printf(m, "cpu family\t: %s\n", init_uts_ns.name.machine);
 	seq_printf(m, "cpu type\t: %s\n", get_cpu_subtype());
 
 	show_cpuflags(m);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 7d51dd7..4caad31 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -167,7 +167,7 @@ static char *usage_string = 
 
 static int __init uml_version_setup(char *line, int *add)
 {
-	printf("%s\n", system_utsname.release);
+	printf("%s\n", init_uts_ns.name.release);
 	exit(0);
 
 	return 0;
@@ -278,7 +278,7 @@ static int __init Usage(char *line, int 
 {
  	const char **p;
 
-	printf(usage_string, system_utsname.release);
+	printf(usage_string, init_uts_ns.name.release);
  	p = &__uml_help_start;
  	while (p < &__uml_help_end) {
  		printf("%s", *p);
@@ -400,7 +400,7 @@ int linux_main(int argc, char **argv)
 	/* Reserve up to 4M after the current brk */
 	uml_reserved = ROUND_4M(brk_start) + (1 << 22);
 
-	setup_machinename(system_utsname.machine);
+	setup_machinename(init_uts_ns.name.machine);
 
 #ifdef CONFIG_CMDLINE_ON_HOST
 	argv1_begin = argv[1];
diff --git a/arch/um/sys-x86_64/sysrq.c b/arch/um/sys-x86_64/sysrq.c
index d0a25af..49a549a 100644
--- a/arch/um/sys-x86_64/sysrq.c
+++ b/arch/um/sys-x86_64/sysrq.c
@@ -16,7 +16,7 @@ void __show_regs(struct pt_regs * regs)
 	printk("\n");
 	print_modules();
 	printk("Pid: %d, comm: %.20s %s %s\n",
-	       current->pid, current->comm, print_tainted(), system_utsname.release);
+	       current->pid, current->comm, print_tainted(), init_uts_ns.name.release);
 	printk("RIP: %04lx:[<%016lx>] ", PT_REGS_CS(regs) & 0xffff,
 	       PT_REGS_RIP(regs));
 	printk("\nRSP: %016lx  EFLAGS: %08lx\n", PT_REGS_RSP(regs),
diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
index 70dd8e5..f79a080 100644
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -292,9 +292,9 @@ void __show_regs(struct pt_regs * regs)
 	print_modules();
 	printk("Pid: %d, comm: %.20s %s %s %.*s\n",
 		current->pid, current->comm, print_tainted(),
-		system_utsname.release,
-		(int)strcspn(system_utsname.version, " "),
-		system_utsname.version);
+		init_uts_ns.name.release,
+		(int)strcspn(init_uts_ns.name.version, " "),
+		init_uts_ns.name.version);
 	printk("RIP: %04lx:[<%016lx>] ", regs->cs & 0xffff, regs->rip);
 	printk_address(regs->rip); 
 	printk("\nRSP: %04lx:%016lx  EFLAGS: %08lx\n", regs->ss, regs->rsp,
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
index 9f27fd3..d5479a8 100644
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c
@@ -1048,7 +1048,7 @@ static void *ipath_register_ib_device(in
 	dev->process_mad = ipath_process_mad;
 
 	snprintf(dev->node_desc, sizeof(dev->node_desc),
-		 IPATH_IDSTR " %s kernel_SMA", system_utsname.nodename);
+		 IPATH_IDSTR " %s kernel_SMA", init_uts_ns.name.nodename);
 
 	ret = ib_register_device(dev);
 	if (ret)
diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 298f2dd..c05e169 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -684,7 +684,7 @@ int __init led_init(void)
 	int ret;
 
 	snprintf(lcd_text_default, sizeof(lcd_text_default),
-		"Linux %s", system_utsname.release);
+		"Linux %s", init_uts_ns.name.release);
 
 	/* Work around the buggy PDC of KittyHawk-machines */
 	switch (CPU_HVERSION) {
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index b65ee57..ef05e16 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -961,8 +961,8 @@ lpfc_fdmi_cmd(struct lpfc_hba * phba, st
 			ae = (ATTRIBUTE_ENTRY *) ((uint8_t *) rh + size);
 			ae->ad.bits.AttrType = be16_to_cpu(OS_NAME_VERSION);
 			sprintf(ae->un.OsNameVersion, "%s %s %s",
-				system_utsname.sysname, system_utsname.release,
-				system_utsname.version);
+				init_uts_ns.name.sysname, init_uts_ns.name.release,
+				init_uts_ns.name.version);
 			len = strlen(ae->un.OsNameVersion);
 			len += (len & 3) ? (4 - (len & 3)) : 4;
 			ae->ad.bits.AttrLen = be16_to_cpu(FOURBYTES + len);
@@ -1080,7 +1080,7 @@ lpfc_fdmi_cmd(struct lpfc_hba * phba, st
 							  size);
 				ae->ad.bits.AttrType = be16_to_cpu(HOST_NAME);
 				sprintf(ae->un.HostName, "%s",
-					system_utsname.nodename);
+					init_uts_ns.name.nodename);
 				len = strlen(ae->un.HostName);
 				len += (len & 3) ? (4 - (len & 3)) : 4;
 				ae->ad.bits.AttrLen =
@@ -1168,7 +1168,7 @@ lpfc_fdmi_tmo_handler(struct lpfc_hba *p
 
 	ndlp = lpfc_findnode_did(phba, NLP_SEARCH_ALL, FDMI_DID);
 	if (ndlp) {
-		if (system_utsname.nodename[0] != '\0') {
+		if (init_uts_ns.name.nodename[0] != '\0') {
 			lpfc_fdmi_cmd(phba, ndlp, SLI_MGMT_DHBA);
 		} else {
 			mod_timer(&phba->fc_fdmitmo, jiffies + HZ * 60);
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index fbd938d..b979b16 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -318,8 +318,8 @@ static int rh_string (
 
  	// id 3 == vendor description
 	} else if (id == 3) {
-		snprintf (buf, sizeof buf, "%s %s %s", system_utsname.sysname,
-			system_utsname.release, hcd->driver->description);
+		snprintf (buf, sizeof buf, "%s %s %s", init_uts_ns.name.sysname,
+			init_uts_ns.name.release, hcd->driver->description);
 
 	// unsupported IDs --> "protocol stall"
 	} else
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index c3d8e5c..e49359d 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -2242,7 +2242,7 @@ eth_bind (struct usb_gadget *gadget)
 		return -ENODEV;
 	}
 	snprintf (manufacturer, sizeof manufacturer, "%s %s/%s",
-		system_utsname.sysname, system_utsname.release,
+		init_uts_ns.name.sysname, init_uts_ns.name.release,
 		gadget->name);
 
 	/* If there's an RNDIS configuration, that's what Windows wants to
diff --git a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/file_storage.c
index cf3be29..81ffe03 100644
--- a/drivers/usb/gadget/file_storage.c
+++ b/drivers/usb/gadget/file_storage.c
@@ -3965,7 +3965,7 @@ static int __init fsg_bind(struct usb_ga
 	usb_gadget_set_selfpowered(gadget);
 
 	snprintf(manufacturer, sizeof manufacturer, "%s %s with %s",
-			system_utsname.sysname, system_utsname.release,
+			init_uts_ns.name.sysname, init_uts_ns.name.release,
 			gadget->name);
 
 	/* On a real device, serial[] would be loaded from permanent
diff --git a/drivers/usb/gadget/serial.c b/drivers/usb/gadget/serial.c
index b992546..1063159 100644
--- a/drivers/usb/gadget/serial.c
+++ b/drivers/usb/gadget/serial.c
@@ -1496,7 +1496,7 @@ static int __init gs_bind(struct usb_gad
 		return -ENOMEM;
 
 	snprintf(manufacturer, sizeof(manufacturer), "%s %s with %s",
-		system_utsname.sysname, system_utsname.release,
+		init_uts_ns.name.sysname, init_uts_ns.name.release,
 		gadget->name);
 
 	memset(dev, 0, sizeof(struct gs_dev));
diff --git a/drivers/usb/gadget/zero.c b/drivers/usb/gadget/zero.c
index 51424f6..5aa1bd4 100644
--- a/drivers/usb/gadget/zero.c
+++ b/drivers/usb/gadget/zero.c
@@ -1240,7 +1240,7 @@ autoconf_fail:
 		EP_OUT_NAME, EP_IN_NAME);
 
 	snprintf (manufacturer, sizeof manufacturer, "%s %s with %s",
-		system_utsname.sysname, system_utsname.release,
+		init_uts_ns.name.sysname, init_uts_ns.name.release,
 		gadget->name);
 
 	return 0;
diff --git a/include/asm-i386/bugs.h b/include/asm-i386/bugs.h
index 50233e0..ce0386e 100644
--- a/include/asm-i386/bugs.h
+++ b/include/asm-i386/bugs.h
@@ -190,6 +190,6 @@ static void __init check_bugs(void)
 	check_fpu();
 	check_hlt();
 	check_popad();
-	system_utsname.machine[1] = '0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
+	init_uts_ns.name.machine[1] = '0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
 	alternative_instructions(); 
 }
diff --git a/include/asm-i386/elf.h b/include/asm-i386/elf.h
index 4153d80..53c2829 100644
--- a/include/asm-i386/elf.h
+++ b/include/asm-i386/elf.h
@@ -108,7 +108,7 @@ typedef struct user_fxsr_struct elf_fpxr
    For the moment, we have only optimizations for the Intel generations,
    but that could change... */
 
-#define ELF_PLATFORM  (system_utsname.machine)
+#define ELF_PLATFORM  (init_uts_ns.name.machine)
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) do { } while (0)
diff --git a/include/asm-sh/bugs.h b/include/asm-sh/bugs.h
index a6de3d0..0a1648d 100644
--- a/include/asm-sh/bugs.h
+++ b/include/asm-sh/bugs.h
@@ -18,7 +18,7 @@ static void __init check_bugs(void)
 {
 	extern char *get_cpu_subtype(void);
 	extern unsigned long loops_per_jiffy;
-	char *p= &system_utsname.machine[2]; /* "sh" */
+	char *p= &init_uts_ns.name.machine[2]; /* "sh" */
 
 	cpu_data->loops_per_jiffy = loops_per_jiffy;
 
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c5863d0..14b3f24 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -523,7 +523,7 @@ static void init_header(struct swsusp_in
 	memset(info, 0, sizeof(struct swsusp_info));
 	info->version_code = LINUX_VERSION_CODE;
 	info->num_physpages = num_physpages;
-	memcpy(&info->uts, &system_utsname, sizeof(system_utsname));
+	memcpy(&info->uts, &init_uts_ns.name, sizeof(init_uts_ns.name));
 	info->cpus = num_online_cpus();
 	info->image_pages = nr_copy_pages;
 	info->pages = nr_copy_pages + nr_meta_pages + 1;
@@ -662,13 +662,13 @@ static int check_header(struct swsusp_in
 		reason = "kernel version";
 	if (info->num_physpages != num_physpages)
 		reason = "memory size";
-	if (strcmp(info->uts.sysname,system_utsname.sysname))
+	if (strcmp(info->uts.sysname,init_uts_ns.name.sysname))
 		reason = "system type";
-	if (strcmp(info->uts.release,system_utsname.release))
+	if (strcmp(info->uts.release,init_uts_ns.name.release))
 		reason = "kernel release";
-	if (strcmp(info->uts.version,system_utsname.version))
+	if (strcmp(info->uts.version,init_uts_ns.name.version))
 		reason = "version";
-	if (strcmp(info->uts.machine,system_utsname.machine))
+	if (strcmp(info->uts.machine,init_uts_ns.name.machine))
 		reason = "machine";
 	if (reason) {
 		printk(KERN_ERR "swsusp: Resume mismatch: %s\n", reason);
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index cb8a92f..b00635f 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -367,7 +367,7 @@ static int __init ic_defaults(void)
 	 */
 	 
 	if (!ic_host_name_set)
-		sprintf(system_utsname.nodename, "%u.%u.%u.%u", NIPQUAD(ic_myaddr));
+		sprintf(init_uts_ns.name.nodename, "%u.%u.%u.%u", NIPQUAD(ic_myaddr));
 
 	if (root_server_addr == INADDR_NONE)
 		root_server_addr = ic_servaddr;
@@ -806,7 +806,7 @@ static void __init ic_do_bootp_ext(u8 *e
 			}
 			break;
 		case 12:	/* Host name */
-			ic_bootp_string(system_utsname.nodename, ext+1, *ext, __NEW_UTS_LEN);
+			ic_bootp_string(init_uts_ns.name.nodename, ext+1, *ext, __NEW_UTS_LEN);
 			ic_host_name_set = 1;
 			break;
 		case 15:	/* Domain name (DNS) */
@@ -817,7 +817,7 @@ static void __init ic_do_bootp_ext(u8 *e
 				ic_bootp_string(root_server_path, ext+1, *ext, sizeof(root_server_path));
 			break;
 		case 40:	/* NIS Domain name (_not_ DNS) */
-			ic_bootp_string(system_utsname.domainname, ext+1, *ext, __NEW_UTS_LEN);
+			ic_bootp_string(init_uts_ns.name.domainname, ext+1, *ext, __NEW_UTS_LEN);
 			break;
 	}
 }
@@ -1369,7 +1369,7 @@ static int __init ip_auto_config(void)
 	printk(", mask=%u.%u.%u.%u", NIPQUAD(ic_netmask));
 	printk(", gw=%u.%u.%u.%u", NIPQUAD(ic_gateway));
 	printk(",\n     host=%s, domain=%s, nis-domain=%s",
-	       system_utsname.nodename, ic_domain, system_utsname.domainname);
+	       init_uts_ns.name.nodename, ic_domain, init_uts_ns.name.domainname);
 	printk(",\n     bootserver=%u.%u.%u.%u", NIPQUAD(ic_servaddr));
 	printk(", rootserver=%u.%u.%u.%u", NIPQUAD(root_server_addr));
 	printk(", rootpath=%s", root_server_path);
@@ -1479,11 +1479,11 @@ static int __init ip_auto_config_setup(c
 			case 4:
 				if ((dp = strchr(ip, '.'))) {
 					*dp++ = '\0';
-					strlcpy(system_utsname.domainname, dp,
-						sizeof(system_utsname.domainname));
+					strlcpy(init_uts_ns.name.domainname, dp,
+						sizeof(init_uts_ns.name.domainname));
 				}
-				strlcpy(system_utsname.nodename, ip,
-					sizeof(system_utsname.nodename));
+				strlcpy(init_uts_ns.name.nodename, ip,
+					sizeof(init_uts_ns.name.nodename));
 				ic_host_name_set = 1;
 				break;
 			case 5:
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index aa8965e..c21f28b 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -176,10 +176,10 @@ rpc_new_client(struct rpc_xprt *xprt, ch
 	}
 
 	/* save the nodename */
-	clnt->cl_nodelen = strlen(system_utsname.nodename);
+	clnt->cl_nodelen = strlen(init_uts_ns.name.nodename);
 	if (clnt->cl_nodelen > UNX_MAXNODENAME)
 		clnt->cl_nodelen = UNX_MAXNODENAME;
-	memcpy(clnt->cl_nodename, system_utsname.nodename, clnt->cl_nodelen);
+	memcpy(clnt->cl_nodename, init_uts_ns.name.nodename, clnt->cl_nodelen);
 	return clnt;
 
 out_no_auth:
diff --git a/sound/core/info_oss.c b/sound/core/info_oss.c
index f9ce854..dcb665a 100644
--- a/sound/core/info_oss.c
+++ b/sound/core/info_oss.c
@@ -94,11 +94,11 @@ static void snd_sndstat_proc_read(struct
 {
 	snd_iprintf(buffer, "Sound Driver:3.8.1a-980706 (ALSA v" CONFIG_SND_VERSION " emulation code)\n");
 	snd_iprintf(buffer, "Kernel: %s %s %s %s %s\n",
-		    system_utsname.sysname,
-		    system_utsname.nodename,
-		    system_utsname.release,
-		    system_utsname.version,
-		    system_utsname.machine);
+		    init_uts_ns.name.sysname,
+		    init_uts_ns.name.nodename,
+		    init_uts_ns.name.release,
+		    init_uts_ns.name.version,
+		    init_uts_ns.name.machine);
 	snd_iprintf(buffer, "Config options: 0\n");
 	snd_iprintf(buffer, "\nInstalled drivers: \n");
 	snd_iprintf(buffer, "Type 10: ALSA emulation\n");
-- 
1.2.4


