Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946539AbWKAFo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946539AbWKAFo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946545AbWKAFn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:43:58 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:62683 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946537AbWKAFm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:42:59 -0500
Message-Id: <20061101054028.568862000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:10 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Andrew Morton <akpm@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, NeilBrown <neilb@suse.de>,
       Adrian Bunk <bunk@stusta.de>, nfs@lists.sourceforge.net,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 30/61] knfsd: Fix race that can disable NFS server.
Content-Disposition: inline; filename=knfsd-fix-race-that-can-disable-nfs-server.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: NeilBrown <neilb@suse.de>

This is a long standing bug that seems to have only recently become
apparent, presumably due to increasing use of NFS over TCP - many
distros seem to be making it the default.

The SK_CONN bit gets set when a listening socket may be ready
for an accept, just as SK_DATA is set when data may be available.

It is entirely possible for svc_tcp_accept to be called with neither
of these set.  It doesn't happen often but there is a small race in
svc_sock_enqueue as SK_CONN and SK_DATA are tested outside the
spin_lock.  They could be cleared immediately after the test and
before the lock is gained.

This normally shouldn't be a problem.  The sockets are non-blocking so
trying to read() or accept() when ther is nothing to do is not a problem.

However: svc_tcp_recvfrom makes the decision "Should I accept() or
should I read()" based on whether SK_CONN is set or not.  This usually
works but is not safe.  The decision should be based on whether it is
a TCP_LISTEN socket or a TCP_CONNECTED socket.


Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 net/sunrpc/svcsock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.1.orig/net/sunrpc/svcsock.c
+++ linux-2.6.18.1/net/sunrpc/svcsock.c
@@ -902,7 +902,7 @@ svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		return 0;
 	}
 
-	if (test_bit(SK_CONN, &svsk->sk_flags)) {
+	if (svsk->sk_sk->sk_state == TCP_LISTEN) {
 		svc_tcp_accept(svsk);
 		svc_sock_received(svsk);
 		return 0;

--
