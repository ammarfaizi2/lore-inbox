Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVCPX7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVCPX7B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbVCPX5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:57:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:64145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262887AbVCPXzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:55:38 -0500
Date: Wed, 16 Mar 2005 15:54:54 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: ralf@linux-mips.org, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       cliffw@osdl.org, tytso@mit.edu, rddunlap@osdl.org
Subject: [4/9] NetROM locking
Message-ID: <20050316235454.GC5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316235336.GY5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

----

From: Ralf Baechle <ralf@linux-mips.org>

Fix deadlock in NetROM due to double locking.  I was sent the patch by
Alan and have doublechecked it.  This bug hits Net/ROM users really hard.
It's accepted by DaveM - but just too late to make it into 2.6.11.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- bk-afu.orig/net/netrom/nr_in.c	2005-02-05 22:16:25.553987776 +0000
+++ bk-afu/net/netrom/nr_in.c	2005-02-05 22:16:25.555987472 +0000
@@ -74,7 +74,6 @@
 static int nr_state1_machine(struct sock *sk, struct sk_buff *skb,
 	int frametype)
 {
-	bh_lock_sock(sk);
 	switch (frametype) {
 	case NR_CONNACK: {
 		nr_cb *nr = nr_sk(sk);
@@ -103,8 +102,6 @@
 	default:
 		break;
 	}
-	bh_unlock_sock(sk);
-
 	return 0;
 }
 
@@ -116,7 +113,6 @@
 static int nr_state2_machine(struct sock *sk, struct sk_buff *skb,
 	int frametype)
 {
-	bh_lock_sock(sk);
 	switch (frametype) {
 	case NR_CONNACK | NR_CHOKE_FLAG:
 		nr_disconnect(sk, ECONNRESET);
@@ -132,8 +128,6 @@
 	default:
 		break;
 	}
-	bh_unlock_sock(sk);
-
 	return 0;
 }
 
@@ -154,7 +148,6 @@
 	nr = skb->data[18];
 	ns = skb->data[17];
 
-	bh_lock_sock(sk);
 	switch (frametype) {
 	case NR_CONNREQ:
 		nr_write_internal(sk, NR_CONNACK);
@@ -265,8 +258,6 @@
 	default:
 		break;
 	}
-	bh_unlock_sock(sk);
-
 	return queued;
 }
 
