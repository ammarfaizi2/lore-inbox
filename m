Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVK1VCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVK1VCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVK1VCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:02:11 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:63881 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751306AbVK1VCK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:02:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WkqP9JeEH6GiinowKLo955ku8XBpIP6xPlUw/E1hyRCFnTapOA8NSaJAAdMvD10wKORxMn2Pm5QeV6G4PAuGET0o0FYGM6eIqYaJrJ+takhxvRKbE5N69lQt7gX4uONjUwLS4i7ziomJU0TWUq01TZzBdklS5yjm9MHCH2tZeaM=
Message-ID: <9fda5f510511281302o465180dfr8833722b6460a71f@mail.gmail.com>
Date: Mon, 28 Nov 2005 13:02:09 -0800
From: Pradeep Vincent <pradeep.vincent@gmail.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [Patch] 2.4.32 - Neighbour Cache (ARP) State machine bug Fixed
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
