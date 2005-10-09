Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVJIFgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVJIFgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 01:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVJIFgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 01:36:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53215 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932219AbVJIFgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 01:36:24 -0400
Date: Sun, 9 Oct 2005 06:36:22 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC] gfp flags annotations - part 4 (lib/*)
Message-ID: <20051009053622.GI7992@ftp.linux.org.uk>
References: <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	missing gfp_t in lib/* and related headers
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN mm/include/linux/idr.h lib/include/linux/idr.h
--- mm/include/linux/idr.h	2005-09-22 14:50:53.000000000 -0400
+++ lib/include/linux/idr.h	2005-10-09 01:21:35.000000000 -0400
@@ -71,7 +71,7 @@
  */
 
 void *idr_find(struct idr *idp, int id);
-int idr_pre_get(struct idr *idp, unsigned gfp_mask);
+int idr_pre_get(struct idr *idp, gfp_t gfp_mask);
 int idr_get_new(struct idr *idp, void *ptr, int *id);
 int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
 void idr_remove(struct idr *idp, int id);
diff -urN mm/include/linux/kobject.h lib/include/linux/kobject.h
--- mm/include/linux/kobject.h	2005-09-22 14:50:53.000000000 -0400
+++ lib/include/linux/kobject.h	2005-10-09 01:21:35.000000000 -0400
@@ -65,7 +65,7 @@
 extern struct kobject * kobject_get(struct kobject *);
 extern void kobject_put(struct kobject *);
 
-extern char * kobject_get_path(struct kobject *, int);
+extern char * kobject_get_path(struct kobject *, gfp_t);
 
 struct kobj_type {
 	void (*release)(struct kobject *);
diff -urN mm/include/linux/radix-tree.h lib/include/linux/radix-tree.h
--- mm/include/linux/radix-tree.h	2005-10-08 21:04:47.000000000 -0400
+++ lib/include/linux/radix-tree.h	2005-10-09 01:21:35.000000000 -0400
@@ -24,7 +24,7 @@
 
 struct radix_tree_root {
 	unsigned int		height;
-	unsigned int		gfp_mask;
+	gfp_t			gfp_mask;
 	struct radix_tree_node	*rnode;
 };
 
diff -urN mm/include/linux/textsearch.h lib/include/linux/textsearch.h
--- mm/include/linux/textsearch.h	2005-10-08 21:04:47.000000000 -0400
+++ lib/include/linux/textsearch.h	2005-10-09 01:21:35.000000000 -0400
@@ -40,7 +40,7 @@
 struct ts_ops
 {
 	const char		*name;
-	struct ts_config *	(*init)(const void *, unsigned int, int);
+	struct ts_config *	(*init)(const void *, unsigned int, gfp_t);
 	unsigned int		(*find)(struct ts_config *,
 					struct ts_state *);
 	void			(*destroy)(struct ts_config *);
@@ -148,7 +148,7 @@
 extern int textsearch_register(struct ts_ops *);
 extern int textsearch_unregister(struct ts_ops *);
 extern struct ts_config *textsearch_prepare(const char *, const void *,
-					    unsigned int, int, int);
+					    unsigned int, gfp_t, int);
 extern void textsearch_destroy(struct ts_config *conf);
 extern unsigned int textsearch_find_continuous(struct ts_config *,
 					       struct ts_state *,
diff -urN mm/lib/idr.c lib/lib/idr.c
--- mm/lib/idr.c	2005-09-22 14:50:54.000000000 -0400
+++ lib/lib/idr.c	2005-10-09 01:21:35.000000000 -0400
@@ -72,7 +72,7 @@
  * If the system is REALLY out of memory this function returns 0,
  * otherwise 1.
  */
-int idr_pre_get(struct idr *idp, unsigned gfp_mask)
+int idr_pre_get(struct idr *idp, gfp_t gfp_mask)
 {
 	while (idp->id_free_cnt < IDR_FREE_MAX) {
 		struct idr_layer *new;
diff -urN mm/lib/kobject.c lib/lib/kobject.c
--- mm/lib/kobject.c	2005-09-22 14:50:54.000000000 -0400
+++ lib/lib/kobject.c	2005-10-09 01:21:35.000000000 -0400
@@ -100,7 +100,7 @@
  * @kobj:	kobject in question, with which to build the path
  * @gfp_mask:	the allocation type used to allocate the path
  */
-char *kobject_get_path(struct kobject *kobj, int gfp_mask)
+char *kobject_get_path(struct kobject *kobj, gfp_t gfp_mask)
 {
 	char *path;
 	int len;
diff -urN mm/lib/kobject_uevent.c lib/lib/kobject_uevent.c
--- mm/lib/kobject_uevent.c	2005-09-22 14:50:54.000000000 -0400
+++ lib/lib/kobject_uevent.c	2005-10-09 01:21:35.000000000 -0400
@@ -62,7 +62,7 @@
  * @gfp_mask:
  */
 static int send_uevent(const char *signal, const char *obj,
-		       char **envp, int gfp_mask)
+		       char **envp, gfp_t gfp_mask)
 {
 	struct sk_buff *skb;
 	char *pos;
@@ -98,7 +98,7 @@
 }
 
 static int do_kobject_uevent(struct kobject *kobj, enum kobject_action action, 
-			     struct attribute *attr, int gfp_mask)
+			     struct attribute *attr, gfp_t gfp_mask)
 {
 	char *path;
 	char *attrpath;
diff -urN mm/lib/textsearch.c lib/lib/textsearch.c
--- mm/lib/textsearch.c	2005-09-22 14:50:54.000000000 -0400
+++ lib/lib/textsearch.c	2005-10-09 01:21:35.000000000 -0400
@@ -254,7 +254,7 @@
  *         parameters or a ERR_PTR().
  */
 struct ts_config *textsearch_prepare(const char *algo, const void *pattern,
-				     unsigned int len, int gfp_mask, int flags)
+				     unsigned int len, gfp_t gfp_mask, int flags)
 {
 	int err = -ENOENT;
 	struct ts_config *conf;
