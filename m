Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269040AbUIMX6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269040AbUIMX6B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269042AbUIMX6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:58:01 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:36520
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269040AbUIMX5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:57:54 -0400
Date: Mon, 13 Sep 2004 16:55:57 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5 bug in tcp_recvmsg?
Message-Id: <20040913165557.568cdffb.davem@davemloft.net>
In-Reply-To: <200409131654.27727.jbarnes@engr.sgi.com>
References: <20040913015003.5406abae.akpm@osdl.org>
	<200409131544.07365.jbarnes@engr.sgi.com>
	<20040913154742.5dd6dabf.davem@davemloft.net>
	<200409131654.27727.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 16:54:27 -0700
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> tg3.  I saw one trace that included do_poll (iirc) and another last week that 
> had sys_select in it.  I'll try to gather some more info.

What you're seeing might be due to the bug fixed by this patch:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/13 12:58:04-07:00 ak@muc.de 
#   [NET]: Fix missing spin lock in lltx path.
#   
#   This fixes a silly missing spin lock in the relock path. For some 
#   reason it seems to still work when you don't have spinlock debugging
#   enabled.
#   
#   Please apply.
#   
#   Thanks to Arjan's spinlock debug kernel for finding it.
#   
#   Signed-off-by: Andi Kleen <ak@muc.de>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/sched/sch_generic.c
#   2004/09/13 12:57:46-07:00 ak@muc.de +3 -1
#   [NET]: Fix missing spin lock in lltx path.
#   
#   This fixes a silly missing spin lock in the relock path. For some 
#   reason it seems to still work when you don't have spinlock debugging
#   enabled.
#   
#   Please apply.
#   
#   Thanks to Arjan's spinlock debug kernel for finding it.
#   
#   Signed-off-by: Andi Kleen <ak@muc.de>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/sched/sch_generic.c b/net/sched/sch_generic.c
--- a/net/sched/sch_generic.c	2004-09-13 16:38:39 -07:00
+++ b/net/sched/sch_generic.c	2004-09-13 16:38:39 -07:00
@@ -148,8 +148,10 @@
 					spin_lock(&dev->queue_lock);
 					return -1;
 				}
-				if (ret == NETDEV_TX_LOCKED && nolock)
+				if (ret == NETDEV_TX_LOCKED && nolock) {
+					spin_lock(&dev->queue_lock);
 					goto collision; 
+				}
 			}
 
 			/* NETDEV_TX_BUSY - we need to requeue */
