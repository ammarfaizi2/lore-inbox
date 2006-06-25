Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWFYJqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWFYJqS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 05:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWFYJqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 05:46:18 -0400
Received: from kevlar.burdell.org ([66.92.73.214]:8898 "EHLO
	kevlar.burdell.org") by vger.kernel.org with ESMTP id S932212AbWFYJqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 05:46:18 -0400
Date: Sun, 25 Jun 2006 05:46:16 -0400
From: Sonny Rao <sonny@burdell.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: anton@samba.org
Subject: [PATCH] fix race in idr code
Message-ID: <20060625094616.GA18382@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I ran into a bug where the kernel died in the idr code:

cpu 0x1d: Vector: 300 (Data Access) at [c000000b7096f710]
    pc: c0000000001f8984: .idr_get_new_above_int+0x140/0x330
    lr: c0000000001f89b4: .idr_get_new_above_int+0x170/0x330
    sp: c000000b7096f990
   msr: 800000000000b032
   dar: 0
 dsisr: 40010000
  current = 0xc000000b70d43830
  paca    = 0xc000000000556900
    pid   = 2022, comm = hwup
1d:mon> t
[c000000b7096f990] c0000000000d2ad8 .expand_files+0x2e8/0x364 (unreliable)
[c000000b7096faa0] c0000000001f8bf8 .idr_get_new_above+0x18/0x68
[c000000b7096fb20] c00000000002a054 .init_new_context+0x5c/0xf0
[c000000b7096fbc0] c000000000049dc8 .copy_process+0x91c/0x1404
[c000000b7096fcd0] c00000000004a988 .do_fork+0xd8/0x224
[c000000b7096fdc0] c00000000000ebdc .sys_clone+0x5c/0x74
[c000000b7096fe30] c000000000008950 .ppc_clone+0x8/0xc
--- Exception: c00 (System Call) at 000000000fde887c
SP (f8b4e7a0) is in userspace

Turned out to be a race-condition and NULL ptr deref, here's my fix:

Users of the idr code are supposed to call idr_pre_get without
locking, so the idr code must serialize itself with respect to layer
allocations.  However, it fails to do so in an error path in
idr_get_new_above_int(). I added the missing locking to fix this.

Signed-off-by: Sonny Rao <sonny@burdell.org>

--- linux-sr/lib/idr.c~orig	2006-06-25 04:00:13.000000000 -0500
+++ linux-sr/lib/idr.c	2006-06-25 04:17:47.000000000 -0500
@@ -48,15 +48,21 @@ static struct idr_layer *alloc_layer(str
 	return(p);
 }
 
+/* only called when idp->lock is held */
+static void __free_layer(struct idr *idp, struct idr_layer *p)
+{
+	p->ary[0] = idp->id_free;
+	idp->id_free = p;
+	idp->id_free_cnt++;
+}
+
 static void free_layer(struct idr *idp, struct idr_layer *p)
 {
 	/*
 	 * Depends on the return element being zeroed.
 	 */
 	spin_lock(&idp->lock);
-	p->ary[0] = idp->id_free;
-	idp->id_free = p;
-	idp->id_free_cnt++;
+	__free_layer(idp, p);
 	spin_unlock(&idp->lock);
 }
 
@@ -184,12 +190,14 @@ build_up:
 			 * The allocation failed.  If we built part of
 			 * the structure tear it down.
 			 */
+			spin_lock(&idp->lock);
 			for (new = p; p && p != idp->top; new = p) {
 				p = p->ary[0];
 				new->ary[0] = NULL;
 				new->bitmap = new->count = 0;
-				free_layer(idp, new);
+				__free_layer(idp, new);
 			}
+			spin_unlock(&idp->lock);
 			return -1;
 		}
 		new->ary[0] = p;

