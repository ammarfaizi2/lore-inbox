Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbVCQBKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbVCQBKR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 20:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbVCQBJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 20:09:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41486 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262953AbVCQBIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 20:08:23 -0500
Date: Thu, 17 Mar 2005 02:08:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv4/inetpeer.c: make a struct static
Message-ID: <20050317010821.GE3251@stusta.de>
References: <20050315144408.GL3189@stusta.de> <20050316145343.6e31ba6a.davem@davemloft.net> <20050316145448.5a45dddc.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316145448.5a45dddc.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 02:54:48PM -0800, David S. Miller wrote:
> On Wed, 16 Mar 2005 14:53:43 -0800
> "David S. Miller" <davem@davemloft.net> wrote:
> 
> > On Tue, 15 Mar 2005 15:44:08 +0100
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > This patch makes a needlessly global struct static.
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > You need to also kill the externs in net/inetpeer.h
> > 
> > Please fix this up and resubmit.
> 
> Actually, Adrian, net/inetpeer.h makes use of
> inet_peer_unused_tailp in inline functions.
> 
> How did you get a successful build after marking
> it static?

I might be too dumb for reading the output of grep (inetpeer.h...), but 
I'm testing all my patches with two .config's that are roughly 
equivalent to allyesconfig and allmodconfig.

inet_peer_unused_tailp might be referenced from other files via 
inetpeer.h, but inet_peer_unused_head isn't referenced directly from 
other files.

cu
Adrian


<--  snip  -->


This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/ipv4/inetpeer.c    |    4 ++--
 include/net/inetpeer.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.11-mm3-full/net/ipv4/inetpeer.c.old	2005-03-15 13:29:32.000000000 +0100
+++ linux-2.6.11-mm3-full/net/ipv4/inetpeer.c	2005-03-15 13:30:13.000000000 +0100
@@ -92,9 +92,9 @@
 int inet_peer_minttl = 120 * HZ;	/* TTL under high load: 120 sec */
 int inet_peer_maxttl = 10 * 60 * HZ;	/* usual time to live: 10 min */
 
+static struct inet_peer *inet_peer_unused_head;
 /* Exported for inet_putpeer inline function.  */
-struct inet_peer *inet_peer_unused_head,
-		**inet_peer_unused_tailp = &inet_peer_unused_head;
+struct inet_peer **inet_peer_unused_tailp = &inet_peer_unused_head;
 DEFINE_SPINLOCK(inet_peer_unused_lock);
 #define PEER_MAX_CLEANUP_WORK 30
 

--- linux-2.6.11-mm4-full/include/net/inetpeer.h.old	2005-03-17 00:32:16.000000000 +0100
+++ linux-2.6.11-mm4-full/include/net/inetpeer.h	2005-03-17 00:32:26.000000000 +0100
@@ -35,7 +35,6 @@
 struct inet_peer	*inet_getpeer(__u32 daddr, int create);
 
 extern spinlock_t inet_peer_unused_lock;
-extern struct inet_peer *inet_peer_unused_head;
 extern struct inet_peer **inet_peer_unused_tailp;
 /* can be called from BH context or outside */
 static inline void	inet_putpeer(struct inet_peer *p)

