Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbWADBru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWADBru (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWADBru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:47:50 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:40179 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965147AbWADBrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:47:49 -0500
Subject: Re: [patch 4/9] slab: cache_estimate cleanup
From: Steven Rostedt <rostedt@goodmis.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: clameter@sgi.com, colpatch@us.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1136336416.12468.11.camel@localhost.localdomain>
References: <1136319948.8629.19.camel@localhost>
	 <1136336416.12468.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 20:47:22 -0500
Message-Id: <1136339242.12468.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 20:00 -0500, Steven Rostedt wrote:
> > +	if (flags & CFLGS_OFF_SLAB) {
> > +		mgmt_size = 0;
> > +		nr_objs = slab_size / obj_size;
> > +
> > +		if (nr_objs > SLAB_LIMIT)
> > +			nr_objs = SLAB_LIMIT;
> > +	} else {
> > +		/* Ignore padding for the initial guess.  The padding
> > +		 * is at most @align-1 bytes, and @size is at least
> 
> should @size be @obj_size
> 
> > +		 * @align. In the worst case, this result will be one
> > +		 * greater than the number of objects that fit into
> > +		 * the memory allocation when taking the padding into
> > +		 * account.
> > +		 */
> > +		nr_objs = (slab_size - sizeof(struct slab)) /
> > +			  (obj_size + sizeof(kmem_bufctl_t));
> > +
> > +		/*
> > +		 * Now take the padding into account and increase the
> > +		 * number of objects/slab until it doesn't fit
> > +		 * anymore.
> > +		 */
> > +		while (slab_mgmt_size(nr_objs, align) + nr_objs*obj_size
> > +		       <= slab_size)
> > +			nr_objs++;
> 
> I've also been looking at this and I've realized that we can even remove
> the "while" and make it into an "if".  It works just as well. I created
> the attached test program to see if there would be any difference
> testing all sizes from 8 to PAGE_SIZE >> 1 (where PAGE_SIZE = 1<<12),
> and all alignments of 4 to size, and I tried this with two orders of
> pages.  The "if" should make the assembly a little better.
> 
> -- Steve
> 
> > +
> > +		/*
> > +		 * Reduce it by one which the maximum number of objects that
> > +		 * fit in the slab.
> > +		 */
> > +		if (nr_objs > 0)
> > +			nr_objs--;

Looking even further into this, we can get rid of the while and this if,
and replace it with one if.

		nr_objs = (slab_size - sizeof(struct slab)) /
			  (obj_size + sizeof(kmem_bufctl_t));

		/*
		 * This calculated number will be either the right
		 * amount, or one greater than what we want.
		 */
		if (slab_mgmt_size(nr_objs, align) + nr_objs*obj_size
		       > slab_size)
			nr_objs--;

		if (nr_objs > SLAB_LIMIT)
			nr_objs = SLAB_LIMIT;

Note the change from <= to >.

Here's a new patch for that.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


From: Steven Rostedt <rostedt@goodmis.org>

This patch cleans up cache_estimate in mm/slab.c and improves the algorithm
by taking an initial guess before executing the while loop. The optimization
was originally made by Balbir Singh with further improvements from Steven
Rostedt. Manfred Spraul provider further modifications: no loop at all for
the off-slab case and explain the background.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
Index: linux-2.6.15/mm/slab.c
===================================================================
--- linux-2.6.15.orig/mm/slab.c	2006-01-03 20:39:24.000000000 -0500
+++ linux-2.6.15/mm/slab.c	2006-01-03 20:40:49.000000000 -0500
@@ -700,32 +700,63 @@
 }
 EXPORT_SYMBOL(kmem_find_general_cachep);
 
-/* Cal the num objs, wastage, and bytes left over for a given slab size. */
-static void cache_estimate(unsigned long gfporder, size_t size, size_t align,
-		 int flags, size_t *left_over, unsigned int *num)
+static size_t slab_mgmt_size(size_t nr_objs, size_t align)
 {
-	int i;
-	size_t wastage = PAGE_SIZE<<gfporder;
-	size_t extra = 0;
-	size_t base = 0;
-
-	if (!(flags & CFLGS_OFF_SLAB)) {
-		base = sizeof(struct slab);
-		extra = sizeof(kmem_bufctl_t);
-	}
-	i = 0;
-	while (i*size + ALIGN(base+i*extra, align) <= wastage)
-		i++;
-	if (i > 0)
-		i--;
-
-	if (i > SLAB_LIMIT)
-		i = SLAB_LIMIT;
-
-	*num = i;
-	wastage -= i*size;
-	wastage -= ALIGN(base+i*extra, align);
-	*left_over = wastage;
+	return ALIGN(sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t), align);
+}
+
+/* Calculate the number of objects and left-over bytes for a given
+   object size. */
+static void cache_estimate(unsigned long gfporder, size_t obj_size,
+			   size_t align, int flags, size_t *left_over,
+			   unsigned int *num)
+{
+	int nr_objs;
+	size_t mgmt_size;
+	size_t slab_size = PAGE_SIZE << gfporder;
+
+	/*
+	 * The slab management structure can be either off the slab or
+	 * on it. For the latter case, the memory allocated for a
+	 * slab is used for:
+	 *
+	 * - The struct slab
+	 * - One kmem_bufctl_t for each object
+	 * - Padding, to achieve alignment of @align
+	 * - @obj_size bytes for each object
+	 */
+	if (flags & CFLGS_OFF_SLAB) {
+		mgmt_size = 0;
+		nr_objs = slab_size / obj_size;
+
+		if (nr_objs > SLAB_LIMIT)
+			nr_objs = SLAB_LIMIT;
+	} else {
+		/* Ignore padding for the initial guess.  The padding
+		 * is at most @align-1 bytes, and @size is at least
+		 * @align. In the worst case, this result will be one
+		 * greater than the number of objects that fit into
+		 * the memory allocation when taking the padding into
+		 * account.
+		 */
+		nr_objs = (slab_size - sizeof(struct slab)) /
+			  (obj_size + sizeof(kmem_bufctl_t));
+
+		/*
+		 * This calculated number will be either the right
+		 * amount, or one greater than what we want.
+		 */
+		if (slab_mgmt_size(nr_objs, align) + nr_objs*obj_size
+		       > slab_size)
+			nr_objs--;
+
+		if (nr_objs > SLAB_LIMIT)
+			nr_objs = SLAB_LIMIT;
+
+		mgmt_size = slab_mgmt_size(nr_objs, align);
+	}
+	*num = nr_objs;
+	*left_over = slab_size - nr_objs*obj_size - mgmt_size;
 }
 
 #define slab_error(cachep, msg) __slab_error(__FUNCTION__, cachep, msg)


