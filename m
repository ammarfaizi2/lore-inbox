Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWGaAnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWGaAnp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWGaAm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:42:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:45965 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932407AbWGaAmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:42:45 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 10:42:39 +1000
Message-Id: <1060731004239.29303@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 011 of 11] knfsd: allow admin to set nthreads per node
References: <20060731103458.29040.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

knfsd: Add /proc/fs/nfsd/pool_threads which allows the sysadmin (or
a userspace daemon) to read and change the number of nfsd threads
in each pool.  The format is a list of space-separated integers,
one per pool.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsctl.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 ./fs/nfsd/nfssvc.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff .prev/fs/nfsd/nfsctl.c ./fs/nfsd/nfsctl.c
--- .prev/fs/nfsd/nfsctl.c	2006-07-31 10:29:37.000000000 +1000
+++ ./fs/nfsd/nfsctl.c	2006-07-31 10:31:46.000000000 +1000
@@ -54,6 +54,7 @@ enum {
 	NFSD_List,
 	NFSD_Fh,
 	NFSD_Threads,
+	NFSD_Pool_Threads,
 	NFSD_Versions,
 	NFSD_Ports,
 	/*
@@ -78,6 +79,7 @@ static ssize_t write_getfd(struct file *
 static ssize_t write_getfs(struct file *file, char *buf, size_t size);
 static ssize_t write_filehandle(struct file *file, char *buf, size_t size);
 static ssize_t write_threads(struct file *file, char *buf, size_t size);
+static ssize_t write_pool_threads(struct file *file, char *buf, size_t size);
 static ssize_t write_versions(struct file *file, char *buf, size_t size);
 static ssize_t write_ports(struct file *file, char *buf, size_t size);
 #ifdef CONFIG_NFSD_V4
@@ -95,6 +97,7 @@ static ssize_t (*write_op[])(struct file
 	[NFSD_Getfs] = write_getfs,
 	[NFSD_Fh] = write_filehandle,
 	[NFSD_Threads] = write_threads,
+	[NFSD_Pool_Threads] = write_pool_threads,
 	[NFSD_Versions] = write_versions,
 	[NFSD_Ports] = write_ports,
 #ifdef CONFIG_NFSD_V4
@@ -363,6 +366,72 @@ static ssize_t write_threads(struct file
 	return strlen(buf);
 }
 
+extern int nfsd_nrpools(void);
+extern int nfsd_get_nrthreads(int n, int *);
+extern int nfsd_set_nrthreads(int n, int *);
+
+static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
+{
+	/* if size > 0, look for an array of number of threads per node
+	 * and apply them  then write out number of threads per node as reply
+	 */
+	char *mesg = buf;
+	int i;
+	int rv;
+	int len;
+    	int npools = nfsd_nrpools();
+	int *nthreads;
+
+	if (npools == 0) {
+		/*
+		 * NFS is shut down.  The admin can start it by
+		 * writing to the threads file but NOT the pool_threads
+		 * file, sorry.  Report zero threads.
+		 */
+		strcpy(buf, "0\n");
+		return strlen(buf);
+	}
+
+	nthreads = kcalloc(npools, sizeof(int), GFP_KERNEL);
+	if (nthreads == NULL)
+		return -ENOMEM;
+
+	if (size > 0) {
+		for (i = 0 ; i < npools ; i++) {
+			rv = get_int(&mesg, &nthreads[i]);
+			if (rv == -ENOENT)
+				break;		/* fewer numbers than pools */
+			if (rv)
+				goto out_free;	/* syntax error */
+			rv = -EINVAL;
+			if (nthreads[i] < 0)
+				goto out_free;
+		}
+		rv = nfsd_set_nrthreads(i, nthreads);
+		if (rv)
+			goto out_free;
+	}
+
+	rv = nfsd_get_nrthreads(npools, nthreads);
+	if (rv)
+		goto out_free;
+
+	mesg = buf;
+	size = SIMPLE_TRANSACTION_LIMIT;
+	for (i = 0 ; i < npools && size > 0 ; i++) {
+		snprintf(mesg, size, "%d%c", nthreads[i], (i == npools-1 ? '\n' : ' '));
+		len = strlen(mesg);
+		size -= len;
+		mesg += len;
+	}
+
+	return (mesg-buf);
+
+out_free:
+	kfree(nthreads);
+	return rv;
+}
+
 static ssize_t write_versions(struct file *file, char *buf, size_t size)
 {
 	/*
@@ -544,6 +613,7 @@ static int nfsd_fill_super(struct super_
 		[NFSD_List] = {"exports", &exports_operations, S_IRUGO},
 		[NFSD_Fh] = {"filehandle", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Threads] = {"threads", &transaction_ops, S_IWUSR|S_IRUSR},
+		[NFSD_Pool_Threads] = {"pool_threads", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Versions] = {"versions", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
 #ifdef CONFIG_NFSD_V4

diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
--- .prev/fs/nfsd/nfssvc.c	2006-07-31 10:31:08.000000000 +1000
+++ ./fs/nfsd/nfssvc.c	2006-07-31 10:31:46.000000000 +1000
@@ -238,6 +238,80 @@ static int nfsd_init_socks(int port)
 	return 0;
 }
 
+int nfsd_nrpools(void)
+{
+	if (nfsd_serv == NULL)
+		return 0;
+	else
+		return nfsd_serv->sv_nrpools;
+}
+
+int nfsd_get_nrthreads(int n, int *nthreads)
+{
+	int i = 0;
+
+	if (nfsd_serv != NULL) {
+		for (i = 0 ; i < nfsd_serv->sv_nrpools && i < n ; i++)
+			nthreads[i] = nfsd_serv->sv_pools[i].sp_nrthreads;
+	}
+
+	return 0;
+}
+
+int nfsd_set_nrthreads(int n, int *nthreads)
+{
+	int i = 0;
+	int tot = 0;
+	int err = 0;
+
+	if (nfsd_serv == NULL || n <= 0)
+		return 0;
+
+	if (n > nfsd_serv->sv_nrpools)
+		n = nfsd_serv->sv_nrpools;
+
+	/* enforce a global maximum number of threads */
+	tot = 0;
+	for (i = 0 ; i < n ; i++) {
+		if (nthreads[i] > NFSD_MAXSERVS)
+			nthreads[i] = NFSD_MAXSERVS;
+		tot += nthreads[i];
+	}
+	if (tot > NFSD_MAXSERVS) {
+		/* total too large: scale down requested numbers */
+		for (i = 0 ; i < n && tot > 0 ; i++) {
+		    	int new = nthreads[i] * NFSD_MAXSERVS / tot;
+			tot -= (nthreads[i] - new);
+			nthreads[i] = new;
+		}
+		for (i = 0 ; i < n && tot > 0 ; i++) {
+			nthreads[i]--;
+			tot--;
+		}
+	}
+
+	/*
+	 * There must always be a thread in pool 0; the admin
+	 * can't shut down NFS completely using pool_threads.
+	 */
+	if (nthreads[0] == 0)
+		nthreads[0] = 1;
+
+	/* apply the new numbers */
+	lock_kernel();
+	svc_get(nfsd_serv);
+	for (i = 0 ; i < n ; i++) {
+		err = svc_set_num_threads(nfsd_serv, &nfsd_serv->sv_pools[i],
+				    	  nthreads[i]);
+		if (err)
+			break;
+	}
+	svc_destroy(nfsd_serv);
+	unlock_kernel();
+
+	return err;
+}
+
 int
 nfsd_svc(unsigned short port, int nrservs)
 {
