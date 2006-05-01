Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWEANt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWEANt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWEANt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:49:58 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:3802 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932106AbWEANt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:49:57 -0400
Date: Mon, 1 May 2006 15:49:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 3/4] task_post_setgid()
In-Reply-To: <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0605011549260.31804@yvahk01.tjqt.qr>
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


[PATCH 3/4] task_post_setgid()

    -   Implement the task_post_setgid() LSM hook which is required by
        MultiAdmin to switch between classes.
        (task_post_setuid also switches between classes -- and already exists)


Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/include/linux/security.h linux-2.6.17-rc3+/include/linux/security.h
--- linux-2.6.17-rc3~/include/linux/security.h	2006-05-01 09:57:13.112832000 +0200
+++ linux-2.6.17-rc3+/include/linux/security.h	2006-05-01 09:57:38.182832000 +0200
@@ -1320,6 +1320,7 @@ struct security_operations {
 #endif	/* CONFIG_KEYS */
 
 	int (*cap_extra)(int);
+	int (*task_post_setgid)(gid_t, gid_t, gid_t, int);
 };
 
 /* global variables */
@@ -2024,6 +2025,11 @@ static inline int security_cap_extra(int
 	return security_ops->cap_extra(cap);
 }
 
+static inline int security_task_post_setgid(gid_t r, gid_t e, gid_t s, int t)
+{
+	return security_ops->task_post_setgid(r, e, s, t);
+}
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2663,6 +2669,11 @@ static inline int security_cap_extra(int
 	return 1;
 }
 
+static inline int security_task_post_setgid(gid_t r, gid_t e, gid_t s, int t)
+{
+	return 0;
+}
+
 static inline struct dentry *securityfs_create_dir(const char *name,
 					struct dentry *parent)
 {
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/kernel/sys.c linux-2.6.17-rc3+/kernel/sys.c
--- linux-2.6.17-rc3~/kernel/sys.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/kernel/sys.c	2006-05-01 09:57:38.192832000 +0200
@@ -836,7 +836,7 @@ asmlinkage long sys_setregid(gid_t rgid,
 	current->gid = new_rgid;
 	key_fsgid_changed(current);
 	proc_id_connector(current, PROC_EVENT_GID);
-	return 0;
+	return security_task_post_setgid(old_rgid, old_egid, (gid_t)-1, LSM_SETID_RE);
 }
 
 /*
@@ -846,6 +846,7 @@ asmlinkage long sys_setregid(gid_t rgid,
  */
 asmlinkage long sys_setgid(gid_t gid)
 {
+	gid_t old_rgid = current->gid;
 	int old_egid = current->egid;
 	int retval;
 
@@ -876,7 +877,7 @@ asmlinkage long sys_setgid(gid_t gid)
 
 	key_fsgid_changed(current);
 	proc_id_connector(current, PROC_EVENT_GID);
-	return 0;
+	return security_task_post_setgid(old_rgid, (gid_t)-1, (gid_t)-1, LSM_SETID_ID);
 }
   
 static int set_user(uid_t new_ruid, int dumpclear)
@@ -1083,6 +1084,8 @@ asmlinkage long sys_getresuid(uid_t __us
  */
 asmlinkage long sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 {
+	gid_t old_rgid = current->gid, old_egid = current->egid,
+	      old_sgid = current->sgid;
 	int retval;
 
 	retval = security_task_setgid(rgid, egid, sgid, LSM_SETID_RES);
@@ -1116,7 +1119,7 @@ asmlinkage long sys_setresgid(gid_t rgid
 
 	key_fsgid_changed(current);
 	proc_id_connector(current, PROC_EVENT_GID);
-	return 0;
+	return security_task_post_setgid(old_rgid, old_egid, old_sgid, LSM_SETID_RES);
 }
 
 asmlinkage long sys_getresgid(gid_t __user *rgid, gid_t __user *egid, gid_t __user *sgid)
@@ -1189,6 +1192,7 @@ asmlinkage long sys_setfsgid(gid_t gid)
 		key_fsgid_changed(current);
 		proc_id_connector(current, PROC_EVENT_GID);
 	}
+	security_task_post_setgid(old_fsgid, (gid_t)-1, (gid_t)-1, LSM_SETID_FS);
 	return old_fsgid;
 }
 
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/security/dummy.c linux-2.6.17-rc3+/security/dummy.c
--- linux-2.6.17-rc3~/security/dummy.c	2006-05-01 09:57:13.112832000 +0200
+++ linux-2.6.17-rc3+/security/dummy.c	2006-05-01 09:57:38.192832000 +0200
@@ -682,6 +682,11 @@ static int dummy_cap_extra(int cap)
 	return 1; /* allow */
 }
 
+static int dummy_task_post_setgid(gid_t r, gid_t e, gid_t s, int t)
+{
+	return 0;
+}
+
 #ifdef CONFIG_SECURITY_NETWORK
 static int dummy_unix_stream_connect (struct socket *sock,
 				      struct socket *other,
@@ -1046,5 +1051,6 @@ void security_fixup_ops (struct security
 #endif	/* CONFIG_KEYS */
 
 	set_to_dummy_if_null(ops, cap_extra);
+	set_to_dummy_if_null(ops, task_post_setgid);
 }
 
#<<eof>>


Jan Engelhardt
-- 
