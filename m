Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVCIMDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVCIMDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 07:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVCIMDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 07:03:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24739 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262340AbVCIMDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 07:03:06 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1110367079.2294.8.camel@boxen> 
References: <1110367079.2294.8.camel@boxen> 
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Alexander Nyberg <alexn@dsv.su.se>
Subject: Race against parent deletion in key_user_lookup() 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 09 Mar 2005 12:02:49 +0000
Message-ID: <3411.1110369769@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I looked at some of the oops reports against keyrings, I think the problem
is that the search isn't restarted after dropping the key_user_lock,
*p will still be NULL when we get back to try_again and look through the tree.

It looks like the intention was that the search start over from scratch.

Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>
Signed-Off-By: David Howells <dhowells@redhat.com>

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


