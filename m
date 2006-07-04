Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWGDNiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWGDNiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWGDNiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:38:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32486 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750828AbWGDNh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:37:59 -0400
Date: Tue, 4 Jul 2006 15:33:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] lockdep: add more rwsem.h documentation
Message-ID: <20060704133319.GA8372@elte.hu>
References: <1152017562.3109.48.camel@laptopd505.fenrus.org> <14683.1152017262@warthog.cambridge.redhat.com> <15345.1152018339@warthog.cambridge.redhat.com> <20060704132135.GA7816@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704132135.GA7816@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> i think you misunderstood what nested locking means in the lockdep 
> case. (and that is my fault, for not adding enough documentation to 
> down_write_nested() and down_read_nested().)

the patch below adds more documentation.

	Ingo

---------------->
Subject: [patch] lockdep: add more rwsem.h documentation
From: Ingo Molnar <mingo@elte.hu>

add more documentation to rwsem.h.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/rwsem.h |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

Index: linux/include/linux/rwsem.h
===================================================================
--- linux.orig/include/linux/rwsem.h
+++ linux/include/linux/rwsem.h
@@ -61,12 +61,25 @@ extern void downgrade_write(struct rw_se
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /*
- * nested locking:
+ * nested locking. NOTE: rwsems are not allowed to recurse
+ * (which occurs if the same task tries to acquire the same
+ * lock instance multiple times), but multiple locks of the
+ * same lock class might be taken, if the order of the locks
+ * is always the same. This ordering rule can be expressed
+ * to lockdep via the _nested() APIs, but enumerating the
+ * subclasses that are used. (If the nesting relationship is
+ * static then another method for expressing nested locking is
+ * the explicit definition of lock class keys and the use of
+ * lockdep_set_class() at lock initialization time.
+ * See Documentation/lockdep-design.txt for more details.)
  */
 extern void down_read_nested(struct rw_semaphore *sem, int subclass);
 extern void down_write_nested(struct rw_semaphore *sem, int subclass);
 /*
- * Take/release a lock when not the owner will release it:
+ * Take/release a lock when not the owner will release it.
+ *
+ * [ This API should be avoided as much as possible - the
+ *   proper abstraction for this case is completions. ]
  */
 extern void down_read_non_owner(struct rw_semaphore *sem);
 extern void up_read_non_owner(struct rw_semaphore *sem);
