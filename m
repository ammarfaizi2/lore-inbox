Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266462AbSLDMc6>; Wed, 4 Dec 2002 07:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266464AbSLDMc6>; Wed, 4 Dec 2002 07:32:58 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9861 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266462AbSLDMcx>;
	Wed, 4 Dec 2002 07:32:53 -0500
Date: Wed, 4 Dec 2002 18:09:22 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: netdev <netdev@oss.sgi.com>, "David S. Miller " <davem@redhat.com>,
       Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com
Subject: Re: [patch] Change Networking mibs to use kmalloc_percpu -- 3/3
Message-ID: <20021204180922.E17375@in.ibm.com>
References: <20021204180510.C17375@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021204180510.C17375@in.ibm.com>; from kiran@in.ibm.com on Wed, Dec 04, 2002 at 06:05:10PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is 3 of 3
 
D: Name: sctpmibs-2.5.50-1.patch
D: Author: Ravikiran Thirumalai
D: Description: Changes sctp stats to use kmalloc_percpu from the traditional
D:              padded NR_CPUS arrays


 include/net/sctp/sctp.h |    2 +-
 net/sctp/protocol.c     |   44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)


diff -ruN -X dontdiff linux-2.5.50/include/net/sctp/sctp.h mibstats-2.5.50/include/net/sctp/sctp.h
--- linux-2.5.50/include/net/sctp/sctp.h	Thu Nov 28 04:05:53 2002
+++ mibstats-2.5.50/include/net/sctp/sctp.h	Wed Dec  4 12:13:33 2002
@@ -203,7 +203,7 @@
 #define SCTP_SOCK_SLEEP_POST(sk) SOCK_SLEEP_POST(sk)
 
 /* SCTP SNMP MIB stats handlers */
-extern struct sctp_mib sctp_statistics[NR_CPUS * 2];
+DECLARE_SNMP_STAT(struct sctp_mib, sctp_statistics);
 #define SCTP_INC_STATS(field)		SNMP_INC_STATS(sctp_statistics, field)
 #define SCTP_INC_STATS_BH(field)	SNMP_INC_STATS_BH(sctp_statistics, field)
 #define SCTP_INC_STATS_USER(field)	SNMP_INC_STATS_USER(sctp_statistics, field)
diff -ruN -X dontdiff linux-2.5.50/net/sctp/protocol.c mibstats-2.5.50/net/sctp/protocol.c
--- linux-2.5.50/net/sctp/protocol.c	Thu Nov 28 04:06:05 2002
+++ mibstats-2.5.50/net/sctp/protocol.c	Wed Dec  4 12:13:33 2002
@@ -59,7 +59,7 @@
 /* Global data structures. */
 sctp_protocol_t sctp_proto;
 struct proc_dir_entry	*proc_net_sctp;
-struct sctp_mib sctp_statistics[NR_CPUS * 2];
+DEFINE_SNMP_STAT(struct sctp_mib, sctp_statistics);
 
 /* This is the global socket data structure used for responding to
  * the Out-of-the-blue (OOTB) packets.  A control sock will be created
@@ -597,6 +597,40 @@
 	}
 }
 
+static int __init init_sctp_mibs(void)
+{
+	int i;
+	
+	sctp_statistics[0] = kmalloc_percpu(sizeof (struct sctp_mib),
+					    GFP_KERNEL);
+	if (!sctp_statistics[0])
+		return -ENOMEM;
+	sctp_statistics[1] = kmalloc_percpu(sizeof (struct sctp_mib),
+					    GFP_KERNEL);
+	if (!sctp_statistics[1]) {
+		kfree_percpu(sctp_statistics[0]);
+		return -ENOMEM;
+	}
+
+	/* Zero all percpu versions of the mibs */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_possible(i)) {
+			memset(per_cpu_ptr(sctp_statistics[0], i), 0,
+					sizeof (struct sctp_mib));
+			memset(per_cpu_ptr(sctp_statistics[1], i), 0,
+					sizeof (struct sctp_mib));
+		}
+	}
+	return 0;
+	
+}
+
+static void cleanup_sctp_mibs(void)
+{
+	kfree_percpu(sctp_statistics[0]);
+	kfree_percpu(sctp_statistics[1]);
+}
+
 /* Initialize the universe into something sensible.  */
 int sctp_init(void)
 {
@@ -610,6 +644,11 @@
 	/* Add SCTP to inetsw linked list.  */
 	inet_register_protosw(&sctp_protosw);
 
+	/* Allocate and initialise sctp mibs.  */
+	status = init_sctp_mibs();
+	if (status) 
+		goto err_init_mibs;
+		
 	/* Initialize proc fs directory.  */
 	sctp_proc_init();
 
@@ -745,6 +784,8 @@
 err_ahash_alloc:
 	sctp_dbg_objcnt_exit();
 	sctp_proc_exit();
+	cleanup_sctp_mibs();
+err_init_mibs:	
 	inet_del_protocol(&sctp_protocol, IPPROTO_SCTP);
 	inet_unregister_protosw(&sctp_protosw);
 	return status;
@@ -774,6 +815,7 @@
 
 	sctp_dbg_objcnt_exit();
 	sctp_proc_exit();
+	cleanup_sctp_mibs();
 
 	inet_del_protocol(&sctp_protocol, IPPROTO_SCTP);
 	inet_unregister_protosw(&sctp_protosw);
