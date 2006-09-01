Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWIAEjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWIAEjd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWIAEjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:39:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:26027 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932154AbWIAEja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:30 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:39:22 +1000
Message-Id: <1060901043922.27606@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 014 of 19] knfsd: lockd: optionally use hostnames for identifying peers
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  This patch adds the nsm_use_hostnames sysctl and module param. If
  set, lockd will use the client's name (as given in the NLM
  arguments) to find the NSM handle. This makes recovery work when the
  NFS peer is multi-homed, and the reboot notification arrives from a
  different IP than the original lock calls.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/host.c                |    6 +++++-
 ./fs/lockd/mon.c                 |   12 +++++++++---
 ./fs/lockd/svc.c                 |   10 ++++++++++
 ./include/linux/lockd/lockd.h    |    1 +
 ./include/linux/lockd/sm_inter.h |    2 ++
 5 files changed, 27 insertions(+), 4 deletions(-)

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-09-01 12:11:07.000000000 +1000
+++ ./fs/lockd/host.c	2006-09-01 12:11:16.000000000 +1000
@@ -462,7 +462,11 @@ __nsm_find(const struct sockaddr_in *sin
 	list_for_each(pos, &nsm_handles) {
 		nsm = list_entry(pos, struct nsm_handle, sm_link);
 
-		if (!nlm_cmp_addr(&nsm->sm_addr, sin))
+		if (hostname && nsm_use_hostnames) {
+			if (strlen(nsm->sm_name) != hostname_len
+			 || memcmp(nsm->sm_name, hostname, hostname_len))
+				continue;
+		} else if (!nlm_cmp_addr(&nsm->sm_addr, sin))
 			continue;
 		atomic_inc(&nsm->sm_count);
 		goto out;

diff .prev/fs/lockd/mon.c ./fs/lockd/mon.c
--- .prev/fs/lockd/mon.c	2006-09-01 12:11:07.000000000 +1000
+++ ./fs/lockd/mon.c	2006-09-01 12:11:16.000000000 +1000
@@ -47,6 +47,7 @@ nsm_mon_unmon(struct nsm_handle *nsm, u3
 	}
 
 	memset(&args, 0, sizeof(args));
+	args.mon_name = nsm->sm_name;
 	args.addr = nsm->sm_addr.sin_addr.s_addr;
 	args.prog = NLM_PROGRAM;
 	args.vers = 3;
@@ -150,7 +151,7 @@ nsm_create(void)
 static u32 *
 xdr_encode_common(struct rpc_rqst *rqstp, u32 *p, struct nsm_args *argp)
 {
-	char	buffer[20];
+	char	buffer[20], *name;
 
 	/*
 	 * Use the dotted-quad IP address of the remote host as
@@ -158,8 +159,13 @@ xdr_encode_common(struct rpc_rqst *rqstp
 	 * hostname first for whatever remote hostname it receives,
 	 * so this works alright.
 	 */
-	sprintf(buffer, "%u.%u.%u.%u", NIPQUAD(argp->addr));
-	if (!(p = xdr_encode_string(p, buffer))
+	if (nsm_use_hostnames) {
+		name = argp->mon_name;
+	} else {
+		sprintf(buffer, "%u.%u.%u.%u", NIPQUAD(argp->addr));
+		name = buffer;
+	}
+	if (!(p = xdr_encode_string(p, name))
 	 || !(p = xdr_encode_string(p, utsname()->nodename)))
 		return ERR_PTR(-EIO);
 	*p++ = htonl(argp->prog);

diff .prev/fs/lockd/svc.c ./fs/lockd/svc.c
--- .prev/fs/lockd/svc.c	2006-09-01 12:11:07.000000000 +1000
+++ ./fs/lockd/svc.c	2006-09-01 12:15:24.000000000 +1000
@@ -61,6 +61,7 @@ static DECLARE_WAIT_QUEUE_HEAD(lockd_exi
 static unsigned long		nlm_grace_period;
 static unsigned long		nlm_timeout = LOCKD_DFLT_TIMEO;
 static int			nlm_udpport, nlm_tcpport;
+int				nsm_use_hostnames = 0;
 
 /*
  * Constants needed for the sysctl interface.
@@ -395,6 +396,14 @@ static ctl_table nlm_sysctls[] = {
 		.extra1		= (int *) &nlm_port_min,
 		.extra2		= (int *) &nlm_port_max,
 	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "nsm_use_hostnames",
+		.data		= &nsm_use_hostnames,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
@@ -483,6 +492,7 @@ module_param_call(nlm_udpport, param_set
 		  &nlm_udpport, 0644);
 module_param_call(nlm_tcpport, param_set_port, param_get_int,
 		  &nlm_tcpport, 0644);
+module_param(nsm_use_hostnames, bool, 0644);
 
 /*
  * Initialising and terminating the module.

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-09-01 12:11:05.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-09-01 12:16:06.000000000 +1000
@@ -142,6 +142,7 @@ extern struct svc_procedure	nlmsvc_proce
 #endif
 extern int			nlmsvc_grace_period;
 extern unsigned long		nlmsvc_timeout;
+extern int			nsm_use_hostnames;
 
 /*
  * Lockd client functions

diff .prev/include/linux/lockd/sm_inter.h ./include/linux/lockd/sm_inter.h
--- .prev/include/linux/lockd/sm_inter.h	2006-09-01 12:11:07.000000000 +1000
+++ ./include/linux/lockd/sm_inter.h	2006-09-01 12:11:16.000000000 +1000
@@ -28,6 +28,8 @@ struct nsm_args {
 	u32		prog;		/* RPC callback info */
 	u32		vers;
 	u32		proc;
+
+	char *		mon_name;
 };
 
 /*
