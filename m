Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWIAEmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWIAEmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWIAEml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:42:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28331 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932154AbWIAEje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:34 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:39:27 +1000
Message-Id: <1060901043927.27629@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 015 of 19] knfsd: make nlmclnt_next_cookie SMP safe
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  The way we incremented the NLM cookie in nlmclnt_next_cookie
  was not thread safe. This patch changes the counter to an
  atomic_t

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/clntproc.c         |   10 +++++-----
 ./include/linux/lockd/lockd.h |    1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff .prev/fs/lockd/clntproc.c ./fs/lockd/clntproc.c
--- .prev/fs/lockd/clntproc.c	2006-09-01 12:11:03.000000000 +1000
+++ ./fs/lockd/clntproc.c	2006-09-01 12:17:03.000000000 +1000
@@ -36,14 +36,14 @@ static const struct rpc_call_ops nlmclnt
 /*
  * Cookie counter for NLM requests
  */
-static u32	nlm_cookie = 0x1234;
+static atomic_t	nlm_cookie = ATOMIC_INIT(0x1234);
 
-static inline void nlmclnt_next_cookie(struct nlm_cookie *c)
+void nlmclnt_next_cookie(struct nlm_cookie *c)
 {
-	memcpy(c->data, &nlm_cookie, 4);
-	memset(c->data+4, 0, 4);
+	u32	cookie = atomic_inc_return(&nlm_cookie);
+
+	memcpy(c->data, &cookie, 4);
 	c->len=4;
-	nlm_cookie++;
 }
 
 static struct nlm_lockowner *nlm_get_lockowner(struct nlm_lockowner *lockowner)

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-09-01 12:16:06.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-09-01 12:17:03.000000000 +1000
@@ -157,6 +157,7 @@ int		  nlmclnt_block(struct nlm_wait *bl
 u32		  nlmclnt_grant(const struct sockaddr_in *addr, const struct nlm_lock *);
 void		  nlmclnt_recovery(struct nlm_host *);
 int		  nlmclnt_reclaim(struct nlm_host *, struct file_lock *);
+void		  nlmclnt_next_cookie(struct nlm_cookie *);
 
 /*
  * Host cache
