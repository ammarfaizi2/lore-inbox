Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUJOWfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUJOWfh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUJOWfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:35:37 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:8117 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262085AbUJOWfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:35:30 -0400
Subject: Re: [Ext2-devel] Ext3 -mm reservations code: is this fix really
	correct?
From: mingming cao <cmm@us.ibm.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1097878826.1968.162.camel@sisko.scot.redhat.com>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	 <1097856114.4591.28.camel@localhost.localdomain>
	 <1097858401.1968.148.camel@sisko.scot.redhat.com>
	 <1097872144.4591.54.camel@localhost.localdomain>
	 <1097878826.1968.162.camel@sisko.scot.redhat.com>
Content-Type: multipart/mixed; boundary="=-R3aoQy68XBP7mwsIcuTK"
Organization: IBM LTC
Message-Id: <1097879695.4591.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 Oct 2004 15:34:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-R3aoQy68XBP7mwsIcuTK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-10-15 at 15:20, Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, 2004-10-15 at 21:29, mingming cao wrote:
> 
> > How about this? Haven't test it, will do it shortly.:)
> 
>                 if ((my_rsv->rsv_start <= group_end_block) &&
> -                               (my_rsv->rsv_end > group_end_block))
> +                               (my_rsv->rsv_end > group_end_block) &&
> +                               (start_block <= my_rsv->rsv_start))
>                         return -1;
>  
> That new "<=" should be a ">=", shouldn't it?

My bad! It should be ">=":)

Updated patch attached. 

Thanks!

Mingming


--=-R3aoQy68XBP7mwsIcuTK
Content-Disposition: attachment; filename=ext3_reservation_window_fix_fix.patch
Content-Type: text/plain; name=ext3_reservation_window_fix_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

---

 linux-2.6.9-rc1-mm5-ming/fs/ext3/balloc.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_reservation_window_fix_fix fs/ext3/balloc.c
--- linux-2.6.9-rc1-mm5/fs/ext3/balloc.c~ext3_reservation_window_fix_fix	2004-10-15 18:23:42.824158856 -0700
+++ linux-2.6.9-rc1-mm5-ming/fs/ext3/balloc.c	2004-10-15 22:38:52.895674208 -0700
@@ -184,9 +184,10 @@ goal_in_my_reservation(struct reserve_wi
  * if the goal is not in any window.
  * Returns NULL if there are no windows or if all windows start after the goal.
  */
-static struct reserve_window_node *search_reserve_window(struct rb_node *n,
+static struct reserve_window_node *search_reserve_window(struct rb_root *root,
 							 unsigned long goal)
 {
+	struct rb_node *n = root->rb_node;
 	struct reserve_window_node *rsv;
 
 	if (!n)
@@ -822,10 +823,10 @@ static int alloc_new_reservation(struct 
 		start_block = goal + group_first_block;
 
 	size = atomic_read(&my_rsv->rsv_goal_size);
-	/* if we have a old reservation, start the search from the old rsv */
 	if (!rsv_is_empty(&my_rsv->rsv_window)) {
 		/*
 		 * if the old reservation is cross group boundary
+		 * and if the goal is inside the old reservation window,
 		 * we will come here when we just failed to allocate from
 		 * the first part of the window. We still have another part
 		 * that belongs to the next group. In this case, there is no
@@ -838,10 +839,10 @@ static int alloc_new_reservation(struct 
 		 */
 
 		if ((my_rsv->rsv_start <= group_end_block) &&
-				(my_rsv->rsv_end > group_end_block))
+				(my_rsv->rsv_end > group_end_block) &&
+				(start_block >= my_rsv->rsv_start))
 			return -1;
 
-		search_head = search_reserve_window(&my_rsv->rsv_node, start_block);
 		if ((atomic_read(&my_rsv->rsv_alloc_hit) >
 		     (my_rsv->rsv_end - my_rsv->rsv_start + 1) / 2)) {
 			/*
@@ -855,14 +856,10 @@ static int alloc_new_reservation(struct 
 			atomic_set(&my_rsv->rsv_goal_size, size);
 		}
 	}
-	else {
-		/*
-		 * we don't have a reservation,
-		 * we set our goal(start_block) and
-		 * the list head for the search
-		 */
-		search_head = search_reserve_window(fs_rsv_root->rb_node, start_block);
-	}
+	/*
+	 * shift the search start to the window near the goal block
+	 */
+	search_head = search_reserve_window(fs_rsv_root, start_block);
 
 	/*
 	 * find_next_reservable_window() simply finds a reservable window

_

--=-R3aoQy68XBP7mwsIcuTK--

