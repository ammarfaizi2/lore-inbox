Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWIAEkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWIAEkL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWIAEjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:39:45 -0400
Received: from ns.suse.de ([195.135.220.2]:7642 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932165AbWIAEjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:40 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:39:32 +1000
Message-Id: <1060901043932.27641@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 016 of 19] knfsd: match GRANTED_RES replies using cookies
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

 When we send a GRANTED_MSG call, we current copy the NLM cookie
 provided in the original LOCK call - because in 1996, some broken
 clients seemed to rely on this bug. However, this means the cookies
 are not unique, so that when the client's GRANTED_RES message comes
 back, we cannot simply match it based on the cookie, but have to
 use the client's IP address in addition. Which breaks when you have
 a multi-homed NFS client.
 
 The X/Open spec explicitly mentions that clients should not expect the
 same cookie; so one may hope that any clients that were broken in 1996
 have either been fixed or rendered obsolete.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/svc4proc.c         |    2 +-
 ./fs/lockd/svclock.c          |   24 +++++++++++++-----------
 ./fs/lockd/svcproc.c          |    2 +-
 ./include/linux/lockd/lockd.h |    2 +-
 4 files changed, 16 insertions(+), 14 deletions(-)

diff .prev/fs/lockd/svc4proc.c ./fs/lockd/svc4proc.c
--- .prev/fs/lockd/svc4proc.c	2006-09-01 12:11:01.000000000 +1000
+++ ./fs/lockd/svc4proc.c	2006-09-01 12:17:21.000000000 +1000
@@ -455,7 +455,7 @@ nlm4svc_proc_granted_res(struct svc_rqst
 
         dprintk("lockd: GRANTED_RES   called\n");
 
-        nlmsvc_grant_reply(rqstp, &argp->cookie, argp->status);
+        nlmsvc_grant_reply(&argp->cookie, argp->status);
         return rpc_success;
 }
 

diff .prev/fs/lockd/svclock.c ./fs/lockd/svclock.c
--- .prev/fs/lockd/svclock.c	2006-09-01 12:11:01.000000000 +1000
+++ ./fs/lockd/svclock.c	2006-09-01 12:17:21.000000000 +1000
@@ -139,19 +139,19 @@ static inline int nlm_cookie_match(struc
  * Find a block with a given NLM cookie.
  */
 static inline struct nlm_block *
-nlmsvc_find_block(struct nlm_cookie *cookie,  struct sockaddr_in *sin)
+nlmsvc_find_block(struct nlm_cookie *cookie)
 {
 	struct nlm_block *block;
 
 	list_for_each_entry(block, &nlm_blocked, b_list) {
-		if (nlm_cookie_match(&block->b_call->a_args.cookie,cookie)
-				&& nlm_cmp_addr(sin, &block->b_host->h_addr))
+		if (nlm_cookie_match(&block->b_call->a_args.cookie,cookie))
 			goto found;
 	}
 
 	return NULL;
 
 found:
+	dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
 	kref_get(&block->b_count);
 	return block;
 }
@@ -165,6 +165,11 @@ found:
  * request, but (as I found out later) that's because some implementations
  * do just this. Never mind the standards comittees, they support our
  * logging industries.
+ *
+ * 10 years later: I hope we can safely ignore these old and broken
+ * clients by now. Let's fix this so we can uniquely identify an incoming
+ * GRANTED_RES message by cookie, without having to rely on the client's IP
+ * address. --okir
  */
 static inline struct nlm_block *
 nlmsvc_create_block(struct svc_rqst *rqstp, struct nlm_file *file,
@@ -197,7 +202,7 @@ nlmsvc_create_block(struct svc_rqst *rqs
 	/* Set notifier function for VFS, and init args */
 	call->a_args.lock.fl.fl_flags |= FL_SLEEP;
 	call->a_args.lock.fl.fl_lmops = &nlmsvc_lock_operations;
-	call->a_args.cookie = *cookie;	/* see above */
+	nlmclnt_next_cookie(&call->a_args.cookie);
 
 	dprintk("lockd: created block %p...\n", block);
 
@@ -640,17 +645,14 @@ static const struct rpc_call_ops nlmsvc_
  * block.
  */
 void
-nlmsvc_grant_reply(struct svc_rqst *rqstp, struct nlm_cookie *cookie, u32 status)
+nlmsvc_grant_reply(struct nlm_cookie *cookie, u32 status)
 {
 	struct nlm_block	*block;
-	struct nlm_file		*file;
 
-	dprintk("grant_reply: looking for cookie %x, host (%08x), s=%d \n", 
-		*(unsigned int *)(cookie->data), 
-		ntohl(rqstp->rq_addr.sin_addr.s_addr), status);
-	if (!(block = nlmsvc_find_block(cookie, &rqstp->rq_addr)))
+	dprintk("grant_reply: looking for cookie %x, s=%d \n",
+		*(unsigned int *)(cookie->data), status);
+	if (!(block = nlmsvc_find_block(cookie)))
 		return;
-	file = block->b_file;
 
 	if (block) {
 		if (status == NLM_LCK_DENIED_GRACE_PERIOD) {

diff .prev/fs/lockd/svcproc.c ./fs/lockd/svcproc.c
--- .prev/fs/lockd/svcproc.c	2006-09-01 12:11:01.000000000 +1000
+++ ./fs/lockd/svcproc.c	2006-09-01 12:17:21.000000000 +1000
@@ -484,7 +484,7 @@ nlmsvc_proc_granted_res(struct svc_rqst 
 
 	dprintk("lockd: GRANTED_RES   called\n");
 
-	nlmsvc_grant_reply(rqstp, &argp->cookie, argp->status);
+	nlmsvc_grant_reply(&argp->cookie, argp->status);
 	return rpc_success;
 }
 

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-09-01 12:17:03.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-09-01 12:17:21.000000000 +1000
@@ -193,7 +193,7 @@ u32		  nlmsvc_cancel_blocked(struct nlm_
 unsigned long	  nlmsvc_retry_blocked(void);
 void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
 					nlm_host_match_fn_t match);
-void	  nlmsvc_grant_reply(struct svc_rqst *, struct nlm_cookie *, u32);
+void		  nlmsvc_grant_reply(struct nlm_cookie *, u32);
 
 /*
  * File handling for the server personality
