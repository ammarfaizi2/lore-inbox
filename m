Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWBJIK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWBJIK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 03:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWBJIK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 03:10:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:20610 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751194AbWBJIKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 03:10:25 -0500
Date: Fri, 10 Feb 2006 00:17:20 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.15.4
Message-ID: <20060210081720.GG30803@sorel.sous-sol.org>
References: <20060210081552.GF30803@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210081552.GF30803@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index a88ae43..de8a0de 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 15
-EXTRAVERSION = .3
+EXTRAVERSION = .4
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 447fa9e..85ca409 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -248,10 +248,17 @@ acpi_parse_lapic(acpi_table_entry_header
 
 	acpi_table_print_madt_entry(header);
 
-	/* Register even disabled CPUs for cpu hotplug */
-
-	x86_acpiid_to_apicid[processor->acpi_id] = processor->id;
+	/* Record local apic id only when enabled */
+	if (processor->flags.enabled)
+		x86_acpiid_to_apicid[processor->acpi_id] = processor->id;
 
+	/*
+	 * We need to register disabled CPU as well to permit
+	 * counting disabled CPUs. This allows us to size
+	 * cpus_possible_map more accurately, to permit
+	 * to not preallocating memory for all NR_CPUS
+	 * when we use CPU hotplug.
+	 */
 	mp_register_lapic(processor->id,	/* APIC ID */
 			  processor->flags.enabled);	/* Enabled? */
 
diff --git a/arch/sparc64/kernel/sys32.S b/arch/sparc64/kernel/sys32.S
index 9cd272a..60b5937 100644
--- a/arch/sparc64/kernel/sys32.S
+++ b/arch/sparc64/kernel/sys32.S
@@ -84,7 +84,6 @@ SIGN2(sys32_fadvise64_64, compat_sys_fad
 SIGN2(sys32_bdflush, sys_bdflush, %o0, %o1)
 SIGN1(sys32_mlockall, sys_mlockall, %o0)
 SIGN1(sys32_nfsservctl, compat_sys_nfsservctl, %o0)
-SIGN1(sys32_clock_settime, compat_sys_clock_settime, %o1)
 SIGN1(sys32_clock_nanosleep, compat_sys_clock_nanosleep, %o1)
 SIGN1(sys32_timer_settime, compat_sys_timer_settime, %o1)
 SIGN1(sys32_io_submit, compat_sys_io_submit, %o1)
diff --git a/arch/sparc64/kernel/systbls.S b/arch/sparc64/kernel/systbls.S
index 4821ef1..1c5674b 100644
--- a/arch/sparc64/kernel/systbls.S
+++ b/arch/sparc64/kernel/systbls.S
@@ -71,7 +71,7 @@ sys_call_table32:
 /*240*/	.word sys_munlockall, sys32_sched_setparam, sys32_sched_getparam, sys32_sched_setscheduler, sys32_sched_getscheduler
 	.word sys_sched_yield, sys32_sched_get_priority_max, sys32_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
 /*250*/	.word sys32_mremap, sys32_sysctl, sys32_getsid, sys_fdatasync, sys32_nfsservctl
-	.word sys_ni_syscall, sys32_clock_settime, compat_sys_clock_gettime, compat_sys_clock_getres, sys32_clock_nanosleep
+	.word sys_ni_syscall, compat_sys_clock_settime, compat_sys_clock_gettime, compat_sys_clock_getres, sys32_clock_nanosleep
 /*260*/	.word compat_sys_sched_getaffinity, compat_sys_sched_setaffinity, sys32_timer_settime, compat_sys_timer_gettime, sys_timer_getoverrun
 	.word sys_timer_delete, sys32_timer_create, sys_ni_syscall, compat_sys_io_setup, sys_io_destroy
 /*270*/	.word sys32_io_submit, sys_io_cancel, compat_sys_io_getevents, sys32_mq_open, sys_mq_unlink
diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
index 58b1921..6535b36 100644
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -170,13 +170,15 @@ SECTIONS
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
-  __initramfs_end = .;	
-  . = ALIGN(32);
+  __initramfs_end = .;
+  /* temporary here to work around NR_CPUS. If you see this comment in 2.6.17+
+   complain */
+  . = ALIGN(4096);	
+  __init_end = .;	
+  . = ALIGN(128);
   __per_cpu_start = .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
 
   . = ALIGN(4096);
   __nosave_begin = .;
diff --git a/arch/x86_64/mm/srat.c b/arch/x86_64/mm/srat.c
index 33340bd..79e3e98 100644
--- a/arch/x86_64/mm/srat.c
+++ b/arch/x86_64/mm/srat.c
@@ -25,6 +25,10 @@ static nodemask_t nodes_found __initdata
 static struct node nodes[MAX_NUMNODES] __initdata;
 static __u8  pxm2node[256] = { [0 ... 255] = 0xff };
 
+/* Too small nodes confuse the VM badly. Usually they result
+   from BIOS bugs. */
+#define NODE_MIN_SIZE (4*1024*1024)
+
 static int node_to_pxm(int n);
 
 int pxm_to_node(int pxm)
@@ -168,22 +172,32 @@ acpi_numa_memory_affinity_init(struct ac
 	       nd->start, nd->end);
 }
 
+static void unparse_node(int node)
+{
+	int i;
+	node_clear(node, nodes_parsed);
+	for (i = 0; i < MAX_LOCAL_APIC; i++) {
+		if (apicid_to_node[i] == node)
+			apicid_to_node[i] = NUMA_NO_NODE;
+	}
+}
+
 void __init acpi_numa_arch_fixup(void) {}
 
 /* Use the information discovered above to actually set up the nodes. */
 int __init acpi_scan_nodes(unsigned long start, unsigned long end)
 {
 	int i;
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+ 		cutoff_node(i, start, end);
+		if ((nodes[i].end - nodes[i].start) < NODE_MIN_SIZE)
+			unparse_node(i);
+ 	}
+
 	if (acpi_numa <= 0)
 		return -1;
 
-	/* First clean up the node list */
-	for_each_node_mask(i, nodes_parsed) {
-		cutoff_node(i, start, end);
-		if (nodes[i].start == nodes[i].end)
-			node_clear(i, nodes_parsed);
-	}
-
 	memnode_shift = compute_hash_shift(nodes, nodes_weight(nodes_parsed));
 	if (memnode_shift < 0) {
 		printk(KERN_ERR
diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index 499344c..98479b8 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -275,68 +275,70 @@ static unsigned char db9_saturn_read_pac
 /*
  * db9_saturn_report() analyzes packet and reports.
  */
-static int db9_saturn_report(unsigned char id, unsigned char data[60], struct input_dev *dev, int n, int max_pads)
+static int db9_saturn_report(unsigned char id, unsigned char data[60], struct input_dev *devs[], int n, int max_pads)
 {
+	struct input_dev *dev;
 	int tmp, i, j;
 
 	tmp = (id == 0x41) ? 60 : 10;
-	for (j = 0; (j < tmp) && (n < max_pads); j += 10, n++) {
+	for (j = 0; j < tmp && n < max_pads; j += 10, n++) {
+		dev = devs[n];
 		switch (data[j]) {
 		case 0x16: /* multi controller (analog 4 axis) */
-			input_report_abs(dev + n, db9_abs[5], data[j + 6]);
+			input_report_abs(dev, db9_abs[5], data[j + 6]);
 		case 0x15: /* mission stick (analog 3 axis) */
-			input_report_abs(dev + n, db9_abs[3], data[j + 4]);
-			input_report_abs(dev + n, db9_abs[4], data[j + 5]);
+			input_report_abs(dev, db9_abs[3], data[j + 4]);
+			input_report_abs(dev, db9_abs[4], data[j + 5]);
 		case 0x13: /* racing controller (analog 1 axis) */
-			input_report_abs(dev + n, db9_abs[2], data[j + 3]);
+			input_report_abs(dev, db9_abs[2], data[j + 3]);
 		case 0x34: /* saturn keyboard (udlr ZXC ASD QE Esc) */
 		case 0x02: /* digital pad (digital 2 axis + buttons) */
-			input_report_abs(dev + n, db9_abs[0], !(data[j + 1] & 128) - !(data[j + 1] & 64));
-			input_report_abs(dev + n, db9_abs[1], !(data[j + 1] & 32) - !(data[j + 1] & 16));
+			input_report_abs(dev, db9_abs[0], !(data[j + 1] & 128) - !(data[j + 1] & 64));
+			input_report_abs(dev, db9_abs[1], !(data[j + 1] & 32) - !(data[j + 1] & 16));
 			for (i = 0; i < 9; i++)
-				input_report_key(dev + n, db9_cd32_btn[i], ~data[j + db9_saturn_byte[i]] & db9_saturn_mask[i]);
+				input_report_key(dev, db9_cd32_btn[i], ~data[j + db9_saturn_byte[i]] & db9_saturn_mask[i]);
 			break;
 		case 0x19: /* mission stick x2 (analog 6 axis + buttons) */
-			input_report_abs(dev + n, db9_abs[0], !(data[j + 1] & 128) - !(data[j + 1] & 64));
-			input_report_abs(dev + n, db9_abs[1], !(data[j + 1] & 32) - !(data[j + 1] & 16));
+			input_report_abs(dev, db9_abs[0], !(data[j + 1] & 128) - !(data[j + 1] & 64));
+			input_report_abs(dev, db9_abs[1], !(data[j + 1] & 32) - !(data[j + 1] & 16));
 			for (i = 0; i < 9; i++)
-				input_report_key(dev + n, db9_cd32_btn[i], ~data[j + db9_saturn_byte[i]] & db9_saturn_mask[i]);
-			input_report_abs(dev + n, db9_abs[2], data[j + 3]);
-			input_report_abs(dev + n, db9_abs[3], data[j + 4]);
-			input_report_abs(dev + n, db9_abs[4], data[j + 5]);
+				input_report_key(dev, db9_cd32_btn[i], ~data[j + db9_saturn_byte[i]] & db9_saturn_mask[i]);
+			input_report_abs(dev, db9_abs[2], data[j + 3]);
+			input_report_abs(dev, db9_abs[3], data[j + 4]);
+			input_report_abs(dev, db9_abs[4], data[j + 5]);
 			/*
-			input_report_abs(dev + n, db9_abs[8], (data[j + 6] & 128 ? 0 : 1) - (data[j + 6] & 64 ? 0 : 1));
-			input_report_abs(dev + n, db9_abs[9], (data[j + 6] & 32 ? 0 : 1) - (data[j + 6] & 16 ? 0 : 1));
+			input_report_abs(dev, db9_abs[8], (data[j + 6] & 128 ? 0 : 1) - (data[j + 6] & 64 ? 0 : 1));
+			input_report_abs(dev, db9_abs[9], (data[j + 6] & 32 ? 0 : 1) - (data[j + 6] & 16 ? 0 : 1));
 			*/
-			input_report_abs(dev + n, db9_abs[6], data[j + 7]);
-			input_report_abs(dev + n, db9_abs[7], data[j + 8]);
-			input_report_abs(dev + n, db9_abs[5], data[j + 9]);
+			input_report_abs(dev, db9_abs[6], data[j + 7]);
+			input_report_abs(dev, db9_abs[7], data[j + 8]);
+			input_report_abs(dev, db9_abs[5], data[j + 9]);
 			break;
 		case 0xd3: /* sankyo ff (analog 1 axis + stop btn) */
-			input_report_key(dev + n, BTN_A, data[j + 3] & 0x80);
-			input_report_abs(dev + n, db9_abs[2], data[j + 3] & 0x7f);
+			input_report_key(dev, BTN_A, data[j + 3] & 0x80);
+			input_report_abs(dev, db9_abs[2], data[j + 3] & 0x7f);
 			break;
 		case 0xe3: /* shuttle mouse (analog 2 axis + buttons. signed value) */
-			input_report_key(dev + n, BTN_START, data[j + 1] & 0x08);
-			input_report_key(dev + n, BTN_A, data[j + 1] & 0x04);
-			input_report_key(dev + n, BTN_C, data[j + 1] & 0x02);
-			input_report_key(dev + n, BTN_B, data[j + 1] & 0x01);
-			input_report_abs(dev + n, db9_abs[2], data[j + 2] ^ 0x80);
-			input_report_abs(dev + n, db9_abs[3], (0xff-(data[j + 3] ^ 0x80))+1); /* */
+			input_report_key(dev, BTN_START, data[j + 1] & 0x08);
+			input_report_key(dev, BTN_A, data[j + 1] & 0x04);
+			input_report_key(dev, BTN_C, data[j + 1] & 0x02);
+			input_report_key(dev, BTN_B, data[j + 1] & 0x01);
+			input_report_abs(dev, db9_abs[2], data[j + 2] ^ 0x80);
+			input_report_abs(dev, db9_abs[3], (0xff-(data[j + 3] ^ 0x80))+1); /* */
 			break;
 		case 0xff:
 		default: /* no pad */
-			input_report_abs(dev + n, db9_abs[0], 0);
-			input_report_abs(dev + n, db9_abs[1], 0);
+			input_report_abs(dev, db9_abs[0], 0);
+			input_report_abs(dev, db9_abs[1], 0);
 			for (i = 0; i < 9; i++)
-				input_report_key(dev + n, db9_cd32_btn[i], 0);
+				input_report_key(dev, db9_cd32_btn[i], 0);
 			break;
 		}
 	}
 	return n;
 }
 
-static int db9_saturn(int mode, struct parport *port, struct input_dev *dev)
+static int db9_saturn(int mode, struct parport *port, struct input_dev *devs[])
 {
 	unsigned char id, data[60];
 	int type, n, max_pads;
@@ -361,7 +363,7 @@ static int db9_saturn(int mode, struct p
 	max_pads = min(db9_modes[mode].n_pads, DB9_MAX_DEVICES);
 	for (tmp = 0, i = 0; i < n; i++) {
 		id = db9_saturn_read_packet(port, data, type + i, 1);
-		tmp = db9_saturn_report(id, data, dev, tmp, max_pads);
+		tmp = db9_saturn_report(id, data, devs, tmp, max_pads);
 	}
 	return 0;
 }
@@ -489,7 +491,7 @@ static void db9_timer(unsigned long priv
 		case DB9_SATURN_DPP:
 		case DB9_SATURN_DPP_2:
 
-			db9_saturn(db9->mode, port, dev);
+			db9_saturn(db9->mode, port, db9->dev);
 			break;
 
 		case DB9_CD32_PAD:
diff --git a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
index a936e7a..330c671 100644
--- a/drivers/input/joystick/grip.c
+++ b/drivers/input/joystick/grip.c
@@ -192,6 +192,9 @@ static void grip_poll(struct gameport *g
 	for (i = 0; i < 2; i++) {
 
 		dev = grip->dev[i];
+		if (!dev)
+			continue;
+
 		grip->reads++;
 
 		switch (grip->mode[i]) {
diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 64b9c31..b6bc049 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -345,7 +345,7 @@ int iforce_init_device(struct iforce *if
 	int i;
 
 	input_dev = input_allocate_device();
-	if (input_dev)
+	if (!input_dev)
 		return -ENOMEM;
 
 	init_waitqueue_head(&iforce->wait);
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 4a26292..76cb1f8 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -167,9 +167,9 @@ void iforce_process_packet(struct iforce
 		iforce->expect_packet = 0;
 		iforce->ecmd = cmd;
 		memcpy(iforce->edata, data, IFORCE_MAX_LENGTH);
-		wake_up(&iforce->wait);
 	}
 #endif
+	wake_up(&iforce->wait);
 
 	if (!iforce->type) {
 		being_used--;
@@ -264,7 +264,7 @@ int iforce_get_id_packet(struct iforce *
 		wait_event_interruptible_timeout(iforce->wait,
 			iforce->ctrl->status != -EINPROGRESS, HZ);
 
-		if (iforce->ctrl->status != -EINPROGRESS) {
+		if (iforce->ctrl->status) {
 			usb_unlink_urb(iforce->ctrl);
 			return -1;
 		}
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 64b4a30..07d7334 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -95,7 +95,6 @@ static void iforce_usb_irq(struct urb *u
 		goto exit;
 	}
 
-	wake_up(&iforce->wait);
 	iforce_process_packet(iforce,
 		(iforce->data[0] << 8) | (urb->actual_length - 1), iforce->data + 1, regs);
 
diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
index 78dd163..03f9e7e 100644
--- a/drivers/input/joystick/sidewinder.c
+++ b/drivers/input/joystick/sidewinder.c
@@ -736,7 +736,7 @@ static int sw_connect(struct gameport *g
 		sprintf(sw->name, "Microsoft SideWinder %s", sw_name[sw->type]);
 		sprintf(sw->phys[i], "%s/input%d", gameport->phys, i);
 
-		input_dev = input_allocate_device();
+		sw->dev[i] = input_dev = input_allocate_device();
 		if (!input_dev) {
 			err = -ENOMEM;
 			goto fail3;
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 2d0af44..b329f10 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -356,7 +356,7 @@ static void mousedev_free(struct mousede
 	kfree(mousedev);
 }
 
-static int mixdev_release(void)
+static void mixdev_release(void)
 {
 	struct input_handle *handle;
 
@@ -370,8 +370,6 @@ static int mixdev_release(void)
 				mousedev_free(mousedev);
 		}
 	}
-
-	return 0;
 }
 
 static int mousedev_release(struct inode * inode, struct file * file)
@@ -384,9 +382,8 @@ static int mousedev_release(struct inode
 
 	if (!--list->mousedev->open) {
 		if (list->mousedev->minor == MOUSEDEV_MIX)
-			return mixdev_release();
-
-		if (!mousedev_mix.open) {
+			mixdev_release();
+		else if (!mousedev_mix.open) {
 			if (list->mousedev->exist)
 				input_close_device(&list->mousedev->handle);
 			else
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index cf66310..a601a42 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -690,6 +690,8 @@ bad3:
 bad2:
 	crypto_free_tfm(tfm);
 bad1:
+	/* Must zero key material before freeing */
+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
 	kfree(cc);
 	return -EINVAL;
 }
@@ -706,6 +708,9 @@ static void crypt_dtr(struct dm_target *
 		cc->iv_gen_ops->dtr(cc);
 	crypto_free_tfm(cc->tfm);
 	dm_put_device(ti, cc->dev);
+
+	/* Must zero key material before freeing */
+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
 	kfree(cc);
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8175a2a..b9f53c0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1182,6 +1182,7 @@ static int bind_rdev_to_array(mdk_rdev_t
 	mdk_rdev_t *same_pdev;
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
 	struct kobject *ko;
+	char *s;
 
 	if (rdev->mddev) {
 		MD_BUG();
@@ -1213,6 +1214,8 @@ static int bind_rdev_to_array(mdk_rdev_t
 	bdevname(rdev->bdev,b);
 	if (kobject_set_name(&rdev->kobj, "dev-%s", b) < 0)
 		return -ENOMEM;
+	while ( (s=strchr(rdev->kobj.k_name, '/')) != NULL)
+		*s = '!';
 			
 	list_add(&rdev->same_set, &mddev->disks);
 	rdev->mddev = mddev;
diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
index 1c6d328..0245e40 100644
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -1610,6 +1610,8 @@ ppp_receive_nonmp_frame(struct ppp *ppp,
 		}
 		else if (!pskb_may_pull(skb, skb->len))
 			goto err;
+		else
+			skb->ip_summed = CHECKSUM_NONE;
 
 		len = slhc_uncompress(ppp->vj, skb->data + 2, skb->len - 2);
 		if (len <= 0) {
@@ -1690,6 +1692,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp,
 			kfree_skb(skb);
 		} else {
 			skb_pull(skb, 2);	/* chop off protocol */
+			skb_postpull_rcsum(skb, skb->data - 2, 2);
 			skb->dev = ppp->dev;
 			skb->protocol = htons(npindex_to_ethertype[npi]);
 			skb->mac.raw = skb->data;
diff --git a/drivers/net/wireless/hostap/Kconfig b/drivers/net/wireless/hostap/Kconfig
index 56f41c7..c50dfc5 100644
--- a/drivers/net/wireless/hostap/Kconfig
+++ b/drivers/net/wireless/hostap/Kconfig
@@ -61,7 +61,7 @@ config HOSTAP_PCI
 
 config HOSTAP_CS
 	tristate "Host AP driver for Prism2/2.5/3 PC Cards"
-	depends on PCMCIA!=n && HOSTAP
+	depends on PCMCIA && HOSTAP
 	---help---
 	Host AP driver's version for Prism2/2.5/3 PC Cards.
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index dc249cb..1aa8b40 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1534,11 +1534,6 @@ struct request_queue *scsi_alloc_queue(s
 	 */
 	if (shost->ordered_tag)
 		blk_queue_ordered(q, QUEUE_ORDERED_TAG);
-	else if (shost->ordered_flush) {
-		blk_queue_ordered(q, QUEUE_ORDERED_FLUSH);
-		q->prepare_flush_fn = scsi_prepare_flush_fn;
-		q->end_flush_fn = scsi_end_flush_fn;
-	}
 
 	if (!shost->use_clustering)
 		clear_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);
diff --git a/fs/dcache.c b/fs/dcache.c
index 17e4391..f3efeaf 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -808,10 +808,14 @@ void d_instantiate(struct dentry *entry,
  *
  * Fill in inode information in the entry. On success, it returns NULL.
  * If an unhashed alias of "entry" already exists, then we return the
- * aliased dentry instead.
+ * aliased dentry instead and drop one reference to inode.
  *
  * Note that in order to avoid conflicts with rename() etc, the caller
  * had better be holding the parent directory semaphore.
+ *
+ * This also assumes that the inode count has been incremented
+ * (or otherwise set) by the caller to indicate that it is now
+ * in use by the dcache.
  */
 struct dentry *d_instantiate_unique(struct dentry *entry, struct inode *inode)
 {
@@ -838,6 +842,7 @@ struct dentry *d_instantiate_unique(stru
 		dget_locked(alias);
 		spin_unlock(&dcache_lock);
 		BUG_ON(!d_unhashed(alias));
+		iput(inode);
 		return alias;
 	}
 	list_add(&entry->d_alias, &inode->i_dentry);
diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index 6fe21d2..422848c 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -830,6 +830,13 @@ pagebuf_rele(
 
 	PB_TRACE(pb, "rele", pb->pb_relse);
 
+	if (unlikely(!hash)) {
+		ASSERT(!pb->pb_relse);
+		if (atomic_dec_and_test(&pb->pb_hold))
+			xfs_buf_free(pb);
+		return;
+	}
+
 	if (atomic_dec_and_lock(&pb->pb_hold, &hash->bh_lock)) {
 		if (pb->pb_relse) {
 			atomic_inc(&pb->pb_hold);
diff --git a/include/asm-alpha/system.h b/include/asm-alpha/system.h
index 050e86d..1f75e4d 100644
--- a/include/asm-alpha/system.h
+++ b/include/asm-alpha/system.h
@@ -562,7 +562,7 @@ __cmpxchg_u64(volatile long *m, unsigned
    if something tries to do an invalid cmpxchg().  */
 extern void __cmpxchg_called_with_bad_pointer(void);
 
-static inline unsigned long
+static __always_inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {
diff --git a/include/linux/security.h b/include/linux/security.h
index f7e0ae0..203fce0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1437,15 +1437,11 @@ static inline void security_sb_post_pivo
 
 static inline int security_inode_alloc (struct inode *inode)
 {
-	if (unlikely (IS_PRIVATE (inode)))
-		return 0;
 	return security_ops->inode_alloc_security (inode);
 }
 
 static inline void security_inode_free (struct inode *inode)
 {
-	if (unlikely (IS_PRIVATE (inode)))
-		return;
 	security_ops->inode_free_security (inode);
 }
 
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 975abe2..c085d75 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -99,7 +99,6 @@ static void del_nbp(struct net_bridge_po
 	struct net_bridge *br = p->br;
 	struct net_device *dev = p->dev;
 
-	dev->br_port = NULL;
 	dev_set_promiscuity(dev, -1);
 
 	spin_lock_bh(&br->lock);
@@ -110,9 +109,7 @@ static void del_nbp(struct net_bridge_po
 
 	list_del_rcu(&p->list);
 
-	del_timer_sync(&p->message_age_timer);
-	del_timer_sync(&p->forward_delay_timer);
-	del_timer_sync(&p->hold_timer);
+	rcu_assign_pointer(dev->br_port, NULL);
 	
 	call_rcu(&p->rcu, destroy_nbp_rcu);
 }
@@ -217,7 +214,6 @@ static struct net_bridge_port *new_nbp(s
 	p->dev = dev;
 	p->path_cost = cost;
  	p->priority = 0x8000 >> BR_PORT_BITS;
-	dev->br_port = p;
 	p->port_no = index;
 	br_init_port(p);
 	p->state = BR_STATE_DISABLED;
@@ -360,6 +356,7 @@ int br_add_if(struct net_bridge *br, str
 	else if ((err = br_sysfs_addif(p)))
 		del_nbp(p);
 	else {
+		rcu_assign_pointer(dev->br_port, p);
 		dev_set_promiscuity(dev, 1);
 
 		list_add_rcu(&p->list, &br->port_list);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index b88220a..c027ac3 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -45,11 +45,17 @@ static void br_pass_frame_up(struct net_
 int br_handle_frame_finish(struct sk_buff *skb)
 {
 	const unsigned char *dest = eth_hdr(skb)->h_dest;
-	struct net_bridge_port *p = skb->dev->br_port;
-	struct net_bridge *br = p->br;
+	struct net_bridge_port *p = rcu_dereference(skb->dev->br_port);
+	struct net_bridge *br;
 	struct net_bridge_fdb_entry *dst;
 	int passedup = 0;
 
+	if (unlikely(!p || p->state == BR_STATE_DISABLED)) {
+		kfree_skb(skb);
+		return 0;
+	}
+
+	br = p->br;
 	/* insert into forwarding database after filtering to avoid spoofing */
 	br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
 
diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index 23422bd..0770664 100644
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -47,9 +47,6 @@
 #define store_orig_dstaddr(skb)	 (skb_origaddr(skb) = (skb)->nh.iph->daddr)
 #define dnat_took_place(skb)	 (skb_origaddr(skb) != (skb)->nh.iph->daddr)
 
-#define has_bridge_parent(device)	((device)->br_port != NULL)
-#define bridge_parent(device)		((device)->br_port->br->dev)
-
 #ifdef CONFIG_SYSCTL
 static struct ctl_table_header *brnf_sysctl_header;
 static int brnf_call_iptables = 1;
@@ -94,6 +91,12 @@ static struct rtable __fake_rtable = {
 	.rt_flags	= 0,
 };
 
+static inline struct net_device *bridge_parent(const struct net_device *dev)
+{
+	struct net_bridge_port *port = rcu_dereference(dev->br_port);
+
+	return port ? port->br->dev : NULL;
+}
 
 /* PF_BRIDGE/PRE_ROUTING *********************************************/
 /* Undo the changes made for ip6tables PREROUTING and continue the
@@ -185,11 +188,15 @@ static int br_nf_pre_routing_finish_brid
 	skb->nf_bridge->mask ^= BRNF_NF_BRIDGE_PREROUTING;
 
 	skb->dev = bridge_parent(skb->dev);
-	if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
-		skb_pull(skb, VLAN_HLEN);
-		skb->nh.raw += VLAN_HLEN;
+	if (!skb->dev)
+		kfree_skb(skb);
+	else {
+		if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
+			skb_pull(skb, VLAN_HLEN);
+			skb->nh.raw += VLAN_HLEN;
+		}
+		skb->dst->output(skb);
 	}
-	skb->dst->output(skb);
 	return 0;
 }
 
@@ -266,7 +273,7 @@ bridged_dnat:
 }
 
 /* Some common code for IPv4/IPv6 */
-static void setup_pre_routing(struct sk_buff *skb)
+static struct net_device *setup_pre_routing(struct sk_buff *skb)
 {
 	struct nf_bridge_info *nf_bridge = skb->nf_bridge;
 
@@ -278,6 +285,8 @@ static void setup_pre_routing(struct sk_
 	nf_bridge->mask |= BRNF_NF_BRIDGE_PREROUTING;
 	nf_bridge->physindev = skb->dev;
 	skb->dev = bridge_parent(skb->dev);
+
+	return skb->dev;
 }
 
 /* We only check the length. A bridge shouldn't do any hop-by-hop stuff anyway */
@@ -372,7 +381,8 @@ static unsigned int br_nf_pre_routing_ip
  	nf_bridge_put(skb->nf_bridge);
 	if ((nf_bridge = nf_bridge_alloc(skb)) == NULL)
 		return NF_DROP;
-	setup_pre_routing(skb);
+	if (!setup_pre_routing(skb))
+		return NF_DROP;
 
 	NF_HOOK(PF_INET6, NF_IP6_PRE_ROUTING, skb, skb->dev, NULL,
 		br_nf_pre_routing_finish_ipv6);
@@ -409,7 +419,6 @@ static unsigned int br_nf_pre_routing(un
 
 		if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
 			skb_pull(skb, VLAN_HLEN);
-			(skb)->nh.raw += VLAN_HLEN;
 		}
 		return br_nf_pre_routing_ipv6(hook, skb, in, out, okfn);
 	}
@@ -426,7 +435,6 @@ static unsigned int br_nf_pre_routing(un
 
 	if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
 		skb_pull(skb, VLAN_HLEN);
-		(skb)->nh.raw += VLAN_HLEN;
 	}
 
 	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
@@ -456,7 +464,8 @@ static unsigned int br_nf_pre_routing(un
  	nf_bridge_put(skb->nf_bridge);
 	if ((nf_bridge = nf_bridge_alloc(skb)) == NULL)
 		return NF_DROP;
-	setup_pre_routing(skb);
+	if (!setup_pre_routing(skb))
+		return NF_DROP;
 	store_orig_dstaddr(skb);
 
 	NF_HOOK(PF_INET, NF_IP_PRE_ROUTING, skb, skb->dev, NULL,
@@ -530,11 +539,16 @@ static unsigned int br_nf_forward_ip(uns
 	struct sk_buff *skb = *pskb;
 	struct nf_bridge_info *nf_bridge;
 	struct vlan_ethhdr *hdr = vlan_eth_hdr(skb);
+	struct net_device *parent;
 	int pf;
 
 	if (!skb->nf_bridge)
 		return NF_ACCEPT;
 
+	parent = bridge_parent(out);
+	if (!parent)
+		return NF_DROP;
+
 	if (skb->protocol == __constant_htons(ETH_P_IP) || IS_VLAN_IP)
 		pf = PF_INET;
 	else
@@ -555,8 +569,8 @@ static unsigned int br_nf_forward_ip(uns
 	nf_bridge->mask |= BRNF_BRIDGED;
 	nf_bridge->physoutdev = skb->dev;
 
-	NF_HOOK(pf, NF_IP_FORWARD, skb, bridge_parent(in),
-		bridge_parent(out), br_nf_forward_finish);
+	NF_HOOK(pf, NF_IP_FORWARD, skb, bridge_parent(in), parent,
+		br_nf_forward_finish);
 
 	return NF_STOLEN;
 }
@@ -679,6 +693,8 @@ static unsigned int br_nf_local_out(unsi
 		goto out;
 	}
 	realoutdev = bridge_parent(skb->dev);
+	if (!realoutdev)
+		return NF_DROP;
 
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	/* iptables should match -o br0.x */
@@ -692,9 +708,11 @@ static unsigned int br_nf_local_out(unsi
 	/* IP forwarded traffic has a physindev, locally
 	 * generated traffic hasn't. */
 	if (realindev != NULL) {
-		if (!(nf_bridge->mask & BRNF_DONT_TAKE_PARENT) &&
-		    has_bridge_parent(realindev))
-			realindev = bridge_parent(realindev);
+		if (!(nf_bridge->mask & BRNF_DONT_TAKE_PARENT) ) {
+			struct net_device *parent = bridge_parent(realindev);
+			if (parent)
+				realindev = parent;
+		}
 
 		NF_HOOK_THRESH(pf, NF_IP_FORWARD, skb, realindev,
 			       realoutdev, br_nf_local_out_finish,
@@ -734,6 +752,9 @@ static unsigned int br_nf_post_routing(u
 	if (!nf_bridge)
 		return NF_ACCEPT;
 
+	if (!realoutdev)
+		return NF_DROP;
+
 	if (skb->protocol == __constant_htons(ETH_P_IP) || IS_VLAN_IP)
 		pf = PF_INET;
 	else
diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
index d071f1c..78b8f28 100644
--- a/net/bridge/br_stp_bpdu.c
+++ b/net/bridge/br_stp_bpdu.c
@@ -136,10 +136,13 @@ static const unsigned char header[6] = {
 /* NO locks */
 int br_stp_handle_bpdu(struct sk_buff *skb)
 {
-	struct net_bridge_port *p = skb->dev->br_port;
-	struct net_bridge *br = p->br;
+	struct net_bridge_port *p = rcu_dereference(skb->dev->br_port);
+	struct net_bridge *br;
 	unsigned char *buf;
 
+	if (!p)
+		goto err;
+
 	/* insert into forwarding database after filtering to avoid spoofing */
 	br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
 
@@ -150,6 +153,7 @@ int br_stp_handle_bpdu(struct sk_buff *s
 
 	buf = skb_pull(skb, sizeof(header));
 
+	br = p->br;
 	spin_lock_bh(&br->lock);
 	if (p->state == BR_STATE_DISABLED 
 	    || !(br->dev->flags & IFF_UP)
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index b7a468f..337bc12 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -66,9 +66,10 @@ asmlinkage long sys_add_key(const char _
 	description = kmalloc(dlen + 1, GFP_KERNEL);
 	if (!description)
 		goto error;
+	description[dlen] = '\0';
 
 	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen + 1) != 0)
+	if (copy_from_user(description, _description, dlen) != 0)
 		goto error2;
 
 	/* pull the payload in if one was supplied */
@@ -160,9 +161,10 @@ asmlinkage long sys_request_key(const ch
 	description = kmalloc(dlen + 1, GFP_KERNEL);
 	if (!description)
 		goto error;
+	description[dlen] = '\0';
 
 	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen + 1) != 0)
+	if (copy_from_user(description, _description, dlen) != 0)
 		goto error2;
 
 	/* pull the callout info into kernel space */
@@ -181,9 +183,10 @@ asmlinkage long sys_request_key(const ch
 		callout_info = kmalloc(dlen + 1, GFP_KERNEL);
 		if (!callout_info)
 			goto error2;
+		callout_info[dlen] = '\0';
 
 		ret = -EFAULT;
-		if (copy_from_user(callout_info, _callout_info, dlen + 1) != 0)
+		if (copy_from_user(callout_info, _callout_info, dlen) != 0)
 			goto error3;
 	}
 
@@ -278,9 +281,10 @@ long keyctl_join_session_keyring(const c
 		name = kmalloc(nlen + 1, GFP_KERNEL);
 		if (!name)
 			goto error;
+		name[nlen] = '\0';
 
 		ret = -EFAULT;
-		if (copy_from_user(name, _name, nlen + 1) != 0)
+		if (copy_from_user(name, _name, nlen) != 0)
 			goto error2;
 	}
 
@@ -582,9 +586,10 @@ long keyctl_keyring_search(key_serial_t 
 	description = kmalloc(dlen + 1, GFP_KERNEL);
 	if (!description)
 		goto error;
+	description[dlen] = '\0';
 
 	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen + 1) != 0)
+	if (copy_from_user(description, _description, dlen) != 0)
 		goto error2;
 
 	/* get the keyring at which to begin the search */
diff --git a/security/seclvl.c b/security/seclvl.c
index 1caac01..136e8ec 100644
--- a/security/seclvl.c
+++ b/security/seclvl.c
@@ -369,7 +369,7 @@ static int seclvl_capable(struct task_st
 static int seclvl_settime(struct timespec *tv, struct timezone *tz)
 {
 	struct timespec now;
-	if (seclvl > 1) {
+	if (tv && seclvl > 1) {
 		now = current_kernel_time();
 		if (tv->tv_sec < now.tv_sec ||
 		    (tv->tv_sec == now.tv_sec && tv->tv_nsec < now.tv_nsec)) {
diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index 7cc831c..6c39e7b 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -750,6 +750,8 @@ int __devinit snd_emu10k1_mixer(emu10k1_
 		"Master Mono Playback Volume",
 		"PCM Out Path & Mute",
 		"Mono Output Select",
+		"Front Playback Switch",
+		"Front Playback Volume",
 		"Surround Playback Switch",
 		"Surround Playback Volume",
 		"Center Playback Switch",
