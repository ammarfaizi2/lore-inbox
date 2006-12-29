Return-Path: <linux-kernel-owner+w=401wt.eu-S965169AbWL2Xr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbWL2Xr0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWL2XrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:47:25 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:45697 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965169AbWL2Xq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:46:57 -0500
Message-Id: <200612292341.kBTNfR7D005534@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/6] UML - Return hotplug errors to host
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Dec 2006 18:41:27 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that errors happening while hotplugging devices from the
host were never returned back to the mconsole client.  In some cases,
success was returned instead of even an information-free error.

This patch cleans that up by having the low-level configuration code
pass back an error string along with an error code.  At the top level,
which knows whether it is early boot time or responding to an mconsole
request, the string is printk'd or returned to the mconsole client.

There are also whitespace and trivial code cleanups in the surrounding code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

--
 arch/um/drivers/chan_kern.c     |   77 ++++++-----------------
 arch/um/drivers/line.c          |   66 +++++++++++---------
 arch/um/drivers/mconsole_kern.c |   40 ++++++++----
 arch/um/drivers/net_kern.c      |   97 +++++++++++++----------------
 arch/um/drivers/ssl.c           |   24 +++++--
 arch/um/drivers/stdio_console.c |   22 ++++--
 arch/um/drivers/ubd_kern.c      |  132 ++++++++++++++++++++++------------------
 arch/um/include/chan_kern.h     |    2 
 arch/um/include/line.h          |    8 +-
 arch/um/include/mconsole_kern.h |   15 ----
 arch/um/kernel/tt/gdb.c         |    4 -
 arch/um/kernel/tt/gdb_kern.c    |    4 -
 12 files changed, 253 insertions(+), 238 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/line.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/line.c	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/line.c	2006-12-29 17:26:54.000000000 -0500
@@ -549,14 +549,16 @@ void close_lines(struct line *lines, int
 		close_chan(&lines[i].chan_list, 0);
 }
 
-static void setup_one_line(struct line *lines, int n, char *init, int init_prio)
+static int setup_one_line(struct line *lines, int n, char *init, int init_prio,
+			  char **error_out)
 {
 	struct line *line = &lines[n];
+	int err = -EINVAL;
 
 	spin_lock(&line->count_lock);
 
 	if(line->tty != NULL){
-		printk("line_setup - device %d is open\n", n);
+		*error_out = "Device is already open";
 		goto out;
 	}
 
@@ -569,18 +571,22 @@ static void setup_one_line(struct line *
 			line->valid = 1;
 		}
 	}
+	err = 0;
 out:
 	spin_unlock(&line->count_lock);
+	return err;
 }
 
 /* Common setup code for both startup command line and mconsole initialization.
  * @lines contains the array (of size @num) to modify;
  * @init is the setup string;
+ * @error_out is an error string in the case of failure;
  */
 
-int line_setup(struct line *lines, unsigned int num, char *init)
+int line_setup(struct line *lines, unsigned int num, char *init,
+	       char **error_out)
 {
-	int i, n;
+	int i, n, err;
 	char *end;
 
 	if(*init == '=') {
@@ -591,52 +597,56 @@ int line_setup(struct line *lines, unsig
 	else {
 		n = simple_strtoul(init, &end, 0);
 		if(*end != '='){
-			printk(KERN_ERR "line_setup failed to parse \"%s\"\n",
-			       init);
-			return 0;
+			*error_out = "Couldn't parse device number";
+			return -EINVAL;
 		}
 		init = end;
 	}
 	init++;
 
 	if (n >= (signed int) num) {
-		printk("line_setup - %d out of range ((0 ... %d) allowed)\n",
-		       n, num - 1);
-		return 0;
+		*error_out = "Device number out of range";
+		return -EINVAL;
+	}
+	else if (n >= 0){
+		err = setup_one_line(lines, n, init, INIT_ONE, error_out);
+		if(err)
+			return err;
 	}
-	else if (n >= 0)
-		setup_one_line(lines, n, init, INIT_ONE);
 	else {
-		for(i = 0; i < num; i++)
-			setup_one_line(lines, i, init, INIT_ALL);
+		for(i = 0; i < num; i++){
+			err = setup_one_line(lines, i, init, INIT_ALL,
+					     error_out);
+			if(err)
+				return err;
+		}
 	}
 	return n == -1 ? num : n;
 }
 
 int line_config(struct line *lines, unsigned int num, char *str,
-		const struct chan_opts *opts)
+		const struct chan_opts *opts, char **error_out)
 {
 	struct line *line;
 	char *new;
 	int n;
 
 	if(*str == '='){
-		printk("line_config - can't configure all devices from "
-		       "mconsole\n");
-		return 1;
+		*error_out = "Can't configure all devices from mconsole";
+		return -EINVAL;
 	}
 
 	new = kstrdup(str, GFP_KERNEL);
 	if(new == NULL){
-		printk("line_config - kstrdup failed\n");
-		return 1;
+		*error_out = "Failed to allocate memory";
+		return -ENOMEM;
 	}
-	n = line_setup(lines, num, new);
+	n = line_setup(lines, num, new, error_out);
 	if(n < 0)
-		return 1;
+		return n;
 
 	line = &lines[n];
-	return parse_chan_pair(line->init_str, line, n, opts);
+	return parse_chan_pair(line->init_str, line, n, opts, error_out);
 }
 
 int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
@@ -685,13 +695,13 @@ int line_id(char **str, int *start_out, 
         return n;
 }
 
-int line_remove(struct line *lines, unsigned int num, int n)
+int line_remove(struct line *lines, unsigned int num, int n, char **error_out)
 {
 	int err;
 	char config[sizeof("conxxxx=none\0")];
 
 	sprintf(config, "%d=none", n);
-	err = line_setup(lines, num, config);
+	err = line_setup(lines, num, config, error_out);
 	if(err >= 0)
 		err = 0;
 	return err;
@@ -740,6 +750,7 @@ static LIST_HEAD(winch_handlers);
 void lines_init(struct line *lines, int nlines, struct chan_opts *opts)
 {
 	struct line *line;
+	char *error;
 	int i;
 
 	for(i = 0; i < nlines; i++){
@@ -754,8 +765,9 @@ void lines_init(struct line *lines, int 
 		if(line->init_str == NULL)
 			printk("lines_init - kstrdup returned NULL\n");
 
-		if(parse_chan_pair(line->init_str, line, i, opts)){
-			printk("parse_chan_pair failed for device %d\n", i);
+		if(parse_chan_pair(line->init_str, line, i, opts, &error)){
+			printk("parse_chan_pair failed for device %d : %s\n",
+			       i, error);
 			line->valid = 0;
 		}
 	}
Index: linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mconsole_kern.c	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c	2006-12-29 17:26:54.000000000 -0500
@@ -371,14 +371,16 @@ static unsigned long long unplugged_page
 static struct list_head unplugged_pages = LIST_HEAD_INIT(unplugged_pages);
 static int unplug_index = UNPLUGGED_PER_PAGE;
 
-static int mem_config(char *str)
+static int mem_config(char *str, char **error_out)
 {
 	unsigned long long diff;
 	int err = -EINVAL, i, add;
 	char *ret;
 
-	if(str[0] != '=')
+	if(str[0] != '='){
+		*error_out = "Expected '=' after 'mem'";
 		goto out;
+	}
 
 	str++;
 	if(str[0] == '-')
@@ -386,12 +388,17 @@ static int mem_config(char *str)
 	else if(str[0] == '+'){
 		add = 1;
 	}
-	else goto out;
+	else {
+		*error_out = "Expected increment to start with '-' or '+'";
+		goto out;
+	}
 
 	str++;
 	diff = memparse(str, &ret);
-	if(*ret != '\0')
+	if(*ret != '\0'){
+		*error_out = "Failed to parse memory increment";
 		goto out;
+	}
 
 	diff /= PAGE_SIZE;
 
@@ -435,11 +442,14 @@ static int mem_config(char *str)
 				unplugged = list_entry(entry,
 						       struct unplugged_pages,
 						       list);
-				unplugged->pages[unplug_index++] = addr;
 				err = os_drop_memory(addr, PAGE_SIZE);
-				if(err)
+				if(err){
 					printk("Failed to release memory - "
 					       "errno = %d\n", err);
+					*error_out = "Failed to release memory";
+					goto out;
+				}
+				unplugged->pages[unplug_index++] = addr;
 			}
 
 			unplugged_pages_count++;
@@ -470,8 +480,9 @@ static int mem_id(char **str, int *start
 	return 0;
 }
 
-static int mem_remove(int n)
+static int mem_remove(int n, char **error_out)
 {
+	*error_out = "Memory doesn't support the remove operation";
 	return -EBUSY;
 }
 
@@ -542,7 +553,7 @@ static void mconsole_get_config(int (*ge
 void mconsole_config(struct mc_request *req)
 {
 	struct mc_device *dev;
-	char *ptr = req->request.data, *name;
+	char *ptr = req->request.data, *name, *error_string = "";
 	int err;
 
 	ptr += strlen("config");
@@ -559,8 +570,8 @@ void mconsole_config(struct mc_request *
 		ptr++;
 
 	if(*ptr == '='){
-		err = (*dev->config)(name);
-		mconsole_reply(req, "", err, 0);
+		err = (*dev->config)(name, &error_string);
+		mconsole_reply(req, error_string, err, 0);
 	}
 	else mconsole_get_config(dev->get_config, req, name);
 }
@@ -595,13 +606,16 @@ void mconsole_remove(struct mc_request *
 		goto out;
 	}
 
-	err = (*dev->remove)(n);
+	err_msg = NULL;
+	err = (*dev->remove)(n, &err_msg);
 	switch(err){
 	case -ENODEV:
-		err_msg = "Device doesn't exist";
+		if(err_msg == NULL)
+			err_msg = "Device doesn't exist";
 		break;
 	case -EBUSY:
-		err_msg = "Device is currently open";
+		if(err_msg == NULL)
+			err_msg = "Device is currently open";
 		break;
 	default:
 		break;
Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2006-12-29 17:26:54.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and 
+ * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
  * James Leu (jleu@mindspring.net).
  * Copyright (C) 2001 by various other people who didn't put their name here.
  * Licensed under the GPL.
@@ -91,8 +91,8 @@ irqreturn_t uml_net_interrupt(int irq, v
 	spin_lock(&lp->lock);
 	while((err = uml_net_rx(dev)) > 0) ;
 	if(err < 0) {
-		printk(KERN_ERR 
-		       "Device '%s' read returned %d, shutting it down\n", 
+		printk(KERN_ERR
+		       "Device '%s' read returned %d, shutting it down\n",
 		       dev->name, err);
 		/* dev_close can't be called in interrupt context, and takes
 		 * again lp->lock.
@@ -159,7 +159,7 @@ out:
 static int uml_net_close(struct net_device *dev)
 {
 	struct uml_net_private *lp = dev->priv;
-	
+
 	netif_stop_queue(dev);
 
 	free_irq(dev->irq, dev);
@@ -194,7 +194,7 @@ static int uml_net_start_xmit(struct sk_
 
 		/* this is normally done in the interrupt when tx finishes */
 		netif_wake_queue(dev);
-	} 
+	}
 	else if(len == 0){
 		netif_start_queue(dev);
 		lp->stats.tx_dropped++;
@@ -333,7 +333,7 @@ static int eth_configure(int n, void *in
 	struct uml_net_private *lp;
 	int save, err, size;
 
-	size = transport->private_size + sizeof(struct uml_net_private) + 
+	size = transport->private_size + sizeof(struct uml_net_private) +
 		FIELD_SIZEOF(struct uml_net_private, user);
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
@@ -438,7 +438,7 @@ static int eth_configure(int n, void *in
 	lp->tl.function = uml_net_user_timer_expire;
 	memcpy(lp->mac, device->mac, sizeof(lp->mac));
 
-	if (transport->user->init) 
+	if (transport->user->init)
 		(*transport->user->init)(&lp->user, dev);
 
 	set_ether_mac(dev, device->mac);
@@ -463,35 +463,33 @@ static struct uml_net *find_device(int n
 	return(device);
 }
 
-static int eth_parse(char *str, int *index_out, char **str_out)
+static int eth_parse(char *str, int *index_out, char **str_out,
+		     char **error_out)
 {
 	char *end;
-	int n;
+	int n, err = -EINVAL;;
 
 	n = simple_strtoul(str, &end, 0);
 	if(end == str){
-		printk(KERN_ERR "eth_setup: Failed to parse '%s'\n", str);
-		return(1);
-	}
-	if(n < 0){
-		printk(KERN_ERR "eth_setup: device %d is negative\n", n);
-		return(1);
+		*error_out = "Bad device number";
+		return err;
 	}
+
 	str = end;
 	if(*str != '='){
-		printk(KERN_ERR 
-		       "eth_setup: expected '=' after device number\n");
-		return(1);
+		*error_out = "Expected '=' after device number";
+		return err;
 	}
+
 	str++;
 	if(find_device(n)){
-		printk(KERN_ERR "eth_setup: Device %d already configured\n",
-		       n);
-		return(1);
+		*error_out = "Device already configured";
+		return err;
 	}
-	if(index_out) *index_out = n;
+
+	*index_out = n;
 	*str_out = str;
-	return(0);
+	return 0;
 }
 
 struct eth_init {
@@ -581,11 +579,15 @@ static int eth_setup_common(char *str, i
 static int eth_setup(char *str)
 {
 	struct eth_init *new;
+	char *error;
 	int n, err;
 
-	err = eth_parse(str, &n, &str);
-	if(err)
+	err = eth_parse(str, &n, &str, &error);
+	if(err){
+		printk(KERN_ERR "eth_setup - Couldn't parse '%s' : %s\n",
+		       str, error);
 		return 1;
+	}
 
 	new = alloc_bootmem(sizeof(*new));
 	if (new == NULL){
@@ -619,26 +621,30 @@ static int eth_init(void)
 		if(eth_setup_common(eth->init, eth->index))
 			list_del(&eth->list);
 	}
-	
+
 	return(1);
 }
 __initcall(eth_init);
 #endif
 
-static int net_config(char *str)
+static int net_config(char *str, char **error_out)
 {
 	int n, err;
 
-	err = eth_parse(str, &n, &str);
-	if(err) return(err);
+	err = eth_parse(str, &n, &str, error_out);
+	if(err)
+		return err;
 
+	/* This string is broken up and the pieces used by the underlying
+	 * driver.  So, it is freed only if eth_setup_common fails.
+	 */
 	str = kstrdup(str, GFP_KERNEL);
 	if(str == NULL){
-		printk(KERN_ERR "net_config failed to strdup string\n");
-		return(-1);
+	        *error_out = "net_config failed to strdup string";
+		return -ENOMEM;
 	}
 	err = !eth_setup_common(str, n);
-	if(err) 
+	if(err)
 		kfree(str);
 	return(err);
 }
@@ -658,7 +664,7 @@ static int net_id(char **str, int *start
         return n;
 }
 
-static int net_remove(int n)
+static int net_remove(int n, char **error_out)
 {
 	struct uml_net *device;
 	struct net_device *dev;
@@ -727,7 +733,7 @@ struct notifier_block uml_inetaddr_notif
 static int uml_net_init(void)
 {
 	struct list_head *ele;
-	struct uml_net_private *lp;	
+	struct uml_net_private *lp;
 	struct in_device *ip;
 	struct in_ifaddr *in;
 
@@ -747,7 +753,7 @@ static int uml_net_init(void)
 			uml_inetaddr_event(NULL, NETDEV_UP, in);
 			in = in->ifa_next;
 		}
-	}	
+	}
 
 	return(0);
 }
@@ -783,8 +789,8 @@ struct sk_buff *ether_adjust_skb(struct 
 	return(skb);
 }
 
-void iter_addresses(void *d, void (*cb)(unsigned char *, unsigned char *, 
-					void *), 
+void iter_addresses(void *d, void (*cb)(unsigned char *, unsigned char *,
+					void *),
 		    void *arg)
 {
 	struct net_device *dev = d;
@@ -809,11 +815,11 @@ int dev_netmask(void *d, void *m)
 	struct in_ifaddr *in;
 	__be32 *mask_out = m;
 
-	if(ip == NULL) 
+	if(ip == NULL)
 		return(1);
 
 	in = ip->ifa_list;
-	if(in == NULL) 
+	if(in == NULL)
 		return(1);
 
 	*mask_out = in->ifa_mask;
@@ -835,7 +841,7 @@ void free_output_buffer(void *buffer)
 	free_pages((unsigned long) buffer, 0);
 }
 
-int tap_setup_common(char *str, char *type, char **dev_name, char **mac_out, 
+int tap_setup_common(char *str, char *type, char **dev_name, char **mac_out,
 		     char **gate_addr)
 {
 	char *remain;
@@ -854,14 +860,3 @@ unsigned short eth_protocol(struct sk_bu
 {
 	return(eth_type_trans(skb, skb->dev));
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.18-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ubd_kern.c	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/ubd_kern.c	2006-12-29 17:38:56.000000000 -0500
@@ -286,7 +286,7 @@ static int parse_unit(char **ptr)
  * otherwise, the str pointer is used (and owned) inside ubd_devs array, so it
  * should not be freed on exit.
  */
-static int ubd_setup_common(char *str, int *index_out)
+static int ubd_setup_common(char *str, int *index_out, char **error_out)
 {
 	struct ubd *ubd_dev;
 	struct openflags flags = global_openflags;
@@ -302,56 +302,54 @@ static int ubd_setup_common(char *str, i
 		str++;
 		if(!strcmp(str, "sync")){
 			global_openflags = of_sync(global_openflags);
-			return(0);
+			return 0;
 		}
 		major = simple_strtoul(str, &end, 0);
 		if((*end != '\0') || (end == str)){
-			printk(KERN_ERR
-			       "ubd_setup : didn't parse major number\n");
-			return(1);
+			*error_out = "Didn't parse major number";
+			return -EINVAL;
 		}
 
-		err = 1;
- 		mutex_lock(&ubd_lock);
- 		if(fake_major != MAJOR_NR){
- 			printk(KERN_ERR "Can't assign a fake major twice\n");
- 			goto out1;
- 		}
+		err = -EINVAL;
+		mutex_lock(&ubd_lock);
+		if(fake_major != MAJOR_NR){
+			*error_out = "Can't assign a fake major twice";
+			goto out1;
+		}
 
- 		fake_major = major;
+		fake_major = major;
 
 		printk(KERN_INFO "Setting extra ubd major number to %d\n",
 		       major);
- 		err = 0;
- 	out1:
- 		mutex_unlock(&ubd_lock);
-		return(err);
+		err = 0;
+	out1:
+		mutex_unlock(&ubd_lock);
+		return err;
 	}
 
 	n = parse_unit(&str);
 	if(n < 0){
-		printk(KERN_ERR "ubd_setup : couldn't parse unit number "
-		       "'%s'\n", str);
-		return(1);
+		*error_out = "Couldn't parse device number";
+		return -EINVAL;
 	}
 	if(n >= MAX_DEV){
-		printk(KERN_ERR "ubd_setup : index %d out of range "
-		       "(%d devices, from 0 to %d)\n", n, MAX_DEV, MAX_DEV - 1);
-		return(1);
+		*error_out = "Device number out of range";
+		return 1;
 	}
 
-	err = 1;
+	err = -EBUSY;
 	mutex_lock(&ubd_lock);
 
 	ubd_dev = &ubd_devs[n];
 	if(ubd_dev->file != NULL){
-		printk(KERN_ERR "ubd_setup : device already configured\n");
+		*error_out = "Device is already configured";
 		goto out;
 	}
 
 	if (index_out)
 		*index_out = n;
 
+	err = -EINVAL;
 	for (i = 0; i < sizeof("rscd="); i++) {
 		switch (*str) {
 		case 'r':
@@ -370,47 +368,54 @@ static int ubd_setup_common(char *str, i
 			str++;
 			goto break_loop;
 		default:
-			printk(KERN_ERR "ubd_setup : Expected '=' or flag letter (r, s, c, or d)\n");
+			*error_out = "Expected '=' or flag letter "
+				"(r, s, c, or d)";
 			goto out;
 		}
 		str++;
 	}
 
-        if (*str == '=')
-		printk(KERN_ERR "ubd_setup : Too many flags specified\n");
-        else
-		printk(KERN_ERR "ubd_setup : Expected '='\n");
+	if (*str == '=')
+		*error_out = "Too many flags specified";
+	else
+		*error_out = "Missing '='";
 	goto out;
 
 break_loop:
-	err = 0;
 	backing_file = strchr(str, ',');
 
-	if (!backing_file) {
+	if (backing_file == NULL)
 		backing_file = strchr(str, ':');
-	}
 
-	if(backing_file){
-		if(ubd_dev->no_cow)
-			printk(KERN_ERR "Can't specify both 'd' and a "
-			       "cow file\n");
+	if(backing_file != NULL){
+		if(ubd_dev->no_cow){
+			*error_out = "Can't specify both 'd' and a cow file";
+			goto out;
+		}
 		else {
 			*backing_file = '\0';
 			backing_file++;
 		}
 	}
+	err = 0;
 	ubd_dev->file = str;
 	ubd_dev->cow.file = backing_file;
 	ubd_dev->boot_openflags = flags;
 out:
 	mutex_unlock(&ubd_lock);
-	return(err);
+	return err;
 }
 
 static int ubd_setup(char *str)
 {
-	ubd_setup_common(str, NULL);
-	return(1);
+	char *error;
+	int err;
+
+	err = ubd_setup_common(str, NULL, &error);
+	if(err)
+		printk(KERN_ERR "Failed to initialize device with \"%s\" : "
+		       "%s\n", str, error);
+	return 1;
 }
 
 __setup("ubd", ubd_setup);
@@ -422,7 +427,7 @@ __uml_help(ubd_setup,
 "    use either a ':' or a ',': the first one allows writing things like;\n"
 "	ubd0=~/Uml/root_cow:~/Uml/root_backing_file\n"
 "    while with a ',' the shell would not expand the 2nd '~'.\n"
-"    When using only one filename, UML will detect whether to thread it like\n"
+"    When using only one filename, UML will detect whether to treat it like\n"
 "    a COW file or a backing file. To override this detection, add the 'd'\n"
 "    flag:\n"
 "	ubd0d=BackingFile\n"
@@ -668,18 +673,19 @@ static int ubd_disk_register(int major, 
 
 #define ROUND_BLOCK(n) ((n + ((1 << 9) - 1)) & (-1 << 9))
 
-static int ubd_add(int n)
+static int ubd_add(int n, char **error_out)
 {
 	struct ubd *ubd_dev = &ubd_devs[n];
-	int err;
+	int err = 0;
 
-	err = -ENODEV;
 	if(ubd_dev->file == NULL)
 		goto out;
 
 	err = ubd_file_size(ubd_dev, &ubd_dev->size);
-	if(err < 0)
+	if(err < 0){
+		*error_out = "Couldn't determine size of device's file";
 		goto out;
+	}
 
 	ubd_dev->size = ROUND_BLOCK(ubd_dev->size);
 
@@ -701,28 +707,31 @@ out:
 	return err;
 }
 
-static int ubd_config(char *str)
+static int ubd_config(char *str, char **error_out)
 {
 	int n, ret;
 
+	/* This string is possibly broken up and stored, so it's only
+	 * freed if ubd_setup_common fails, or if only general options
+	 * were set.
+	 */
 	str = kstrdup(str, GFP_KERNEL);
 	if (str == NULL) {
-		printk(KERN_ERR "ubd_config failed to strdup string\n");
-		ret = 1;
-		goto out;
+		*error_out = "Failed to allocate memory";
+		return -ENOMEM;
 	}
-	ret = ubd_setup_common(str, &n);
-	if (ret) {
-		ret = -1;
+
+	ret = ubd_setup_common(str, &n, error_out);
+	if (ret)
 		goto err_free;
-	}
+
 	if (n == -1) {
 		ret = 0;
 		goto err_free;
 	}
 
  	mutex_lock(&ubd_lock);
-	ret = ubd_add(n);
+	ret = ubd_add(n, error_out);
 	if (ret)
 		ubd_devs[n].file = NULL;
  	mutex_unlock(&ubd_lock);
@@ -777,7 +786,7 @@ static int ubd_id(char **str, int *start
         return n;
 }
 
-static int ubd_remove(int n)
+static int ubd_remove(int n, char **error_out)
 {
 	struct ubd *ubd_dev;
 	int err = -ENODEV;
@@ -815,7 +824,9 @@ out:
 	return err;
 }
 
-/* All these are called by mconsole in process context and without ubd-specific locks. */
+/* All these are called by mconsole in process context and without
+ * ubd-specific locks.
+ */
 static struct mc_device ubd_mc = {
 	.name		= "ubd",
 	.config		= ubd_config,
@@ -851,7 +862,8 @@ static struct platform_driver ubd_driver
 
 static int __init ubd_init(void)
 {
-        int i;
+	char *error;
+	int i, err;
 
 	if (register_blkdev(MAJOR_NR, "ubd"))
 		return -1;
@@ -870,8 +882,12 @@ static int __init ubd_init(void)
 			return -1;
 	}
 	platform_driver_register(&ubd_driver);
-	for (i = 0; i < MAX_DEV; i++)
-		ubd_add(i);
+	for (i = 0; i < MAX_DEV; i++){
+		err = ubd_add(i, &error);
+		if(err)
+			printk(KERN_ERR "Failed to initialize ubd device %d :"
+			       "%s\n", i, error);
+	}
 	return 0;
 }
 
Index: linux-2.6.18-mm/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/chan_kern.c	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/chan_kern.c	2006-12-29 17:26:54.000000000 -0500
@@ -19,44 +19,11 @@
 #include "line.h"
 #include "os.h"
 
-/* XXX: could well be moved to somewhere else, if needed. */
-static int my_printf(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
-
-static int my_printf(const char * fmt, ...)
-{
-	/* Yes, can be called on atomic context.*/
-	char *buf = kmalloc(4096, GFP_ATOMIC);
-	va_list args;
-	int r;
-
-	if (!buf) {
-		/* We print directly fmt.
-		 * Yes, yes, yes, feel free to complain. */
-		r = strlen(fmt);
-	} else {
-		va_start(args, fmt);
-		r = vsprintf(buf, fmt, args);
-		va_end(args);
-		fmt = buf;
-	}
-
-	if (r)
-		r = os_write_file(1, fmt, r);
-	return r;
-
-}
-
 #ifdef CONFIG_NOCONFIG_CHAN
-/* Despite its name, there's no added trailing newline. */
-static int my_puts(const char * buf)
-{
-	return os_write_file(1, buf, strlen(buf));
-}
-
-static void *not_configged_init(char *str, int device, struct chan_opts *opts)
+static void *not_configged_init(char *str, int device,
+				const struct chan_opts *opts)
 {
-	my_puts("Using a channel type which is configured out of "
+	printk("Using a channel type which is configured out of "
 	       "UML\n");
 	return NULL;
 }
@@ -64,34 +31,34 @@ static void *not_configged_init(char *st
 static int not_configged_open(int input, int output, int primary, void *data,
 			      char **dev_out)
 {
-	my_puts("Using a channel type which is configured out of "
+	printk("Using a channel type which is configured out of "
 	       "UML\n");
 	return -ENODEV;
 }
 
 static void not_configged_close(int fd, void *data)
 {
-	my_puts("Using a channel type which is configured out of "
+	printk("Using a channel type which is configured out of "
 	       "UML\n");
 }
 
 static int not_configged_read(int fd, char *c_out, void *data)
 {
-	my_puts("Using a channel type which is configured out of "
+	printk("Using a channel type which is configured out of "
 	       "UML\n");
 	return -EIO;
 }
 
 static int not_configged_write(int fd, const char *buf, int len, void *data)
 {
-	my_puts("Using a channel type which is configured out of "
+	printk("Using a channel type which is configured out of "
 	       "UML\n");
 	return -EIO;
 }
 
 static int not_configged_console_write(int fd, const char *buf, int len)
 {
-	my_puts("Using a channel type which is configured out of "
+	printk("Using a channel type which is configured out of "
 	       "UML\n");
 	return -EIO;
 }
@@ -99,14 +66,14 @@ static int not_configged_console_write(i
 static int not_configged_window_size(int fd, void *data, unsigned short *rows,
 				     unsigned short *cols)
 {
-	my_puts("Using a channel type which is configured out of "
+	printk("Using a channel type which is configured out of "
 	       "UML\n");
 	return -ENODEV;
 }
 
 static void not_configged_free(void *data)
 {
-	my_puts("Using a channel type which is configured out of "
+	printk("Using a channel type which is configured out of "
 	       "UML\n");
 }
 
@@ -534,7 +501,7 @@ static const struct chan_type chan_table
 };
 
 static struct chan *parse_chan(struct line *line, char *str, int device,
-			       const struct chan_opts *opts)
+			       const struct chan_opts *opts, char **error_out)
 {
 	const struct chan_type *entry;
 	const struct chan_ops *ops;
@@ -553,19 +520,21 @@ static struct chan *parse_chan(struct li
 		}
 	}
 	if(ops == NULL){
-		my_printf("parse_chan couldn't parse \"%s\"\n",
-		       str);
+		*error_out = "No match for configured backends";
 		return NULL;
 	}
-	if(ops->init == NULL)
-		return NULL;
+
 	data = (*ops->init)(str, device, opts);
-	if(data == NULL)
+	if(data == NULL){
+		*error_out = "Configuration failed";
 		return NULL;
+	}
 
 	chan = kmalloc(sizeof(*chan), GFP_ATOMIC);
-	if(chan == NULL)
+	if(chan == NULL){
+		*error_out = "Memory allocation failed";
 		return NULL;
+	}
 	*chan = ((struct chan) { .list	 	= LIST_HEAD_INIT(chan->list),
 				 .free_list 	=
 				 	LIST_HEAD_INIT(chan->free_list),
@@ -582,7 +551,7 @@ static struct chan *parse_chan(struct li
 }
 
 int parse_chan_pair(char *str, struct line *line, int device,
-		    const struct chan_opts *opts)
+		    const struct chan_opts *opts, char **error_out)
 {
 	struct list_head *chans = &line->chan_list;
 	struct chan *new, *chan;
@@ -599,14 +568,14 @@ int parse_chan_pair(char *str, struct li
 		in = str;
 		*out = '\0';
 		out++;
-		new = parse_chan(line, in, device, opts);
+		new = parse_chan(line, in, device, opts, error_out);
 		if(new == NULL)
 			return -1;
 
 		new->input = 1;
 		list_add(&new->list, chans);
 
-		new = parse_chan(line, out, device, opts);
+		new = parse_chan(line, out, device, opts, error_out);
 		if(new == NULL)
 			return -1;
 
@@ -614,7 +583,7 @@ int parse_chan_pair(char *str, struct li
 		new->output = 1;
 	}
 	else {
-		new = parse_chan(line, str, device, opts);
+		new = parse_chan(line, str, device, opts, error_out);
 		if(new == NULL)
 			return -1;
 
Index: linux-2.6.18-mm/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ssl.c	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/ssl.c	2006-12-29 17:26:54.000000000 -0500
@@ -46,9 +46,9 @@ static struct chan_opts opts = {
 	.in_kernel 	= 1,
 };
 
-static int ssl_config(char *str);
+static int ssl_config(char *str, char **error_out);
 static int ssl_get_config(char *dev, char *str, int size, char **error_out);
-static int ssl_remove(int n);
+static int ssl_remove(int n, char **error_out);
 
 static struct line_driver driver = {
 	.name 			= "UML serial line",
@@ -80,9 +80,10 @@ static struct line serial_lines[NR_PORTS
 
 static struct lines lines = LINES_INIT(NR_PORTS);
 
-static int ssl_config(char *str)
+static int ssl_config(char *str, char **error_out)
 {
-	return line_config(serial_lines, ARRAY_SIZE(serial_lines), str, &opts);
+	return line_config(serial_lines, ARRAY_SIZE(serial_lines), str, &opts,
+			   error_out);
 }
 
 static int ssl_get_config(char *dev, char *str, int size, char **error_out)
@@ -91,9 +92,10 @@ static int ssl_get_config(char *dev, cha
 			       size, error_out);
 }
 
-static int ssl_remove(int n)
+static int ssl_remove(int n, char **error_out)
 {
-	return line_remove(serial_lines, ARRAY_SIZE(serial_lines), n);
+	return line_remove(serial_lines, ARRAY_SIZE(serial_lines), n,
+			   error_out);
 }
 
 static int ssl_open(struct tty_struct *tty, struct file *filp)
@@ -212,7 +214,15 @@ __uml_exitcall(ssl_exit);
 
 static int ssl_chan_setup(char *str)
 {
-	return line_setup(serial_lines, ARRAY_SIZE(serial_lines), str);
+	char *error;
+	int ret;
+
+	ret = line_setup(serial_lines, ARRAY_SIZE(serial_lines), str, &error);
+	if(ret < 0)
+		printk(KERN_ERR "Failed to set up serial line with "
+		       "configuration string \"%s\" : %s\n", str, error);
+
+	return 1;
 }
 
 __setup("ssl", ssl_chan_setup);
Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2006-12-29 17:26:54.000000000 -0500
@@ -52,9 +52,9 @@ static struct chan_opts opts = {
 	.in_kernel 	= 1,
 };
 
-static int con_config(char *str);
+static int con_config(char *str, char **error_out);
 static int con_get_config(char *dev, char *str, int size, char **error_out);
-static int con_remove(int n);
+static int con_remove(int n, char **con_remove);
 
 static struct line_driver driver = {
 	.name 			= "UML console",
@@ -87,9 +87,9 @@ static struct line vts[MAX_TTYS] = { LIN
 				     [ 1 ... MAX_TTYS - 1 ] =
 				     LINE_INIT(CONFIG_CON_CHAN, &driver) };
 
-static int con_config(char *str)
+static int con_config(char *str, char **error_out)
 {
-	return line_config(vts, ARRAY_SIZE(vts), str, &opts);
+	return line_config(vts, ARRAY_SIZE(vts), str, &opts, error_out);
 }
 
 static int con_get_config(char *dev, char *str, int size, char **error_out)
@@ -97,9 +97,9 @@ static int con_get_config(char *dev, cha
 	return line_get_config(dev, vts, ARRAY_SIZE(vts), str, size, error_out);
 }
 
-static int con_remove(int n)
+static int con_remove(int n, char **error_out)
 {
-	return line_remove(vts, ARRAY_SIZE(vts), n);
+	return line_remove(vts, ARRAY_SIZE(vts), n, error_out);
 }
 
 static int con_open(struct tty_struct *tty, struct file *filp)
@@ -192,7 +192,15 @@ __uml_exitcall(console_exit);
 
 static int console_chan_setup(char *str)
 {
-	return line_setup(vts, ARRAY_SIZE(vts), str);
+	char *error;
+	int ret;
+
+	ret = line_setup(vts, ARRAY_SIZE(vts), str, &error);
+	if(ret < 0)
+		printk(KERN_ERR "Failed to set up console with "
+		       "configuration string \"%s\" : %s\n", str, error);
+
+	return 1;
 }
 __setup("con", console_chan_setup);
 __channel_help(console_chan_setup, "con");
Index: linux-2.6.18-mm/arch/um/include/chan_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/chan_kern.h	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/chan_kern.h	2006-12-29 17:26:54.000000000 -0500
@@ -30,7 +30,7 @@ struct chan {
 extern void chan_interrupt(struct list_head *chans, struct delayed_work *task,
 			   struct tty_struct *tty, int irq);
 extern int parse_chan_pair(char *str, struct line *line, int device,
-			   const struct chan_opts *opts);
+			   const struct chan_opts *opts, char **error_out);
 extern int open_chan(struct list_head *chans);
 extern int write_chan(struct list_head *chans, const char *buf, int len,
 			     int write_irq);
Index: linux-2.6.18-mm/arch/um/include/line.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/line.h	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/line.h	2006-12-29 17:26:54.000000000 -0500
@@ -76,7 +76,7 @@ struct lines {
 extern void line_close(struct tty_struct *tty, struct file * filp);
 extern int line_open(struct line *lines, struct tty_struct *tty);
 extern int line_setup(struct line *lines, unsigned int sizeof_lines,
-		      char *init);
+		      char *init, char **error_out);
 extern int line_write(struct tty_struct *tty, const unsigned char *buf,
 		      int len);
 extern void line_put_char(struct tty_struct *tty, unsigned char ch);
@@ -102,9 +102,11 @@ extern void lines_init(struct line *line
 extern void close_lines(struct line *lines, int nlines);
 
 extern int line_config(struct line *lines, unsigned int sizeof_lines,
-		       char *str, const struct chan_opts *opts);
+		       char *str, const struct chan_opts *opts,
+		       char **error_out);
 extern int line_id(char **str, int *start_out, int *end_out);
-extern int line_remove(struct line *lines, unsigned int sizeof_lines, int n);
+extern int line_remove(struct line *lines, unsigned int sizeof_lines, int n,
+		       char **error_out);
 extern int line_get_config(char *dev, struct line *lines,
 			   unsigned int sizeof_lines, char *str,
 			   int size, char **error_out);
Index: linux-2.6.18-mm/arch/um/include/mconsole_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/mconsole_kern.h	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/mconsole_kern.h	2006-12-29 17:26:54.000000000 -0500
@@ -18,10 +18,10 @@ struct mconsole_entry {
 struct mc_device {
 	struct list_head list;
 	char *name;
-	int (*config)(char *);
+	int (*config)(char *, char **);
 	int (*get_config)(char *, char *, int, char **);
         int (*id)(char **, int *, int *);
-	int (*remove)(int);
+	int (*remove)(int, char **);
 };
 
 #define CONFIG_CHUNK(str, size, current, chunk, end) \
@@ -50,14 +50,3 @@ static inline void mconsole_register_dev
 #endif
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.18-mm/arch/um/kernel/tt/gdb.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/tt/gdb.c	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/tt/gdb.c	2006-12-29 17:26:54.000000000 -0500
@@ -139,7 +139,7 @@ static void config_gdb_cb(void *arg)
 	init_proxy(debugger_pid, 0, 0);
 }
 
-int gdb_config(char *str)
+int gdb_config(char *str, char **error_out)
 {
 	struct gdb_data data;
 
@@ -154,7 +154,7 @@ void remove_gdb_cb(void *unused)
 	exit_debugger_cb(NULL);
 }
 
-int gdb_remove(int unused)
+int gdb_remove(int unused, char **error_out)
 {
 	initial_thread_cb(remove_gdb_cb, NULL);
         return 0;
Index: linux-2.6.18-mm/arch/um/kernel/tt/gdb_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/tt/gdb_kern.c	2006-12-29 17:26:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/tt/gdb_kern.c	2006-12-29 17:26:54.000000000 -0500
@@ -8,8 +8,8 @@
 
 #ifdef CONFIG_MCONSOLE
 
-extern int gdb_config(char *str);
-extern int gdb_remove(int n);
+extern int gdb_config(char *str, char **error_out);
+extern int gdb_remove(int n, char **error_out);
 
 static struct mc_device gdb_mc = {
 	.name		= "gdb",

