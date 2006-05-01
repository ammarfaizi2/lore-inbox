Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWEANtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWEANtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWEANtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:49:11 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:58073 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932102AbWEANtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:49:10 -0400
Date: Mon, 1 May 2006 15:48:54 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/4] security_cap_extra() and more
In-Reply-To: <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0605011548250.31804@yvahk01.tjqt.qr>
References: <20060417162345.GA9609@infradead.org>
 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
 <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
 <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
 <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH 1/4] security_cap_extra() and more

    -   Renames capable() to capable_light().
        This function is used if only a capability is to be checked.

    -   Implement a new capable that calls security_cap_extra().
        Since a subadmin has almost the same capabilities as a
        superadmin, an extra helper is needed to decide whether an
        action is allowed, based on the philosophy of the LSM.

    -   implement the .cap_extra LSM hook


Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/include/linux/capability.h linux-2.6.17-rc3+/include/linux/capability.h
--- linux-2.6.17-rc3~/include/linux/capability.h	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/include/linux/capability.h	2006-04-30 23:25:25.233048000 +0200
@@ -357,6 +357,8 @@ static inline kernel_cap_t cap_invert(ke
 
 #define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
 
+int capable_light(int);
+int __capable_light(struct task_struct *, int);
 int capable(int cap);
 int __capable(struct task_struct *t, int cap);
 
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/include/linux/security.h linux-2.6.17-rc3+/include/linux/security.h
--- linux-2.6.17-rc3~/include/linux/security.h	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/include/linux/security.h	2006-04-30 23:25:35.893048000 +0200
@@ -1319,6 +1319,7 @@ struct security_operations {
 
 #endif	/* CONFIG_KEYS */
 
+	int (*cap_extra)(int);
 };
 
 /* global variables */
@@ -2018,6 +2019,11 @@ static inline int security_netlink_recv(
 	return security_ops->netlink_recv(skb);
 }
 
+static inline int security_cap_extra(int cap)
+{
+	return security_ops->cap_extra(cap);
+}
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2651,6 +2657,12 @@ static inline int security_netlink_recv 
 	return cap_netlink_recv (skb);
 }
 
+static inline int security_cap_extra(int cap);
+{
+	/* Capability test already passed. No more checks. => Allow. */
+	return 1;
+}
+
 static inline struct dentry *securityfs_create_dir(const char *name,
 					struct dentry *parent)
 {
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/kernel/capability.c linux-2.6.17-rc3+/kernel/capability.c
--- linux-2.6.17-rc3~/kernel/capability.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/kernel/capability.c	2006-04-30 23:30:06.143048000 +0200
@@ -238,7 +238,7 @@ int __capable(struct task_struct *t, int
 {
 	if (security_capable(t, cap) == 0) {
 		t->flags |= PF_SUPERPRIV;
-		return 1;
+		return security_cap_extra(cap);
 	}
 	return 0;
 }
@@ -249,3 +249,20 @@ int capable(int cap)
 	return __capable(current, cap);
 }
 EXPORT_SYMBOL(capable);
+
+int __capable_light(struct task_struct *t, int cap)
+{
+	if (security_capable(t, cap) == 0) {
+		t->flags |= PF_SUPERPRIV;
+		return 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(__capable_light);
+
+int capable_light(int cap)
+{
+	return __capable_light(current, cap);
+}
+EXPORT_SYMBOL(capable_light);
+
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/security/dummy.c linux-2.6.17-rc3+/security/dummy.c
--- linux-2.6.17-rc3~/security/dummy.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/security/dummy.c	2006-04-30 23:30:24.763048000 +0200
@@ -677,6 +677,11 @@ static int dummy_netlink_recv (struct sk
 	return 0;
 }
 
+static int dummy_cap_extra(int cap)
+{
+	return 1; /* allow */
+}
+
 #ifdef CONFIG_SECURITY_NETWORK
 static int dummy_unix_stream_connect (struct socket *sock,
 				      struct socket *other,
@@ -1040,5 +1045,6 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, key_permission);
 #endif	/* CONFIG_KEYS */
 
+	set_to_dummy_if_null(ops, cap_extra);
 }
 
#<<eof>>


Jan Engelhardt
-- 
