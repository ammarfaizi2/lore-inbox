Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUJIWx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUJIWx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 18:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUJIWx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 18:53:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:15313 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267516AbUJIWxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 18:53:43 -0400
Date: Sat, 9 Oct 2004 15:53:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041009155339.Y2357@build.pdx.osdl.net>
References: <1097272140.1442.75.camel@krustophenia.net> <20041008145252.M2357@build.pdx.osdl.net> <1097273105.1442.78.camel@krustophenia.net> <20041008151911.Q2357@build.pdx.osdl.net> <20041008152430.R2357@build.pdx.osdl.net> <87zn2wbt7c.fsf@sulphur.joq.us> <20041008221635.V2357@build.pdx.osdl.net> <87is9jc1eb.fsf@sulphur.joq.us> <20041009121141.X2357@build.pdx.osdl.net> <878yafbpsj.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <878yafbpsj.fsf@sulphur.joq.us>; from joq@io.com on Sat, Oct 09, 2004 at 03:27:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jack O'Quin (joq@io.com) wrote:
> Chris Wright <chrisw@osdl.org> writes:
> > The egid makes a setgid-audio program be meaningful as well.
> 
> That works already, because we test the e_gid from the bprm structure,
> right?  Is that redundant?

You're right.  It's not quite redundant, because current->egid test is
before current->egid would be reset on setgid (happens in apply_creds).
Using apply_creds actually makes a bit more sense here, and simplifies
things a touch.

- use apply_creds and update gid_ok accordingly
- only upgrade cap_effective
- less generic variable names
  - s/any/rt_any/
  - s/gid/rt_gid/
  - s/mlock/rt_mlock/

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--- security/realtime.c~in_egroup	2004-10-08 22:17:23.499153832 -0700
+++ security/realtime.c	2004-10-09 15:49:38.048243488 -0700
@@ -45,34 +45,37 @@
  *  each is referenced only once in each function call.  Nothing
  *  depends on parameters having the same value every time.
  */
-static int any;			/* if TRUE, any process is realtime */
-module_param(any, int, 0644);
+
+/* if TRUE, any process is realtime */
+static int rt_any;
+module_param_named(any, rt_any, int, 0644);
 MODULE_PARM_DESC(any, " grant realtime privileges to any process.");
 
-static int gid = -1;			/* realtime group id, or NO_GROUP */
-module_param(gid, int, 0644);
+/* realtime group id, or NO_GROUP */
+static int rt_gid = -1;
+module_param_named(gid, rt_gid, int, 0644);
 MODULE_PARM_DESC(gid, " the group ID with access to realtime privileges.");
 
-static int mlock = 1;			/* enable mlock() privileges */
-module_param(mlock, int, 0644);
+/* enable mlock() privileges */
+static int rt_mlock = 1;
+module_param_named(mlock, rt_mlock, int, 0644);
 MODULE_PARM_DESC(mlock, " enable memory locking privileges.");
 
 /* helper function for testing group membership */
-static inline int gid_ok(int gid, int e_gid)
+static inline int gid_ok(int gid)
 {
 	if (gid == -1)
 		return 0;
 
-	if ((gid == e_gid) || (gid == current->gid))
+	if (gid == current->gid)
 		return 1;
 
 	return in_egroup_p(gid);
 }
 
-static int realtime_bprm_set_security(struct linux_binprm *bprm)
+static void realtime_bprm_apply_creds(struct linux_binprm *bprm, int unsafe)
 {
-
-	cap_bprm_set_security(bprm);
+	cap_bprm_apply_creds(bprm, unsafe);
 
 	/*  If a non-zero `any' parameter was specified, we grant
 	 *  realtime privileges to every process.  If the `gid'
@@ -81,17 +84,13 @@
 	 *  groups, we grant realtime capabilites.
 	 */
 
-	if (any || gid_ok(gid, bprm->e_gid)) {
-		cap_raise(bprm->cap_effective, CAP_SYS_NICE);
-		cap_raise(bprm->cap_permitted, CAP_SYS_NICE);
-		if (mlock) {
-			cap_raise(bprm->cap_effective, CAP_IPC_LOCK);
-			cap_raise(bprm->cap_permitted, CAP_IPC_LOCK);
-			cap_raise(bprm->cap_effective, CAP_SYS_RESOURCE);
-			cap_raise(bprm->cap_permitted, CAP_SYS_RESOURCE);
+	if (rt_any || gid_ok(rt_gid)) {
+		cap_raise(current->cap_effective, CAP_SYS_NICE);
+		if (rt_mlock) {
+			cap_raise(current->cap_effective, CAP_IPC_LOCK);
+			cap_raise(current->cap_effective, CAP_SYS_RESOURCE);
 		}
 	}
-	return 0;
 }
 
 static struct security_operations capability_ops = {
@@ -102,8 +101,8 @@
 	.capable =			cap_capable,
 	.netlink_send =			cap_netlink_send,
 	.netlink_recv =			cap_netlink_recv,
-	.bprm_apply_creds =		cap_bprm_apply_creds,
-	.bprm_set_security =		realtime_bprm_set_security,
+	.bprm_apply_creds =		realtime_bprm_apply_creds,
+	.bprm_set_security =		cap_bprm_set_security,
 	.bprm_secureexec =		cap_bprm_secureexec,
 	.task_post_setuid =		cap_task_post_setuid,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
@@ -117,14 +116,14 @@
 {
 	{ .ctl_name	= 1,
 	  .procname	= "any",
-	  .data		= &any,
+	  .data		= &rt_any,
 	  .maxlen	= sizeof(int),
 	  .mode		= 0644,
 	  .proc_handler	= &proc_dointvec,
 	},
 	{ .ctl_name	= 2,
 	  .procname	= "gid",
-	  .data		= &gid,
+	  .data		= &rt_gid,
 	  .maxlen	= sizeof(int),
 	  .mode		= 0644,
 	  .proc_handler	= &proc_dointvec_minmax,
@@ -133,7 +132,7 @@
 	},
 	{ .ctl_name	= 3,
 	  .procname	= "mlock",
-	  .data		= &mlock,
+	  .data		= &rt_mlock,
 	  .maxlen	= sizeof(int),
 	  .mode		= 0644,
 	  .proc_handler	= &proc_dointvec,
@@ -205,15 +204,15 @@
 		return -ENOMEM;
 	}
 
-	if (any)
+	if (rt_any)
 		printk(KERN_INFO RT_LSM
-		       "initialized (all groups, mlock=%d)\n", mlock);
-	else if (gid == -1)
+		       "initialized (all groups, mlock=%d)\n", rt_mlock);
+	else if (rt_gid == -1)
 		printk(KERN_INFO RT_LSM
-		       "initialized (no groups, mlock=%d)\n", mlock);
+		       "initialized (no groups, mlock=%d)\n", rt_mlock);
 	else
 		printk(KERN_INFO RT_LSM
-		       "initialized (group %d, mlock=%d)\n", gid, mlock);
+		       "initialized (group %d, mlock=%d)\n", rt_gid, rt_mlock);
 		
 	return 0;
 }
