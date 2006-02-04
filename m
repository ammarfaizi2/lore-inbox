Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946263AbWBDCG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946263AbWBDCG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 21:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946265AbWBDCG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 21:06:57 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:36998 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945939AbWBDCGy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 21:06:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nQ2o+xXsTFBq2gogDpp5X0H4iCWtDW11Dx4F8CABUFWclKo6EooAlWXAUp2pz8CF48KUi1hpd4WqxT2O5SpBz2aOqNyNwVQKbVKbqpyXdDl9sMbEOEbaltwhygHRSv7Y6WCFrAAvYhPda3JicPeqPKF7nqsxyNwZH1p5Kv1q+Gc=
Message-ID: <9fda5f510602031806j2f9ef743t206c9ee2c3bef384@mail.gmail.com>
Date: Fri, 3 Feb 2006 18:06:53 -0800
From: Pradeep Vincent <pradeep.vincent@gmail.com>
To: Roberto Nibali <ratz@drugphish.ch>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Fwd: [Patch] 2.4.32 - Neighbour Cache (ARP) State machine bug Fixed
In-Reply-To: <9fda5f510511281257o364acb3gd634f8e412cd7301@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9fda5f510511281257o364acb3gd634f8e412cd7301@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending..

---------- Forwarded message ----------
From: Pradeep Vincent <pradeep.vincent@gmail.com>
Date: Nov 28, 2005 12:57 PM
Subject: [Patch] 2.4.32 - Neighbour Cache (ARP) State machine bug Fixed
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: pradeep.vincent@gmail.com


In 2.4.21, arp code uses gc_timer to check for stale arp cache
entries. In 2.6, each entry has its own timer to check for stale arp
cache. 2.4.29 to 2.4.32 kernels (atleast) use neither of these timers.
This causes problems in environments where IPs or MACs are reassigned
- saw this problem on load balancing router based networks that use
VMACs. Tested this code on load balancing router based networks as
well as peer-linux systems.

Let me know if I need to contact someone else about this,

Thanks,

Pradeep Vincent


diff -Naur old/net/core/neighbour.c new/net/core/neighbour.c
--- old/net/core/neighbour.c    Wed Nov 23 17:15:30 2005
+++ new/net/core/neighbour.c    Wed Nov 23 17:26:01 2005
@@ -14,6 +14,7 @@
*     Vitaly E. Lavrov        releasing NULL neighbor in neigh_add.
*     Harald Welte            Add neighbour cache statistics like rtstat
*     Harald Welte            port neighbour cache rework from 2.6.9-rcX
+ *      Pradeep Vincent         Move neighbour cache entry to stale state
*/

#include <linux/config.h>
@@ -705,6 +706,14 @@
                      neigh_release(n);
                      continue;
              }
+
+               /* Mark it stale - To be reconfirmed later when used */
+               if (n->nud_state&NUD_REACHABLE &&
+                   now - n->confirmed > n->parms->reachable_time) {
+                       n->nud_state = NUD_STALE;
+                       neigh_suspect(n);
+               }
+
              write_unlock(&n->lock);

next_elt:
