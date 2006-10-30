Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWJ3Fnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWJ3Fnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 00:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWJ3Fnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 00:43:49 -0500
Received: from cantor.suse.de ([195.135.220.2]:13506 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161104AbWJ3Fns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 00:43:48 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Mon, 30 Oct 2006 16:43:35 +1100
Message-ID: <17733.37127.64785.591939@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH 1/2] sunrpc: add missing spin_unlock
In-Reply-To: message from Trond Myklebust on Sunday October 29
References: <20061028185554.GM9973@localhost>
	<20061029133551.GA10072@localhost>
	<20061029133700.GA10295@localhost>
	<1162153319.5545.62.camel@lade.trondhjem.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 29, Trond.Myklebust@netapp.com wrote:
> On Sun, 2006-10-29 at 22:37 +0900, Akinobu Mita wrote:
> > auth_domain_put() forgot to unlock acquired spinlock.
> 
> ACK. (and added Neil to the CC list).

Thanks.  Also ACK.

However this raises the question of why no-one has reported spinlock
deadlocks despite this bug being in 2.6.17 and 2.6.18.
It turns out the code was never exercised due to other bugs.

This patch fixes those.  Andrew: I notice the first fix has gone into
rc3-mm1. Thanks.  If that and this could get to rc4, that would be
great.

Thanks everyone,
NeilBrown

------------------------
Subject: Fix refcounting problems in rpc servers

From: Neil Brown <neilb@suse.de>

A recent patch fixed a problem which would occur when the refcount on
an auth_domain reached zero.  This problem has not been reported in
practice despite existing in two major kernel releases because the
refcount can never reach zero.

This patch fixes the problems that stop the refcount reaching zero.

1/ We were adding to the refcount when inserting in the hash table,
   but only removing from the hashtable when the refcount reached zero.
   Obviously it never would.  So don't count the implied reference of
   being in the hash table.

2/ There are two paths on which a socket can be destroyed.  One called
   svcauth_unix_info_release().  The other didn't.  So when the other was
   taken, we can lose a reference to an ip_map which in-turn holds a
   reference to an auth_domain

   So unify the exit paths into svc_sock_put.  This highlights the fact
   that svc_delete_socket has slightly odd semantics - it does not drop
   a reference but probably should.  Fixing this need a bit more
   thought and testing.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcauth.c |    4 +---
 ./net/sunrpc/svcsock.c |   30 ++++++++++++++----------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff .prev/net/sunrpc/svcauth.c ./net/sunrpc/svcauth.c
--- .prev/net/sunrpc/svcauth.c	2006-10-30 15:41:10.000000000 +1100
+++ ./net/sunrpc/svcauth.c	2006-10-30 16:12:00.000000000 +1100
@@ -148,10 +148,8 @@ auth_domain_lookup(char *name, struct au
 			return hp;
 		}
 	}
-	if (new) {
+	if (new)
 		hlist_add_head(&new->hash, head);
-		kref_get(&new->ref);
-	}
 	spin_unlock(&auth_domain_lock);
 	return new;
 }

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-10-30 15:26:54.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2006-10-30 16:22:58.000000000 +1100
@@ -330,8 +330,13 @@ static inline void
 svc_sock_put(struct svc_sock *svsk)
 {
 	if (atomic_dec_and_test(&svsk->sk_inuse) && test_bit(SK_DEAD, &svsk->sk_flags)) {
-		dprintk("svc: releasing dead socket\n");
-		sock_release(svsk->sk_sock);
+		printk("svc: releasing dead socket\n");
+		if (svsk->sk_sock->file)
+			sockfd_put(svsk->sk_sock);
+		else
+			sock_release(svsk->sk_sock);
+		if (svsk->sk_info_authunix != NULL)
+			svcauth_unix_info_release(svsk->sk_info_authunix);
 		kfree(svsk);
 	}
 }
@@ -1636,20 +1641,13 @@ svc_delete_socket(struct svc_sock *svsk)
 		if (test_bit(SK_TEMP, &svsk->sk_flags))
 			serv->sv_tmpcnt--;
 
-	if (!atomic_read(&svsk->sk_inuse)) {
-		spin_unlock_bh(&serv->sv_lock);
-		if (svsk->sk_sock->file)
-			sockfd_put(svsk->sk_sock);
-		else
-			sock_release(svsk->sk_sock);
-		if (svsk->sk_info_authunix != NULL)
-			svcauth_unix_info_release(svsk->sk_info_authunix);
-		kfree(svsk);
-	} else {
-		spin_unlock_bh(&serv->sv_lock);
-		dprintk(KERN_NOTICE "svc: server socket destroy delayed\n");
-		/* svsk->sk_server = NULL; */
-	}
+	/* This atomic_inc should be needed - svc_delete_socket
+	 * should have the semantic of dropping a reference.
+	 * But it doesn't yet....
+	 */
+	atomic_inc(&svsk->sk_inuse);
+	spin_unlock_bh(&serv->sv_lock);
+	svc_sock_put(svsk);
 }
 
 /*
