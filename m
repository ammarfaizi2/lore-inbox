Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162775AbWLBEg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162775AbWLBEg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162776AbWLBEg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:36:58 -0500
Received: from mta10.adelphia.net ([68.168.78.202]:14263 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S1162775AbWLBEg5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:36:57 -0500
Date: Fri, 1 Dec 2006 22:36:55 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH 8/12] IPMI: system interface hotplug
Message-ID: <20061202043655.GD30531@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add the ability to hot add and remove interfaces in the ipmi_si
driver.  Any users who have the device open will get errors if they
try to send a message.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
@@ -61,6 +61,10 @@
 #include "ipmi_si_sm.h"
 #include <linux/init.h>
 #include <linux/dmi.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+
+#define PFX "ipmi_si: "
 
 /* Measure times between events in the driver. */
 #undef DEBUG_TIMING
@@ -92,7 +96,7 @@ enum si_intf_state {
 enum si_type {
     SI_KCS, SI_SMIC, SI_BT
 };
-static char *si_to_str[] = { "KCS", "SMIC", "BT" };
+static char *si_to_str[] = { "kcs", "smic", "bt" };
 
 #define DEVICE_NAME "ipmi_si"
 
@@ -222,7 +226,10 @@ struct smi_info
 static int force_kipmid[SI_MAX_PARMS];
 static int num_force_kipmid;
 
+static int unload_when_empty = 1;
+
 static int try_smi_init(struct smi_info *smi);
+static void cleanup_one_si(struct smi_info *to_clean);
 
 static ATOMIC_NOTIFIER_HEAD(xaction_notifier_list);
 static int register_xaction_notifier(struct notifier_block * nb)
@@ -247,7 +254,7 @@ static void return_hosed_msg(struct smi_
 	/* Make it a reponse */
 	msg->rsp[0] = msg->data[0] | 4;
 	msg->rsp[1] = msg->data[1];
-	msg->rsp[2] = 0xFF; /* Unknown error. */
+	msg->rsp[2] = IPMI_ERR_UNSPECIFIED;
 	msg->rsp_size = 3;
 
 	smi_info->curr_msg = NULL;
@@ -716,6 +723,15 @@ static void sender(void                *
 	struct timeval    t;
 #endif
 
+	if (atomic_read(&smi_info->stop_operation)) {
+		msg->rsp[0] = msg->data[0] | 4;
+		msg->rsp[1] = msg->data[1];
+		msg->rsp[2] = IPMI_ERR_UNSPECIFIED;
+		msg->rsp_size = 3;
+		deliver_recv_msg(smi_info, msg);
+		return;
+	}
+
 	spin_lock_irqsave(&(smi_info->msg_lock), flags);
 #ifdef DEBUG_TIMING
 	do_gettimeofday(&t);
@@ -819,6 +835,9 @@ static void request_events(void *send_in
 {
 	struct smi_info *smi_info = send_info;
 
+	if (atomic_read(&smi_info->stop_operation))
+		return;
+
 	atomic_set(&smi_info->req_events, 1);
 }
 
@@ -1003,6 +1022,16 @@ static int num_regshifts = 0;
 static int slave_addrs[SI_MAX_PARMS];
 static int num_slave_addrs = 0;
 
+#define IPMI_IO_ADDR_SPACE  0
+#define IPMI_MEM_ADDR_SPACE 1
+static char *addr_space_to_str[] = { "I/O", "mem" };
+
+static int hotmod_handler(const char *val, struct kernel_param *kp);
+
+module_param_call(hotmod, hotmod_handler, NULL, NULL, 0200);
+MODULE_PARM_DESC(hotmod, "Add and remove interfaces.  See"
+		 " Documentation/IPMI.txt in the kernel sources for the"
+		 " gory details.");
 
 module_param_named(trydefaults, si_trydefaults, bool, 0);
 MODULE_PARM_DESC(trydefaults, "Setting this to 'false' will disable the"
@@ -1054,12 +1083,12 @@ module_param_array(force_kipmid, int, &n
 MODULE_PARM_DESC(force_kipmid, "Force the kipmi daemon to be enabled (1) or"
 		 " disabled(0).  Normally the IPMI driver auto-detects"
 		 " this, but the value may be overridden by this parm.");
+module_param(unload_when_empty, int, 0);
+MODULE_PARM_DESC(unload_when_empty, "Unload the module if no interfaces are"
+		 " specified or found, default is 1.  Setting to 0"
+		 " is useful for hot add of devices using hotmod.");
 
 
-#define IPMI_IO_ADDR_SPACE  0
-#define IPMI_MEM_ADDR_SPACE 1
-static char *addr_space_to_str[] = { "I/O", "memory" };
-
 static void std_irq_cleanup(struct smi_info *info)
 {
 	if (info->si_type == SI_BT)
@@ -1333,6 +1362,234 @@ static int mem_setup(struct smi_info *in
 	return 0;
 }
 
+/*
+ * Parms come in as <op1>[:op2[:op3...]].  ops are:
+ *   add|remove,kcs|bt|smic,mem|i/o,<address>[,<opt1>[,<opt2>[,...]]]
+ * Options are:
+ *   rsp=<regspacing>
+ *   rsi=<regsize>
+ *   rsh=<regshift>
+ *   irq=<irq>
+ *   ipmb=<ipmb addr>
+ */
+enum hotmod_op { HM_ADD, HM_REMOVE };
+struct hotmod_vals {
+	char *name;
+	int  val;
+};
+static struct hotmod_vals hotmod_ops[] = {
+	{ "add",	HM_ADD },
+	{ "remove",	HM_REMOVE },
+	{ NULL }
+};
+static struct hotmod_vals hotmod_si[] = {
+	{ "kcs",	SI_KCS },
+	{ "smic",	SI_SMIC },
+	{ "bt",		SI_BT },
+	{ NULL }
+};
+static struct hotmod_vals hotmod_as[] = {
+	{ "mem",	IPMI_MEM_ADDR_SPACE },
+	{ "i/o",	IPMI_IO_ADDR_SPACE },
+	{ NULL }
+};
+static int ipmi_strcasecmp(const char *s1, const char *s2)
+{
+	while (*s1 || *s2) {
+		if (!*s1)
+			return -1;
+		if (!*s2)
+			return 1;
+		if (*s1 != *s2)
+			return *s1 - *s2;
+		s1++;
+		s2++;
+	}
+	return 0;
+}
+static int parse_str(struct hotmod_vals *v, int *val, char *name, char **curr)
+{
+	char *s;
+	int  i;
+
+	s = strchr(*curr, ',');
+	if (!s) {
+		printk(KERN_WARNING PFX "No hotmod %s given.\n", name);
+		return -EINVAL;
+	}
+	*s = '\0';
+	s++;
+	for (i = 0; hotmod_ops[i].name; i++) {
+		if (ipmi_strcasecmp(*curr, v[i].name) == 0) {
+			*val = v[i].val;
+			*curr = s;
+			return 0;
+		}
+	}
+
+	printk(KERN_WARNING PFX "Invalid hotmod %s '%s'\n", name, *curr);
+	return -EINVAL;
+}
+
+static int hotmod_handler(const char *val, struct kernel_param *kp)
+{
+	char *str = kstrdup(val, GFP_KERNEL);
+	int  rv = -EINVAL;
+	char *next, *curr, *s, *n, *o;
+	enum hotmod_op op;
+	enum si_type si_type;
+	int  addr_space;
+	unsigned long addr;
+	int regspacing;
+	int regsize;
+	int regshift;
+	int irq;
+	int ipmb;
+	int ival;
+	struct smi_info *info;
+
+	if (!str)
+		return -ENOMEM;
+
+	/* Kill any trailing spaces, as we can get a "\n" from echo. */
+	ival = strlen(str) - 1;
+	while ((ival >= 0) && isspace(str[ival])) {
+		str[ival] = '\0';
+		ival--;
+	}
+
+	for (curr = str; curr; curr = next) {
+		regspacing = 1;
+		regsize = 1;
+		regshift = 0;
+		irq = 0;
+		ipmb = 0x20;
+
+		next = strchr(curr, ':');
+		if (next) {
+			*next = '\0';
+			next++;
+		}
+
+		rv = parse_str(hotmod_ops, &ival, "operation", &curr);
+		if (rv)
+			break;
+		op = ival;
+
+		rv = parse_str(hotmod_si, &ival, "interface type", &curr);
+		if (rv)
+			break;
+		si_type = ival;
+
+		rv = parse_str(hotmod_as, &addr_space, "address space", &curr);
+		if (rv)
+			break;
+
+		s = strchr(curr, ',');
+		if (s) {
+			*s = '\0';
+			s++;
+		}
+		addr = simple_strtoul(curr, &n, 0);
+		if ((*n != '\0') || (*curr == '\0')) {
+			printk(KERN_WARNING PFX "Invalid hotmod address"
+			       " '%s'\n", curr);
+			break;
+		}
+
+		while (s) {
+			curr = s;
+			s = strchr(curr, ',');
+			if (s) {
+				*s = '\0';
+				s++;
+			}
+			o = strchr(curr, '=');
+			if (o) {
+				*o = '\0';
+				o++;
+			}
+#define HOTMOD_INT_OPT(name, val) \
+			if (ipmi_strcasecmp(curr, name) == 0) {		\
+				if (!o) {				\
+					printk(KERN_WARNING PFX		\
+					       "No option given for '%s'\n", \
+						curr);			\
+					goto out;			\
+				}					\
+				val = simple_strtoul(o, &n, 0);		\
+				if ((*n != '\0') || (*o == '\0')) {	\
+					printk(KERN_WARNING PFX		\
+					       "Bad option given for '%s'\n", \
+					       curr);			\
+					goto out;			\
+				}					\
+			}
+
+			HOTMOD_INT_OPT("rsp", regspacing)
+			else HOTMOD_INT_OPT("rsi", regsize)
+			else HOTMOD_INT_OPT("rsh", regshift)
+			else HOTMOD_INT_OPT("irq", irq)
+			else HOTMOD_INT_OPT("ipmb", ipmb)
+			else {
+				printk(KERN_WARNING PFX
+				       "Invalid hotmod option '%s'\n",
+				       curr);
+				goto out;
+			}
+#undef HOTMOD_INT_OPT
+		}
+
+		if (op == HM_ADD) {
+			info = kzalloc(sizeof(*info), GFP_KERNEL);
+			if (!info) {
+				rv = -ENOMEM;
+				goto out;
+			}
+
+			info->addr_source = "hotmod";
+			info->si_type = si_type;
+			info->io.addr_data = addr;
+			info->io.addr_type = addr_space;
+			if (addr_space == IPMI_MEM_ADDR_SPACE)
+				info->io_setup = mem_setup;
+			else
+				info->io_setup = port_setup;
+
+			info->io.addr = NULL;
+			info->io.regspacing = regspacing;
+			if (!info->io.regspacing)
+				info->io.regspacing = DEFAULT_REGSPACING;
+			info->io.regsize = regsize;
+			if (!info->io.regsize)
+				info->io.regsize = DEFAULT_REGSPACING;
+			info->io.regshift = regshift;
+			info->irq = irq;
+			if (info->irq)
+				info->irq_setup = std_irq_setup;
+			info->slave_addr = ipmb;
+
+			try_smi_init(info);
+		} else {
+			/* remove */
+			struct smi_info *e, *tmp_e;
+
+			mutex_lock(&smi_infos_lock);
+			list_for_each_entry_safe(e, tmp_e, &smi_infos, link) {
+				if (e->io.addr_type != addr_space)
+					continue;
+				if (e->si_type != si_type)
+					continue;
+				if (e->io.addr_data == addr)
+					cleanup_one_si(e);
+			}
+			mutex_unlock(&smi_infos_lock);
+		}
+	}
+ out:
+	kfree(str);
+	return rv;
+}
 
 static __devinit void hardcode_find_bmc(void)
 {
@@ -1349,11 +1606,11 @@ static __devinit void hardcode_find_bmc(
 
 		info->addr_source = "hardcoded";
 
-		if (!si_type[i] || strcmp(si_type[i], "kcs") == 0) {
+		if (!si_type[i] || ipmi_strcasecmp(si_type[i], "kcs") == 0) {
 			info->si_type = SI_KCS;
-		} else if (strcmp(si_type[i], "smic") == 0) {
+		} else if (ipmi_strcasecmp(si_type[i], "smic") == 0) {
 			info->si_type = SI_SMIC;
-		} else if (strcmp(si_type[i], "bt") == 0) {
+		} else if (ipmi_strcasecmp(si_type[i], "bt") == 0) {
 			info->si_type = SI_BT;
 		} else {
 			printk(KERN_WARNING
@@ -1968,19 +2225,9 @@ static int try_get_dev_id(struct smi_inf
 static int type_file_read_proc(char *page, char **start, off_t off,
 			       int count, int *eof, void *data)
 {
-	char            *out = (char *) page;
 	struct smi_info *smi = data;
 
-	switch (smi->si_type) {
-	    case SI_KCS:
-		return sprintf(out, "kcs\n");
-	    case SI_SMIC:
-		return sprintf(out, "smic\n");
-	    case SI_BT:
-		return sprintf(out, "bt\n");
-	    default:
-		return 0;
-	}
+	return sprintf(page, "%s\n", si_to_str[smi->si_type]);
 }
 
 static int stat_file_read_proc(char *page, char **start, off_t off,
@@ -2016,7 +2263,24 @@ static int stat_file_read_proc(char *pag
 	out += sprintf(out, "incoming_messages:     %ld\n",
 		       smi->incoming_messages);
 
-	return (out - ((char *) page));
+	return out - page;
+}
+
+static int param_read_proc(char *page, char **start, off_t off,
+			   int count, int *eof, void *data)
+{
+	struct smi_info *smi = data;
+
+	return sprintf(page,
+		       "%s,%s,0x%lx,rsp=%d,rsi=%d,rsh=%d,irq=%d,ipmb=%d\n",
+		       si_to_str[smi->si_type],
+		       addr_space_to_str[smi->io.addr_type],
+		       smi->io.addr_data,
+		       smi->io.regspacing,
+		       smi->io.regsize,
+		       smi->io.regshift,
+		       smi->irq,
+		       smi->slave_addr);
 }
 
 /*
@@ -2407,6 +2671,16 @@ static int try_smi_init(struct smi_info 
 		goto out_err_stop_timer;
 	}
 
+	rv = ipmi_smi_add_proc_entry(new_smi->intf, "params",
+				     param_read_proc, NULL,
+				     new_smi, THIS_MODULE);
+	if (rv) {
+		printk(KERN_ERR
+		       "ipmi_si: Unable to create proc entry: %d\n",
+		       rv);
+		goto out_err_stop_timer;
+	}
+
 	list_add_tail(&new_smi->link, &smi_infos);
 
 	mutex_unlock(&smi_infos_lock);
@@ -2515,7 +2789,7 @@ static __devinit int init_ipmi_si(void)
 	}
 
 	mutex_lock(&smi_infos_lock);
-	if (list_empty(&smi_infos)) {
+	if (unload_when_empty && list_empty(&smi_infos)) {
 		mutex_unlock(&smi_infos_lock);
 #ifdef CONFIG_PCI
 		pci_unregister_driver(&ipmi_pci_driver);
@@ -2530,7 +2804,7 @@ static __devinit int init_ipmi_si(void)
 }
 module_init(init_ipmi_si);
 
-static void __devexit cleanup_one_si(struct smi_info *to_clean)
+static void cleanup_one_si(struct smi_info *to_clean)
 {
 	int           rv;
 	unsigned long flags;
Index: linux-2.6.19-rc6/Documentation/IPMI.txt
===================================================================
--- linux-2.6.19-rc6.orig/Documentation/IPMI.txt
+++ linux-2.6.19-rc6/Documentation/IPMI.txt
@@ -365,6 +365,7 @@ You can change this at module load time 
        regshifts=<shift1>,<shift2>,...
        slave_addrs=<addr1>,<addr2>,...
        force_kipmid=<enable1>,<enable2>,...
+       unload_when_empty=[0|1]
 
 Each of these except si_trydefaults is a list, the first item for the
 first interface, second item for the second interface, etc.
@@ -416,6 +417,11 @@ by the driver, but systems with broken i
 or users that don't want the daemon (don't need the performance, don't
 want the CPU hit) can disable it.
 
+If unload_when_empty is set to 1, the driver will be unloaded if it
+doesn't find any interfaces or all the interfaces fail to work.  The
+default is one.  Setting to 0 is useful with the hotmod, but is
+obviously only useful for modules.
+
 When compiled into the kernel, the parameters can be specified on the
 kernel command line as:
 
@@ -441,6 +447,25 @@ have high-res timers enabled in the kern
 interrupts enabled, the driver will run VERY slowly.  Don't blame me,
 these interfaces suck.
 
+The driver supports a hot add and remove of interfaces.  This way,
+interfaces can be added or removed after the kernel is up and running.
+This is done using /sys/modules/ipmi_si/hotmod, which is a write-only
+parameter.  You write a string to this interface.  The string has the
+format:
+   <op1>[:op2[:op3...]]
+The "op"s are:
+   add|remove,kcs|bt|smic,mem|i/o,<address>[,<opt1>[,<opt2>[,...]]]
+You can specify more than one interface on the line.  The "opt"s are:
+   rsp=<regspacing>
+   rsi=<regsize>
+   rsh=<regshift>
+   irq=<irq>
+   ipmb=<ipmb slave addr>
+and these have the same meanings as discussed above.  Note that you
+can also use this on the kernel command line for a more compact format
+for specifying an interface.  Note that when removing an interface,
+only the first three parameters (si type, address type, and address)
+are used for the comparison.  Any options are ignored for removing.
 
 The SMBus Driver
 ----------------
