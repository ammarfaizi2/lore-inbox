Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272375AbRHYAzi>; Fri, 24 Aug 2001 20:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272374AbRHYAzX>; Fri, 24 Aug 2001 20:55:23 -0400
Received: from mailg.telia.com ([194.22.194.26]:23490 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S272373AbRHYAzC>;
	Fri, 24 Aug 2001 20:55:02 -0400
Message-Id: <200108250055.f7P0tGh28170@mailg.telia.com>
From: Roger Larsson <roger.larsson@norran.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] simpler __alloc_pages{_limit}
Date: Sat, 25 Aug 2001 02:48:28 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <200108242253.f7OMrbQ20401@mailf.telia.com>
In-Reply-To: <200108242253.f7OMrbQ20401@mailf.telia.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_S8MLZ83BHUZ59ETLQYXS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_S8MLZ83BHUZ59ETLQYXS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi again,

[two typos corrected from the version at linux-mm]

I read through __alloc_pages again and found out that allocs with order > 0
are not treated nicely.

To begin with if order > 0 then direct_reclaim will be false even if it is
allowed to wait...

This version allows "direct_reclaim" with order > 0 !

How?

Like we finally end up doing anyway...
reclaiming pages and freeing.

While adding this I thought why not always do it like this,
even with order == 0?
since it will allow for merging of pages to higher orders.
Before returning a page that was not mergeable...

Doing this - the code started to collaps...
__alloc_pages_limit could suddenly handle all special cases!
(with small functional differences)

Comments?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

--------------Boundary-00=_S8MLZ83BHUZ59ETLQYXS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.4.8-pre3-alloc_pages_limit-R2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="patch-2.4.8-pre3-alloc_pages_limit-R2"

*******************************************
Patch prepared by: roger.larsson@norran.net
Name of file: patches/patch-2.4.8-pre3-alloc_pages_limit-R2

*******************************************
Patch prepared by: roger.larsson@norran.net
Name of file: /home/roger/patches/patch-2.4.8-pre3-alloc_pages_limit-R2

--- linux/mm/page_alloc.c.orig=09Thu Aug 23 22:02:04 2001
+++ linux/mm/page_alloc.c=09Sat Aug 25 01:47:02 2001
@@ -212,9 +212,12 @@
 =09return NULL;
 }
=20
-#define PAGES_MIN=090
-#define PAGES_LOW=091
-#define PAGES_HIGH=092
+#define PAGES_MEMALLOC  0
+#define PAGES_CRITICAL  1
+#define PAGES_MIN=092
+#define PAGES_LOW=093
+#define PAGES_HIGH=094
+#define PAGES_LOW_FREE  5
=20
 /*
  * This function does the dirty work for __alloc_pages
@@ -228,7 +231,7 @@
=20
 =09for (;;) {
 =09=09zone_t *z =3D *(zone++);
-=09=09unsigned long water_mark;
+=09=09unsigned long water_mark, free_min;
=20
 =09=09if (!z)
 =09=09=09break;
@@ -239,10 +242,25 @@
 =09=09 * We allocate if the number of free + inactive_clean
 =09=09 * pages is above the watermark.
 =09=09 */
+
+=09=09free_min =3D z->pages_min;
+
 =09=09switch (limit) {
+=09=09=09case PAGES_MEMALLOC:
+=09=09=09=09free_min =3D water_mark =3D 1;
+=09=09=09=09break;
+=09=09=09case PAGES_CRITICAL:
+=09=09=09=09/* XXX: is pages_min/4 a good amount to reserve for this? */
+=09=09=09=09free_min =3D water_mark =3D z->pages_min / 4;
+=09=09=09=09break;
 =09=09=09default:
 =09=09=09case PAGES_MIN:
-=09=09=09=09water_mark =3D z->pages_min;
+=09=09=09=09water_mark =3D z->pages_min; /*  + (1 << order) - 1; */
+=09=09=09=09break;
+=09=09=09case PAGES_LOW_FREE:
+=09=09=09=09free_min =3D water_mark =3D z->pages_low;
+=09=09=09=09if (direct_reclaim)
+=09=09=09=09=09printk(KERN_WARNING "__alloc_free_limit(PAGES_FREE && dir=
ect_reclaim =3D 1)\n");
 =09=09=09=09break;
 =09=09=09case PAGES_LOW:
 =09=09=09=09water_mark =3D z->pages_low;
@@ -251,23 +269,44 @@
 =09=09=09=09water_mark =3D z->pages_high;
 =09=09}
=20
-=09=09if (z->free_pages + z->inactive_clean_pages >=3D water_mark) {
-=09=09=09struct page *page =3D NULL;
-=09=09=09/* If possible, reclaim a page directly. */
-=09=09=09if (direct_reclaim)
-=09=09=09=09page =3D reclaim_page(z);
-=09=09=09/* If that fails, fall back to rmqueue. */
-=09=09=09if (!page)
-=09=09=09=09page =3D rmqueue(z, order);
-=09=09=09if (page)
-=09=09=09=09return page;
-=09=09}
+
+
+=09=09if (z->free_pages + z->inactive_clean_pages < water_mark)=20
+=09=09=09continue;
+
+=09=09do {
+=09=09=09/*
+=09=09=09 * Reclaim a page from the inactive_clean list.
+=09=09=09 * low water mark. Free all reclaimed pages to
+=09=09=09 * give them a chance to merge to higher orders.
+=09=09=09 */
+=09=09=09if (direct_reclaim) {
+=09=09=09=09struct page *reclaim =3D reclaim_page(z);
+=09=09=09=09if (reclaim) {
+=09=09=09=09=09__free_page(reclaim);
+=09=09=09=09} else if (z->inactive_clean_pages > 0) {
+=09=09=09=09=09printk(KERN_ERR "reclaim_pages failed but there are inact=
ive_clean_pages\n");
+=09=09=09=09=09break;
+=09=09=09=09}
+=09=09=09}
+=09=09=09=09
+=09=09=09/* Always alloc via rmqueue */
+=09=09=09if (z->free_pages >=3D free_min)
+=09=09=09{
+=09=09=09=09struct page *page =3D rmqueue(z, order);
+=09=09=09=09if (page)
+=09=09=09=09=09return page;
+=09=09=09}
+
+=09=09=09/* if it is possible to make progress by retrying - do it */
+=09=09} while (direct_reclaim && z->inactive_clean_pages);
 =09}
=20
 =09/* Found nothing. */
 =09return NULL;
 }
=20
+
 #ifndef CONFIG_DISCONTIGMEM
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned long order)
 {
@@ -281,7 +320,6 @@
  */
 struct page * __alloc_pages(unsigned int gfp_mask, unsigned long order, =
zonelist_t *zonelist)
 {
-=09zone_t **zone;
 =09int direct_reclaim =3D 0;
 =09struct page * page;
=20
@@ -300,34 +338,24 @@
=20
 =09/*
 =09 * Can we take pages directly from the inactive_clean
-=09 * list?
+=09 * list? __alloc_pages_limit now handles any 'order'.
 =09 */
-=09if (order =3D=3D 0 && (gfp_mask & __GFP_WAIT))
+=09if (gfp_mask & __GFP_WAIT)
 =09=09direct_reclaim =3D 1;
=20
-try_again:
 =09/*
 =09 * First, see if we have any zones with lots of free memory.
 =09 *
 =09 * We allocate free memory first because it doesn't contain
 =09 * any data ... DUH!
 =09 */
-=09zone =3D zonelist->zones;
-=09for (;;) {
-=09=09zone_t *z =3D *(zone++);
-=09=09if (!z)
-=09=09=09break;
-=09=09if (!z->size)
-=09=09=09BUG();
+=09page =3D __alloc_pages_limit(zonelist, order, PAGES_LOW_FREE, 0);
+=09if (page)
+=09=09return page;
=20
-=09=09if (z->free_pages >=3D z->pages_low) {
-=09=09=09page =3D rmqueue(z, order);
-=09=09=09if (page)
-=09=09=09=09return page;
-=09=09} else if (z->free_pages < z->pages_min &&
-=09=09=09=09=09waitqueue_active(&kreclaimd_wait)) {
-=09=09=09=09wake_up_interruptible(&kreclaimd_wait);
-=09=09}
+=09/* "all" requested zones has less than LOW free memory, start kreclai=
md */
+=09if (waitqueue_active(&kreclaimd_wait)) {
+=09=09wake_up_interruptible(&kreclaimd_wait);
 =09}
=20
 =09/*
@@ -356,7 +384,7 @@
=20
 =09/*
 =09 * OK, none of the zones on our zonelist has lots
-=09 * of pages free.
+=09 * of pages free or a higher order alloc did not succeed
 =09 *
 =09 * We wake up kswapd, in the hope that kswapd will
 =09 * resolve this situation before memory gets tight.
@@ -371,6 +399,8 @@
 =09 * - if we don't have __GFP_IO set, kswapd may be
 =09 *   able to free some memory we can't free ourselves
 =09 */
+
+
 =09wakeup_kswapd();
 =09if (gfp_mask & __GFP_WAIT) {
 =09=09__set_current_state(TASK_RUNNING);
@@ -385,6 +415,7 @@
 =09 * Kswapd should, in most situations, bring the situation
 =09 * back to normal in no time.
 =09 */
+try_again:
 =09page =3D __alloc_pages_limit(zonelist, order, PAGES_MIN, direct_recla=
im);
 =09if (page)
 =09=09return page;
@@ -398,40 +429,21 @@
 =09 * - we're /really/ tight on memory
 =09 * =09--> try to free pages ourselves with page_launder
 =09 */
-=09if (!(current->flags & PF_MEMALLOC)) {
+=09if (!(current->flags & PF_MEMALLOC) &&
+=09    (gfp_mask & __GFP_WAIT)) {
 =09=09/*
-=09=09 * Are we dealing with a higher order allocation?
-=09=09 *
-=09=09 * Move pages from the inactive_clean to the free list
-=09=09 * in the hope of creating a large, physically contiguous
-=09=09 * piece of free memory.
+=09=09 * Move pages from the inactive_dirty to the inactive_clean
 =09=09 */
-=09=09if (order > 0 && (gfp_mask & __GFP_WAIT)) {
-=09=09=09zone =3D zonelist->zones;
-=09=09=09/* First, clean some dirty pages. */
-=09=09=09current->flags |=3D PF_MEMALLOC;
-=09=09=09page_launder(gfp_mask, 1);
-=09=09=09current->flags &=3D ~PF_MEMALLOC;
-=09=09=09for (;;) {
-=09=09=09=09zone_t *z =3D *(zone++);
-=09=09=09=09if (!z)
-=09=09=09=09=09break;
-=09=09=09=09if (!z->size)
-=09=09=09=09=09continue;
-=09=09=09=09while (z->inactive_clean_pages) {
-=09=09=09=09=09struct page * page;
-=09=09=09=09=09/* Move one page to the free list. */
-=09=09=09=09=09page =3D reclaim_page(z);
-=09=09=09=09=09if (!page)
-=09=09=09=09=09=09break;
-=09=09=09=09=09__free_page(page);
-=09=09=09=09=09/* Try if the allocation succeeds. */
-=09=09=09=09=09page =3D rmqueue(z, order);
-=09=09=09=09=09if (page)
-=09=09=09=09=09=09return page;
-=09=09=09=09}
-=09=09=09}
-=09=09}
+
+=09=09/* First, clean some dirty pages. */
+=09=09current->flags |=3D PF_MEMALLOC;
+=09=09page_launder(gfp_mask, 1);
+=09=09current->flags &=3D ~PF_MEMALLOC;
+
+=09=09page =3D __alloc_pages_limit(zonelist, order, PAGES_MIN, direct_re=
claim);=20
+=09=09if (page)
+=09=09=09return page;
+
 =09=09/*
 =09=09 * When we arrive here, we are really tight on memory.
 =09=09 * Since kswapd didn't succeed in freeing pages for us,
@@ -447,17 +459,15 @@
 =09=09 * any progress freeing pages, in that case it's better
 =09=09 * to give up than to deadlock the kernel looping here.
 =09=09 */
-=09=09if (gfp_mask & __GFP_WAIT) {
-=09=09=09if (!order || total_free_shortage()) {
-=09=09=09=09int progress =3D try_to_free_pages(gfp_mask);
-=09=09=09=09if (progress || (gfp_mask & __GFP_FS))
-=09=09=09=09=09goto try_again;
-=09=09=09=09/*
-=09=09=09=09 * Fail in case no progress was made and the
-=09=09=09=09 * allocation may not be able to block on IO.
-=09=09=09=09 */
-=09=09=09=09return NULL;
-=09=09=09}
+=09=09if (!order || total_free_shortage()) {
+=09=09=09int progress =3D try_to_free_pages(gfp_mask);
+=09=09=09if (progress || (gfp_mask & __GFP_FS))
+=09=09=09=09goto try_again;
+=09=09=09/*
+=09=09=09 * Fail in case no progress was made and the
+=09=09=09 * allocation may not be able to block on IO.
+=09=09=09 */
+=09=09=09return NULL;
 =09=09}
 =09}
=20
@@ -471,35 +481,11 @@
 =09 * in the system, otherwise it would be just too easy to
 =09 * deadlock the system...
 =09 */
-=09zone =3D zonelist->zones;
-=09for (;;) {
-=09=09zone_t *z =3D *(zone++);
-=09=09struct page * page =3D NULL;
-=09=09if (!z)
-=09=09=09break;
-=09=09if (!z->size)
-=09=09=09BUG();
-
-=09=09/*
-=09=09 * SUBTLE: direct_reclaim is only possible if the task
-=09=09 * becomes PF_MEMALLOC while looping above. This will
-=09=09 * happen when the OOM killer selects this task for
-=09=09 * instant execution...
-=09=09 */
-=09=09if (direct_reclaim) {
-=09=09=09page =3D reclaim_page(z);
-=09=09=09if (page)
-=09=09=09=09return page;
-=09=09}
-
-=09=09/* XXX: is pages_min/4 a good amount to reserve for this? */
-=09=09if (z->free_pages < z->pages_min / 4 &&
-=09=09=09=09!(current->flags & PF_MEMALLOC))
-=09=09=09continue;
-=09=09page =3D rmqueue(z, order);
-=09=09if (page)
-=09=09=09return page;
-=09}
+=09page =3D __alloc_pages_limit(zonelist, order,
+=09=09=09=09   current->flags & PF_MEMALLOC ? PAGES_MEMALLOC : PAGES_CRI=
TICAL,
+=09=09=09=09   direct_reclaim);=20
+=09if (page)
+=09=09return page;
=20
 =09/* No luck.. */
 =09printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", orde=
r);

--------------Boundary-00=_S8MLZ83BHUZ59ETLQYXS--
