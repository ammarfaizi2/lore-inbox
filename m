Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWGISxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWGISxE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 14:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWGISxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 14:53:03 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:26338 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161054AbWGISxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 14:53:02 -0400
Date: Sun, 9 Jul 2006 13:52:28 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       Kirill Korotaev <dev@openvz.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6: kernel/sysctl.c: PROC_FS=n compile error
Message-ID: <20060709185228.GB14100@sergelap.austin.ibm.com>
References: <20060703030355.420c7155.akpm@osdl.org> <20060708202011.GD5020@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708202011.GD5020@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adrian Bunk (bunk@stusta.de):
> namespaces-utsname-sysctl-hack.patch and ipc-namespace-sysctls.patch 
> cause the following compile error with CONFIG_PROC_FS=n:
> 
> <--  snip  -->
> 
> ...
>   CC      kernel/sysctl.o
> kernel/sysctl.c:107: warning: #proc_do_ipc_string# used but never defined
> kernel/sysctl.c:150: warning: #proc_do_utsns_string# used but never defined
> kernel/sysctl.c:2465: warning: #proc_do_uts_string# defined but not used
> ...
>   LD      .tmp_vmlinux1
> kernel/built-in.o:(.data+0x938): undefined reference to `proc_do_utsns_string'
> kernel/built-in.o:(.data+0x964): undefined reference to `proc_do_utsns_string'
> kernel/built-in.o:(.data+0x990): undefined reference to `proc_do_utsns_string'
> kernel/built-in.o:(.data+0x9bc): undefined reference to `proc_do_utsns_string'
> kernel/built-in.o:(.data+0x9e8): undefined reference to `proc_do_utsns_string'
> kernel/built-in.o:(.data+0xc24): undefined reference to `proc_do_ipc_string'
> kernel/built-in.o:(.data+0xc50): undefined reference to `proc_do_ipc_string'
> kernel/built-in.o:(.data+0xc7c): undefined reference to `proc_do_ipc_string'
> kernel/built-in.o:(.data+0xca8): undefined reference to `proc_do_ipc_string'
> kernel/built-in.o:(.data+0xcd4): undefined reference to `proc_do_ipc_string'
> kernel/built-in.o:(.data+0xd00): more undefined references to `proc_do_ipc_string' follow
> make: *** [.tmp_vmlinux1] Error 1

Does the below patch fix this for you?  Took me awhile to get a valid
CONFIG_PROC_FS=n .config, and I'm having other -mm s390 build failures
which I'll look into tomorrow, but this seems to fix the problem.

thanks,
-serge

From: Serge Hallyn <serue@us.ibm.com>
Subject: [PATCH] namespaces: fix compilation when !CONFIG_PROC_FS

The proc_do_uts_string function was misnamed when !CONFIG_PROC_FS.  The
proc_do_ipc_string function was not defined if !CONFIG_PROC_FS.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 kernel/sysctl.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

488d4b4675744109a40f5a0a7d73075176cd281a
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5c4d19d..11e71c3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -142,13 +142,8 @@ extern int max_lock_depth;
 
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
-#ifndef CONFIG_UTS_NS
 static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
-#else
-static int proc_do_utsns_string(ctl_table *table, int write, struct file *filp,
-		  void __user *buffer, size_t *lenp, loff_t *ppos);
-#endif
 
 static ctl_table root_table[];
 static struct ctl_table_header root_table_header =
@@ -291,7 +286,7 @@ static ctl_table kern_table[] = {
 		/* could maybe use __NEW_UTS_LEN here? */
 		.maxlen		= FIELD_SIZEOF(struct new_utsname, sysname),
 		.mode		= 0444,
-		.proc_handler	= &proc_do_utsns_string,
+		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
 	{
@@ -300,7 +295,7 @@ static ctl_table kern_table[] = {
 		.data		= NULL,
 		.maxlen		= FIELD_SIZEOF(struct new_utsname, release),
 		.mode		= 0444,
-		.proc_handler	= &proc_do_utsns_string,
+		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
 	{
@@ -309,7 +304,7 @@ static ctl_table kern_table[] = {
 		.data		= NULL,
 		.maxlen		= FIELD_SIZEOF(struct new_utsname, version),
 		.mode		= 0444,
-		.proc_handler	= &proc_do_utsns_string,
+		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
 	{
@@ -318,7 +313,7 @@ static ctl_table kern_table[] = {
 		.data		= NULL,
 		.maxlen		= FIELD_SIZEOF(struct new_utsname, nodename),
 		.mode		= 0644,
-		.proc_handler	= &proc_do_utsns_string,
+		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
 	{
@@ -327,7 +322,7 @@ static ctl_table kern_table[] = {
 		.data		= NULL,
 		.maxlen		= FIELD_SIZEOF(struct new_utsname, domainname),
 		.mode		= 0644,
-		.proc_handler	= &proc_do_utsns_string,
+		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
 #endif /* !CONFIG_UTS_NS */
@@ -1791,7 +1786,7 @@ static int proc_do_uts_string(ctl_table 
 	return r;
 }
 #else /* !CONFIG_UTS_NS */
-static int proc_do_utsns_string(ctl_table *table, int write, struct file *filp,
+static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int r;
@@ -2461,11 +2456,19 @@ int proc_dostring(ctl_table *table, int 
 }
 
 static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
-			    void __user *buffer, size_t *lenp, loff_t *ppos)
+		void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
+#ifdef CONFIG_SYSVIPC
+static int proc_do_ipc_string(ctl_table *table, int write, struct file *filp,
+		void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
+#endif
+
 int proc_dointvec(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos)
 {
-- 
1.1.6
