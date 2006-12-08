Return-Path: <linux-kernel-owner+w=401wt.eu-S1761149AbWLHTB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761149AbWLHTB6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761155AbWLHTB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:01:58 -0500
Received: from mta9.adelphia.net ([68.168.78.199]:60983 "EHLO
	mta9.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761149AbWLHTB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:01:57 -0500
Date: Fri, 8 Dec 2006 13:01:55 -0600
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH 2/2] IPMI: misc fixes
Message-ID: <20061208190155.GC14675@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix various problems pointed out by Andrew Morton and others:
  * platform_device_unregister checks for NULL, no need to check here.
  * Formatting fixes.
  * Remove big macro and convert to a function.
  * Use strcmp instead of defining a broken case-insensitive comparison,
    and make the output parameter info match the case of the input one
    (change "I/O" to "i/o").
  * Return the length instead of 0 from the hotmod parameter handler.
  * Remove some unused cruft.
  * The trydefaults parameter only has to do with scanning the "standard"
    addresses, don't check for that on ACPI.

Signed-off-by: Corey Minyard <cminyard@acm.org>

Index: linux-2.6.19/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_msghandler.c
@@ -2142,8 +2142,7 @@ cleanup_bmc_device(struct kref *ref)
 	bmc = container_of(ref, struct bmc_device, refcount);
 
 	remove_files(bmc);
-	if (bmc->dev)
-		platform_device_unregister(bmc->dev);
+	platform_device_unregister(bmc->dev);
 	kfree(bmc);
 }
 
@@ -2341,8 +2340,7 @@ static int ipmi_bmc_register(ipmi_smi_t 
 
 		while (ipmi_find_bmc_prod_dev_id(&ipmidriver,
 						 bmc->id.product_id,
-						 bmc->id.device_id))
-		{
+						 bmc->id.device_id)) {
 			if (!warn_printed) {
 				printk(KERN_WARNING PFX
 				       "This machine has two different BMCs"
Index: linux-2.6.19/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_si_intf.c
@@ -1028,7 +1028,7 @@ static int num_slave_addrs;
 
 #define IPMI_IO_ADDR_SPACE  0
 #define IPMI_MEM_ADDR_SPACE 1
-static char *addr_space_to_str[] = { "I/O", "mem" };
+static char *addr_space_to_str[] = { "i/o", "mem" };
 
 static int hotmod_handler(const char *val, struct kernel_param *kp);
 
@@ -1397,20 +1397,7 @@ static struct hotmod_vals hotmod_as[] = 
 	{ "i/o",	IPMI_IO_ADDR_SPACE },
 	{ NULL }
 };
-static int ipmi_strcasecmp(const char *s1, const char *s2)
-{
-	while (*s1 || *s2) {
-		if (!*s1)
-			return -1;
-		if (!*s2)
-			return 1;
-		if (*s1 != *s2)
-			return *s1 - *s2;
-		s1++;
-		s2++;
-	}
-	return 0;
-}
+
 static int parse_str(struct hotmod_vals *v, int *val, char *name, char **curr)
 {
 	char *s;
@@ -1424,7 +1411,7 @@ static int parse_str(struct hotmod_vals 
 	*s = '\0';
 	s++;
 	for (i = 0; hotmod_ops[i].name; i++) {
-		if (ipmi_strcasecmp(*curr, v[i].name) == 0) {
+		if (strcmp(*curr, v[i].name) == 0) {
 			*val = v[i].val;
 			*curr = s;
 			return 0;
@@ -1435,10 +1422,34 @@ static int parse_str(struct hotmod_vals 
 	return -EINVAL;
 }
 
+static int check_hotmod_int_op(const char *curr, const char *option,
+			       const char *name, int *val)
+{
+	char *n;
+
+	if (strcmp(curr, name) == 0) {
+		if (!option) {
+			printk(KERN_WARNING PFX
+			       "No option given for '%s'\n",
+			       curr);
+			return -EINVAL;
+		}
+		*val = simple_strtoul(option, &n, 0);
+		if ((*n != '\0') || (*option == '\0')) {
+			printk(KERN_WARNING PFX
+			       "Bad option given for '%s'\n",
+			       curr);
+			return -EINVAL;
+		}
+		return 1;
+	}
+	return 0;
+}
+
 static int hotmod_handler(const char *val, struct kernel_param *kp)
 {
 	char *str = kstrdup(val, GFP_KERNEL);
-	int  rv = -EINVAL;
+	int  rv;
 	char *next, *curr, *s, *n, *o;
 	enum hotmod_op op;
 	enum si_type si_type;
@@ -1450,13 +1461,15 @@ static int hotmod_handler(const char *va
 	int irq;
 	int ipmb;
 	int ival;
+	int len;
 	struct smi_info *info;
 
 	if (!str)
 		return -ENOMEM;
 
 	/* Kill any trailing spaces, as we can get a "\n" from echo. */
-	ival = strlen(str) - 1;
+	len = strlen(str);
+	ival = len - 1;
 	while ((ival >= 0) && isspace(str[ival])) {
 		str[ival] = '\0';
 		ival--;
@@ -1513,35 +1526,37 @@ static int hotmod_handler(const char *va
 				*o = '\0';
 				o++;
 			}
-#define HOTMOD_INT_OPT(name, val) \
-			if (ipmi_strcasecmp(curr, name) == 0) {		\
-				if (!o) {				\
-					printk(KERN_WARNING PFX		\
-					       "No option given for '%s'\n", \
-						curr);			\
-					goto out;			\
-				}					\
-				val = simple_strtoul(o, &n, 0);		\
-				if ((*n != '\0') || (*o == '\0')) {	\
-					printk(KERN_WARNING PFX		\
-					       "Bad option given for '%s'\n", \
-					       curr);			\
-					goto out;			\
-				}					\
-			}
-
-			HOTMOD_INT_OPT("rsp", regspacing)
-			else HOTMOD_INT_OPT("rsi", regsize)
-			else HOTMOD_INT_OPT("rsh", regshift)
-			else HOTMOD_INT_OPT("irq", irq)
-			else HOTMOD_INT_OPT("ipmb", ipmb)
-			else {
-				printk(KERN_WARNING PFX
-				       "Invalid hotmod option '%s'\n",
-				       curr);
+			rv = check_hotmod_int_op(curr, o, "rsp", &regspacing);
+			if (rv < 0)
 				goto out;
-			}
-#undef HOTMOD_INT_OPT
+			else if (rv)
+				continue;
+			rv = check_hotmod_int_op(curr, o, "rsi", &regsize);
+			if (rv < 0)
+				goto out;
+			else if (rv)
+				continue;
+			rv = check_hotmod_int_op(curr, o, "rsh", &regshift);
+			if (rv < 0)
+				goto out;
+			else if (rv)
+				continue;
+			rv = check_hotmod_int_op(curr, o, "irq", &irq);
+			if (rv < 0)
+				goto out;
+			else if (rv)
+				continue;
+			rv = check_hotmod_int_op(curr, o, "ipmb", &ipmb);
+			if (rv < 0)
+				goto out;
+			else if (rv)
+				continue;
+
+			rv = -EINVAL;
+			printk(KERN_WARNING PFX
+			       "Invalid hotmod option '%s'\n",
+			       curr);
+			goto out;
 		}
 
 		if (op == HM_ADD) {
@@ -1590,6 +1605,7 @@ static int hotmod_handler(const char *va
 			mutex_unlock(&smi_infos_lock);
 		}
 	}
+	rv = len;
  out:
 	kfree(str);
 	return rv;
@@ -1610,11 +1626,11 @@ static __devinit void hardcode_find_bmc(
 
 		info->addr_source = "hardcoded";
 
-		if (!si_type[i] || ipmi_strcasecmp(si_type[i], "kcs") == 0) {
+		if (!si_type[i] || strcmp(si_type[i], "kcs") == 0) {
 			info->si_type = SI_KCS;
-		} else if (ipmi_strcasecmp(si_type[i], "smic") == 0) {
+		} else if (strcmp(si_type[i], "smic") == 0) {
 			info->si_type = SI_SMIC;
-		} else if (ipmi_strcasecmp(si_type[i], "bt") == 0) {
+		} else if (strcmp(si_type[i], "bt") == 0) {
 			info->si_type = SI_BT;
 		} else {
 			printk(KERN_WARNING
@@ -1779,7 +1795,6 @@ struct SPMITable {
 static __devinit int try_init_acpi(struct SPMITable *spmi)
 {
 	struct smi_info  *info;
-	char             *io_type;
 	u8 		 addr_space;
 
 	if (spmi->IPMIlegacy != 1) {
@@ -1843,11 +1858,9 @@ static __devinit int try_init_acpi(struc
 	info->io.regshift = spmi->addr.register_bit_offset;
 
 	if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-		io_type = "memory";
 		info->io_setup = mem_setup;
 		info->io.addr_type = IPMI_IO_ADDR_SPACE;
 	} else if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		io_type = "I/O";
 		info->io_setup = port_setup;
 		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
 	} else {
@@ -2773,8 +2786,7 @@ static __devinit int init_ipmi_si(void)
 #endif
 
 #ifdef CONFIG_ACPI
-	if (si_trydefaults)
-		acpi_find_bmc();
+	acpi_find_bmc();
 #endif
 
 #ifdef CONFIG_PCI
