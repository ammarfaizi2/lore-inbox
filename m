Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbSLNNve>; Sat, 14 Dec 2002 08:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbSLNNve>; Sat, 14 Dec 2002 08:51:34 -0500
Received: from angband.namesys.com ([212.16.7.85]:10112 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267612AbSLNNvc>; Sat, 14 Dec 2002 08:51:32 -0500
Date: Sat, 14 Dec 2002 14:44:37 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large writes
Message-ID: <20021214144437.B13549@namesys.com>
References: <3DFA2D4F.3010301@namesys.com> <3DFA53DA.DE6788C1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3DFA53DA.DE6788C1@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Dec 13, 2002 at 01:40:42PM -0800, Andrew Morton wrote:
> >     These three changesets implement reiserfs_file_write.
> What a big patch.

Yup. Also it was around for half a year or something ;)
Also actually it consists of two parts(changesets).

> I'd be interested in testing it a bit.  Could you please
> describe under what circumstances the new code paths are
> executed?  Is it simply appending to a normal old file?  No
> special mount options?

Well, there are several paths all related to appending.
One path is to seek far beyond end of file and then write some amount of data
(or just do a truncate beyond end of file) therefore creating a hole
(with different code than before).
Also Just appending to a file in chunks bigger than 4k.
Somewhat different code paths if you append to just created file, file
that is smaller than 4k in size and file that is bigger than 4k in size.

> A few little comments, and maybe a security problem....

Hopefuly not a problem.

> > +int reiserfs_can_fit_pages ( struct super_block *sb /* superblock of filesystem
> > +						       to estimate space */ )
> > +{
> > +	unsigned long space;
> > +
> > +	spin_lock(&REISERFS_SB(sb)->bitmap_lock);
> > +	space = (SB_FREE_BLOCKS(sb) - REISERFS_SB(sb)->reserved_blocks) / ( PAGE_CACHE_SIZE/sb->s_blocksize);
> > +	spin_unlock(&REISERFS_SB(sb)->bitmap_lock);
> > +
> > +	return space;
> >  }
> Both of the divisions here can be replaced with shifts.  Divides are expensive.

Well, this can be done of course.

> The locking here is peculiar:
> 
> 	spin_lock(lock);
> 	value = calculation();
> 	spin_unlock(lock);
> 	return value;

The locking is here for different reason. We protect against somebody 
changing REISERFS_SB(sb)->reserved_blocks value while we are calculating.
If you'd look into where we I call reiserfs_can_fit_pages() in file.c,
you'd notice first I am taking BKL. No other codepath increases
REISERFS_SB(sb)->reserved_blocks value (we only increase it in the same region),
also all "old style" allocations are done under BKL as well.
There is only possible decrease of REISERFS_SB(sb)->reserved_blocks that is
not under BKL and is the whole reason I need this additional lock.
Obviously decreasing REISERFS_SB(sb)->reserved_blocks is completely ok
to happen.

> Surely, if the calculation relies on the lock then the returned value is invalidated
> as soon as you drop the lock?

Well, kind of, but we only care if the calcutaion may become less and this
cannot happen.

> > +/* this function from inode.c would be used here, too */
> > +extern void restart_transaction(struct reiserfs_transaction_handle *th,
> > +                                struct inode *inode, struct path *path);
> This decl should be in a header file.

Sure.

> > +/* I really do not want to play with memory shortage right now, so
> > +   to simplify the code, we are not going to write more than this much pages at
> > +   a time. This still should considerably improve performance compared to 4k
> > +   at a time case. */
> > +#define REISERFS_WRITE_PAGES_AT_A_TIME 32
> Page sizes vary.  A better value may be
> 	(128 * 1024) / PAGE_CACHE_SIZE
> so that consistent behaviour is seem on platforms which have page sizes larger
> than 4k.

Ok.

> > +int reiserfs_allocate_blocks_for_region(
> > ...
> > +    b_blocknr_t allocated_blocks[blocks_to_allocate]; // Pointer to a place where allocated blocknumbers would be stored. Right now statically allocated, later that will change.
> This is a variable-sized array (aka: alloca).  It's not a problem IMO, but
> worth pointing out...

Sure.

> > +    reiserfs_blocknr_hint_t hint; // hint structure for block allocator.
> > +    size_t res; // return value of various functions that we call.
> > +    int curr_block; // current block used to keep track of unmapped blocks.
> > +    int i; // loop counter
> > +    int itempos; // position in item
> > +    unsigned int from = (pos & (PAGE_CACHE_SIZE - 1)); // writing position in
> > +						       // first page
> > +    unsigned int to = ((pos + write_bytes - 1) & (PAGE_CACHE_SIZE - 1)) + 1; /* last modified byte offset in last page */
> > +    __u64 hole_size ; // amount of blocks for a file hole, if it needed to be created.
> > +    int modifying_this_item = 0; // Flag for items traversal code to keep track
> > +				 // of the fact that we already prepared
> > +				 // current block for journal
> How much stack is this function using, worst-case?

For 4k blocksize, 4k pages, 32bit arch it will take at most:
sizeof(struct cpu_key)+sizeof(void *)*3+sizeof(struct reiserfs_transaction_handle)+sizeof(struct path)+sizeof(unsigned int)*32+sizeof(reiserfs_blocknr_hint_t)+sizeof(size_t)+sizeof(int)*6+sizeof(__u64) = 340 bytes (only local variables
obviously).

For 1k blocksize, 4k pages, 32bit arch it will take at most:
sizeof(struct cpu_key)+sizeof(void *)*3+sizeof(struct reiserfs_transaction_handle)+sizeof(struct path)+sizeof(unsigned int)*32*4+sizeof(reiserfs_blocknr_hint_t)+sizeof(size_t)+sizeof(int)*6+sizeof(__u64) = 724 bytes (only local variables)

> > +    for ( i = 0; i < num_pages; i++) {
> > +	prepared_pages[i] = grab_cache_page(mapping, index + i); // locks the page
> OK.  But note that locking multiple pages here is only free from AB/BA deadlocks
> because this is the only path which does it, and it is singly-threaded via i_sem.

It just a memo to not forget to release a page later. Also parallel mmap writer
won't be able to touch these pages if these are yet unallocated.

> > +	if ( from != 0 ) {/* First page needs to be partially zeroed */
> > +	    char *kaddr = kmap_atomic(prepared_pages[0], KM_USER0);
> > +	    memset(kaddr, 0, from);
> > +	    kunmap_atomic( kaddr, KM_USER0);
> > +	    SetPageUptodate(prepared_pages[0]);
> > +	}
> > +	if ( to != PAGE_CACHE_SIZE ) { /* Last page needs to be partially zeroed */
> > +	    char *kaddr = kmap_atomic(prepared_pages[num_pages-1], KM_USER0);
> > +	    memset(kaddr+to, 0, PAGE_CACHE_SIZE - to);
> > +	    kunmap_atomic( kaddr, KM_USER0);
> > +	    SetPageUptodate(prepared_pages[num_pages-1]);
> > +	}
> This seems wrong.  This could be a newly-allocated pagecache page.  It is not
> yet fully uptodate.  If (say) the subsequent copy_from_user gets a fault then
> it appears that this now-uptodate pagecache page will leak uninitialised stuff?

No, I do not see it. Even if we have somebody already mmapped this part of file,
and he got enough of luck that subsequent copy_from_user gets a fault and then
this someone gets to CPU and tries to access the page, the SIGBUS should happen
because of access to mmaped area beyond end of file as we have not yet updated
the file size note that we have this check before this code you pointed out:
    if ( (pos & ~(PAGE_CACHE_SIZE - 1)) > inode->i_size ) {

Or am I missing something?
Ok, actually I see how I can move this check to where I do copy_from_user.

I will take care of replacing multiplys and divisions with shifting.
Thanks a lot for your review.

Bye,
    Oleg
