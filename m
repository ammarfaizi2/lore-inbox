Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284529AbRLEV4k>; Wed, 5 Dec 2001 16:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284689AbRLEV4L>; Wed, 5 Dec 2001 16:56:11 -0500
Received: from ns.caldera.de ([212.34.180.1]:9946 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S284451AbRLEVyF>;
	Wed, 5 Dec 2001 16:54:05 -0500
Date: Wed, 5 Dec 2001 22:53:46 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Kevin Corry <corryk@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: gendisk list access (was: [Evms-devel] Unresolved symbols)
Message-ID: <20011205225346.A7313@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Kevin Corry <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <OFCE7B6713.9A6E1AF1-ON85256B02.004FB1C4@raleigh.ibm.com> <20011112173217.A3404@caldera.de> <01120514525902.13647@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01120514525902.13647@boiler>; from corryk@us.ibm.com on Wed, Dec 05, 2001 at 02:52:59PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 02:52:59PM -0600, Kevin Corry wrote:
> So one of my questions is: what is in store for the gendisk list in 2.5? 
> There is a comment in add_gendisk() about some part of that code going away 
> in 2.5 (although it's vague as to what the comment refers to),

There are two comments, first

* XXX: you should _never_ access this directly.
*      the only reason this is exported is source compatiblity.

over the declaration of gendisk_head - since 2.5.1-pre2 gendisk_head
is static and the comment is gone.

The second is

*      In 2.5 this will go away. Fix the drivers who rely on
*      old behaviour.

This is in add_gendisk and means that we currently work around callers
trying to do add_gendisk on the same structure twice.  This will go away
as soon as the 'sd' driver is fixed.

> but no 
> corresponding comment in del_gendisk(). Are these two APIs coming or going? 
> I've also noticed get_start_sect() and get_nr_sects() in genhd.c in the 
> latest 2.5 patches. Are there any more new APIs that will be coming?

For early 2.5 the above API will remain - for mid to late 2.5 I plan to
get rid of per-major gendisk completly.  My design on a replacement is not
yet written down, but the details are:

 - the minor_shift member moves into the block queue
 - each block queue gets a pointer to be used for partitioning, this will
   be opaque to the drivers.
 - a per-queue 'struct gendisk' equivalent (minus the fields that aren't used)
   will go into above pointer.
 - partitions will be registered as normal block devices, to the layers
   outside the partitioning handling there will be no difference between
   a block device and a partition.

Hope this helps..

> In order for EVMS to run this list correctly during volume discovery, and to 
> sufficiently abstract access to the gendisk list variables, and to keep 
> everything SMP safe, it seems we would need APIs such as lock_gendisk_list(), 
> unlock_gendisk_list(), get_gendisk_first(), and get_gendisk_next(). I've 
> included a patch below (against 2.4.16) for genhd.c with examples of these 
> APIs. EVMS could then use these to lock the list, traverse the list and 
> process all entries, and then unlock.

This API looks really ugly to me.  Did you take a look at my 'walk_gendisk'
patch I sent to the evms list some time ago?  (attached again).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff linux.shrink_icache/drivers/block/genhd.c linux.walk_gendisk/drivers/block/genhd.c
--- linux.shrink_icache/drivers/block/genhd.c	Wed Oct 31 12:52:32 2001
+++ linux.walk_gendisk/drivers/block/genhd.c	Fri Nov  2 15:06:00 2001
@@ -121,6 +121,32 @@
 EXPORT_SYMBOL(get_gendisk);
 
 
+/**
+ * walk_gendisk - issue a command for every registered gendisk
+ * @walk: user-specified callback
+ * @data: opaque data for the callback
+ *
+ * This function walks through the gendisk chain and calls back
+ * into @walk for every element.
+ */
+int
+walk_gendisk(int (*walk)(struct gendisk *, void *), void *data)
+{
+	struct gendisk *gp;
+	int error = 0;
+
+	read_lock(&gendisk_lock);
+	for (gp = gendisk_head; gp; gp = gp->next)
+		if ((error = walk(gp, data)))
+			break;
+	read_unlock(&gendisk_lock);
+
+	return error;
+}
+
+EXPORT_SYMBOL(walk_gendisk);
+
+
 #ifdef CONFIG_PROC_FS
 int
 get_partition_list(char *page, char **start, off_t offset, int count)
diff -uNr -Xdontdiff linux.shrink_icache/include/linux/genhd.h linux.walk_gendisk/include/linux/genhd.h
--- linux.shrink_icache/include/linux/genhd.h	Fri Nov  2 15:02:48 2001
+++ linux.walk_gendisk/include/linux/genhd.h	Fri Nov  2 15:06:00 2001
@@ -93,6 +93,7 @@
 extern void add_gendisk(struct gendisk *gp);
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(kdev_t dev);
+extern int walk_gendisk(int (*walk)(struct gendisk *, void *), void *);
 
 #endif  /*  __KERNEL__  */
 
