Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270088AbUJHSVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270088AbUJHSVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270078AbUJHSUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:20:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52109 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S270051AbUJHSFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:05:53 -0400
Date: Fri, 8 Oct 2004 13:05:42 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041008180542.GA3068@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041007124221.D2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007124221.D2357@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch is against -mm3, and includes the suggestions Chris
last sent out.

> I think encoding error, testing error, then returning hardcoded error is
> wasteful.  I'd change alloc_task_security api to return NULL on ENOMEM.
...
> Do you need all those alloc_task_security's in there?  Why not just one
> at the top?

Good points - cleaned these up.

>  And are you convinced there's no leak on the other kmalloc
> failures?

Yes, they each get freed if this function is called again on the same
item, and they get freed when the task closes.  Unless I'm missing
something...

thanks,
-serge

Changelog:
	Sep 10, 2004: original version
	Sep 12, 2004: add ipv6 support
	Sep 13, 2004: support simultaneous ipv4+ipv6
	Oct  6, 2004: move kref release function to kref_put from kref_init
	Oct  7, 2004: requested code cleanups (mainly nix #defines)
	Oct  8, 2004: more cleanups.

Signed-Off-By: Serge E. Hallyn <serue@us.ibm.com>

diff -Nrup linux-2.6.9-rc3-mm3/security/bsdjail.c linux-2.6.9-rc3-mm3-jail/security/bsdjail.c
--- linux-2.6.9-rc3-mm3/security/bsdjail.c	2004-10-08 13:56:38.851128096 -0500
+++ linux-2.6.9-rc3-mm3-jail/security/bsdjail.c	2004-10-08 12:59:41.000000000 -0500
@@ -27,16 +27,16 @@
 #include <linux/ip.h>
 #include <net/ipv6.h>
 #include <linux/mount.h>
-#include <asm/uaccess.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
 #include <linux/seq_file.h>
 #include <linux/un.h>
 #include <linux/smp_lock.h>
 #include <linux/kref.h>
+#include <asm/uaccess.h>
 
-static int jail_debug = 0;
-MODULE_PARM(jail_debug, "i");
+static int jail_debug;
+module_param(jail_debug, int, 0);
 MODULE_PARM_DESC(jail_debug, "Print bsd jail debugging messages.\n");
 
 #define DBG 0
@@ -52,7 +52,7 @@ MODULE_PARM_DESC(jail_debug, "Print bsd 
 #define MY_NAME "bsdjail"
 
 /* flag to keep track of how we were registered */
-static int secondary = 0;
+static int secondary;
 
 /*
  * The task structure holding jail information.
@@ -80,7 +80,7 @@ struct jail_struct {
 	int cur_nrtask;	/* current number of tasks within this jail. */
 	long maxtimeslice;      /* max timeslice in ms for procs in this jail */
 	long nice;      	/* nice level for processes in this jail */
-	long max_data, max_memlock;  /* equivalent to RLIMIT_{DATA,MEMLOCK} */
+	long max_data, max_memlock;  /* equivalent to RLIMIT_{DATA, MEMLOCK} */
 /* values for the jail_flags field */
 #define IN_USE 1	 /* if 0, task is setting up jail, not yet in it */
 #define GOT_IPV4 2
@@ -88,29 +88,6 @@ struct jail_struct {
 	char jail_flags;
 };
 
-#define in_use(x) (x->jail_flags & IN_USE)
-#define set_in_use(x) (x->jail_flags |= IN_USE)
-
-#define got_network(x) (x->jail_flags & (GOT_IPV4 | GOT_IPV6))
-#define got_ipv4(x) (x->jail_flags & (GOT_IPV4))
-#define got_ipv6(x) (x->jail_flags & (GOT_IPV6))
-#define set_ipv4(x) (x->jail_flags |= GOT_IPV4)
-#define set_ipv6(x) (x->jail_flags |= GOT_IPV6)
-#define unset_got_ipv4(x) (x->jail_flags &= ~GOT_IPV4)
-#define unset_got_ipv6(x) (x->jail_flags &= ~GOT_IPV6)
-
-/*
- * structs, defines, and functions to cope with stacking
- */
-
-#define get_task_security(task) (task->security)
-#define get_inode_security(inode) (inode->i_security)
-#define get_sock_security(sock) (sock->sk_security)
-#define get_file_security(file) (file->f_security)
-#define get_ipc_security(ipc)	(ipc->security)
-
-#define jail_of(proc) (get_task_security(proc))
-
 /*
  * disable_jail:  A jail which was in use, but has no references
  * left, is disabled - we free up the mountpoint and dentry, and
@@ -134,12 +111,9 @@ static void free_jail(struct jail_struct
 	if (!tsec)
 		return;
 
-	if (tsec->root_pathname)
-		kfree(tsec->root_pathname);
-	if (tsec->ip4_addr_name)
-		kfree(tsec->ip4_addr_name);
-	if (tsec->ip6_addr_name)
-		kfree(tsec->ip6_addr_name);
+	kfree(tsec->root_pathname);
+	kfree(tsec->ip4_addr_name);
+	kfree(tsec->ip6_addr_name);
 	kfree(tsec);
 }
 
@@ -151,17 +125,11 @@ static void release_jail(struct kref *kr
 {
 	struct jail_struct *tsec;
 
-	tsec = container_of(kref,struct jail_struct,kref);
+	tsec = container_of(kref, struct jail_struct, kref);
 	disable_jail(tsec);
 	free_jail(tsec);
 }
 
-#define set_task_security(task,data) task->security = data
-#define set_inode_security(inode,data) inode->i_security = data
-#define set_sock_security(sock,data) sock->sk_security = data
-#define set_file_security(file,data) file->f_security = data
-#define set_ipc_security(ipc,data)   ipc.security = data
-
 /*
  * jail_task_free_security: this is the callback hooked into LSM.
  * If there was no task->security field for bsdjail, do nothing.
@@ -171,20 +139,18 @@ static void release_jail(struct kref *kr
  */
 static void jail_task_free_security(struct task_struct *task)
 {
-	struct jail_struct *tsec;
-
-	tsec = get_task_security(task);
+	struct jail_struct *tsec = task->security;
 
 	if (!tsec)
 		return;
 
-	if (!in_use(tsec)) {
+	if (!(tsec->jail_flags & IN_USE)) {
 		/*
 		 * someone did 'echo -n x > /proc/<pid>/attr/exec' but
 		 * then forked before execing.  Nuke the old info.
 		 */
 		free_jail(tsec);
-		set_task_security(task,NULL);
+		task->security = NULL;
 		return;
 	}
 	tsec->cur_nrtask--;
@@ -196,20 +162,21 @@ static struct jail_struct *
 alloc_task_security(struct task_struct *tsk)
 {
 	struct jail_struct *tsec;
+
 	tsec = kmalloc(sizeof(struct jail_struct), GFP_KERNEL);
-	if (!tsec)
-		return ERR_PTR(-ENOMEM);
-	memset(tsec, 0, sizeof(struct jail_struct));
-	set_task_security(tsk, tsec);
+	if (tsec) {
+		memset(tsec, 0, sizeof(struct jail_struct));
+		tsk->security = tsec;
+	}
 	return tsec;
 }
 
 static inline int
 in_jail(struct task_struct *t)
 {
-	struct jail_struct *tsec = jail_of(t);
+	struct jail_struct *tsec = t->security;
 
-	if (tsec && in_use(tsec))
+	if (tsec && (tsec->jail_flags & IN_USE))
 		return 1;
 
 	return 0;
@@ -223,27 +190,27 @@ in_jail(struct task_struct *t)
 static void
 setup_netaddress(struct jail_struct *tsec)
 {
-	unsigned int a,b,c,d, i;
+	unsigned int a, b, c, d, i;
 	unsigned int x[8];
 
-	unset_got_ipv4(tsec);
+	tsec->jail_flags &= ~(GOT_IPV4 | GOT_IPV6);
 	tsec->addr4 = 0;
-	unset_got_ipv6(tsec);
 	ipv6_addr_set(&tsec->addr6, 0, 0, 0, 0);
 
 	if (tsec->ip4_addr_name) {
-		if (sscanf(tsec->ip4_addr_name,"%u.%u.%u.%u",&a,&b,&c,&d)!=4)
+		if (sscanf(tsec->ip4_addr_name, "%u.%u.%u.%u",
+					&a, &b, &c, &d) != 4)
 			return;
 		if (a>255 || b>255 || c>255 || d>255)
 			return;
-		tsec->addr4 = htonl((a<<24)|(b<<16)|(c<<8)|d);
-		set_ipv4(tsec);
+		tsec->addr4 = htonl((a<<24) | (b<<16) | (c<<8) | d);
+		tsec->jail_flags |= GOT_IPV4;
 		bsdj_debug(DBG, "Network (ipv4) set up (%s)\n",
 			tsec->ip4_addr_name);
 	}
 
 	if (tsec->ip6_addr_name) {
-		if (sscanf(tsec->ip6_addr_name,"%x:%x:%x:%x:%x:%x:%x:%x",
+		if (sscanf(tsec->ip6_addr_name, "%x:%x:%x:%x:%x:%x:%x:%x",
 			&x[0], &x[1], &x[2], &x[3], &x[4], &x[5], &x[6],
 			&x[7]) != 8) {
 			printk(KERN_INFO "%s: bad ipv6 addr %s\n", __FUNCTION__,
@@ -257,7 +224,7 @@ setup_netaddress(struct jail_struct *tse
 			}
 			tsec->addr6.in6_u.u6_addr16[i] = htons(x[i]);
 		}
-		set_ipv6(tsec);
+		tsec->jail_flags |= GOT_IPV6;
 		bsdj_debug(DBG, "Network (ipv6) set up (%s)\n",
 			tsec->ip6_addr_name);
 	}
@@ -275,10 +242,9 @@ setup_netaddress(struct jail_struct *tse
 static int enable_jail(struct task_struct *tsk)
 {
 	struct nameidata nd;
-	struct jail_struct *tsec;
+	struct jail_struct *tsec = tsk->security;
 	int retval = -EFAULT;
 
-	tsec = jail_of(tsk);
 	if (!tsec || !tsec->root_pathname)
 		goto out;
 
@@ -339,7 +305,7 @@ static int enable_jail(struct task_struc
 	tsec->dentry = dget(nd.dentry);
 	path_release(&nd);
 	kref_init(&tsec->kref);
-	set_in_use(tsec);
+	tsec->jail_flags |= IN_USE;
 
 	/* won't let ourselves be removed until this jail goes away */
 	try_module_get(THIS_MODULE);
@@ -361,108 +327,66 @@ out:
 static int
 jail_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 	long val;
 	int start, len;
 
-	if (tsec && in_use(tsec))
+	if (tsec && (tsec->jail_flags & IN_USE))
 		return -EINVAL;  /* let them guess why */
 
 	if (p != current || strcmp(name, "exec"))
 		return -EPERM;
 
-	if (strncmp(value, "root ", 5)==0) {
+	if (!tsec) {
+		tsec = alloc_task_security(current);
 		if (!tsec)
-			tsec = alloc_task_security(current);
-		if (IS_ERR(tsec))
 			return -ENOMEM;
+	}
 
-		if (tsec->root_pathname)
-			kfree(tsec->root_pathname);
+	if (strncmp(value, "root ", 5) == 0) {
+		kfree(tsec->root_pathname);
 		start = 5;
-		len = size-start;
-		tsec->root_pathname = kmalloc(len+1, GFP_KERNEL);
+		len = size - start + 1;
+		tsec->root_pathname = kmalloc(len, GFP_KERNEL);
 		if (!tsec->root_pathname)
 			return -ENOMEM;
-		strlcpy(tsec->root_pathname, value+start, len+1);
-	} else if (strncmp(value, "ip ", 3)==0) {
-		if (!tsec)
-			tsec = alloc_task_security(current);
-		if (IS_ERR(tsec))
-			return -ENOMEM;
-
-		if (tsec->ip4_addr_name)
-			kfree(tsec->ip4_addr_name);
+		strlcpy(tsec->root_pathname, value+start, len);
+	} else if (strncmp(value, "ip ", 3) == 0) {
+		kfree(tsec->ip4_addr_name);
 		start = 3;
-		len = size-start;
-		tsec->ip4_addr_name = kmalloc(len+1, GFP_KERNEL);
+		len = size - start + 1;
+		tsec->ip4_addr_name = kmalloc(len, GFP_KERNEL);
 		if (!tsec->ip4_addr_name)
 			return -ENOMEM;
-		strlcpy(tsec->ip4_addr_name, value+start, len+1);
+		strlcpy(tsec->ip4_addr_name, value+start, len);
 	} else if (strncmp(value, "ip6 ", 4) == 0) {
-		if (!tsec)
-			tsec = alloc_task_security(current);
-		if (IS_ERR(tsec))
-			return -ENOMEM;
-
-		if (tsec->ip6_addr_name)
-			kfree(tsec->ip6_addr_name);
+		kfree(tsec->ip6_addr_name);
 		start = 4;
-		len = size-start;
-		tsec->ip6_addr_name = kmalloc(len+1, GFP_KERNEL);
+		len = size - start + 1;
+		tsec->ip6_addr_name = kmalloc(len, GFP_KERNEL);
 		if (!tsec->ip6_addr_name)
 			return -ENOMEM;
-		strlcpy(tsec->ip6_addr_name, value+start, len+1);
+		strlcpy(tsec->ip6_addr_name, value+start, len);
 
 	/* the next two are equivalent */
-	} else if (strncmp(value, "slice ", 6)==0) {
-		if (!tsec)
-			tsec = alloc_task_security(current);
-		if (IS_ERR(tsec))
-			return -ENOMEM;
-
+	} else if (strncmp(value, "slice ", 6) == 0) {
 		val = simple_strtoul(value+6, NULL, 0);
 		tsec->maxtimeslice = val;
-	} else if (strncmp(value, "timeslice ", 10)==0) {
-		if (!tsec)
-			tsec = alloc_task_security(current);
-		if (IS_ERR(tsec))
-			return -ENOMEM;
-
+	} else if (strncmp(value, "timeslice ", 10) == 0) {
 		val = simple_strtoul(value+10, NULL, 0);
 		tsec->maxtimeslice = val;
-	} else if (strncmp(value, "nrtask ", 7)==0) {
-		if (!tsec)
-			tsec = alloc_task_security(current);
-		if (IS_ERR(tsec))
-			return -ENOMEM;
-
+	} else if (strncmp(value, "nrtask ", 7) == 0) {
 		val = (int) simple_strtol(value+7, NULL, 0);
 		if (val < 1)
 			return -EINVAL;
 		tsec->max_nrtask = val;
-	} else if (strncmp(value, "memlock ", 8)==0) {
-		if (!tsec)
-			tsec = alloc_task_security(current);
-		if (IS_ERR(tsec))
-			return -ENOMEM;
-
+	} else if (strncmp(value, "memlock ", 8) == 0) {
 		val = simple_strtoul(value+8, NULL, 0);
 		tsec->max_memlock = val;
-	} else if (strncmp(value, "data ", 5)==0) {
-		if (!tsec)
-			tsec = alloc_task_security(current);
-		if (IS_ERR(tsec))
-			return -ENOMEM;
-
+	} else if (strncmp(value, "data ", 5) == 0) {
 		val = simple_strtoul(value+5, NULL, 0);
 		tsec->max_data = val;
-	} else if (strncmp(value, "nice ", 5)==0) {
-		if (!tsec)
-			tsec = alloc_task_security(current);
-		if (IS_ERR(tsec))
-			return -ENOMEM;
-
+	} else if (strncmp(value, "nice ", 5) == 0) {
 		val = simple_strtoul(value+5, NULL, 0);
 		tsec->nice = val;
 	} else
@@ -510,9 +434,9 @@ jail_getprocattr(struct task_struct *p, 
 	int err = 0;
 
 	if (in_jail(current)) {
-		if (strcmp(name, "current")==0) {
+		if (strcmp(name, "current") == 0) {
 			/* provide network info */
-			err = print_jail_net_info(jail_of(current), value,
+			err = print_jail_net_info(current->security, value,
 				size);
 			return err;
 		}
@@ -537,8 +461,8 @@ jail_getprocattr(struct task_struct *p, 
 	if (strcmp(name, "current"))
 		return -EPERM;
 
-	tsec = jail_of(p);
-	if (!tsec || !in_use(tsec)) {
+	tsec = p->security;
+	if (!tsec || !(tsec->jail_flags & IN_USE)) {
 		err = snprintf(value, size, "Not Jailed\n");
 	} else {
 		err = snprintf(value, size,
@@ -570,16 +494,12 @@ jail_file_send_sigiotask(struct task_str
        int fd, int reason)
 {
 	struct file *file;
-	struct jail_struct *tsec, *fsec;
 
 	if (!in_jail(current))
 		return 0;
 
-        file = (struct file *)((long)fown - offsetof(struct file,f_owner));
-	tsec = jail_of(tsk);
-	fsec = get_file_security(file);
-
-	if (fsec != tsec)
+	file = (struct file *) ((long)fown - offsetof(struct file, f_owner));
+	if (file->f_security != tsk->security)
 		return -EPERM;
 
 	return 0;
@@ -590,8 +510,8 @@ jail_file_set_fowner(struct file *file)
 {
 	struct jail_struct *tsec;
 
-	tsec = jail_of(current);
-	set_file_security(file, tsec);
+	tsec = current->security;
+	file->f_security = tsec;
 	if (tsec)
 		kref_get(&tsec->kref);
 
@@ -602,33 +522,33 @@ static void free_ipc_security(struct ker
 {
 	struct jail_struct *tsec;
 
-	tsec = get_ipc_security(ipc);
+	tsec = ipc->security;
 	if (!tsec)
 		return;
 	kref_put(&tsec->kref, release_jail);
-	set_ipc_security((*ipc), NULL);
+	ipc->security = NULL;
 }
 
 static void free_file_security(struct file *file)
 {
 	struct jail_struct *tsec;
 
-	tsec = get_file_security(file);
+	tsec = file->f_security;
 	if (!tsec)
 		return;
 	kref_put(&tsec->kref, release_jail);
-	set_file_security(file, NULL);
+	file->f_security = NULL;
 }
 
 static void free_inode_security(struct inode *inode)
 {
 	struct jail_struct *tsec;
 
-	tsec = get_inode_security(inode);
+	tsec = inode->i_security;
 	if (!tsec)
 		return;
 	kref_put(&tsec->kref, release_jail);
-	set_inode_security(inode, NULL);
+	inode->i_security = NULL;
 }
 
 /*
@@ -638,10 +558,10 @@ static void free_inode_security(struct i
 static int
 jail_ptrace (struct task_struct *tracer, struct task_struct *tracee)
 {
-	struct jail_struct *tsec = jail_of(tracer);
+	struct jail_struct *tsec = tracer->security;
 
-	if (tsec && in_use(tsec)) {
-		if (tsec == jail_of(tracee))
+	if (tsec && (tsec->jail_flags & IN_USE)) {
+		if (tsec == tracee->security)
 			return 0;
 		return -EPERM;
 	}
@@ -664,10 +584,10 @@ static inline int jail_inet4_bind(struct
 	struct sockaddr_in *inaddr;
 	__u32 sin_addr, jailaddr;
 
-	if (!got_ipv4(tsec))
+	if (!(tsec->jail_flags & GOT_IPV4))
 		return -EPERM;
 
-	inaddr = (struct sockaddr_in *)address;
+	inaddr = (struct sockaddr_in *) address;
 	sin_addr = inaddr->sin_addr.s_addr;
 	jailaddr = tsec->addr4;
 
@@ -692,17 +612,17 @@ jail_inet6_bind(struct socket *sock, str
 	struct sockaddr_in6 *inaddr6;
 	struct in6_addr *sin6_addr, *jailaddr;
 
-	if (!got_ipv6(tsec))
+	if (!(tsec->jail_flags & GOT_IPV6))
 		return -EPERM;
 
-	inaddr6 = (struct sockaddr_in6 *)address;
+	inaddr6 = (struct sockaddr_in6 *) address;
 	sin6_addr = &inaddr6->sin6_addr;
 	jailaddr = &tsec->addr6;
 
-	if (ipv6_addr_cmp(jailaddr, sin6_addr)==0)
+	if (ipv6_addr_cmp(jailaddr, sin6_addr) == 0)
 		return 0;
 
-	if (ipv6_addr_cmp(sin6_addr, &in6addr_loopback)==0) {
+	if (ipv6_addr_cmp(sin6_addr, &in6addr_loopback) == 0) {
 		ipv6_addr_copy(sin6_addr, jailaddr);
 		return 0;
 	}
@@ -720,15 +640,15 @@ jail_inet6_bind(struct socket *sock, str
 static int
 jail_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE))
 		return 0;
 
 	if (sock->sk->sk_family == AF_UNIX)
 		return jail_socket_unix_bind(sock, address, addrlen);
 
-	if (!got_network(tsec))
+	if (!(tsec->jail_flags & (GOT_IPV4 | GOT_IPV6)))
 		/* If we want to be strict, we could just
 		 * deny net access when lacking a pseudo ip.
 		 * For now we just allow it. */
@@ -752,18 +672,19 @@ jail_socket_bind(struct socket *sock, st
 static int
 jail_socket_create(int family, int type, int protocol, int kern)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec) || kern || !got_network(tsec))
+	if (!tsec || kern || !(tsec->jail_flags & IN_USE) ||
+			!(tsec->jail_flags & (GOT_IPV4 | GOT_IPV6)))
 		return 0;
 
 	switch(family) {
 		case AF_INET:
-			if (got_ipv4(tsec))
+			if (tsec->jail_flags & GOT_IPV4)
 				return 0;
 			return -EPERM;
 		case AF_INET6:
-			if (got_ipv6(tsec))
+			if (tsec->jail_flags & GOT_IPV6)
 				return 0;
 			return -EPERM;
 		default:
@@ -779,9 +700,10 @@ jail_socket_post_create(struct socket *s
 {
 	struct inet_opt *inet;
 	struct ipv6_pinfo *inet6;
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec) || kern || !got_network(tsec))
+	if (!tsec || kern || !(tsec->jail_flags & IN_USE) ||
+			!(tsec->jail_flags & (GOT_IPV4 | GOT_IPV6)))
 		return;
 
 	switch(family) {
@@ -805,9 +727,10 @@ jail_socket_listen(struct socket *sock, 
 {
 	struct inet_opt *inet;
 	struct ipv6_pinfo *inet6;
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec) || !got_network(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE) ||
+			!(tsec->jail_flags & (GOT_IPV4 | GOT_IPV6)))
 		return 0;
 
 	switch (sock->sk->sk_family) {
@@ -819,7 +742,7 @@ jail_socket_listen(struct socket *sock, 
 
 		case AF_INET6:
 			inet6 = inet6_sk(sock->sk);
-			if (ipv6_addr_cmp(&inet6->saddr, &tsec->addr6)==0)
+			if (ipv6_addr_cmp(&inet6->saddr, &tsec->addr6) == 0)
 				return 0;
 			return -EPERM;
 
@@ -833,11 +756,11 @@ static void free_sock_security(struct so
 {
 	struct jail_struct *tsec;
 
-	tsec = get_sock_security(sk);
+	tsec = sk->sk_security;
 	if (!tsec)
 		return;
 	kref_put(&tsec->kref, release_jail);
-	set_sock_security(sk, NULL);
+	sk->sk_security = NULL;
 }
 
 /*
@@ -854,12 +777,12 @@ jail_socket_unix_bind(struct socket *soc
 	if (sock->sk->sk_family != AF_UNIX)
 		return 0;
 
-	sunaddr = (struct sockaddr_un *)address;
+	sunaddr = (struct sockaddr_un *) address;
 	if (sunaddr->sun_path[0] != 0)
 		return 0;
 
-	tsec = jail_of(current);
-	set_sock_security(sock->sk, tsec);
+	tsec = current->security;
+	sock->sk->sk_security = tsec;
 	if (tsec)
 		kref_get(&tsec->kref);
 	return 0;
@@ -874,8 +797,8 @@ jail_socket_unix_may_send(struct socket 
 {
 	struct jail_struct *tsec, *ssec;
 
-	tsec = jail_of(current);  /* jail of sending process */
-	ssec = get_sock_security(other->sk);  /* jail of receiver */
+	tsec = current->security;  /* jail of sending process */
+	ssec = other->sk->sk_security;  /* jail of receiver */
 
 	if (tsec != ssec)
 		return -EPERM;
@@ -889,8 +812,8 @@ jail_socket_unix_stream_connect(struct s
 {
 	struct jail_struct *tsec, *ssec;
 
-	tsec = jail_of(current);  /* jail of sending process */
-	ssec = get_sock_security(other->sk);  /* jail of receiver */
+	tsec = current->security;  /* jail of sending process */
+	ssec = other->sk->sk_security;  /* jail of receiver */
 
 	if (tsec != ssec)
 		return -EPERM;
@@ -953,9 +876,9 @@ jail_capable (struct task_struct *tsk, i
 static inline int
 jail_security_task_create (unsigned long clone_flags)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE))
 		return 0;
 
 	if (tsec->max_nrtask && tsec->cur_nrtask >= tsec->max_nrtask)
@@ -969,12 +892,12 @@ jail_security_task_create (unsigned long
 static int
 jail_task_alloc_security(struct task_struct *tsk)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE))
 		return 0;
 
-	set_task_security(tsk, tsec);
+	tsk->security = tsec;
 	kref_get(&tsec->kref);
 	tsec->cur_nrtask++;
 	if (tsec->maxtimeslice) {
@@ -998,14 +921,13 @@ jail_task_alloc_security(struct task_str
 static int
 jail_bprm_alloc_security(struct linux_binprm *bprm)
 {
-	struct jail_struct *tsec;
+	struct jail_struct *tsec = current->security;
 	int ret;
 
-	tsec = jail_of(current);
 	if (!tsec)
 		return 0;
 
-	if (in_use(tsec))
+	if (tsec->jail_flags & IN_USE)
 		return 0;
 
 	if (tsec->root_pathname) {
@@ -1073,23 +995,23 @@ static int
 jail_proc_inode_permission(struct inode *inode, int mask,
 				    struct nameidata *nd)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 	struct dentry *dentry = nd->dentry;
 	unsigned pid;
 
 	pid = name_to_int(dentry);
 	if (pid == ~0U) {
 		struct qstr *dname = &dentry->d_name;
-		if (strcmp(dname->name, "scsi")==0 ||
-			strcmp(dname->name, "sys")==0 ||
-			strcmp(dname->name, "ide")==0)
+		if (strcmp(dname->name, "scsi") == 0 ||
+			strcmp(dname->name, "sys") == 0 ||
+			strcmp(dname->name, "ide") == 0)
 			return -EPERM;
 		return 0;
 	}
 
 	if (dentry->d_parent != dentry->d_sb->s_root)
 		return 0;
-	if (get_inode_security(inode) != tsec)
+	if (inode->i_security != tsec)
 		return -ENOENT;
 
 	return 0;
@@ -1132,11 +1054,11 @@ is_jailroot_parent(struct dentry *candid
  */
 static int jail_task_lookup(struct task_struct *p)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
 	if (!tsec)
 		return 0;
-	if (tsec == jail_of(p))
+	if (tsec == p->security)
 		return 0;
 	return -EPERM;
 }
@@ -1146,14 +1068,14 @@ static int jail_task_lookup(struct task_
  */
 static void jail_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	struct jail_struct *tsec = jail_of(p);
+	struct jail_struct *tsec = p->security;
 
-	if (!tsec || !in_use(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE))
 		return;
-	if (get_inode_security(inode))
+	if (inode->i_security)
 		return;
 	kref_get(&tsec->kref);
-	set_inode_security(inode, tsec);
+	inode->i_security = tsec;
 }
 
 /*
@@ -1167,16 +1089,16 @@ static int
 jail_inode_permission(struct inode *inode, int mask,
 				    struct nameidata *nd)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE))
 		return 0;
 
 	if (!nd)
 		return 0;
 
 	if (nd->dentry &&
-		strcmp(nd->dentry->d_sb->s_type->name, "proc")==0) {
+		strcmp(nd->dentry->d_sb->s_type->name, "proc") == 0) {
 		return jail_proc_inode_permission(inode, mask, nd);
 
 	}
@@ -1187,10 +1109,10 @@ jail_inode_permission(struct inode *inod
 		return 0;
 
 	if (is_jailroot_parent(nd->dentry, tsec->dentry, tsec->mnt)) {
-		bsdj_debug(WARN,"Attempt to chdir(..) out of jail!\n"
-				"(%s is a subdir of %s)\n",
-				tsec->dentry->d_name.name,
-				nd->dentry->d_name.name);
+		bsdj_debug(WARN, "Attempt to chdir(..) out of jail!\n"
+				 "(%s is a subdir of %s)\n",
+				 tsec->dentry->d_name.name,
+				 nd->dentry->d_name.name);
 		return -EPERM;
 	}
 
@@ -1204,18 +1126,18 @@ jail_inode_permission(struct inode *inod
 static inline int
 generic_procpid_check(struct dentry *dentry)
 {
-	struct jail_struct *jail = jail_of(current);
+	struct jail_struct *jail = current->security;
 	unsigned pid = name_to_int(dentry);
 
-	if (!jail || !in_use(jail))
+	if (!jail || !(jail->jail_flags & IN_USE))
 		return 0;
 	if (pid == ~0U)
 		return 0;
-	if (strcmp(dentry->d_sb->s_type->name, "proc")!=0)
+	if (strcmp(dentry->d_sb->s_type->name, "proc") != 0)
 		return 0;
 	if (dentry->d_parent != dentry->d_sb->s_root)
 		return 0;
-	if (get_inode_security(dentry->d_inode) != jail)
+	if (dentry->d_inode->i_security != jail)
 		return -ENOENT;
 	return 0;
 }
@@ -1241,12 +1163,12 @@ jail_inode_getxattr(struct dentry *dentr
 static int
 jail_task_kill(struct task_struct *p, struct siginfo *info, int sig)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE))
 		return 0;
 
-	if (tsec == jail_of(p))
+	if (tsec == p->security)
 		return 0;
 
 	if (sig==SIGCHLD)
@@ -1283,12 +1205,12 @@ static int jail_task_setscheduler (struc
 static inline int
 basic_ipc_security_check(struct kern_ipc_perm *p, struct task_struct *target)
 {
-	struct jail_struct *tsec = jail_of(target);
+	struct jail_struct *tsec = target->security;
 
-	if (!tsec || !in_use(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE))
 		return 0;
 
-	if (get_ipc_security(p) != tsec)
+	if (p->security != tsec)
 		return -EPERM;
 
 	return 0;
@@ -1303,11 +1225,11 @@ jail_ipc_permission(struct kern_ipc_perm
 static int
 jail_shm_alloc_security (struct shmid_kernel *shp)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE))
 		return 0;
-	set_ipc_security(shp->shm_perm, tsec);
+	shp->shm_perm.security = tsec;
 	kref_get(&tsec->kref);
 	return 0;
 }
@@ -1342,11 +1264,11 @@ jail_shm_shmat(struct shmid_kernel *shp,
 static int
 jail_msg_queue_alloc(struct msg_queue *msq)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE))
 		return 0;
-	set_ipc_security(msq->q_perm, tsec);
+	msq->q_perm.security = tsec;
 	kref_get(&tsec->kref);
 	return 0;
 }
@@ -1388,11 +1310,11 @@ jail_msg_queue_msgrcv(struct msg_queue *
 static int
 jail_sem_alloc_security(struct sem_array *sma)
 {
-	struct jail_struct *tsec = jail_of(current);
+	struct jail_struct *tsec = current->security;
 
-	if (!tsec || !in_use(tsec))
+	if (!tsec || !(tsec->jail_flags & IN_USE))
 		return 0;
-	set_ipc_security(sma->sem_perm, tsec);
+	sma->sem_perm.security = tsec;
 	kref_get(&tsec->kref);
 	return 0;
 }
