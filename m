Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSGVKon>; Mon, 22 Jul 2002 06:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSGVKon>; Mon, 22 Jul 2002 06:44:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15112 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316672AbSGVKog>; Mon, 22 Jul 2002 06:44:36 -0400
Message-ID: <3D3BE17F.3040905@evision.ag>
Date: Mon, 22 Jul 2002 12:42:07 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 sysctl
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------070604060209080106060104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070604060209080106060104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is making the sysctl code acutally be written in C.
It wasn't mostly due to georgeous ommitted size array "forward
declarations". As a side effect it makes the table structure easier to
deduce.

--------------070604060209080106060104
Content-Type: text/plain;
 name="sysctl-2.5.27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysctl-2.5.27.diff"

diff -urN linux-2.5.27/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.5.27/include/linux/sysctl.h	2002-07-20 21:11:05.000000000 +0200
+++ linux/include/linux/sysctl.h	2002-07-21 19:30:43.000000000 +0200
@@ -126,7 +126,7 @@
 	KERN_S390_USER_DEBUG_LOGGING=51,  /* int: dumps of user faults */
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
-	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
+	KERN_CADPID=54		/* int: PID of the process to notify on CAD */
 };
 
 
@@ -148,7 +148,7 @@
 	VM_DIRTY_SYNC=13,	/* dirty_sync_ratio */
 	VM_DIRTY_WB_CS=14,	/* dirty_writeback_centisecs */
 	VM_DIRTY_EXPIRE_CS=15,	/* dirty_expire_centisecs */
-	VM_NR_PDFLUSH_THREADS=16, /* nr_pdflush_threads */
+	VM_NR_PDFLUSH_THREADS=16 /* nr_pdflush_threads */
 };
 
 
@@ -225,7 +225,7 @@
 {
 	NET_UNIX_DESTROY_DELAY=1,
 	NET_UNIX_DELETE_DELAY=2,
-	NET_UNIX_MAX_DGRAM_QLEN=3,
+	NET_UNIX_MAX_DGRAM_QLEN=3
 };
 
 /* /proc/sys/net/ipv4 */
@@ -344,7 +344,7 @@
 	NET_IPV4_CONF_LOG_MARTIANS=11,
 	NET_IPV4_CONF_TAG=12,
 	NET_IPV4_CONF_ARPFILTER=13,
-	NET_IPV4_CONF_MEDIUM_ID=14,
+	NET_IPV4_CONF_MEDIUM_ID=14
 };
 
 /* /proc/sys/net/ipv6 */
@@ -553,7 +553,7 @@
 	FS_LEASES=13,	/* int: leases enabled */
 	FS_DIR_NOTIFY=14,	/* int: directory notification enabled */
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
-	FS_DQSTATS=16,	/* disc quota usage statistics */
+	FS_DQSTATS=16	/* disc quota usage statistics */
 };
 
 /* /proc/sys/fs/quota/ */
@@ -565,7 +565,7 @@
 	FS_DQ_CACHE_HITS = 5,
 	FS_DQ_ALLOCATED = 6,
 	FS_DQ_FREE = 7,
-	FS_DQ_SYNCS = 8,
+	FS_DQ_SYNCS = 8
 };
 
 /* CTL_DEBUG names: */
@@ -619,12 +619,12 @@
 
 /* /proc/sys/dev/parport/parport n/devices/ */
 enum {
-	DEV_PARPORT_DEVICES_ACTIVE=-3,
+	DEV_PARPORT_DEVICES_ACTIVE=-3
 };
 
 /* /proc/sys/dev/parport/parport n/devices/device n */
 enum {
-	DEV_PARPORT_DEVICE_TIMESLICE=1,
+	DEV_PARPORT_DEVICE_TIMESLICE=1
 };
 
 /* /proc/sys/dev/mac_hid */
@@ -645,7 +645,7 @@
 	ABI_DEFHANDLER_LCALL7=3,/* default handler for procs using lcall7 */
 	ABI_DEFHANDLER_LIBCSO=4,/* default handler for an libc.so ELF interp */
 	ABI_TRACE=5,		/* tracing flags */
-	ABI_FAKE_UTSNAME=6,	/* fake target utsname information */
+	ABI_FAKE_UTSNAME=6	/* fake target utsname information */
 };
 
 #ifdef __KERNEL__
diff -urN linux-2.5.27/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.5.27/kernel/sysctl.c	2002-07-20 21:11:07.000000000 +0200
+++ linux/kernel/sysctl.c	2002-07-21 19:30:43.000000000 +0200
@@ -102,59 +102,10 @@
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp);
 
-static ctl_table root_table[];
-static struct ctl_table_header root_table_header =
-	{ root_table, LIST_HEAD_INIT(root_table_header.ctl_entry) };
-
-static ctl_table kern_table[];
-static ctl_table vm_table[];
-#ifdef CONFIG_NET
-extern ctl_table net_table[];
-#endif
-static ctl_table proc_table[];
-static ctl_table fs_table[];
-static ctl_table debug_table[];
-static ctl_table dev_table[];
 extern ctl_table random_table[];
 
-/* /proc declarations: */
-
-#ifdef CONFIG_PROC_FS
-
-static ssize_t proc_readsys(struct file *, char *, size_t, loff_t *);
-static ssize_t proc_writesys(struct file *, const char *, size_t, loff_t *);
-static int proc_sys_permission(struct inode *, int);
-
-struct file_operations proc_sys_file_operations = {
-	read:		proc_readsys,
-	write:		proc_writesys,
-};
-
-static struct inode_operations proc_sys_inode_operations = {
-	permission:	proc_sys_permission,
-};
-
-extern struct proc_dir_entry *proc_sys_root;
-
-static void register_proc_table(ctl_table *, struct proc_dir_entry *);
-static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
-#endif
-
 /* The default sysctl tables: */
 
-static ctl_table root_table[] = {
-	{CTL_KERN, "kernel", NULL, 0, 0555, kern_table},
-	{CTL_VM, "vm", NULL, 0, 0555, vm_table},
-#ifdef CONFIG_NET
-	{CTL_NET, "net", NULL, 0, 0555, net_table},
-#endif
-	{CTL_PROC, "proc", NULL, 0, 0555, proc_table},
-	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
-	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
-        {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
-	{0}
-};
-
 static ctl_table kern_table[] = {
 	{KERN_OSTYPE, "ostype", system_utsname.sysname, 64,
 	 0444, NULL, &proc_doutsstring, &sysctl_string},
@@ -235,7 +186,7 @@
 #ifdef CONFIG_MAGIC_SYSRQ
 	{KERN_SYSRQ, "sysrq", &sysrq_enabled, sizeof (int),
 	 0644, NULL, &proc_dointvec},
-#endif	 
+#endif
 	{KERN_CADPID, "cad_pid", &cad_pid, sizeof (int),
 	 0600, NULL, &proc_dointvec},
 	{KERN_MAX_THREADS, "threads-max", &max_threads, sizeof(int),
@@ -264,7 +215,6 @@
 static int one = 1;
 static int one_hundred = 100;
 
-
 static ctl_table vm_table[] = {
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
@@ -307,6 +257,10 @@
 	{0}
 };
 
+#ifdef CONFIG_NET
+extern ctl_table net_table[];
+#endif
+
 static ctl_table proc_table[] = {
 	{0}
 };
@@ -343,7 +297,48 @@
 
 static ctl_table dev_table[] = {
 	{0}
-};  
+};
+
+static ctl_table root_table[] = {
+	{CTL_KERN, "kernel", NULL, 0, 0555, kern_table},
+	{CTL_VM, "vm", NULL, 0, 0555, vm_table},
+#ifdef CONFIG_NET
+	{CTL_NET, "net", NULL, 0, 0555, net_table},
+#endif
+	{CTL_PROC, "proc", NULL, 0, 0555, proc_table},
+	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
+	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
+        {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+	{0}
+};
+static struct ctl_table_header root_table_header =
+	{ root_table, LIST_HEAD_INIT(root_table_header.ctl_entry) };
+
+static ctl_table debug_table[];
+static ctl_table dev_table[];
+
+/* /proc declarations: */
+
+#ifdef CONFIG_PROC_FS
+
+static ssize_t proc_readsys(struct file *, char *, size_t, loff_t *);
+static ssize_t proc_writesys(struct file *, const char *, size_t, loff_t *);
+static int proc_sys_permission(struct inode *, int);
+
+struct file_operations proc_sys_file_operations = {
+	read:		proc_readsys,
+	write:		proc_writesys,
+};
+
+static struct inode_operations proc_sys_inode_operations = {
+	permission:	proc_sys_permission,
+};
+
+extern struct proc_dir_entry *proc_sys_root;
+
+static void register_proc_table(ctl_table *, struct proc_dir_entry *);
+static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
+#endif
 
 extern void init_irq_proc (void);
 
diff -urN linux-2.5.27/net/sunrpc/sysctl.c linux/net/sunrpc/sysctl.c
--- linux-2.5.27/net/sunrpc/sysctl.c	2002-07-20 21:11:07.000000000 +0200
+++ linux/net/sunrpc/sysctl.c	2002-07-21 19:30:43.000000000 +0200
@@ -33,29 +33,6 @@
 #ifdef RPC_DEBUG
 
 static struct ctl_table_header *sunrpc_table_header;
-static ctl_table		sunrpc_table[];
-
-void
-rpc_register_sysctl(void)
-{
-	if (!sunrpc_table_header) {
-		sunrpc_table_header = register_sysctl_table(sunrpc_table, 1);
-#ifdef CONFIG_PROC_FS
-		if (sunrpc_table[0].de)
-			sunrpc_table[0].de->owner = THIS_MODULE;
-#endif
-	}
-			
-}
-
-void
-rpc_unregister_sysctl(void)
-{
-	if (sunrpc_table_header) {
-		unregister_sysctl_table(sunrpc_table_header);
-		sunrpc_table_header = NULL;
-	}
-}
 
 static int
 proc_dodebug(ctl_table *table, int write, struct file *file,
@@ -135,4 +112,26 @@
 	{0}
 };
 
+void
+rpc_register_sysctl(void)
+{
+	if (!sunrpc_table_header) {
+		sunrpc_table_header = register_sysctl_table(sunrpc_table, 1);
+#ifdef CONFIG_PROC_FS
+		if (sunrpc_table[0].de)
+			sunrpc_table[0].de->owner = THIS_MODULE;
+#endif
+	}
+			
+}
+
+void
+rpc_unregister_sysctl(void)
+{
+	if (sunrpc_table_header) {
+		unregister_sysctl_table(sunrpc_table_header);
+		sunrpc_table_header = NULL;
+	}
+}
+
 #endif

--------------070604060209080106060104--

