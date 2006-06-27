Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWF0UUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWF0UUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWF0UUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:20:20 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:10625 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1030340AbWF0UUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:20:17 -0400
Message-Id: <20060627201746.906819000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:23 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, sonny@burdell.org
Subject: [PATCH 23/25] idr: fix race in idr code
Content-Disposition: inline; filename=idr-fix-race-in-idr-code.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Sonny Rao <sonny@burdell.org>

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
-- Exception: c00 (System Call) at 000000000fde887c
SP (f8b4e7a0) is in userspace

Turned out to be a race-condition and NULL ptr deref, here's my fix:

Users of the idr code are supposed to call idr_pre_get without locking, so the
idr code must serialize itself with respect to layer allocations.  However, it
fails to do so in an error path in idr_get_new_above_int().  I added the
missing locking to fix this.

Signed-off-by: Sonny Rao <sonny@burdell.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 lib/idr.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- linux-2.6.17.1.orig/lib/idr.c
+++ linux-2.6.17.1/lib/idr.c
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

--
