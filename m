Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWIAEkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWIAEkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWIAEkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:40:17 -0400
Received: from ns.suse.de ([195.135.220.2]:8666 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932113AbWIAEjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:45 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:39:38 +1000
Message-Id: <1060901043938.27653@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 017 of 19] knfsd: Export nsm_local_state to user space via sysctl
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  Every NLM call includes the client's NSM state. Currently,
  the Linux client always reports 0 - which seems not to cause
  any problems, but is not what the protocol says.

  This patch exposes the kernel's internal variable to user
  space via a sysctl, which can be set at system boot time
  by statd.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/mon.c                 |    2 +-
 ./fs/lockd/svc.c                 |    9 +++++++++
 ./include/linux/lockd/sm_inter.h |    2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff .prev/fs/lockd/mon.c ./fs/lockd/mon.c
--- .prev/fs/lockd/mon.c	2006-09-01 12:11:16.000000000 +1000
+++ ./fs/lockd/mon.c	2006-09-01 12:17:47.000000000 +1000
@@ -24,7 +24,7 @@ static struct rpc_program	nsm_program;
 /*
  * Local NSM state
  */
-u32				nsm_local_state;
+int				nsm_local_state;
 
 /*
  * Common procedure for SM_MON/SM_UNMON calls

diff .prev/fs/lockd/svc.c ./fs/lockd/svc.c
--- .prev/fs/lockd/svc.c	2006-09-01 12:15:24.000000000 +1000
+++ ./fs/lockd/svc.c	2006-09-01 12:19:26.000000000 +1000
@@ -33,6 +33,7 @@
 #include <linux/sunrpc/svcsock.h>
 #include <net/ip.h>
 #include <linux/lockd/lockd.h>
+#include <linux/lockd/sm_inter.h>
 #include <linux/nfs.h>
 
 #define NLMDBG_FACILITY		NLMDBG_SVC
@@ -404,6 +405,14 @@ static ctl_table nlm_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "nsm_local_state",
+		.data		= &nsm_local_state,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 

diff .prev/include/linux/lockd/sm_inter.h ./include/linux/lockd/sm_inter.h
--- .prev/include/linux/lockd/sm_inter.h	2006-09-01 12:11:16.000000000 +1000
+++ ./include/linux/lockd/sm_inter.h	2006-09-01 12:17:47.000000000 +1000
@@ -42,6 +42,6 @@ struct nsm_res {
 
 int		nsm_monitor(struct nlm_host *);
 int		nsm_unmonitor(struct nlm_host *);
-extern u32	nsm_local_state;
+extern int	nsm_local_state;
 
 #endif /* LINUX_LOCKD_SM_INTER_H */
