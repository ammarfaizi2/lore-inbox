Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289367AbSAVTpu>; Tue, 22 Jan 2002 14:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289375AbSAVTpe>; Tue, 22 Jan 2002 14:45:34 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:36942 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289367AbSAVTpU>; Tue, 22 Jan 2002 14:45:20 -0500
Date: Tue, 22 Jan 2002 14:45:15 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Rainer Krienke <krienke@uni-koblenz.de>, Pete Zaitcev <zaitcev@redhat.com>,
        linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Message-ID: <20020122144515.A5647@devserv.devel.redhat.com>
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <shszo36pt1h.fsf@charged.uio.no> <200201221308.g0MD8EY16176@bliss.uni-koblenz.de> <E16T0ye-0002K6-00@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16T0ye-0002K6-00@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Jan 22, 2002 at 02:28:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Trond Myklebust <trond.myklebust@fys.uio.no>
> Date: Tue, 22 Jan 2002 14:28:39 +0100

> The fix would be to add an argument to the function pmap_create() in order to 
> allow rpc_register() to specify that the call to xprt_create_proto() should 
> set up the socket on a secure port.

I am sorry to miss this in our unit test.

-- Pete

--- linux-2.4.9-unmaj-7.diff ---
Copyright 2001 Red Hat, Inc.
GPL v2 - XXX fill in the legal blob.

-7 is with pmap_clnt fix for nfsd registration with portmapper.

diff -ur -X dontdiff linux-2.4.9-18.3/Documentation/Configure.help linux-2.4.9-18.3-p3/Documentation/Configure.help
--- linux-2.4.9-18.3/Documentation/Configure.help	Tue Dec 18 13:01:06 2001
+++ linux-2.4.9-18.3-p3/Documentation/Configure.help	Tue Dec 18 13:53:25 2001
@@ -23926,4 +23926,13 @@
   in the lm_sensors package, which you can download at 
   http://www.lm-sensors.nu
 
+Additional unnamed block majors
+CONFIG_MORE_UNNAMED_MAJORS
+  This option allows to use majors 12, 14, 38, and 39 in addition to
+  major 0 for unnamed block devices, thus letting you to mount 1279
+  virtual filesystems.
+
+  If unsure, answer N. Thousands of mount points are unlikely to work
+  anyways.
+
 # End:
diff -ur -X dontdiff linux-2.4.9-18.3/Makefile linux-2.4.9-18.3-p3/Makefile
--- linux-2.4.9-18.3/Makefile	Tue Dec 18 13:10:50 2001
+++ linux-2.4.9-18.3-p3/Makefile	Thu Jan  3 17:02:41 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 9
-EXTRAVERSION = -18.3
+EXTRAVERSION = -18.3-p3
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
@@ -339,7 +339,8 @@
 $(TOPDIR)/include/linux/compile.h: include/linux/compile.h
 
 newversion:
-	. scripts/mkversion > .version
+	. scripts/mkversion > .tmpversion
+	@mv -f .tmpversion .version
 
 include/linux/compile.h: $(CONFIGURATION) include/linux/version.h newversion
 	@echo -n \#define UTS_VERSION \"\#`cat .version` > .ver
diff -ur -X dontdiff linux-2.4.9-18.3/fs/Config.in linux-2.4.9-18.3-p3/fs/Config.in
--- linux-2.4.9-18.3/fs/Config.in	Tue Dec 18 13:00:48 2001
+++ linux-2.4.9-18.3-p3/fs/Config.in	Tue Dec 18 13:58:31 2001
@@ -137,6 +137,8 @@
    define_bool CONFIG_SMB_FS n
 fi
 
+bool 'More majors for unnamed block devices' CONFIG_MORE_UNNAMED_MAJORS
+
 mainmenu_option next_comment
 comment 'Partition Types'
 source fs/partitions/Config.in
diff -ur -X dontdiff linux-2.4.9-18.3/fs/lockd/clntproc.c linux-2.4.9-18.3-p3/fs/lockd/clntproc.c
--- linux-2.4.9-18.3/fs/lockd/clntproc.c	Tue Dec 18 13:01:03 2001
+++ linux-2.4.9-18.3-p3/fs/lockd/clntproc.c	Mon Jan  7 13:28:29 2002
@@ -107,6 +107,7 @@
 	sigset_t		oldset;
 	unsigned long		flags;
 	int			status, proto, vers;
+	int			resport;
 
 	vers = (NFS_PROTO(inode)->version == 3) ? 4 : 1;
 	if (NFS_PROTO(inode)->version > 3) {
@@ -116,6 +117,7 @@
 
 	/* Retrieve transport protocol from NFS client */
 	proto = NFS_CLIENT(inode)->cl_xprt->prot;
+	resport = NFS_CLIENT(inode)->cl_xprt->resport;
 
 	if (!(host = nlmclnt_lookup_host(NFS_ADDR(inode), proto, vers)))
 		return -ENOLCK;
@@ -127,7 +129,7 @@
 
 		/* Bind an rpc client to this host handle (does not
 		 * perform a portmapper lookup) */
-		if (!(clnt = nlm_bind_host(host))) {
+		if (!(clnt = nlm_bind_host(host, resport))) {
 			status = -ENOLCK;
 			goto done;
 		}
@@ -162,6 +164,7 @@
 		locks_init_lock(&call->a_res.lock.fl);
 	}
 	call->a_host = host;
+	call->a_resport = resport;
 
 	/* Set up the argument struct */
 	nlmclnt_setlockargs(call, fl);
@@ -260,7 +263,7 @@
 		}
 
 		/* If we have no RPC client yet, create one. */
-		if ((clnt = nlm_bind_host(host)) == NULL)
+		if ((clnt = nlm_bind_host(host, req->a_resport)) == NULL)
 			return -ENOLCK;
 
 		/* Perform the RPC call. If an error occurs, try again */
@@ -328,7 +331,7 @@
 			nlm_procname(proc), host->h_name);
 
 	/* If we have no RPC client yet, create one. */
-	if ((clnt = nlm_bind_host(host)) == NULL)
+	if ((clnt = nlm_bind_host(host, req->a_resport)) == NULL)
 		return -ENOLCK;
 
         /* bootstrap and kick off the async RPC call */
@@ -356,7 +359,7 @@
 			nlm_procname(proc), host->h_name);
 
 	/* If we have no RPC client yet, create one. */
-	if ((clnt = nlm_bind_host(host)) == NULL)
+	if ((clnt = nlm_bind_host(host, req->a_resport)) == NULL)
 		return -ENOLCK;
 
         /* bootstrap and kick off the async RPC call */
diff -ur -X dontdiff linux-2.4.9-18.3/fs/lockd/host.c linux-2.4.9-18.3-p3/fs/lockd/host.c
--- linux-2.4.9-18.3/fs/lockd/host.c	Tue Dec 18 13:00:49 2001
+++ linux-2.4.9-18.3-p3/fs/lockd/host.c	Mon Jan  7 12:34:26 2002
@@ -163,7 +163,7 @@
  * Create the NLM RPC client for an NLM peer
  */
 struct rpc_clnt *
-nlm_bind_host(struct nlm_host *host)
+nlm_bind_host(struct nlm_host *host, int resport)
 {
 	struct rpc_clnt	*clnt;
 	struct rpc_xprt	*xprt;
@@ -187,15 +187,19 @@
 					host->h_nextrebind - jiffies);
 		}
 	} else {
-		uid_t saved_fsuid = current->fsuid;
-		kernel_cap_t saved_cap = current->cap_effective;
+		if (resport) {
+			uid_t saved_fsuid = current->fsuid;
+			kernel_cap_t saved_cap = current->cap_effective;
 
-		/* Create RPC socket as root user so we get a priv port */
-		current->fsuid = 0;
-		cap_raise (current->cap_effective, CAP_NET_BIND_SERVICE);
-		xprt = xprt_create_proto(host->h_proto, &host->h_addr, NULL);
-		current->fsuid = saved_fsuid;
-		current->cap_effective = saved_cap;
+			/* Create RPC socket as root user so we get a priv port */
+			current->fsuid = 0;
+			cap_raise (current->cap_effective, CAP_NET_BIND_SERVICE);
+			xprt = xprt_create_proto(host->h_proto, &host->h_addr, NULL, 1);
+			current->fsuid = saved_fsuid;
+			current->cap_effective = saved_cap;
+		} else {
+			xprt = xprt_create_proto(host->h_proto, &host->h_addr, NULL, 0);
+		}
 		if (xprt == NULL)
 			goto forgetit;
 
diff -ur -X dontdiff linux-2.4.9-18.3/fs/lockd/mon.c linux-2.4.9-18.3-p3/fs/lockd/mon.c
--- linux-2.4.9-18.3/fs/lockd/mon.c	Tue Dec 18 13:00:49 2001
+++ linux-2.4.9-18.3-p3/fs/lockd/mon.c	Sun Jan  6 01:08:03 2002
@@ -110,7 +110,7 @@
 	sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 	sin.sin_port = 0;
 
-	xprt = xprt_create_proto(IPPROTO_UDP, &sin, NULL);
+	xprt = xprt_create_proto(IPPROTO_UDP, &sin, NULL, 1);
 	if (!xprt)
 		goto out;
 
diff -ur -X dontdiff linux-2.4.9-18.3/fs/nfs/inode.c linux-2.4.9-18.3-p3/fs/nfs/inode.c
--- linux-2.4.9-18.3/fs/nfs/inode.c	Tue Dec 18 13:01:21 2001
+++ linux-2.4.9-18.3-p3/fs/nfs/inode.c	Mon Jan  7 13:31:06 2002
@@ -351,7 +351,7 @@
 
 	/* Now create transport and client */
 	xprt = xprt_create_proto(tcp? IPPROTO_TCP : IPPROTO_UDP,
-						&srvaddr, &timeparms);
+		&srvaddr, &timeparms, (data->flags & NFS_MOUNT_NORES) == 0);
 	if (xprt == NULL)
 		goto out_no_xprt;
 
diff -ur -X dontdiff linux-2.4.9-18.3/fs/nfs/mount_clnt.c linux-2.4.9-18.3-p3/fs/nfs/mount_clnt.c
--- linux-2.4.9-18.3/fs/nfs/mount_clnt.c	Tue Dec 18 13:00:49 2001
+++ linux-2.4.9-18.3-p3/fs/nfs/mount_clnt.c	Sun Jan  6 01:07:12 2002
@@ -82,7 +82,7 @@
 	struct rpc_xprt	*xprt;
 	struct rpc_clnt	*clnt;
 
-	if (!(xprt = xprt_create_proto(IPPROTO_UDP, srvaddr, NULL)))
+	if (!(xprt = xprt_create_proto(IPPROTO_UDP, srvaddr, NULL, 1)))
 		return NULL;
 
 	clnt = rpc_create_client(xprt, hostname,
diff -ur -X dontdiff linux-2.4.9-18.3/fs/super.c linux-2.4.9-18.3-p3/fs/super.c
--- linux-2.4.9-18.3/fs/super.c	Tue Dec 18 13:00:59 2001
+++ linux-2.4.9-18.3-p3/fs/super.c	Wed Dec 19 10:56:35 2001
@@ -516,27 +516,57 @@
  * filesystems which don't use real block-devices.  -- jrs
  */
 
-static unsigned long unnamed_dev_in_use[256/(8*sizeof(unsigned long))];
+static int unnamed_dev_majors[] = {
+	UNNAMED_MAJOR,
+#ifdef CONFIG_MORE_UNNAMED_MAJORS	/* Always on, keeps Configure.help */
+	12, 14, 38, 39,
+#endif
+};
+#define UNNAMED_NMAJ (sizeof(unnamed_dev_majors)/sizeof(int))
+
+static int unnamed_dev_nmaj = 1;
+static int unnamed_maj_in_use[UNNAMED_NMAJ] = { UNNAMED_MAJOR, };
+static unsigned long unnamed_dev_in_use[(UNNAMED_NMAJ*256)/(8*sizeof(long))];
+
+#ifdef CONFIG_MORE_UNNAMED_MAJORS
+void majorhog_init(void);
+#endif
 
 kdev_t get_unnamed_dev(void)
 {
 	int i;
 
-	for (i = 1; i < 256; i++) {
+#ifdef CONFIG_MORE_UNNAMED_MAJORS
+	if (!test_and_set_bit(0, unnamed_maj_in_use)) {		/* first call */
+		/* relatively SMP safe: only adds majors and does it once */
+		majorhog_init();
+	}
+#endif
+
+	/* find_first_zero_bit isn't atomic */
+	for (i = 1; i < unnamed_dev_nmaj*256; i++) {
 		if (!test_and_set_bit(i,unnamed_dev_in_use))
-			return MKDEV(UNNAMED_MAJOR, i);
+			return MKDEV(unnamed_maj_in_use[i/256], i & 255);
 	}
+
 	return 0;
 }
 
 void put_unnamed_dev(kdev_t dev)
 {
-	if (!dev || MAJOR(dev) != UNNAMED_MAJOR)
-		return;
-	if (test_and_clear_bit(MINOR(dev), unnamed_dev_in_use))
+	int i;
+
+	if (!dev)
 		return;
-	printk("VFS: put_unnamed_dev: freeing unused device %s\n",
-			kdevname(dev));
+	for (i = 0; i < unnamed_dev_nmaj; i++) {
+		if (unnamed_maj_in_use[i] == MAJOR(dev)) {
+			if (test_and_clear_bit(i * 256 + MINOR(dev), unnamed_dev_in_use))
+				return;
+			printk("VFS: put_unnamed_dev: freeing unused device %s\n",
+			    kdevname(dev));
+			return;
+		}
+	}
 }
 
 static int grab_super(struct super_block *sb)
@@ -1090,3 +1120,41 @@
 		return;
 	}
 }
+
+#ifdef CONFIG_MORE_UNNAMED_MAJORS
+
+/* #include <linux/major.h> */
+/* #include <linux/errno.h> */
+/* #include <linux/fs.h> */
+#include <linux/devfs_fs_kernel.h>
+
+static int majorhog_open(struct inode *inode, struct file *file)
+{
+	return -EDOM;	/* Something rididculous for identification */
+}
+
+static struct block_device_operations majorhog_fops = {
+	open:		majorhog_open,
+};
+
+void majorhog_init(void) 
+{
+	int i, j;
+
+	if (unnamed_dev_nmaj != 1)
+		return;
+
+	j = 1;
+	for (i = 1; i < UNNAMED_NMAJ; i++) {
+		if (devfs_register_blkdev(unnamed_dev_majors[i],
+		    "unnamed", &majorhog_fops) == 0) {
+			unnamed_maj_in_use[j++] = unnamed_dev_majors[i];
+		} else {
+			printk(KERN_WARNING "Unable to hog major number %d\n",
+			    unnamed_dev_majors[i]);
+		}
+	}
+	unnamed_dev_nmaj = j;
+}
+
+#endif /* CONFIG_MORE_UNNAMED_MAJORS */
diff -ur -X dontdiff linux-2.4.9-18.3/include/linux/lockd/lockd.h linux-2.4.9-18.3-p3/include/linux/lockd/lockd.h
--- linux-2.4.9-18.3/include/linux/lockd/lockd.h	Wed Aug 15 14:24:26 2001
+++ linux-2.4.9-18.3-p3/include/linux/lockd/lockd.h	Mon Jan  7 12:42:58 2002
@@ -63,6 +63,7 @@
 #define NLMCLNT_OHSIZE		(sizeof(system_utsname.nodename)+10)
 struct nlm_rqst {
 	unsigned int		a_flags;	/* initial RPC task flags */
+	int			a_resport;
 	struct nlm_host *	a_host;		/* host handle */
 	struct nlm_args		a_args;		/* arguments */
 	struct nlm_res		a_res;		/* result */
@@ -144,7 +145,7 @@
 struct nlm_host * nlmsvc_lookup_host(struct svc_rqst *);
 struct nlm_host * nlm_lookup_host(struct svc_client *,
 					struct sockaddr_in *, int, int);
-struct rpc_clnt * nlm_bind_host(struct nlm_host *);
+struct rpc_clnt * nlm_bind_host(struct nlm_host *, int);
 void		  nlm_rebind_host(struct nlm_host *);
 struct nlm_host * nlm_get_host(struct nlm_host *);
 void		  nlm_release_host(struct nlm_host *);
Only in linux-2.4.9-18.3-p3/include/linux: modules
diff -ur -X dontdiff linux-2.4.9-18.3/include/linux/nfs_mount.h linux-2.4.9-18.3-p3/include/linux/nfs_mount.h
--- linux-2.4.9-18.3/include/linux/nfs_mount.h	Tue Dec 18 13:00:52 2001
+++ linux-2.4.9-18.3-p3/include/linux/nfs_mount.h	Sun Jan  6 01:10:53 2002
@@ -54,6 +54,7 @@
 #define NFS_MOUNT_KERBEROS	0x0100	/* 3 */
 #define NFS_MOUNT_NONLM		0x0200	/* 3 */
 #define NFS_MOUNT_BROKEN_SUID	0x0400	/* 4 */
+#define NFS_MOUNT_NORES		0x0800	/* ? XXX */
 #define NFS_MOUNT_FLAGMASK	0xFFFF
 
 #endif
diff -ur -X dontdiff linux-2.4.9-18.3/include/linux/sunrpc/xprt.h linux-2.4.9-18.3-p3/include/linux/sunrpc/xprt.h
--- linux-2.4.9-18.3/include/linux/sunrpc/xprt.h	Wed Aug 15 14:24:26 2001
+++ linux-2.4.9-18.3-p3/include/linux/sunrpc/xprt.h	Mon Jan  7 01:48:40 2002
@@ -143,7 +143,8 @@
 				nocong	   : 1,	/* no congestion control */
 				stream     : 1,	/* TCP */
 				tcp_more   : 1,	/* more record fragments */
-				connecting : 1;	/* being reconnected */
+				connecting : 1,	/* being reconnected */
+				resport    : 1;	/* use reserved port */
 
 	/*
 	 * State of TCP reply receive stuff
@@ -171,7 +172,8 @@
 #ifdef __KERNEL__
 
 struct rpc_xprt *	xprt_create_proto(int proto, struct sockaddr_in *addr,
-					struct rpc_timeout *toparms);
+					struct rpc_timeout *toparms,
+					int use_res_port);
 int			xprt_destroy(struct rpc_xprt *);
 void			xprt_shutdown(struct rpc_xprt *);
 void			xprt_default_timeout(struct rpc_timeout *, int);
diff -ur -X dontdiff linux-2.4.9-18.3/net/sunrpc/pmap_clnt.c linux-2.4.9-18.3-p3/net/sunrpc/pmap_clnt.c
--- linux-2.4.9-18.3/net/sunrpc/pmap_clnt.c	Wed Jun 21 12:43:37 2000
+++ linux-2.4.9-18.3-p3/net/sunrpc/pmap_clnt.c	Tue Jan 22 10:36:56 2002
@@ -28,7 +28,7 @@
 #define PMAP_UNSET		2
 #define PMAP_GETPORT		3
 
-static struct rpc_clnt *	pmap_create(char *, struct sockaddr_in *, int);
+static struct rpc_clnt *pmap_create(char *, struct sockaddr_in *, int, int);
 static void			pmap_getport_done(struct rpc_task *);
 extern struct rpc_program	pmap_program;
 spinlock_t			pmap_lock = SPIN_LOCK_UNLOCKED;
@@ -60,7 +60,7 @@
 	spin_unlock(&pmap_lock);
 
 	task->tk_status = -EACCES; /* why set this? returns -EIO below */
-	if (!(pmap_clnt = pmap_create(clnt->cl_server, sap, map->pm_prot)))
+	if (!(pmap_clnt = pmap_create(clnt->cl_server, sap, map->pm_prot, 0)))
 		goto bailout;
 	task->tk_status = 0;
 
@@ -101,7 +101,7 @@
 			NIPQUAD(sin->sin_addr.s_addr), prog, vers, prot);
 
 	strcpy(hostname, in_ntoa(sin->sin_addr.s_addr));
-	if (!(pmap_clnt = pmap_create(hostname, sin, prot)))
+	if (!(pmap_clnt = pmap_create(hostname, sin, prot, 0)))
 		return -EACCES;
 
 	/* Setup the call info struct */
@@ -158,7 +158,8 @@
 
 	sin.sin_family = AF_INET;
 	sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-	if (!(pmap_clnt = pmap_create("localhost", &sin, IPPROTO_UDP))) {
+	/* Use a privileged port or else portmapper rejects out request. */
+	if (!(pmap_clnt = pmap_create("localhost", &sin, IPPROTO_UDP, 1))) {
 		dprintk("RPC: couldn't create pmap client\n");
 		return -EACCES;
 	}
@@ -183,13 +184,13 @@
 }
 
 static struct rpc_clnt *
-pmap_create(char *hostname, struct sockaddr_in *srvaddr, int proto)
+pmap_create(char *hostname, struct sockaddr_in *srvaddr, int proto, int resport)
 {
 	struct rpc_xprt	*xprt;
 	struct rpc_clnt	*clnt;
 
 	/* printk("pmap: create xprt\n"); */
-	if (!(xprt = xprt_create_proto(proto, srvaddr, NULL)))
+	if (!(xprt = xprt_create_proto(proto, srvaddr, NULL, resport)))
 		return NULL;
 	xprt->addr.sin_port = htons(RPC_PMAP_PORT);
 
diff -ur -X dontdiff linux-2.4.9-18.3/net/sunrpc/xprt.c linux-2.4.9-18.3-p3/net/sunrpc/xprt.c
--- linux-2.4.9-18.3/net/sunrpc/xprt.c	Tue Dec 18 13:00:54 2001
+++ linux-2.4.9-18.3-p3/net/sunrpc/xprt.c	Mon Jan  7 13:26:30 2002
@@ -97,7 +97,7 @@
 static void	xprt_reserve_status(struct rpc_task *task);
 static void	xprt_disconnect(struct rpc_xprt *);
 static void	xprt_reconn_status(struct rpc_task *task);
-static struct socket *xprt_create_socket(int, struct rpc_timeout *);
+static struct socket *xprt_create_socket(int, struct rpc_timeout *, int);
 static int	xprt_bind_socket(struct rpc_xprt *, struct socket *);
 static void	xprt_remove_pending(struct rpc_xprt *);
 
@@ -434,7 +434,8 @@
 	status = -ENOTCONN;
 	if (!inet) {
 		/* Create an unconnected socket */
-		if (!(sock = xprt_create_socket(xprt->prot, &xprt->timeout)))
+		if (!(sock = xprt_create_socket(xprt->prot, &xprt->timeout,
+		    xprt->resport)))
 			goto defer;
 		xprt_bind_socket(xprt, sock);
 		inet = sock->sk;
@@ -1459,7 +1460,7 @@
  */
 static struct rpc_xprt *
 xprt_setup(struct socket *sock, int proto,
-			struct sockaddr_in *ap, struct rpc_timeout *to)
+		struct sockaddr_in *ap, struct rpc_timeout *to, int use_resport)
 {
 	struct rpc_xprt	*xprt;
 	struct rpc_rqst	*req;
@@ -1504,6 +1505,8 @@
 
 	INIT_LIST_HEAD(&xprt->rx_pending);
 
+	xprt->resport = use_resport;
+
 	dprintk("RPC:      created transport %p\n", xprt);
 	
 	xprt_bind_socket(xprt, sock);
@@ -1574,7 +1577,7 @@
  * Create a client socket given the protocol and peer address.
  */
 static struct socket *
-xprt_create_socket(int proto, struct rpc_timeout *to)
+xprt_create_socket(int proto, struct rpc_timeout *to, int resport)
 {
 	struct socket	*sock;
 	int		type, err;
@@ -1590,7 +1593,8 @@
 	}
 
 	/* If the caller has the capability, bind to a reserved port */
-	if (capable(CAP_NET_BIND_SERVICE) && xprt_bindresvport(sock) < 0)
+	if (resport &&
+	    capable(CAP_NET_BIND_SERVICE) && xprt_bindresvport(sock) < 0)
 		goto failed;
 
 	return sock;
@@ -1604,17 +1608,18 @@
  * Create an RPC client transport given the protocol and peer address.
  */
 struct rpc_xprt *
-xprt_create_proto(int proto, struct sockaddr_in *sap, struct rpc_timeout *to)
+xprt_create_proto(int proto, struct sockaddr_in *sap, struct rpc_timeout *to,
+    int use_resport)
 {
 	struct socket	*sock;
 	struct rpc_xprt	*xprt;
 
 	dprintk("RPC:      xprt_create_proto called\n");
 
-	if (!(sock = xprt_create_socket(proto, to)))
+	if (!(sock = xprt_create_socket(proto, to, use_resport)))
 		return NULL;
 
-	if (!(xprt = xprt_setup(sock, proto, sap, to)))
+	if (!(xprt = xprt_setup(sock, proto, sap, to, use_resport)))
 		sock_release(sock);
 
 	return xprt;
