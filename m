Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVDDTs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVDDTs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVDDTs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:48:26 -0400
Received: from [195.23.16.24] ([195.23.16.24]:47794 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261357AbVDDTpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:45:36 -0400
Message-ID: <42519911.508@grupopie.com>
Date: Mon, 04 Apr 2005 20:44:17 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] create a kstrdup library function
Content-Type: multipart/mixed;
 boundary="------------050904070609010907050009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050904070609010907050009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

This patch creates a new kstrdup library function and changes the 
"local" implementations in several places to use this function.

This is just a cleanup to allow reusing the strdup code, and to prevent 
bugs in future duplications of strdup.

Most of the changes come from the sound and net subsystems. The sound 
part had already been acknowledged by Takashi Iwai and the net part by 
David S. Miller.

I left UML alone for now because I would need more time to read the code 
carefully before making changes there.


Signed-off-by: Paulo Marques <pmarques@grupopie.com>

  drivers/md/dm-ioctl.c      |   14 +++-----------
  drivers/parport/probe.c    |   18 +++++-------------
  include/linux/netdevice.h  |    4 ----
  include/linux/string.h     |    2 ++
  include/sound/core.h       |    3 ++-
  lib/string.c               |   20 ++++++++++++++++++++
  net/core/neighbour.c       |    3 ++-
  net/core/sysctl_net_core.c |   15 ---------------
  net/ipv4/devinet.c         |    2 +-
  net/ipv6/addrconf.c        |    3 ++-
  net/sunrpc/svcauth_unix.c  |   11 ++---------
  sound/core/info.c          |    3 ++-
  sound/core/info_oss.c      |    3 ++-
  sound/core/memory.c        |   41 
++++++++++++++---------------------------
  sound/core/oss/mixer_oss.c |    3 ++-
  sound/core/oss/pcm_oss.c   |    3 ++-
  sound/core/sound.c         |    2 +-
  sound/core/timer.c         |    3 ++-
  sound/isa/gus/gus_mem.c    |    7 ++++---
  sound/synth/emux/emux.c    |    3 ++-
  20 files changed, 70 insertions(+), 93 deletions(-)

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

--------------050904070609010907050009
Content-Type: text/plain;
 name="strdup_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="strdup_patch"

diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/drivers/md/dm-ioctl.c linux-2.6.12-rc1-mm4/drivers/md/dm-ioctl.c
--- linux-2.6.12-rc1-mm4.vanilla/drivers/md/dm-ioctl.c	2005-03-02 07:37:51.000000000 +0000
+++ linux-2.6.12-rc1-mm4/drivers/md/dm-ioctl.c	2005-04-04 20:17:36.000000000 +0100
@@ -122,14 +122,6 @@ static struct hash_cell *__get_uuid_cell
 /*-----------------------------------------------------------------
  * Inserting, removing and renaming a device.
  *---------------------------------------------------------------*/
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
@@ -139,7 +131,7 @@ static struct hash_cell *alloc_cell(cons
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name);
+	hc->name = kstrdup(name, GFP_KERNEL);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -149,7 +141,7 @@ static struct hash_cell *alloc_cell(cons
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid);
+		hc->uuid = kstrdup(uuid, GFP_KERNEL);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -273,7 +265,7 @@ static int dm_hash_rename(const char *ol
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new);
+	new_name = kstrdup(new, GFP_KERNEL);
 	if (!new_name)
 		return -ENOMEM;
 
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/drivers/parport/probe.c linux-2.6.12-rc1-mm4/drivers/parport/probe.c
--- linux-2.6.12-rc1-mm4.vanilla/drivers/parport/probe.c	2005-04-01 18:01:29.000000000 +0100
+++ linux-2.6.12-rc1-mm4/drivers/parport/probe.c	2005-04-04 20:17:36.000000000 +0100
@@ -48,14 +48,6 @@ static void pretty_print(struct parport 
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
@@ -88,16 +80,16 @@ static void parse_data(struct parport *p
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
@@ -112,7 +104,7 @@ static void parse_data(struct parport *p
 				   !strcmp(p, "COMMAND SET")) {
 				if (info->cmdset)
 					kfree (info->cmdset);
-				info->cmdset = strdup(sep);
+				info->cmdset = kstrdup(sep, GFP_KERNEL);
 				/* if it speaks printer language, it's
 				   probably a printer */
 				if (strstr(sep, "PJL") || strstr(sep, "PCL"))
@@ -120,7 +112,7 @@ static void parse_data(struct parport *p
 			} else if (!strcmp(p, "DES") || !strcmp(p, "DESCRIPTION")) {
 				if (info->description)
 					kfree (info->description);
-				info->description = strdup(sep);
+				info->description = kstrdup(sep, GFP_KERNEL);
 			}
 		}
 	rock_on:
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/include/linux/netdevice.h linux-2.6.12-rc1-mm4/include/linux/netdevice.h
--- linux-2.6.12-rc1-mm4.vanilla/include/linux/netdevice.h	2005-04-01 18:01:44.000000000 +0100
+++ linux-2.6.12-rc1-mm4/include/linux/netdevice.h	2005-04-04 20:17:36.000000000 +0100
@@ -924,10 +924,6 @@ extern int skb_checksum_help(struct sk_b
 extern void		net_enable_timestamp(void);
 extern void		net_disable_timestamp(void);
 
-#ifdef CONFIG_SYSCTL
-extern char *net_sysctl_strdup(const char *s);
-#endif
-
 #endif /* __KERNEL__ */
 
 #endif	/* _LINUX_DEV_H */
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/include/linux/string.h linux-2.6.12-rc1-mm4/include/linux/string.h
--- linux-2.6.12-rc1-mm4.vanilla/include/linux/string.h	2005-03-02 07:38:07.000000000 +0000
+++ linux-2.6.12-rc1-mm4/include/linux/string.h	2005-04-04 20:17:36.000000000 +0100
@@ -88,6 +88,8 @@ extern int memcmp(const void *,const voi
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
+extern char *kstrdup(const char *s, int gfp);
+
 #ifdef __cplusplus
 }
 #endif
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/include/sound/core.h linux-2.6.12-rc1-mm4/include/sound/core.h
--- linux-2.6.12-rc1-mm4.vanilla/include/sound/core.h	2005-04-01 18:01:44.000000000 +0100
+++ linux-2.6.12-rc1-mm4/include/sound/core.h	2005-04-04 20:17:36.000000000 +0100
@@ -292,6 +292,7 @@ void *snd_hidden_kcalloc(size_t n, size_
 void snd_hidden_kfree(const void *obj);
 void *snd_hidden_vmalloc(unsigned long size);
 void snd_hidden_vfree(void *obj);
+char *snd_hidden_kstrdup(const char *s, int flags);
 #define kmalloc(size, flags) snd_hidden_kmalloc(size, flags)
 #define kcalloc(n, size, flags) snd_hidden_kcalloc(n, size, flags)
 #define kfree(obj) snd_hidden_kfree(obj)
@@ -301,6 +302,7 @@ void snd_hidden_vfree(void *obj);
 #define vmalloc_nocheck(size) snd_wrapper_vmalloc(size)
 #define kfree_nocheck(obj) snd_wrapper_kfree(obj)
 #define vfree_nocheck(obj) snd_wrapper_vfree(obj)
+#define kstrdup(s, flags)  snd_hidden_kstrdup(s, flags)
 #else
 #define snd_memory_init() /*NOP*/
 #define snd_memory_done() /*NOP*/
@@ -311,7 +313,6 @@ void snd_hidden_vfree(void *obj);
 #define kfree_nocheck(obj) kfree(obj)
 #define vfree_nocheck(obj) vfree(obj)
 #endif
-char *snd_kmalloc_strdup(const char *string, int flags);
 int copy_to_user_fromio(void __user *dst, const volatile void __iomem *src, size_t count);
 int copy_from_user_toio(volatile void __iomem *dst, const void __user *src, size_t count);
 
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/lib/string.c linux-2.6.12-rc1-mm4/lib/string.c
--- linux-2.6.12-rc1-mm4.vanilla/lib/string.c	2005-03-02 07:38:25.000000000 +0000
+++ linux-2.6.12-rc1-mm4/lib/string.c	2005-04-04 20:17:36.000000000 +0100
@@ -599,3 +599,23 @@ void *memchr(const void *s, int c, size_
 }
 EXPORT_SYMBOL(memchr);
 #endif
+
+/*
+ * kstrdup - allocate space for and copy an existing string
+ *
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ */
+char *kstrdup(const char *s, int gfp)
+{
+	int len;
+	char *buf;
+
+	if (!s) return NULL;
+
+	len = strlen(s) + 1;
+	buf = kmalloc(len, gfp);
+	if (buf)
+		memcpy(buf, s, len);
+	return buf;
+}
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/net/core/neighbour.c linux-2.6.12-rc1-mm4/net/core/neighbour.c
--- linux-2.6.12-rc1-mm4.vanilla/net/core/neighbour.c	2005-04-01 18:01:32.000000000 +0100
+++ linux-2.6.12-rc1-mm4/net/core/neighbour.c	2005-04-04 20:17:36.000000000 +0100
@@ -32,6 +32,7 @@
 #include <net/sock.h>
 #include <linux/rtnetlink.h>
 #include <linux/random.h>
+#include <linux/string.h>
 
 #define NEIGH_DEBUG 1
 
@@ -2281,7 +2282,7 @@ int neigh_sysctl_register(struct net_dev
 		t->neigh_vars[17].extra1 = dev;
 	}
 
-	dev_name = net_sysctl_strdup(dev_name_source);
+	dev_name = kstrdup(dev_name_source, GFP_KERNEL);
 	if (!dev_name) {
 		err = -ENOBUFS;
 		goto free;
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/net/core/sysctl_net_core.c linux-2.6.12-rc1-mm4/net/core/sysctl_net_core.c
--- linux-2.6.12-rc1-mm4.vanilla/net/core/sysctl_net_core.c	2005-03-02 07:38:03.000000000 +0000
+++ linux-2.6.12-rc1-mm4/net/core/sysctl_net_core.c	2005-04-04 20:17:36.000000000 +0100
@@ -35,19 +35,6 @@ extern int sysctl_somaxconn;
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
@@ -177,6 +164,4 @@ ctl_table core_table[] = {
 	{ .ctl_name = 0 }
 };
 
-EXPORT_SYMBOL(net_sysctl_strdup);
-
 #endif
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/net/ipv4/devinet.c linux-2.6.12-rc1-mm4/net/ipv4/devinet.c
--- linux-2.6.12-rc1-mm4.vanilla/net/ipv4/devinet.c	2005-04-01 18:01:44.000000000 +0100
+++ linux-2.6.12-rc1-mm4/net/ipv4/devinet.c	2005-04-04 20:17:36.000000000 +0100
@@ -1449,7 +1449,7 @@ static void devinet_sysctl_register(stru
 	 * by sysctl and we wouldn't want anyone to change it under our feet
 	 * (see SIOCSIFNAME).
 	 */	
-	dev_name = net_sysctl_strdup(dev_name);
+	dev_name = kstrdup(dev_name, GFP_KERNEL);
 	if (!dev_name)
 	    goto free;
 
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/net/ipv6/addrconf.c linux-2.6.12-rc1-mm4/net/ipv6/addrconf.c
--- linux-2.6.12-rc1-mm4.vanilla/net/ipv6/addrconf.c	2005-04-01 18:01:44.000000000 +0100
+++ linux-2.6.12-rc1-mm4/net/ipv6/addrconf.c	2005-04-04 20:17:36.000000000 +0100
@@ -57,6 +57,7 @@
 #endif
 #include <linux/delay.h>
 #include <linux/notifier.h>
+#include <linux/string.h>
 
 #include <net/sock.h>
 #include <net/snmp.h>
@@ -3439,7 +3440,7 @@ static void addrconf_sysctl_register(str
 	 * by sysctl and we wouldn't want anyone to change it under our feet
 	 * (see SIOCSIFNAME).
 	 */	
-	dev_name = net_sysctl_strdup(dev_name);
+	dev_name = kstrdup(dev_name, GFP_KERNEL);
 	if (!dev_name)
 	    goto free;
 
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/net/sunrpc/svcauth_unix.c linux-2.6.12-rc1-mm4/net/sunrpc/svcauth_unix.c
--- linux-2.6.12-rc1-mm4.vanilla/net/sunrpc/svcauth_unix.c	2005-04-01 18:01:32.000000000 +0100
+++ linux-2.6.12-rc1-mm4/net/sunrpc/svcauth_unix.c	2005-04-04 20:17:36.000000000 +0100
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/seq_file.h>
 #include <linux/hash.h>
+#include <linux/string.h>
 
 #define RPCDBG_FACILITY	RPCDBG_AUTH
 
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
@@ -55,7 +48,7 @@ struct auth_domain *unix_domain_find(cha
 	if (new == NULL)
 		return NULL;
 	cache_init(&new->h.h);
-	new->h.name = strdup(name);
+	new->h.name = kstrdup(name, GFP_KERNEL);
 	new->h.flavour = RPC_AUTH_UNIX;
 	new->addr_changes = 0;
 	new->h.h.expiry_time = NEVER;
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/sound/core/info.c linux-2.6.12-rc1-mm4/sound/core/info.c
--- linux-2.6.12-rc1-mm4.vanilla/sound/core/info.c	2005-04-01 18:01:44.000000000 +0100
+++ linux-2.6.12-rc1-mm4/sound/core/info.c	2005-04-04 20:17:36.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/vmalloc.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/info.h>
@@ -754,7 +755,7 @@ static snd_info_entry_t *snd_info_create
 	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
 	if (entry == NULL)
 		return NULL;
-	entry->name = snd_kmalloc_strdup(name, GFP_KERNEL);
+	entry->name = kstrdup(name, GFP_KERNEL);
 	if (entry->name == NULL) {
 		kfree(entry);
 		return NULL;
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/sound/core/info_oss.c linux-2.6.12-rc1-mm4/sound/core/info_oss.c
--- linux-2.6.12-rc1-mm4.vanilla/sound/core/info_oss.c	2005-03-02 07:37:49.000000000 +0000
+++ linux-2.6.12-rc1-mm4/sound/core/info_oss.c	2005-04-04 20:17:36.000000000 +0100
@@ -22,6 +22,7 @@
 #include <sound/driver.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/info.h>
@@ -51,7 +52,7 @@ int snd_oss_info_register(int dev, int n
 			x = NULL;
 		}
 	} else {
-		x = snd_kmalloc_strdup(string, GFP_KERNEL);
+		x = kstrdup(string, GFP_KERNEL);
 		if (x == NULL) {
 			up(&strings);
 			return -ENOMEM;
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/sound/core/memory.c linux-2.6.12-rc1-mm4/sound/core/memory.c
--- linux-2.6.12-rc1-mm4.vanilla/sound/core/memory.c	2005-04-01 18:01:32.000000000 +0100
+++ linux-2.6.12-rc1-mm4/sound/core/memory.c	2005-04-04 20:17:36.000000000 +0100
@@ -184,6 +184,20 @@ void snd_hidden_vfree(void *obj)
 	snd_wrapper_vfree(obj);
 }
 
+char *snd_hidden_kstrdup(const char *s, int flags)
+{
+	int len;
+	char *buf;
+	
+	if (!s) return NULL;
+	
+	len = strlen(s) + 1;
+	buf = _snd_kmalloc(len, flags);
+	if (buf)
+		memcpy(buf, s, len);
+	return buf;
+}
+
 static void snd_memory_info_read(snd_info_entry_t *entry, snd_info_buffer_t * buffer)
 {
 	snd_iprintf(buffer, "kmalloc: %li bytes\n", snd_alloc_kmalloc);
@@ -214,36 +228,9 @@ int __exit snd_memory_info_done(void)
 	return 0;
 }
 
-#else
-
-#define _snd_kmalloc kmalloc
-
 #endif /* CONFIG_SND_DEBUG_MEMORY */
 
 /**
- * snd_kmalloc_strdup - copy the string
- * @string: the original string
- * @flags: allocation conditions, GFP_XXX
- *
- * Allocates a memory chunk via kmalloc() and copies the string to it.
- *
- * Returns the pointer, or NULL if no enoguh memory.
- */
-char *snd_kmalloc_strdup(const char *string, int flags)
-{
-	size_t len;
-	char *ptr;
-
-	if (!string)
-		return NULL;
-	len = strlen(string) + 1;
-	ptr = _snd_kmalloc(len, flags);
-	if (ptr)
-		memcpy(ptr, string, len);
-	return ptr;
-}
-
-/**
  * copy_to_user_fromio - copy data from mmio-space to user-space
  * @dst: the destination pointer on user-space
  * @src: the source pointer on mmio
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/sound/core/oss/mixer_oss.c linux-2.6.12-rc1-mm4/sound/core/oss/mixer_oss.c
--- linux-2.6.12-rc1-mm4.vanilla/sound/core/oss/mixer_oss.c	2005-04-01 18:01:45.000000000 +0100
+++ linux-2.6.12-rc1-mm4/sound/core/oss/mixer_oss.c	2005-04-04 20:17:36.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/control.h>
@@ -1137,7 +1138,7 @@ static void snd_mixer_oss_proc_write(snd
 			goto __unlock;
 		}
 		tbl->oss_id = ch;
-		tbl->name = snd_kmalloc_strdup(str, GFP_KERNEL);
+		tbl->name = kstrdup(str, GFP_KERNEL);
 		if (! tbl->name) {
 			kfree(tbl);
 			goto __unlock;
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/sound/core/oss/pcm_oss.c linux-2.6.12-rc1-mm4/sound/core/oss/pcm_oss.c
--- linux-2.6.12-rc1-mm4.vanilla/sound/core/oss/pcm_oss.c	2005-04-01 18:01:45.000000000 +0100
+++ linux-2.6.12-rc1-mm4/sound/core/oss/pcm_oss.c	2005-04-04 20:17:36.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/time.h>
 #include <linux/vmalloc.h>
 #include <linux/moduleparam.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/pcm.h>
@@ -2347,7 +2348,7 @@ static void snd_pcm_oss_proc_write(snd_i
 					for (setup1 = pstr->oss.setup_list; setup1->next; setup1 = setup1->next);
 					setup1->next = setup;
 				}
-				template.task_name = snd_kmalloc_strdup(task_name, GFP_KERNEL);
+				template.task_name = kstrdup(task_name, GFP_KERNEL);
 			} else {
 				buffer->error = -ENOMEM;
 			}
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/sound/core/sound.c linux-2.6.12-rc1-mm4/sound/core/sound.c
--- linux-2.6.12-rc1-mm4.vanilla/sound/core/sound.c	2005-04-01 18:01:45.000000000 +0100
+++ linux-2.6.12-rc1-mm4/sound/core/sound.c	2005-04-04 20:17:36.000000000 +0100
@@ -399,8 +399,8 @@ EXPORT_SYMBOL(snd_hidden_kcalloc);
 EXPORT_SYMBOL(snd_hidden_kfree);
 EXPORT_SYMBOL(snd_hidden_vmalloc);
 EXPORT_SYMBOL(snd_hidden_vfree);
+EXPORT_SYMBOL(snd_hidden_kstrdup);
 #endif
-EXPORT_SYMBOL(snd_kmalloc_strdup);
 EXPORT_SYMBOL(copy_to_user_fromio);
 EXPORT_SYMBOL(copy_from_user_toio);
   /* init.c */
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/sound/core/timer.c linux-2.6.12-rc1-mm4/sound/core/timer.c
--- linux-2.6.12-rc1-mm4.vanilla/sound/core/timer.c	2005-04-01 18:01:45.000000000 +0100
+++ linux-2.6.12-rc1-mm4/sound/core/timer.c	2005-04-04 20:17:36.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/moduleparam.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/timer.h>
 #include <sound/control.h>
@@ -99,7 +100,7 @@ static snd_timer_instance_t *snd_timer_i
 	timeri = kcalloc(1, sizeof(*timeri), GFP_KERNEL);
 	if (timeri == NULL)
 		return NULL;
-	timeri->owner = snd_kmalloc_strdup(owner, GFP_KERNEL);
+	timeri->owner = kstrdup(owner, GFP_KERNEL);
 	if (! timeri->owner) {
 		kfree(timeri);
 		return NULL;
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/sound/isa/gus/gus_mem.c linux-2.6.12-rc1-mm4/sound/isa/gus/gus_mem.c
--- linux-2.6.12-rc1-mm4.vanilla/sound/isa/gus/gus_mem.c	2005-03-02 07:38:07.000000000 +0000
+++ linux-2.6.12-rc1-mm4/sound/isa/gus/gus_mem.c	2005-04-04 20:17:36.000000000 +0100
@@ -21,6 +21,7 @@
 
 #include <sound/driver.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/gus.h>
 #include <sound/info.h>
@@ -213,7 +214,7 @@ snd_gf1_mem_block_t *snd_gf1_mem_alloc(s
 	if (share_id != NULL)
 		memcpy(&block.share_id, share_id, sizeof(block.share_id));
 	block.owner = owner;
-	block.name = snd_kmalloc_strdup(name, GFP_KERNEL);
+	block.name = kstrdup(name, GFP_KERNEL);
 	nblock = snd_gf1_mem_xalloc(alloc, &block);
 	snd_gf1_mem_lock(alloc, 1);
 	return nblock;
@@ -253,13 +254,13 @@ int snd_gf1_mem_init(snd_gus_card_t * gu
 	if (gus->gf1.enh_mode) {
 		block.ptr = 0;
 		block.size = 1024;
-		block.name = snd_kmalloc_strdup("InterWave LFOs", GFP_KERNEL);
+		block.name = kstrdup("InterWave LFOs", GFP_KERNEL);
 		if (snd_gf1_mem_xalloc(alloc, &block) == NULL)
 			return -ENOMEM;
 	}
 	block.ptr = gus->gf1.default_voice_address;
 	block.size = 4;
-	block.name = snd_kmalloc_strdup("Voice default (NULL's)", GFP_KERNEL);
+	block.name = kstrdup("Voice default (NULL's)", GFP_KERNEL);
 	if (snd_gf1_mem_xalloc(alloc, &block) == NULL)
 		return -ENOMEM;
 #ifdef CONFIG_SND_DEBUG
diff -uprN -X dontdiff linux-2.6.12-rc1-mm4.vanilla/sound/synth/emux/emux.c linux-2.6.12-rc1-mm4/sound/synth/emux/emux.c
--- linux-2.6.12-rc1-mm4.vanilla/sound/synth/emux/emux.c	2005-03-02 07:38:09.000000000 +0000
+++ linux-2.6.12-rc1-mm4/sound/synth/emux/emux.c	2005-04-04 20:17:36.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/emux_synth.h>
 #include <linux/init.h>
@@ -76,7 +77,7 @@ int snd_emux_register(snd_emux_t *emu, s
 	snd_assert(name != NULL, return -EINVAL);
 
 	emu->card = card;
-	emu->name = snd_kmalloc_strdup(name, GFP_KERNEL);
+	emu->name = kstrdup(name, GFP_KERNEL);
 	emu->voices = kcalloc(emu->max_voices, sizeof(snd_emux_voice_t), GFP_KERNEL);
 	if (emu->voices == NULL)
 		return -ENOMEM;

--------------050904070609010907050009--
