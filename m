Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933951AbWKTJUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933951AbWKTJUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 04:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934030AbWKTJUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 04:20:15 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:29140 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S933951AbWKTJUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 04:20:14 -0500
Subject: [PATCH] lockdep: annotate irda warning
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrey Borzenkov <arvidjaar@mail.ru>, Andrew Morton <akpm@osdl.org>
Cc: samuel@sortiz.org, irda-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       arjan <arjan@infradead.org>
In-Reply-To: <200611181612.36008.arvidjaar@mail.ru>
References: <200611181612.36008.arvidjaar@mail.ru>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 10:15:39 +0100
Message-Id: <1164014139.5968.138.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(repost with slightly changed patch)

On Sat, 2006-11-18 at 16:12 +0300, Andrey Borzenkov wrote:

> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.19-rc5-2avb #2
> - ---------------------------------------------
> pppd/26425 is trying to acquire lock:
>  (&hashbin->hb_spinlock){....}, at: [<dfdea87a>] irlmp_slsap_inuse+0x5a/0x170 
> [irda]
> 
> but task is already holding lock:
>  (&hashbin->hb_spinlock){....}, at: [<dfdea857>] irlmp_slsap_inuse+0x37/0x170 
> [irda]
> 
> other info that might help us debug this:
> 1 lock held by pppd/26425:
>  #0:  (&hashbin->hb_spinlock){....}, at: [<dfdea857>] 
> irlmp_slsap_inuse+0x37/0x170 [irda]
> 
> stack backtrace:
>  [<c010413c>] dump_trace+0x1cc/0x200
>  [<c010418a>] show_trace_log_lvl+0x1a/0x30
>  [<c01047f2>] show_trace+0x12/0x20
>  [<c01048c9>] dump_stack+0x19/0x20
>  [<c01346ca>] __lock_acquire+0x8fa/0xc20
>  [<c0134d2d>] lock_acquire+0x5d/0x80
>  [<c02a851c>] _spin_lock+0x2c/0x40
>  [<dfdea87a>] irlmp_slsap_inuse+0x5a/0x170 [irda]
>  [<dfdebab2>] irlmp_open_lsap+0x62/0x180 [irda]
>  [<dfdf35d1>] irttp_open_tsap+0x181/0x230 [irda]
>  [<dfdc0c3d>] ircomm_open_tsap+0x5d/0xa0 [ircomm]
>  [<dfdc05d8>] ircomm_open+0xb8/0xd0 [ircomm]
>  [<dfdd0477>] ircomm_tty_open+0x4f7/0x570 [ircomm_tty]
>  [<c020bbe4>] tty_open+0x174/0x340
>  [<c016bd69>] chrdev_open+0x89/0x170
>  [<c0167bd6>] __dentry_open+0xa6/0x1d0
>  [<c0167da5>] nameidata_to_filp+0x35/0x40
>  [<c0167df9>] do_filp_open+0x49/0x50
>  [<c0167e47>] do_sys_open+0x47/0xd0
>  [<c0167f0c>] sys_open+0x1c/0x20
>  [<c010307d>] sysenter_past_esp+0x56/0x8d
>  [<b7f86410>] 0xb7f86410
>  =======================

The comment at the nesting lock says:

	/* Careful for priority inversions here !
	 * irlmp->links is never taken while another IrDA
	 * spinlock is held, so we are safe. Jean II */

So, under the assumption the author was right, it just needs a lockdep
annotation.

(depends on patches in -mm for spin_lock_irqsave_nested())

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 net/irda/irlmp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6-mm/net/irda/irlmp.c
===================================================================
--- linux-2.6-mm.orig/net/irda/irlmp.c	2006-11-20 09:54:50.000000000 +0100
+++ linux-2.6-mm/net/irda/irlmp.c	2006-11-20 10:12:11.000000000 +0100
@@ -1678,7 +1678,8 @@ static int irlmp_slsap_inuse(__u8 slsap_
 	 *  every IrLAP connection and check every LSAP associated with each
 	 *  the connection.
 	 */
-	spin_lock_irqsave(&irlmp->links->hb_spinlock, flags);
+	spin_lock_irqsave_nested(&irlmp->links->hb_spinlock, flags,
+			SINGLE_DEPTH_NESTING);
 	lap = (struct lap_cb *) hashbin_get_first(irlmp->links);
 	while (lap != NULL) {
 		IRDA_ASSERT(lap->magic == LMP_LAP_MAGIC, goto errlap;);


