Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWGYB6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWGYB6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWGYB5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:57:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:21675 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932395AbWGYBzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:55:42 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 25 Jul 2006 11:55:02 +1000
Message-Id: <1060725015502.21995@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 9] knfsd: Define new nfsdfs file: portlist - contains list of ports.
References: <20060725114207.21779.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This file will list all ports that nfsd has open.
Default when TCP enabled will be
   ipv4 udp 0.0.0.0 2049
   ipv4 tcp 0.0.0.0 2049

Later, the list of ports will be settable.

'portlist' chosen rather than 'ports', to avoid unnecessary confusion with
non-mainline patches which created 'ports' with different semantics.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsctl.c               |   19 +++++++++++++++++++
 ./include/linux/sunrpc/svcsock.h |    1 +
 ./net/sunrpc/svcsock.c           |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff .prev/fs/nfsd/nfsctl.c ./fs/nfsd/nfsctl.c
--- .prev/fs/nfsd/nfsctl.c	2006-07-24 15:17:36.000000000 +1000
+++ ./fs/nfsd/nfsctl.c	2006-07-24 15:21:44.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/nfs.h>
 #include <linux/nfsd_idmap.h>
 #include <linux/sunrpc/svc.h>
+#include <linux/sunrpc/svcsock.h>
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/cache.h>
 #include <linux/nfsd/xdr.h>
@@ -51,6 +52,7 @@ enum {
 	NFSD_Fh,
 	NFSD_Threads,
 	NFSD_Versions,
+	NFSD_Ports,
 	/*
 	 * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
 	 * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
@@ -74,6 +76,7 @@ static ssize_t write_getfs(struct file *
 static ssize_t write_filehandle(struct file *file, char *buf, size_t size);
 static ssize_t write_threads(struct file *file, char *buf, size_t size);
 static ssize_t write_versions(struct file *file, char *buf, size_t size);
+static ssize_t write_ports(struct file *file, char *buf, size_t size);
 #ifdef CONFIG_NFSD_V4
 static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
 static ssize_t write_recoverydir(struct file *file, char *buf, size_t size);
@@ -90,6 +93,7 @@ static ssize_t (*write_op[])(struct file
 	[NFSD_Fh] = write_filehandle,
 	[NFSD_Threads] = write_threads,
 	[NFSD_Versions] = write_versions,
+	[NFSD_Ports] = write_ports,
 #ifdef CONFIG_NFSD_V4
 	[NFSD_Leasetime] = write_leasetime,
 	[NFSD_RecoveryDir] = write_recoverydir,
@@ -419,6 +423,20 @@ static ssize_t write_versions(struct fil
 	return len;
 }
 
+static ssize_t write_ports(struct file *file, char *buf, size_t size)
+{
+	/* for now, ignore what was written and just
+	 * return known ports
+	 * AF proto address port
+	 */
+	int len = 0;
+	lock_kernel();
+	if (nfsd_serv)
+		len = svc_sock_names(buf, nfsd_serv);
+	unlock_kernel();
+	return len;
+}
+
 #ifdef CONFIG_NFSD_V4
 extern time_t nfs4_leasetime(void);
 
@@ -482,6 +500,7 @@ static int nfsd_fill_super(struct super_
 		[NFSD_Fh] = {"filehandle", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Threads] = {"threads", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Versions] = {"versions", &transaction_ops, S_IWUSR|S_IRUSR},
+		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},

diff .prev/include/linux/sunrpc/svcsock.h ./include/linux/sunrpc/svcsock.h
--- .prev/include/linux/sunrpc/svcsock.h	2006-07-24 15:21:44.000000000 +1000
+++ ./include/linux/sunrpc/svcsock.h	2006-07-24 15:21:44.000000000 +1000
@@ -61,5 +61,6 @@ int		svc_recv(struct svc_serv *, struct 
 int		svc_send(struct svc_rqst *);
 void		svc_drop(struct svc_rqst *);
 void		svc_sock_update_bufs(struct svc_serv *serv);
+int		svc_sock_names(char *buf, struct svc_serv *serv);
 
 #endif /* SUNRPC_SVCSOCK_H */

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-07-24 15:21:44.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-07-24 15:21:44.000000000 +1000
@@ -429,6 +429,43 @@ out:
 }
 
 /*
+ * Report socket names for nfsdfs
+ */
+int one_sock_name(char *buf, struct svc_sock *svsk)
+{
+	int len;
+	switch(svsk->sk_sk->sk_family) {
+	case AF_INET:
+		len = sprintf(buf, "ipv4 %s %u.%u.%u.%u %d\n",
+			      svsk->sk_sk->sk_protocol==IPPROTO_UDP?
+			      "udp" : "tcp",
+			      NIPQUAD(inet_sk(svsk->sk_sk)->rcv_saddr),
+			      inet_sk(svsk->sk_sk)->num);
+		break;
+	default: len = sprintf(buf, "*unknown-%d*\n",
+			       svsk->sk_sk->sk_family);
+	}
+	return len;
+}
+
+int
+svc_sock_names(char *buf, struct svc_serv *serv)
+{
+	struct svc_sock *svsk;
+	int len = 0;
+
+	if (!serv) return 0;
+	spin_lock(&serv->sv_lock);
+	list_for_each_entry(svsk, &serv->sv_permsocks, sk_list) {
+		int onelen = one_sock_name(buf+len, svsk);
+		len += onelen;
+	}
+	spin_unlock(&serv->sv_lock);
+	return len;
+}
+EXPORT_SYMBOL(svc_sock_names);
+
+/*
  * Check input queue length
  */
 static int
