Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWIEV5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWIEV5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWIEV5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:57:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21769 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751523AbWIEV5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:57:30 -0400
Date: Tue, 5 Sep 2006 23:57:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: sri@us.ibm.com
Cc: lksctp-developers@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: [2.6 patch] net/sctp/: cleanups
Message-ID: <20060905215721.GM9173@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make the following needlessly global function static:
  - socket.c: sctp_apply_peer_addr_params()
- add proper prototypes for the several global functions in
  include/net/sctp/sctp.h

Note that this fixes wrong prototypes for the following functions:
- sctp_snmp_proc_exit()
- sctp_eps_proc_exit()
- sctp_assocs_proc_exit()

The latter was spotted by the GNU C compiler and reported
by David Woodhouse.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/net/sctp/sctp.h |   13 +++++++++++++
 net/sctp/ipv6.c         |    1 -
 net/sctp/protocol.c     |    7 -------
 net/sctp/socket.c       |   14 +++++++-------
 4 files changed, 20 insertions(+), 15 deletions(-)

--- linux-2.6.18-rc5-mm1/include/net/sctp/sctp.h.old	2006-09-05 16:50:33.000000000 +0200
+++ linux-2.6.18-rc5-mm1/include/net/sctp/sctp.h	2006-09-05 16:54:18.000000000 +0200
@@ -128,6 +128,8 @@
 				     int flags);
 extern struct sctp_pf *sctp_get_pf_specific(sa_family_t family);
 extern int sctp_register_pf(struct sctp_pf *, sa_family_t);
+int sctp_inetaddr_event(struct notifier_block *this, unsigned long ev,
+                        void *ptr);
 
 /*
  * sctp/socket.c
@@ -178,6 +180,17 @@
 			  struct sock *oldsk, struct sock *newsk);
 
 /*
+ * sctp/proc.c
+ */
+int sctp_snmp_proc_init(void);
+void sctp_snmp_proc_exit(void);
+int sctp_eps_proc_init(void);
+void sctp_eps_proc_exit(void);
+int sctp_assocs_proc_init(void);
+void sctp_assocs_proc_exit(void);
+
+
+/*
  *  Section:  Macros, externs, and inlines
  */
 
--- linux-2.6.18-rc5-mm1/net/sctp/socket.c.old	2006-09-05 16:49:15.000000000 +0200
+++ linux-2.6.18-rc5-mm1/net/sctp/socket.c	2006-09-05 16:49:27.000000000 +0200
@@ -2081,13 +2081,13 @@
  *                     SPP_SACKDELAY_ENABLE, setting both will have undefined
  *                     results.
  */
-int sctp_apply_peer_addr_params(struct sctp_paddrparams *params,
-				struct sctp_transport   *trans,
-				struct sctp_association *asoc,
-				struct sctp_sock        *sp,
-				int                      hb_change,
-				int                      pmtud_change,
-				int                      sackdelay_change)
+static int sctp_apply_peer_addr_params(struct sctp_paddrparams *params,
+				       struct sctp_transport   *trans,
+				       struct sctp_association *asoc,
+				       struct sctp_sock        *sp,
+				       int                      hb_change,
+				       int                      pmtud_change,
+				       int                      sackdelay_change)
 {
 	int error;
 
--- linux-2.6.18-rc5-mm1/net/sctp/ipv6.c.old	2006-09-05 16:50:51.000000000 +0200
+++ linux-2.6.18-rc5-mm1/net/sctp/ipv6.c	2006-09-05 16:50:58.000000000 +0200
@@ -78,7 +78,6 @@
 
 #include <asm/uaccess.h>
 
-extern int sctp_inetaddr_event(struct notifier_block *, unsigned long, void *);
 static struct notifier_block sctp_inet6addr_notifier = {
 	.notifier_call = sctp_inetaddr_event,
 };
--- linux-2.6.18-rc5-mm1/net/sctp/protocol.c.old	2006-09-05 16:53:10.000000000 +0200
+++ linux-2.6.18-rc5-mm1/net/sctp/protocol.c	2006-09-05 16:53:20.000000000 +0200
@@ -82,13 +82,6 @@
 kmem_cache_t *sctp_chunk_cachep __read_mostly;
 kmem_cache_t *sctp_bucket_cachep __read_mostly;
 
-extern int sctp_snmp_proc_init(void);
-extern int sctp_snmp_proc_exit(void);
-extern int sctp_eps_proc_init(void);
-extern int sctp_eps_proc_exit(void);
-extern int sctp_assocs_proc_init(void);
-extern int sctp_assocs_proc_exit(void);
-
 /* Return the address of the control sock. */
 struct sock *sctp_get_ctl_sock(void)
 {

