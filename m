Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbUKIG5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUKIG5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 01:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUKIFy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:54:28 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:2202
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261406AbUKIFab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:30:31 -0500
Date: Mon, 8 Nov 2004 21:18:20 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: atomic counter underflow when running "rmmod tg3" on
 2.6.10-rc1-mm3
Message-Id: <20041108211820.45d18021.davem@davemloft.net>
In-Reply-To: <200411090333.36550.bero@arklinux.org>
References: <200411090333.36550.bero@arklinux.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004 03:33:36 +0100
Bernhard Rosenkraenzer <bero@arklinux.org> wrote:

> BUG: atomic counter underflow at:
>  [<c02882f6>] qdisc_destroy+0x66/0x80

Yes, this was fixed recently.  The fix should be in Linus's
tree as of this morning.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/05 16:30:34-08:00 tgraf@suug.ch 
#   [PKT_SCHED]: Builtin qdiscs should avoid all qdisc_destroy() processing.
#   
#   None of the code in __qdisc_destroy should be applied to a builtin qdisc
#   or am I missing something?
#   
#   The patch below prevents builtin qdiscs from being destroyed and
#   fixes a refcnt underflow whould lead to a bogus list unlinking
#   and dev_put.
#   
#   Signed-off-by: Thomas Graf <tgraf@suug.ch>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/sched/sch_generic.c
#   2004/11/05 16:30:14-08:00 tgraf@suug.ch +3 -3
#   [PKT_SCHED]: Builtin qdiscs should avoid all qdisc_destroy() processing.
#   
#   None of the code in __qdisc_destroy should be applied to a builtin qdisc
#   or am I missing something?
#   
#   The patch below prevents builtin qdiscs from being destroyed and
#   fixes a refcnt underflow whould lead to a bogus list unlinking
#   and dev_put.
#   
#   Signed-off-by: Thomas Graf <tgraf@suug.ch>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/sched/sch_generic.c b/net/sched/sch_generic.c
--- a/net/sched/sch_generic.c	2004-11-08 21:06:35 -08:00
+++ b/net/sched/sch_generic.c	2004-11-08 21:06:35 -08:00
@@ -479,15 +479,15 @@
 	module_put(ops->owner);
 
 	dev_put(qdisc->dev);
-	if (!(qdisc->flags&TCQ_F_BUILTIN))
-		kfree((char *) qdisc - qdisc->padded);
+	kfree((char *) qdisc - qdisc->padded);
 }
 
 /* Under dev->queue_lock and BH! */
 
 void qdisc_destroy(struct Qdisc *qdisc)
 {
-	if (!atomic_dec_and_test(&qdisc->refcnt))
+	if (qdisc->flags & TCQ_F_BUILTIN ||
+		!atomic_dec_and_test(&qdisc->refcnt))
 		return;
 	list_del(&qdisc->list);
 	call_rcu(&qdisc->q_rcu, __qdisc_destroy);
