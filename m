Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVCILSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVCILSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVCILSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:18:48 -0500
Received: from mailfe04.swip.net ([212.247.154.97]:35780 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261608AbVCILSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:18:04 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Race against parent deletion in key_user_lookup()
From: Alexander Nyberg <alexn@dsv.su.se>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 09 Mar 2005 12:17:59 +0100
Message-Id: <1110367079.2294.8.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at some of the oops reports against keyrings, I think the problem
is that the search isn't restarted after dropping the key_user_lock,
*p will still be NULL when we get back to try_again and look through the tree.

It looks like the intention was that the search start over from scratch.


Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

===== security/keys/key.c 1.5 vs edited =====
--- 1.5/security/keys/key.c	2005-01-21 06:02:10 +01:00
+++ edited/security/keys/key.c	2005-03-09 12:04:54 +01:00
@@ -57,9 +57,10 @@ struct key_user *key_user_lookup(uid_t u
 {
 	struct key_user *candidate = NULL, *user;
 	struct rb_node *parent = NULL;
-	struct rb_node **p = &key_user_tree.rb_node;
+	struct rb_node **p;
 
  try_again:
+	p = &key_user_tree.rb_node;
 	spin_lock(&key_user_lock);
 
 	/* search the tree for a user record with a matching UID */


