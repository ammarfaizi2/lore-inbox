Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVKHPAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVKHPAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVKHPAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:00:13 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:34205 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964876AbVKHPAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:00:11 -0500
Date: Tue, 8 Nov 2005 08:00:08 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: kernel-janitors@lists.osdl.org, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH 4/8] Cleanup kmem_cache_create()
Message-ID: <20051108150008.GL23749@parisc-linux.org>
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436FF70D.6040604@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 04:53:33PM -0800, Matthew Dobson wrote:
> @@ -1652,9 +1649,9 @@ kmem_cache_t *kmem_cache_create(const ch
>  		 * gfp() funcs are more friendly towards high-order requests,
>  		 * this should be changed.
>  		 */
> -		do {
> -			unsigned int break_flag = 0;
> -cal_wastage:
> +		unsigned int break_flag = 0;
> +
> +		for ( ; ; cachep->gfporder++) {
>  			cache_estimate(cachep->gfporder, size, align, flags,
>  						&left_over, &cachep->num);
>  			if (break_flag)
> @@ -1662,13 +1659,13 @@ cal_wastage:
>  			if (cachep->gfporder >= MAX_GFP_ORDER)
>  				break;
>  			if (!cachep->num)
> -				goto next;
> -			if (flags & CFLGS_OFF_SLAB &&
> -					cachep->num > offslab_limit) {
> +				continue;
> +			if ((flags & CFLGS_OFF_SLAB) &&
> +			    (cachep->num > offslab_limit)) {
>  				/* This num of objs will cause problems. */
> -				cachep->gfporder--;
> +				cachep->gfporder -= 2;
>  				break_flag++;
> -				goto cal_wastage;
> +				continue;
>  			}
>  
>  			/*
> @@ -1680,33 +1677,29 @@ cal_wastage:
>  
>  			if ((left_over*8) <= (PAGE_SIZE<<cachep->gfporder))
>  				break;	/* Acceptable internal fragmentation. */
> -next:
> -			cachep->gfporder++;
> -		} while (1);
> +		}
>  	}

I also don't like your changes to this.  Might I suggest:

Index: mm/slab.c
===================================================================
RCS file: /var/cvs/linux-2.6/mm/slab.c,v
retrieving revision 1.31
diff -u -p -r1.31 slab.c
--- mm/slab.c	14 Feb 2005 02:55:36 -0000	1.31
+++ mm/slab.c	8 Nov 2005 14:58:35 -0000
@@ -1150,6 +1150,53 @@ static void slab_destroy (kmem_cache_t *
 	}
 }
 
+/*
+ * Calculate size (in pages) of slabs, and the num of objs per slab.  This
+ * could be made much more intelligent.  For now, try to avoid using high
+ * page-orders for slabs.  When the gfp() funcs are more friendly towards
+ * high-order requests, this should be changed.
+ */
+static size_t find_best_slab_order(kmem_cache_t *cachep, size_t size,
+					 size_t align, unsigned long flags)
+{
+	size_t left_over = 0;
+
+	for ( ; ; cachep->gfporder++) {
+		unsigned int num;
+		size_t remainder;
+
+		if (cachep->gfporder > MAX_GFP_ORDER) {
+			cachep->num = 0;
+			break;
+		}
+
+		cache_estimate(cachep->gfporder, size, align, flags,
+						&remainder, &num);
+		if (!num)
+			continue;
+
+		if (flags & CFLGS_OFF_SLAB && num > offslab_limit) {
+			/* This num of objs will cause problems. */
+			break;
+		}
+
+		cachep->num = num;
+		left_over = remainder;
+
+		/*
+		 * Large num of objs is good, but v. large slabs are
+		 * currently bad for the gfp()s.
+		 */
+		if (cachep->gfporder >= slab_break_gfp_order)
+			break;
+
+		if ((left_over*8) <= (PAGE_SIZE<<cachep->gfporder))
+			break;	/* Acceptable internal fragmentation. */
+	}
+
+	return left_over;
+}
+
 /**
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
@@ -1330,44 +1377,7 @@ kmem_cache_create (const char *name, siz
 		cache_estimate(cachep->gfporder, size, align, flags,
 					&left_over, &cachep->num);
 	} else {
-		/*
-		 * Calculate size (in pages) of slabs, and the num of objs per
-		 * slab.  This could be made much more intelligent.  For now,
-		 * try to avoid using high page-orders for slabs.  When the
-		 * gfp() funcs are more friendly towards high-order requests,
-		 * this should be changed.
-		 */
-		do {
-			unsigned int break_flag = 0;
-cal_wastage:
-			cache_estimate(cachep->gfporder, size, align, flags,
-						&left_over, &cachep->num);
-			if (break_flag)
-				break;
-			if (cachep->gfporder >= MAX_GFP_ORDER)
-				break;
-			if (!cachep->num)
-				goto next;
-			if (flags & CFLGS_OFF_SLAB &&
-					cachep->num > offslab_limit) {
-				/* This num of objs will cause problems. */
-				cachep->gfporder--;
-				break_flag++;
-				goto cal_wastage;
-			}
-
-			/*
-			 * Large num of objs is good, but v. large slabs are
-			 * currently bad for the gfp()s.
-			 */
-			if (cachep->gfporder >= slab_break_gfp_order)
-				break;
-
-			if ((left_over*8) <= (PAGE_SIZE<<cachep->gfporder))
-				break;	/* Acceptable internal fragmentation. */
-next:
-			cachep->gfporder++;
-		} while (1);
+		left_over = find_best_slab_order(cachep, size, align, flags);
 	}
 
 	if (!cachep->num) {
