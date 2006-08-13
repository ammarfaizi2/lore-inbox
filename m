Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWHMVCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWHMVCF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWHMVBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:01:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9486 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751503AbWHMVBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:01:17 -0400
Date: Sun, 13 Aug 2006 23:01:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] net/ipv6/ip6_fib.c: make code static
Message-ID: <20060813210116.GQ3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
>  git-net.patch
>...
>  git trees
>...

This patch makes the following needlessly global code static:
- fib6_walker_lock
- struct fib6_walker_list
- fib6_walk_continue()
- fib6_walk()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/net/ip6_fib.h |   25 -------------------------
 net/ipv6/ip6_fib.c    |   29 ++++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 30 deletions(-)

--- linux-2.6.18-rc4-mm1/include/net/ip6_fib.h.old	2006-08-13 20:25:29.000000000 +0200
+++ linux-2.6.18-rc4-mm1/include/net/ip6_fib.h	2006-08-13 20:29:34.000000000 +0200
@@ -92,28 +92,6 @@
 	void *args;
 };
 
-extern struct fib6_walker_t fib6_walker_list;
-extern rwlock_t fib6_walker_lock;
-
-static inline void fib6_walker_link(struct fib6_walker_t *w)
-{
-	write_lock_bh(&fib6_walker_lock);
-	w->next = fib6_walker_list.next;
-	w->prev = &fib6_walker_list;
-	w->next->prev = w;
-	w->prev->next = w;
-	write_unlock_bh(&fib6_walker_lock);
-}
-
-static inline void fib6_walker_unlink(struct fib6_walker_t *w)
-{
-	write_lock_bh(&fib6_walker_lock);
-	w->next->prev = w->prev;
-	w->prev->next = w->next;
-	w->prev = w->next = w;
-	write_unlock_bh(&fib6_walker_lock);
-}
-
 struct rt6_statistics {
 	__u32		fib_nodes;
 	__u32		fib_route_nodes;
@@ -195,9 +173,6 @@
 extern void			fib6_clean_all(int (*func)(struct rt6_info *, void *arg),
 					       int prune, void *arg);
 
-extern int			fib6_walk(struct fib6_walker_t *w);
-extern int			fib6_walk_continue(struct fib6_walker_t *w);
-
 extern int			fib6_add(struct fib6_node *root,
 					 struct rt6_info *rt,
 					 struct nlmsghdr *nlh,
--- linux-2.6.18-rc4-mm1/net/ipv6/ip6_fib.c.old	2006-08-13 20:26:04.000000000 +0200
+++ linux-2.6.18-rc4-mm1/net/ipv6/ip6_fib.c	2006-08-13 20:29:35.000000000 +0200
@@ -69,8 +69,7 @@
 	void *arg;
 };
 
-DEFINE_RWLOCK(fib6_walker_lock);
-
+static DEFINE_RWLOCK(fib6_walker_lock);
 
 #ifdef CONFIG_IPV6_SUBTREES
 #define FWS_INIT FWS_S
@@ -82,6 +81,8 @@
 
 static void fib6_prune_clones(struct fib6_node *fn, struct rt6_info *rt);
 static struct fib6_node * fib6_repair_tree(struct fib6_node *fn);
+static int fib6_walk(struct fib6_walker_t *w);
+static int fib6_walk_continue(struct fib6_walker_t *w);
 
 /*
  *	A routing update causes an increase of the serial number on the
@@ -94,13 +95,31 @@
 
 static DEFINE_TIMER(ip6_fib_timer, fib6_run_gc, 0, 0);
 
-struct fib6_walker_t fib6_walker_list = {
+static struct fib6_walker_t fib6_walker_list = {
 	.prev	= &fib6_walker_list,
 	.next	= &fib6_walker_list, 
 };
 
 #define FOR_WALKERS(w) for ((w)=fib6_walker_list.next; (w) != &fib6_walker_list; (w)=(w)->next)
 
+static inline void fib6_walker_link(struct fib6_walker_t *w)
+{
+	write_lock_bh(&fib6_walker_lock);
+	w->next = fib6_walker_list.next;
+	w->prev = &fib6_walker_list;
+	w->next->prev = w;
+	w->prev->next = w;
+	write_unlock_bh(&fib6_walker_lock);
+}
+
+static inline void fib6_walker_unlink(struct fib6_walker_t *w)
+{
+	write_lock_bh(&fib6_walker_lock);
+	w->next->prev = w->prev;
+	w->prev->next = w->next;
+	w->prev = w->next = w;
+	write_unlock_bh(&fib6_walker_lock);
+}
 static __inline__ u32 fib6_new_sernum(void)
 {
 	u32 n = ++rt_sernum;
@@ -1173,7 +1192,7 @@
  *	<0  -> walk is terminated by an error.
  */
 
-int fib6_walk_continue(struct fib6_walker_t *w)
+static int fib6_walk_continue(struct fib6_walker_t *w)
 {
 	struct fib6_node *fn, *pn;
 
@@ -1247,7 +1266,7 @@
 	}
 }
 
-int fib6_walk(struct fib6_walker_t *w)
+static int fib6_walk(struct fib6_walker_t *w)
 {
 	int res;
 

