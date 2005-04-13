Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVDMJDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVDMJDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDMJDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:03:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:12471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261259AbVDMJDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:03:48 -0400
Date: Wed, 13 Apr 2005 02:02:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] Fix reproducible SMP crash in security/keys/key.c
Message-Id: <20050413020246.37e77feb.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504122129510.3075@x40-4.cs.helsinki.fi>
References: <Pine.LNX.4.58.0504122129510.3075@x40-4.cs.helsinki.fi>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Jaakkola <jjaakkol@cs.Helsinki.FI> wrote:
>
> SMP race handling is broken in key_user_lookup() in security/keys/key.c

This was fixed post-2.6.11.  Can you confirm that 2.6.12-rc2 works OK?

This is the patch we used.  It should go into -stable if it's not already
there.


From: Alexander Nyberg <alexn@dsv.su.se>

I looked at some of the oops reports against keyrings, I think the problem
is that the search isn't restarted after dropping the key_user_lock, *p
will still be NULL when we get back to try_again and look through the tree.

It looks like the intention was that the search start over from scratch.

Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/security/keys/key.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN security/keys/key.c~race-against-parent-deletion-in-key_user_lookup security/keys/key.c
--- 25/security/keys/key.c~race-against-parent-deletion-in-key_user_lookup	2005-03-10 00:38:38.000000000 -0800
+++ 25-akpm/security/keys/key.c	2005-03-10 00:38:38.000000000 -0800
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
_

