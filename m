Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVD0RTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVD0RTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVD0RS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:18:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:25542 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261810AbVD0RRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:17:41 -0400
Date: Wed, 27 Apr 2005 10:16:39 -0700
From: Greg KH <gregkh@suse.de>
To: jjaakkol@cs.Helsinki.FI, dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [05/07] [PATCH] Fix reproducible SMP crash in security/keys/key.c
Message-ID: <20050427171639.GF3195@kroah.com>
References: <20050427171446.GA3195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427171446.GA3195@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------

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
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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
