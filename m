Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWDEAIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWDEAIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWDEAHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:07:06 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:40130
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750975AbWDEABk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:40 -0400
Date: Tue, 4 Apr 2006 17:00:56 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Robert Olsson <robert.olsson@its.uu.se>,
       David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 18/26] fib_trie.c node freeing fix
Message-ID: <20060405000056.GS27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fib_trie.c-node-freeing-fix.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply to 2.6.{14,15,16} -stable, thanks a lot.

From: Robert Olsson <robert.olsson@its.uu.se>

[FIB_TRIE]: Fix leaf freeing.

Seems like leaf (end-nodes) has been freed by __tnode_free_rcu and not
by __leaf_free_rcu. This fixes the problem. Only tnode_free is now
used which checks for appropriate node type. free_leaf can be removed.

Signed-off-by: Robert Olsson <robert.olsson@its.uu.se>
Signed-off-by: David Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/fib_trie.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.16.1.orig/net/ipv4/fib_trie.c
+++ linux-2.6.16.1/net/ipv4/fib_trie.c
@@ -314,11 +314,6 @@ static void __leaf_free_rcu(struct rcu_h
 	kfree(container_of(head, struct leaf, rcu));
 }
 
-static inline void free_leaf(struct leaf *leaf)
-{
-	call_rcu(&leaf->rcu, __leaf_free_rcu);
-}
-
 static void __leaf_info_free_rcu(struct rcu_head *head)
 {
 	kfree(container_of(head, struct leaf_info, rcu));
@@ -357,7 +352,12 @@ static void __tnode_free_rcu(struct rcu_
 
 static inline void tnode_free(struct tnode *tn)
 {
-	call_rcu(&tn->rcu, __tnode_free_rcu);
+	if(IS_LEAF(tn)) {
+		struct leaf *l = (struct leaf *) tn;
+		call_rcu_bh(&l->rcu, __leaf_free_rcu);
+	}
+        else
+		call_rcu(&tn->rcu, __tnode_free_rcu);
 }
 
 static struct leaf *leaf_new(void)

--
