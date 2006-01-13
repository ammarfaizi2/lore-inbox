Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161643AbWAMDO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161643AbWAMDO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161641AbWAMDOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:14:39 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:17836 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1161640AbWAMDOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:14:37 -0500
From: NeilBrown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 13 Jan 2006 14:14:27 +1100
Message-Id: <1060113031427.4647@cse.unsw.edu.au>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH kNFSd 001 of 3] semaphore to mutex conversion.
References: <20060113141059.4573.patches@notabene>
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on 
	tone.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build and boot tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/svcsock.h |    2 +-
 ./net/sunrpc/svcsock.c           |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff ./include/linux/sunrpc/svcsock.h~current~ ./include/linux/sunrpc/svcsock.h
--- ./include/linux/sunrpc/svcsock.h~current~	2006-01-13 12:37:33.000000000 +1100
+++ ./include/linux/sunrpc/svcsock.h	2006-01-13 12:37:33.000000000 +1100
@@ -36,7 +36,7 @@ struct svc_sock {
 
 	struct list_head	sk_deferred;	/* deferred requests that need to
 						 * be revisted */
-	struct semaphore        sk_sem;		/* to serialize sending data */
+	struct mutex		sk_mutex;	/* to serialize sending data */
 
 	int			(*sk_recvfrom)(struct svc_rqst *rqstp);
 	int			(*sk_sendto)(struct svc_rqst *rqstp);

diff ./net/sunrpc/svcsock.c~current~ ./net/sunrpc/svcsock.c
--- ./net/sunrpc/svcsock.c~current~	2006-01-13 12:37:25.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2006-01-13 12:37:33.000000000 +1100
@@ -1296,13 +1296,13 @@ svc_send(struct svc_rqst *rqstp)
 		xb->page_len +
 		xb->tail[0].iov_len;
 
-	/* Grab svsk->sk_sem to serialize outgoing data. */
-	down(&svsk->sk_sem);
+	/* Grab svsk->sk_mutex to serialize outgoing data. */
+	mutex_lock(&svsk->sk_mutex);
 	if (test_bit(SK_DEAD, &svsk->sk_flags))
 		len = -ENOTCONN;
 	else
 		len = svsk->sk_sendto(rqstp);
-	up(&svsk->sk_sem);
+	mutex_unlock(&svsk->sk_mutex);
 	svc_sock_release(rqstp);
 
 	if (len == -ECONNREFUSED || len == -ENOTCONN || len == -EAGAIN)
@@ -1351,7 +1351,7 @@ svc_setup_socket(struct svc_serv *serv, 
 	svsk->sk_lastrecv = get_seconds();
 	INIT_LIST_HEAD(&svsk->sk_deferred);
 	INIT_LIST_HEAD(&svsk->sk_ready);
-	sema_init(&svsk->sk_sem, 1);
+	mutex_init(&svsk->sk_mutex);
 
 	/* Initialize the socket */
 	if (sock->type == SOCK_DGRAM)
