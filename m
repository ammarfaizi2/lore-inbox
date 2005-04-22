Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVDVDnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVDVDnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 23:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVDVDnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 23:43:53 -0400
Received: from peabody.ximian.com ([130.57.169.10]:35819 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261933AbVDVDni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 23:43:38 -0400
Subject: [patch 2/2] kstrdup: replace a few
From: Robert Love <rml@novell.com>
To: Rusty Russell <rusty@rustcorp.com.au>, Mr Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 21 Apr 2005 23:44:30 -0400
Message-Id: <1114141470.6973.90.camel@jenny.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Rusty and I's LCA kernel tutorial again brought up kstrdup().  Let's
> close this never ending saga and provide a standard kernel
> implementation.

Convert a few existing implementations, with a nice net loss of 50
lines.  Still way more to go.

Best,

	Robert Love


Convert a bunch of strdup() implementations and their callers to the new
kstrdup().  A few remain, for example see sound/core, and there are tons of
open coded strdup()'s around.  Sigh.  But this is a start.

By: Robert Love and Rusty Russell.

Signed-off-by: Robert Love <rml@novell.com>

 arch/um/kernel/process_kern.c |    8 ++------
 drivers/md/dm-ioctl.c         |   17 +++--------------
 drivers/parport/probe.c       |   18 +++++-------------
 include/linux/netdevice.h     |    4 ----
 net/core/neighbour.c          |    2 +-
 net/core/sysctl_net_core.c    |   15 ---------------
 net/ipv4/devinet.c            |    2 +-
 net/ipv6/addrconf.c           |    2 +-
 net/sunrpc/svcauth_unix.c     |   11 ++---------
 9 files changed, 15 insertions(+), 64 deletions(-)

diff -urN linux-2.6.12-rc3/arch/um/kernel/process_kern.c linux/arch/um/kernel/process_kern.c
--- linux-2.6.12-rc3/arch/um/kernel/process_kern.c	2005-04-20 22:47:00.000000000 -0400
+++ linux/arch/um/kernel/process_kern.c	2005-04-21 21:51:38.000000000 -0400
@@ -8,6 +8,7 @@
 #include "linux/kernel.h"
 #include "linux/sched.h"
 #include "linux/interrupt.h"
+#include "linux/string.h"
 #include "linux/mm.h"
 #include "linux/slab.h"
 #include "linux/utsname.h"
@@ -356,12 +357,7 @@
 
 char *uml_strdup(char *string)
 {
-	char *new;
-
-	new = kmalloc(strlen(string) + 1, GFP_KERNEL);
-	if(new == NULL) return(NULL);
-	strcpy(new, string);
-	return(new);
+	return kstrdup(string, GFP_KERNEL);
 }
 
 void *get_init_task(void)
diff -urN linux-2.6.12-rc3/drivers/md/dm-ioctl.c linux/drivers/md/dm-ioctl.c
--- linux-2.6.12-rc3/drivers/md/dm-ioctl.c	2005-03-02 02:37:51.000000000 -0500
+++ linux/drivers/md/dm-ioctl.c	2005-04-21 21:46:15.000000000 -0400
@@ -119,17 +119,6 @@
 	return NULL;
 }
 
-/*-----------------------------------------------------------------
- * Inserting, removing and renaming a device.
- *---------------------------------------------------------------*/
-static inline char *kstrdup(const char *str)
-{
-	char *r = kmalloc(strlen(str) + 1, GFP_KERNEL);
-	if (r)
-		strcpy(r, str);
-	return r;
-}
-
 static struct hash_cell *alloc_cell(const char *name, const char *uuid,
 				    struct mapped_device *md)
 {
@@ -139,7 +128,7 @@
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name);
+	hc->name = kstrdup(name, GFP_KERNEL);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -149,7 +138,7 @@
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid);
+		hc->uuid = kstrdup(uuid, GFP_KERNEL);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -273,7 +262,7 @@
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new);
+	new_name = kstrdup(new, GFP_KERNEL);
 	if (!new_name)
 		return -ENOMEM;
 
diff -urN linux-2.6.12-rc3/drivers/parport/probe.c linux/drivers/parport/probe.c
--- linux-2.6.12-rc3/drivers/parport/probe.c	2005-04-20 22:47:04.000000000 -0400
+++ linux/drivers/parport/probe.c	2005-04-21 21:45:39.000000000 -0400
@@ -48,14 +48,6 @@
 	printk("\n");
 }
 
-static char *strdup(char *str)
-{
-	int n = strlen(str)+1;
-	char *s = kmalloc(n, GFP_KERNEL);
-	if (!s) return NULL;
-	return strcpy(s, str);
-}
-
 static void parse_data(struct parport *port, int device, char *str)
 {
 	char *txt = kmalloc(strlen(str)+1, GFP_KERNEL);
@@ -88,16 +80,16 @@
 			if (!strcmp(p, "MFG") || !strcmp(p, "MANUFACTURER")) {
 				if (info->mfr)
 					kfree (info->mfr);
-				info->mfr = strdup(sep);
+				info->mfr = kstrdup(sep, GFP_KERNEL);
 			} else if (!strcmp(p, "MDL") || !strcmp(p, "MODEL")) {
 				if (info->model)
 					kfree (info->model);
-				info->model = strdup(sep);
+				info->model = kstrdup(sep, GFP_KERNEL);
 			} else if (!strcmp(p, "CLS") || !strcmp(p, "CLASS")) {
 				int i;
 				if (info->class_name)
 					kfree (info->class_name);
-				info->class_name = strdup(sep);
+				info->class_name = kstrdup(sep, GFP_KERNEL);
 				for (u = sep; *u; u++)
 					*u = toupper(*u);
 				for (i = 0; classes[i].token; i++) {
@@ -112,7 +104,7 @@
 				   !strcmp(p, "COMMAND SET")) {
 				if (info->cmdset)
 					kfree (info->cmdset);
-				info->cmdset = strdup(sep);
+				info->cmdset = kstrdup(sep, GFP_KERNEL);
 				/* if it speaks printer language, it's
 				   probably a printer */
 				if (strstr(sep, "PJL") || strstr(sep, "PCL"))
@@ -120,7 +112,7 @@
 			} else if (!strcmp(p, "DES") || !strcmp(p, "DESCRIPTION")) {
 				if (info->description)
 					kfree (info->description);
-				info->description = strdup(sep);
+				info->description = kstrdup(sep, GFP_KERNEL);
 			}
 		}
 	rock_on:
diff -urN linux-2.6.12-rc3/include/linux/netdevice.h linux/include/linux/netdevice.h
--- linux-2.6.12-rc3/include/linux/netdevice.h	2005-04-20 22:47:07.000000000 -0400
+++ linux/include/linux/netdevice.h	2005-04-21 21:39:20.000000000 -0400
@@ -924,10 +924,6 @@
 extern void		net_enable_timestamp(void);
 extern void		net_disable_timestamp(void);
 
-#ifdef CONFIG_SYSCTL
-extern char *net_sysctl_strdup(const char *s);
-#endif
-
 #endif /* __KERNEL__ */
 
 #endif	/* _LINUX_DEV_H */
diff -urN linux-2.6.12-rc3/net/core/neighbour.c linux/net/core/neighbour.c
--- linux-2.6.12-rc3/net/core/neighbour.c	2005-04-20 22:47:08.000000000 -0400
+++ linux/net/core/neighbour.c	2005-04-21 21:43:58.000000000 -0400
@@ -2281,7 +2281,7 @@
 		t->neigh_vars[17].extra1 = dev;
 	}
 
-	dev_name = net_sysctl_strdup(dev_name_source);
+	dev_name = kstrdup(dev_name_source, GFP_KERNEL);
 	if (!dev_name) {
 		err = -ENOBUFS;
 		goto free;
diff -urN linux-2.6.12-rc3/net/core/sysctl_net_core.c linux/net/core/sysctl_net_core.c
--- linux-2.6.12-rc3/net/core/sysctl_net_core.c	2005-03-02 02:38:03.000000000 -0500
+++ linux/net/core/sysctl_net_core.c	2005-04-21 21:38:39.000000000 -0400
@@ -35,19 +35,6 @@
 extern char sysctl_divert_version[];
 #endif /* CONFIG_NET_DIVERT */
 
-/*
- * This strdup() is used for creating copies of network 
- * device names to be handed over to sysctl.
- */
- 
-char *net_sysctl_strdup(const char *s)
-{
-	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
-	if (rv)
-		strcpy(rv, s);
-	return rv;
-}
-
 ctl_table core_table[] = {
 #ifdef CONFIG_NET
 	{
@@ -177,6 +164,4 @@
 	{ .ctl_name = 0 }
 };
 
-EXPORT_SYMBOL(net_sysctl_strdup);
-
 #endif
diff -urN linux-2.6.12-rc3/net/ipv4/devinet.c linux/net/ipv4/devinet.c
--- linux-2.6.12-rc3/net/ipv4/devinet.c	2005-04-20 22:47:08.000000000 -0400
+++ linux/net/ipv4/devinet.c	2005-04-21 21:41:01.000000000 -0400
@@ -1447,7 +1447,7 @@
 	 * by sysctl and we wouldn't want anyone to change it under our feet
 	 * (see SIOCSIFNAME).
 	 */	
-	dev_name = net_sysctl_strdup(dev_name);
+	dev_name = kstrdup(dev_name, GFP_KERNEL);
 	if (!dev_name)
 	    goto free;
 
diff -urN linux-2.6.12-rc3/net/ipv6/addrconf.c linux/net/ipv6/addrconf.c
--- linux-2.6.12-rc3/net/ipv6/addrconf.c	2005-04-20 22:47:08.000000000 -0400
+++ linux/net/ipv6/addrconf.c	2005-04-21 21:40:52.000000000 -0400
@@ -3439,7 +3439,7 @@
 	 * by sysctl and we wouldn't want anyone to change it under our feet
 	 * (see SIOCSIFNAME).
 	 */	
-	dev_name = net_sysctl_strdup(dev_name);
+	dev_name = kstrdup(dev_name, GFP_KERNEL);
 	if (!dev_name)
 	    goto free;
 
diff -urN linux-2.6.12-rc3/net/sunrpc/svcauth_unix.c linux/net/sunrpc/svcauth_unix.c
--- linux-2.6.12-rc3/net/sunrpc/svcauth_unix.c	2005-04-20 22:47:08.000000000 -0400
+++ linux/net/sunrpc/svcauth_unix.c	2005-04-21 21:38:09.000000000 -0400
@@ -1,6 +1,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/string.h>
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svcsock.h>
@@ -20,14 +21,6 @@
  */
 
 
-static char *strdup(char *s)
-{
-	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
-	if (rv)
-		strcpy(rv, s);
-	return rv;
-}
-
 struct unix_domain {
 	struct auth_domain	h;
 	int	addr_changes;
@@ -55,7 +48,7 @@
 	if (new == NULL)
 		return NULL;
 	cache_init(&new->h.h);
-	new->h.name = strdup(name);
+	new->h.name = kstrdup(name, GFP_KERNEL);
 	new->h.flavour = RPC_AUTH_UNIX;
 	new->addr_changes = 0;
 	new->h.h.expiry_time = NEVER;


