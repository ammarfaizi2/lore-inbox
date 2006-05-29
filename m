Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWE2VoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWE2VoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWE2VYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:24:11 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:19384 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751335AbWE2VYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:07 -0400
Date: Mon, 29 May 2006 23:24:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 17/61] lock validator: sk_callback_lock workaround
Message-ID: <20060529212427.GQ3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

temporary workaround for the lock validator: make all uses of
sk_callback_lock softirq-safe. (The real solution will be to
express to the lock validator that sk_callback_lock rules are
to be generated per-address-family.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 net/core/sock.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

Index: linux/net/core/sock.c
===================================================================
--- linux.orig/net/core/sock.c
+++ linux/net/core/sock.c
@@ -934,9 +934,9 @@ int sock_i_uid(struct sock *sk)
 {
 	int uid;
 
-	read_lock(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 	uid = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_uid : 0;
-	read_unlock(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 	return uid;
 }
 
@@ -944,9 +944,9 @@ unsigned long sock_i_ino(struct sock *sk
 {
 	unsigned long ino;
 
-	read_lock(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 	ino = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_ino : 0;
-	read_unlock(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 	return ino;
 }
 
@@ -1306,33 +1306,33 @@ ssize_t sock_no_sendpage(struct socket *
 
 static void sock_def_wakeup(struct sock *sk)
 {
-	read_lock(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
 		wake_up_interruptible_all(sk->sk_sleep);
-	read_unlock(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void sock_def_error_report(struct sock *sk)
 {
-	read_lock(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
 		wake_up_interruptible(sk->sk_sleep);
 	sk_wake_async(sk,0,POLL_ERR); 
-	read_unlock(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void sock_def_readable(struct sock *sk, int len)
 {
-	read_lock(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
 		wake_up_interruptible(sk->sk_sleep);
 	sk_wake_async(sk,1,POLL_IN);
-	read_unlock(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void sock_def_write_space(struct sock *sk)
 {
-	read_lock(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 
 	/* Do not wake up a writer until he can make "significant"
 	 * progress.  --DaveM
@@ -1346,7 +1346,7 @@ static void sock_def_write_space(struct 
 			sk_wake_async(sk, 2, POLL_OUT);
 	}
 
-	read_unlock(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void sock_def_destruct(struct sock *sk)
