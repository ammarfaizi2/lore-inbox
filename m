Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRBHAkq>; Wed, 7 Feb 2001 19:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130764AbRBHAkg>; Wed, 7 Feb 2001 19:40:36 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:2827 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129282AbRBHAkT>; Wed, 7 Feb 2001 19:40:19 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 8 Feb 2001 11:34:46 +1100 (EST)
Message-ID: <14977.59814.532773.466631@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Christoph Hellwig <hch@ns.caldera.de>, Ben LaHaise <bcrl@redhat.com>,
        Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: message from Linus Torvalds on Wednesday February 7
In-Reply-To: <20010207192622.A23859@caldera.de>
	<Pine.LNX.4.10.10102071032390.4623-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 7, torvalds@transmeta.com wrote:
> 
> 
> On Wed, 7 Feb 2001, Christoph Hellwig wrote:
> 
> > On Tue, Feb 06, 2001 at 12:59:02PM -0800, Linus Torvalds wrote:
> > > 
> > > Actually, they really aren't.
> > > 
> > > They kind of _used_ to be, but more and more they've moved away from that
> > > historical use. Check in particular the page cache, and as a really
> > > extreme case the swap cache version of the page cache.
> > 
> > Yes.  And that exactly why I think it's ugly to have the left-over
> > caching stuff in the same data sctruture as the IO buffer.
> 
> I do agree.
> 
> I would not be opposed to factoring out the "pure block IO" part from the
> bh struct. It should not even be very hard. You'd do something like
> 
> 	struct block_io {
> 		.. here is the stuff needed for block IO ..
> 	};
> 
> 	struct buffer_head {
> 		struct block_io io;
> 		.. here is the stuff needed for hashing etc ..
> 	}
> 
> and then you make "generic_make_request()" and everything lower down take
> just the "struct block_io".
> 

I was just thinking the same, or a similar thing.
I wanted to do

    struct io_head {
         stuff
    };
    struct buffer_head {
         struct io_head;
         more stuff;
    }

so that, as an unnamed substructure, the content of the struct io_head
would automagically be promoted to appear to be content of
buffer_head.
However I then remembered (when it didn't work) that unnamed
substructures are a feature of the Plan-9 C compiler, not the GNU
Compiler Collection. (Any gcc coders out there think this would be a
good thing to add?
  http://plan9.bell-labs.com/sys/doc/compiler.html
)

Anyway, I produced the same result in a rather ugly way with #defines
and modified raid5 to use 32byte block_io structures instead of the
80+ byte buffer_heads, and it ... doesn't quite work :-( it boots
fine, but raid5 dies and the Oops message is a few kilometers away.
Anyway, I think the concept it fine.

Patch is below for your inspection.

It occurs to me that Stephen's desire to pass lots of requests through
make_request all at once isn't a bad idea and could be done by simply
linking the io_heads together with b_reqnext.
This would require:
  1/ all callers of generic_make_request (there are 3) to initialise
     b_reqnext
  2/ all registered make_request_fn functions (there are again 3 I
     think)  to cope with following b_reqnext

It shouldn't be too hard to make the elevator code take advantage of
any ordering that it fines in the list.

I don't have a patch which does this.

NeilBrown


--- ./include/linux/fs.h	2001/02/07 22:45:37	1.1
+++ ./include/linux/fs.h	2001/02/07 23:09:05
@@ -207,6 +207,7 @@
 #define BH_Protected	6	/* 1 if the buffer is protected */
 
 /*
+ * THIS COMMENT NO-LONGER CORRECT.
  * Try to keep the most commonly used fields in single cache lines (16
  * bytes) to improve performance.  This ordering should be
  * particularly beneficial on 32-bit processors.
@@ -217,31 +218,43 @@
  * The second 16 bytes we use for lru buffer scans, as used by
  * sync_buffers() and refill_freelist().  -- sct
  */
+
+/* 
+ * io_head is all that is needed by device drivers.
+ */
+#define io_head_fields \
+	unsigned long b_state;		/* buffer state bitmap (see above) */	\
+	struct buffer_head *b_reqnext;	/* request queue */			\
+	unsigned short b_size;		/* block size */			\
+	kdev_t b_rdev;			/* Real device */			\
+	unsigned long b_rsector;	/* Real buffer location on disk */	\
+	char * b_data;			/* pointer to data block (512 byte) */	\
+	void (*b_end_io)(struct buffer_head *bh, int uptodate); /* I/O completion */ \
+ 	void *b_private;		/* reserved for b_end_io */		\
+	struct page *b_page;		/* the page this bh is mapped to */	\
+     /* this line intensionally left blank */
+struct io_head {
+	io_head_fields
+};
+
+/* buffer_head adds all the stuff needed by the buffer cache */
 struct buffer_head {
-	/* First cache line: */
+	io_head_fields
+
 	struct buffer_head *b_next;	/* Hash queue list */
 	unsigned long b_blocknr;	/* block number */
-	unsigned short b_size;		/* block size */
 	unsigned short b_list;		/* List that this buffer appears */
 	kdev_t b_dev;			/* device (B_FREE = free) */
 
 	atomic_t b_count;		/* users using this block */
-	kdev_t b_rdev;			/* Real device */
-	unsigned long b_state;		/* buffer state bitmap (see above) */
 	unsigned long b_flushtime;	/* Time when (dirty) buffer should be written */
 
 	struct buffer_head *b_next_free;/* lru/free list linkage */
 	struct buffer_head *b_prev_free;/* doubly linked list of buffers */
 	struct buffer_head *b_this_page;/* circular list of buffers in one page */
-	struct buffer_head *b_reqnext;	/* request queue */
 
 	struct buffer_head **b_pprev;	/* doubly linked list of hash-queue */
-	char * b_data;			/* pointer to data block (512 byte) */
-	struct page *b_page;		/* the page this bh is mapped to */
-	void (*b_end_io)(struct buffer_head *bh, int uptodate); /* I/O completion */
- 	void *b_private;		/* reserved for b_end_io */
 
-	unsigned long b_rsector;	/* Real buffer location on disk */
 	wait_queue_head_t b_wait;
 
 	struct inode *	     b_inode;
--- ./drivers/md/raid5.c	2001/02/06 05:43:31	1.2
+++ ./drivers/md/raid5.c	2001/02/07 23:15:36
@@ -151,18 +151,16 @@
 
 	for (i=0; i<num; i++) {
 		struct page *page;
-		bh = kmalloc(sizeof(struct buffer_head), priority);
+		bh = kmalloc(sizeof(struct io_head), priority);
 		if (!bh)
 			return 1;
-		memset(bh, 0, sizeof (struct buffer_head));
-		init_waitqueue_head(&bh->b_wait);
+		memset(bh, 0, sizeof (struct io_head));
 		page = alloc_page(priority);
 		bh->b_data = page_address(page);
 		if (!bh->b_data) {
 			kfree(bh);
 			return 1;
 		}
-		atomic_set(&bh->b_count, 0);
 		bh->b_page = page;
 		sh->bh_cache[i] = bh;
 
@@ -412,7 +410,7 @@
 			spin_lock_irqsave(&conf->device_lock, flags);
 		}
 	} else {
-		md_error(mddev_to_kdev(conf->mddev), bh->b_dev);
+		md_error(mddev_to_kdev(conf->mddev), conf->disks[i].dev);
 		clear_bit(BH_Uptodate, &bh->b_state);
 	}
 	clear_bit(BH_Lock, &bh->b_state);
@@ -440,7 +438,7 @@
 
 	md_spin_lock_irqsave(&conf->device_lock, flags);
 	if (!uptodate)
-		md_error(mddev_to_kdev(conf->mddev), bh->b_dev);
+		md_error(mddev_to_kdev(conf->mddev), conf->disks[i].dev);
 	clear_bit(BH_Lock, &bh->b_state);
 	set_bit(STRIPE_HANDLE, &sh->state);
 	__release_stripe(conf, sh);
@@ -456,12 +454,10 @@
 	unsigned long block = sh->sector / (sh->size >> 9);
 
 	init_buffer(bh, raid5_end_read_request, sh);
-	bh->b_dev       = conf->disks[i].dev;
 	bh->b_blocknr   = block;
 
 	bh->b_state	= (1 << BH_Req) | (1 << BH_Mapped);
 	bh->b_size	= sh->size;
-	bh->b_list	= BUF_LOCKED;
 	return bh;
 }
 
@@ -1085,15 +1081,14 @@
 			else
 				bh->b_end_io = raid5_end_write_request;
 			if (conf->disks[i].operational)
-				bh->b_dev = conf->disks[i].dev;
+				bh->b_rdev = conf->disks[i].dev;
 			else if (conf->spare && action[i] == WRITE+1)
-				bh->b_dev = conf->spare->dev;
+				bh->b_rdev = conf->spare->dev;
 			else skip=1;
 			if (!skip) {
 				PRINTK("for %ld schedule op %d on disc %d\n", sh->sector, action[i]-1, i);
 				atomic_inc(&sh->count);
-				bh->b_rdev = bh->b_dev;
-				bh->b_rsector = bh->b_blocknr * (bh->b_size>>9);
+				bh->b_rsector = sh->sector;
 				generic_make_request(action[i]-1, bh);
 			} else {
 				PRINTK("skip op %d on disc %d for sector %ld\n", action[i]-1, i, sh->sector);
@@ -1502,7 +1497,7 @@
 	}
 
 	memory = conf->max_nr_stripes * (sizeof(struct stripe_head) +
-		 conf->raid_disks * ((sizeof(struct buffer_head) + PAGE_SIZE))) / 1024;
+		 conf->raid_disks * ((sizeof(struct io_head) + PAGE_SIZE))) / 1024;
 	if (grow_stripes(conf, conf->max_nr_stripes, GFP_KERNEL)) {
 		printk(KERN_ERR "raid5: couldn't allocate %dkB for buffers\n", memory);
 		shrink_stripes(conf, conf->max_nr_stripes);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
