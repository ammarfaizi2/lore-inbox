Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284711AbRLEVA4>; Wed, 5 Dec 2001 16:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284710AbRLEVAt>; Wed, 5 Dec 2001 16:00:49 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:61684 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S284715AbRLEVAb>; Wed, 5 Dec 2001 16:00:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Christoph Hellwig <hch@caldera.de>
Subject: gendisk list access (was: [Evms-devel] Unresolved symbols)
Date: Wed, 5 Dec 2001 14:52:59 -0600
X-Mailer: KMail [version 1.2]
Cc: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <OFCE7B6713.9A6E1AF1-ON85256B02.004FB1C4@raleigh.ibm.com> <20011112173217.A3404@caldera.de>
In-Reply-To: <20011112173217.A3404@caldera.de>
MIME-Version: 1.0
Message-Id: <01120514525902.13647@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 November 2001 10:32, Christoph Hellwig wrote:
> On Mon, Nov 12, 2001 at 08:41:30AM -0600, Mark Peloquin wrote:
> >
> > > 1) gendisk_head called by EVMS's ldev_mgr - RedHat now uses an ac-based
> > > kernel, and gendisk_head was made private as of 2.4.9-ac9. I have no
> > > idea why this was done, but was able to fix the unresolved symbol by
> > > exporting it again as in a vanilla genhd.c. There is a comment saying
> > > that you should never access this directly, and the only reason it was
> > > exported was for source compatibility, so I guess this is why it was
> > > removed in the ac kernel. Can EVMS be fixed so that it doesn't need
> > > gendisk_head exported by the kernel?
> >
> > Since we build on the stock kernels, we have not yet dealt with
> > some of the differences found in the -ac kernels. Abstraction of
> > the gendisk_head is one of these. I believe the -ac kernel now
> > using functions to add and delete gendisk entries from the
> > gendisk list, and thus no longer requires the gendisk_head to
> > be exported. The change you made will work until we code for
> > the difference.
>
> You are supposed to use {add,del,get}_gendisk since 2.4.10/2.4.9-ac<~14>.
> Alan removed the export in 2.4.9-ac17, but I disagree with him as we
> want to maintain source compatibility.
>
> Note that direct access is racy as no locking is performed.
>
> 	Christoph

We have been looking back over the EVMS code that accesses the gendisk list, 
and trying to figure out how to abstract out the direct access of 
gendisk_head. Unfortunately, the currently supplied API get_gendisk() is not 
sufficient. EVMS needs to traverse the entire gendisk list to determine all 
of the available disks in the system. The only way to do this using 
get_gendisk() would be to iterate through every possible major number, 
calling get_gendisk() for each one. Obviously that is wasteful. Also (as I 
believe has been pointed out already in other discussions), accesing the list 
even in this manner is still unsafe, because the gendisk_lock is only held 
while searching the list for the given major number, not while the caller 
actually accesses the item that is returned.

So one of my questions is: what is in store for the gendisk list in 2.5? 
There is a comment in add_gendisk() about some part of that code going away 
in 2.5 (although it's vague as to what the comment refers to), but no 
corresponding comment in del_gendisk(). Are these two APIs coming or going? 
I've also noticed get_start_sect() and get_nr_sects() in genhd.c in the 
latest 2.5 patches. Are there any more new APIs that will be coming?

In order for EVMS to run this list correctly during volume discovery, and to 
sufficiently abstract access to the gendisk list variables, and to keep 
everything SMP safe, it seems we would need APIs such as lock_gendisk_list(), 
unlock_gendisk_list(), get_gendisk_first(), and get_gendisk_next(). I've 
included a patch below (against 2.4.16) for genhd.c with examples of these 
APIs. EVMS could then use these to lock the list, traverse the list and 
process all entries, and then unlock.

Comments?

Kevin Corry



diff -Naur linux-2.4.16/drivers/block/genhd.c 
linux-2.4.16-new/drivers/block/genhd.c
--- linux-2.4.16/drivers/block/genhd.c	Wed Oct 17 16:46:29 2001
+++ linux-2.4.16-new/drivers/block/genhd.c	Wed Dec  5 14:27:49 2001
@@ -123,6 +123,51 @@
 EXPORT_SYMBOL(get_gendisk);
 
 
+void
+lock_gendisk_list(void)
+{
+	read_lock(&gendisk_lock);
+}
+
+EXPORT_SYMBOL(lock_gendisk_list);
+
+void
+unlock_gendisk_list(void)
+{
+	read_unlock(&gendisk_lock);
+}
+
+EXPORT_SYMBOL(unlock_gendisk_list);
+
+
+/**
+ * get_gendisk_first - returns the first item in the gendisk list. Must have
+ *                    first locked the gendisk list using lock_gendisk().
+ */
+struct gendisk *
+get_gendisk_first(void)
+{
+	return gendisk_head;
+}
+
+EXPORT_SYMBOL(get_gendisk_first);
+
+
+/**
+ * get_gendisk_next - return the gendisk entry immediately following the
+ *                    specified entry. Must have locked the gendisk list
+ *                    first using lock_gendisk().
+ * @cur: Current item from the gendisk list. Get the following item.
+ */
+struct gendisk *
+get_gendisk_next(struct gendisk *cur)
+{
+	return( cur ? cur->next : NULL );
+}
+
+EXPORT_SYMBOL(get_gendisk_next);
+
+
 #ifdef CONFIG_PROC_FS
 int
 get_partition_list(char *page, char **start, off_t offset, int count)
diff -Naur linux-2.4.16/include/linux/genhd.h 
linux-2.4.16-new/include/linux/genhd.h
--- linux-2.4.16/include/linux/genhd.h	Thu Nov 22 13:47:05 2001
+++ linux-2.4.16-new/include/linux/genhd.h	Wed Dec  5 14:29:46 2001
@@ -91,6 +91,10 @@
 extern void add_gendisk(struct gendisk *gp);
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(kdev_t dev);
+extern void lock_gendisk_list(void);
+extern void unlock_gendisk_list(void);
+extern struct gendisk *get_gendisk_first(void);
+extern struct gendisk *get_gendisk_next(struct gendisk *cur);
 
 #endif  /*  __KERNEL__  */
 
