Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSGQP34>; Wed, 17 Jul 2002 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSGQP3z>; Wed, 17 Jul 2002 11:29:55 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:24244 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S315167AbSGQP3r>; Wed, 17 Jul 2002 11:29:47 -0400
Message-ID: <3D358DD8.D39F06FF@pp.inet.fi>
Date: Wed, 17 Jul 2002 18:31:36 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@zip.com.au>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
References: <20020716163636.GW811@suse.de> <Pine.LNX.4.44L.0207161349100.3009-100000@duckman.distro.conectiva> <20020716170921.GX811@suse.de> <3D34773C.F61E7C0F@pp.inet.fi> <20020717054006.GZ811@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Jul 16 2002, Jari Ruusu wrote:
> > Your remapping code has _never_ worked. This is because your remapping is
> > supposedly enabled in none_status(), but init hook of type 0 transfer is
> > never called (check the code in loop_init_xfer). And, even if were enabled,
> > you would quickly notice that lo->lo_pending count is never decremented in
> > your 'remap' code.
> 
> That might be so for the 2.5 code base, I know for a fact that it worked
> when it was implemented in 2.4. Maybe with the same lo_pending bug, I
> dunno.

Both 2.4 and 2.5 have same two bugs:
1)  lo->lo_pending never decremented in remap case
2)  remapping _never_ enabled (and this caused it to appear to work)

> That said, please do split up the patches as Andrew/wli suggested. For
> the 2.5 one I'd be inclined to just take it as-is, but the 2.4 patch
> definitely needs to be split.

OK. Since 2.5.25 patch still applies to 2.5.26 with one 3-line offset, I
won't send new one but comment the patch.


Andrew Morton wrote:
> - Does the file_operations-based file-backed IO work with all
>  crypto setups?

Yes. It even works with tmpfs based setups (old code didn't).

>- What are those preallocated pages doing?  Are they really needed
>  with the 2.5 VM?  What problem are they solving?

They are solving problem where all partitions are encrypted except /boot,
including swap and root partitions. No runtime kernel allocations means
guaranteed availability of pages (and bios) for device backed loop, even
when kernel has used all emergency reserves. Deadlock-free encrypted swap
needs that.


On Tue, Jul 16 2002, Jari Ruusu wrote:
> --- linux-2.5.25/drivers/block/loop.c   Wed Jun 19 12:14:13 2002
> +++ linux-2.5.25-loopfix/drivers/block/loop.c   Wed Jul 10 22:59:10 2002

[credits in comments removed]

> @@ -82,14 +98,14 @@
> 
>  static int max_loop = 8;
>  static struct loop_device *loop_dev;
> -static int *loop_sizes;
> +static /*FIXME sector_t*/int *loop_sizes;
>  static devfs_handle_t devfs_handle;      /*  For the directory */
> 
>  /*
>   * Transfer functions
>   */
>  static int transfer_none(struct loop_device *lo, int cmd, char *raw_buf,
> -                        char *loop_buf, int size, int real_block)
> +                        char *loop_buf, int size, /*FIXME sector_t*/int real_block)
>  {
>         if (raw_buf != loop_buf) {
>                 if (cmd == READ)
> @@ -97,12 +113,12 @@
>                 else
>                         memcpy(raw_buf, loop_buf, size);
>         }
> -
> +       cond_resched();
>         return 0;
>  }
> 
>  static int transfer_xor(struct loop_device *lo, int cmd, char *raw_buf,
> -                       char *loop_buf, int size, int real_block)
> +                       char *loop_buf, int size, /*FIXME sector_t*/int real_block)
>  {
>         char    *in, *out, *key;
>         int     i, keysize;

Above FIXMEs are just preparing for Large-Block-Devices patch.
cond_resched() in transfer function improves interactive performance.

> @@ -119,12 +135,12 @@
>         keysize = lo->lo_encrypt_key_size;
>         for (i = 0; i < size; i++)
>                 *out++ = *in++ ^ key[(i & 511) % keysize];
> +       cond_resched();
>         return 0;
>  }

cond_resched() in transfer function improves interactive performance.

> 
>  static int none_status(struct loop_device *lo, struct loop_info *info)
>  {
> -       lo->lo_flags |= LO_FLAGS_BH_REMAP;
>         return 0;
>  }
> 

LO_FLAGS_BH_REMAP flag is not needed because new remap code just tests for
LO_CRYPT_NONE transfer type. Actually, this function is _never_ called.

> @@ -153,353 +169,429 @@
>         &xor_funcs
>  };
> 
> -#define MAX_DISK_SIZE 1024*1024*1024
> -
> -static unsigned long
> -compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry)
> -{
> -       loff_t size = lo_dentry->d_inode->i_mapping->host->i_size;
> -       return (size - lo->lo_offset) >> BLOCK_SIZE_BITS;
> +/*
> + *  First number of 'lo_prealloc' is the default number of RAM pages
> + *  to pre-allocate for each device backed loop. Every (configured)
> + *  device backed loop pre-allocates this amount of RAM pages unless
> + *  later 'lo_prealloc' numbers provide an override. 'lo_prealloc'
> + *  overrides are defined in pairs: loop_index,number_of_pages
> + */
> +static int lo_prealloc[9] = { 125, -1, 0, -1, 0, -1, 0, -1, 0 };
> +#define LO_PREALLOC_MIN 4    /* minimum user defined pre-allocated RAM pages */
> +#define LO_PREALLOC_MAX 512  /* maximum user defined pre-allocated RAM pages */
> +
> +#ifdef MODULE
> +MODULE_PARM(lo_prealloc, "1-9i");
> +MODULE_PARM_DESC(lo_prealloc, "Number of pre-allocated pages [,index,pages]...");
> +#else
> +static int __init lo_prealloc_setup(char *str)
> +{
> +       int x, y, z;
> +
> +       for (x = 0; x < (sizeof(lo_prealloc) / sizeof(int)); x++) {
> +               z = get_option(&str, &y);
> +               if (z > 0)
> +                       lo_prealloc[x] = y;
> +               if (z < 2)
> +                       break;
> +       }
> +       return 1;
>  }
> +__setup("lo_prealloc=", lo_prealloc_setup);
> +#endif

MAX_DISK_SIZE and compute_loop_size() aren't needed anymore. See above
comment about lo_prealloc[]. MODULE_PARM macro and lo_prealloc_setup() are
required so that lo_prealloc[] may be modified by
insmod/modprobe/kernel-command-line.

OK, this is where the _patch_ gets hairy but resulting code does not.
This is a list completely removed functions and structures:

    do_lo_send()                - Replaced by do_bio_filebacked().
    lo_send()                   - Replaced by do_bio_filebacked().
    struct lo_read_data         - Not needed any more.
    lo_read_actor()             - Replaced by do_bio_filebacked().
    do_lo_receive()             - Replaced by do_bio_filebacked().
    lo_receive()                - Replaced by do_bio_filebacked().
    loop_get_bs()               - Soft-blocksize based IV computation is
                                  just not working properly. Filesystems may
                                  use different soft-blocksize to read
                                  superblock but write that with different
                                  soft-blocksize. And that results in
                                  different IV and causes data corruption.
                                  And, soft-blocksize may be different when
                                  userland tools (fsck, mkfs, mtools) access
                                  a loop device. Again, data corruption
                                  guaranteed.
    loop_get_iv()               - See above.
    loop_add_bio()              - Replaced by loop_add_queue_last/first()
    bio_transfer()              - Code is now elsewhere.

This is a list of new functions and structures, look at loop.c code after
patching:

    struct loop_bio_extension   - This structure hangs from bio->bi_private
                                  of all pre-allocated buffer-BIOs.
    loop_prealloc_cleanup()     - Frees previously pre-allocated BIO list.
    loop_prealloc_init()        - Pre-allocates number of pages and BIOs.
                                  The amount of pages to pre-alloacate is
                                  defined by lo_prealloc[] contents.
    loop_add_queue_last()       - Adds a BIO to end of queue. Normal
                                  circular single linked list, list tag
                                  points to last, last points to first.
                                  Queues can only be accessed with
                                  lo->lo_lock held.
    loop_add_queue_first()      - Adds a BIO to beginning of list.
    loop_file_io()              - This used by file backed loop thread.
                                  Calls file->f_op->write/read to do actual
                                  file I/O and attempts to process non-funny
                                  errno cases like EAGAIN, ENOMEM and
                                  others.

Significantly reworked functions, look at loop.c code after patching:

    loop_put_buffer()           - Frees a BIO to merge-bio (freelist#1) or
                                  buffer-bio (freelist#0) list. Wakes up
                                  waiting loop thread if need be.
    loop_get_buffer()           - This allocates a merge-bio from freelist#1
                                  if request does not have one already
                                  allocated, and then allocates buffer-bio
                                  from freelist#0. If merge-bio was just
                                  allocated, it is initialized. buffer-bio
                                  is then initialized to process one vec
                                  from original request and this means that
                                  struct loop_bio_extension that hangs off
                                  bufferbio->bi_private is also initialized.
                                  If allocation from private freelists
                                  failed, flags are set in lo->lo_bio_need
                                  so that loop_end_io_transfer() ->
                                  loop_put_buffer() wakes loop thread as
                                  soon I/O completes and a bio is freed.
    loop_get_bio()              - Gets a BIO from beginning of loop thread
                                  work queue.
    loop_end_io_transfer()      - Reads are queued for loop thread to
                                  handle. For writes, buffer-bio is freed
                                  and if buffer-bio was last one (merge bio
                                  is used as rendezvous point for multi-vec
                                  bios), bio_endio() is called for original
                                  BIO and merge-bio is freed.
    figure_loop_size()          - Updated with fixes from Large-Block-Devices
                                  patch.
    do_bio_filebacked()         - Processes file backed requests by calling
                                  lo_do_transfer() and loop_file_io().
                                  Handles multi-vec bios just fine.

Remaining part of patch is more readable, so I will just add comments:

>  static int loop_make_request(request_queue_t *q, struct bio *old_bio)
>  {
> -       struct bio *new_bio = NULL;
> +       struct bio *new_bio, *merge;
>         struct loop_device *lo;
> -       unsigned long IV;
> -       int rw = bio_rw(old_bio);
> +       struct loop_bio_extension *extension;
> +       int rw = bio_rw(old_bio), y;
>         int unit = minor(to_kdev_t(old_bio->bi_bdev->bd_dev));
> 
>         if (unit >= max_loop)

Just adds new variables.

> @@ -528,27 +620,57 @@
>          * file backed, queue for loop_thread to handle
>          */
>         if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
> -               loop_add_bio(lo, old_bio);
> +               loop_add_queue_last(lo, old_bio, &lo->lo_bio_que0);
> +               return 0;
> +       }
> +
> +       /*
> +        * device backed, just remap bdev & sector for NONE transfer
> +        */
> +       if (lo->lo_encrypt_type == LO_CRYPT_NONE) {
> +               old_bio->bi_sector += lo->lo_offset >> 9;
> +               old_bio->bi_bdev = lo->lo_device;
> +               generic_make_request(old_bio);
> +               if (atomic_dec_and_test(&lo->lo_pending))
> +                       wake_up_interruptible(&lo->lo_bio_wait);
>                 return 0;
>         }

A working version of type 0 transfer remapping.

> 
>         /*
> -        * piggy old buffer on original, and submit for I/O
> +        * device backed, start reads and writes now if buffer available
>          */
> -       new_bio = loop_get_buffer(lo, old_bio);
> -       IV = loop_get_iv(lo, old_bio->bi_sector);
> +       merge = NULL;
> +       try_next_old_bio_vec:
> +       new_bio = loop_get_buffer(lo, old_bio, 0, &merge);
> +       if (!new_bio) {
> +               /* just queue request and let thread handle allocs later */
> +               if (merge)
> +                       loop_add_queue_last(lo, merge, &lo->lo_bio_que1);
> +               else
> +                       loop_add_queue_last(lo, old_bio, &lo->lo_bio_que2);
> +               return 0;
> +       }

Sets merge-bio to NULL so that loop_get_buffer() allocates new merge-bio.
new_bio is just one vec from the original. If some alloc failed, put it back
to queue. If a merge-bio was allocated, put that merge-bio to queue #1. If
nothing was allocated, but original to queue #2.

>         if (rw == WRITE) {
> -               if (bio_transfer(lo, new_bio, old_bio))
> -                       goto err;
> +               extension = new_bio->bi_private;
> +               y = extension->bioext_index;
> +               if (lo_do_transfer(lo, WRITE, page_address(new_bio->bi_io_vec[0].bv_page), page_address(old_bio->bi_io_vec[y].bv_page) + old_bio->bi_io_vec[y].bv_offset, extension->bioext_size, extension->bioext_sector)) {
> +                       clear_bit(BIO_UPTODATE, &merge->bi_flags);
> +               }
>         }

Do transfers for writes here.

> 
> +       /* merge & old_bio may vanish during generic_make_request() */
> +       /* if last vec gets processed before function returns   */
> +       y = (merge->bi_idx < old_bio->bi_vcnt) ? 1 : 0;
>         generic_make_request(new_bio);
> +
> +       /* other vecs may need processing too */
> +       if (y)
> +               goto try_next_old_bio_vec;
>         return 0;

Send request to underlying driver, and try to allocate new buffer-bio for
next vec.

> 
>  err:
>         if (atomic_dec_and_test(&lo->lo_pending))
> -               up(&lo->lo_bh_mutex);
> -       loop_put_buffer(new_bio);
> +               wake_up_interruptible(&lo->lo_bio_wait);
>  out:
>         bio_io_error(old_bio);
>         return 0;
> @@ -557,26 +679,6 @@
>         goto out;
>  }
> 

[ removed loop_handle_bio() ]

>  /*
>   * worker thread that handles reads/writes to file backed loop devices,
>   * to avoid blocking in our make_request_fn. it also does loop decrypting
> @@ -586,9 +688,15 @@
>  static int loop_thread(void *data)
>  {
>         struct loop_device *lo = data;
> -       struct bio *bio;
> +       struct bio *bio, *xbio, *merge;
> +       struct loop_bio_extension *extension;
> +       int x, y, flushcnt = 0;
> +       wait_queue_t waitq;
> 
> +       init_waitqueue_entry(&waitq, current);
>         daemonize();
> +       exit_files(current);
> +       reparent_to_init();
> 
>         sprintf(current->comm, "loop%d", lo->lo_number);
>         current->flags |= PF_IOTHREAD;  /* loop can be used in an encrypted device

Adds new variables and missing loop thread initialization.

> @@ -611,23 +719,132 @@
>         up(&lo->lo_sem);
> 
>         for (;;) {
> -               down_interruptible(&lo->lo_bh_mutex);
> +               add_wait_queue(&lo->lo_bio_wait, &waitq);
> +               for (;;) {
> +                       set_current_state(TASK_INTERRUPTIBLE);
> +                       if (!atomic_read(&lo->lo_pending))
> +                               break;
> +
> +                       x = 0;
> +                       spin_lock_irq(&lo->lo_lock);
> +                       if (lo->lo_bio_que0) {
> +                               /* don't sleep if device backed READ needs processing */
> +                               /* don't sleep if file backed READ/WRITE needs processing */
> +                               x = 1;
> +                       } else if (lo->lo_bio_que1) {
> +                               /* don't sleep if a buffer-bio is available */
> +                               /* don't sleep if need-buffer-bio request is not set */
> +                               if (lo->lo_bio_free0 || !(lo->lo_bio_need & 1))
> +                                       x = 1;
> +                       } else if (lo->lo_bio_que2) {
> +                               /* don't sleep if a merge-bio is available */
> +                               /* don't sleep if need-merge-bio request is not set */
> +                               if (lo->lo_bio_free1 || !(lo->lo_bio_need & 2))
> +                                       x = 1;
> +                       }
> +                       spin_unlock_irq(&lo->lo_lock);
> +                       if (x)
> +                               break;
> +
> +                       schedule();
> +               }
> +               current->state = TASK_RUNNING;
> +               remove_wait_queue(&lo->lo_bio_wait, &waitq);
> +

Determine if thread should sleep or not. Extra wakeups don't cause any harm.

>                 /*
> -                * could be upped because of tear-down, not because of
> +                * could be woken because of tear-down, not because of
>                  * pending work
>                  */
>                 if (!atomic_read(&lo->lo_pending))
>                         break;
> 
> -               bio = loop_get_bio(lo);
> -               if (!bio) {
> -                       printk("loop: missing bio\n");
> +               bio = loop_get_bio(lo, &x);
> +               if (!bio)
>                         continue;
> +
> +               /*
> +                *  x  list tag         usage(has-buffer,has-merge)
> +                * --- --------         --------------------------
> +                *  0  lo->lo_bio_que0  dev-r(y,y) / file-rw
> +                *  1  lo->lo_bio_que1  dev-rw(n,y)
> +                *  2  lo->lo_bio_que2  dev-rw(n,n)
> +                */
> +               if (x >= 1) {
> +                       /* loop_make_request didn't allocate a buffer, do that now */
> +                       if (x == 1) {
> +                               merge = bio;
> +                               bio = merge->bi_private;
> +                       } else {
> +                               merge = NULL;
> +                       }

If bio came from list #1, it was a merge-bio. If it came from list #2, it
was plain original bio with nothing allocated.

> +                       try_next_bio_vec:
> +                       xbio = loop_get_buffer(lo, bio, 1, &merge);
> +                       if (!xbio) {
> +                               blk_run_queues();
> +                               flushcnt = 0;
> +                               if (merge)
> +                                       loop_add_queue_first(lo, merge, &lo->lo_bio_que1);
> +                               else
> +                                       loop_add_queue_first(lo, bio, &lo->lo_bio_que2);
> +                               /* lo->lo_bio_need should be non-zero now, go back to sleep */
> +                               continue;
> +                       }

Try to alloc new buffer-bio. If failed, stuff things back to queue and goto sleep.

> +                       if (bio_rw(bio) == WRITE) {
> +                               extension = xbio->bi_private;
> +                               y = extension->bioext_index;
> +                               if (lo_do_transfer(lo, WRITE, page_address(xbio->bi_io_vec[0].bv_page), page_address(bio->bi_io_vec[y].bv_page) + bio->bi_io_vec[y].bv_offset, extension->bioext_size, extension->bioext_sector)) {
> +                                       clear_bit(BIO_UPTODATE, &merge->bi_flags);
> +                               }
> +                       }

Do transfers for writes here.

> +
> +                       /* merge & bio may vanish during generic_make_request() */
> +                       /* if last vec gets processed before function returns   */
> +                       y = (merge->bi_idx < bio->bi_vcnt) ? 1 : 0;
> +                       generic_make_request(xbio);

Send request to underlying driver.

> +
> +                       /* start I/O if there are no more requests lacking buffers */
> +                       x = 0;
> +                       spin_lock_irq(&lo->lo_lock);
> +                       if (!y && !lo->lo_bio_que1 && !lo->lo_bio_que2)
> +                               x = 1;
> +                       spin_unlock_irq(&lo->lo_lock);
> +                       if (x || (++flushcnt >= lo->lo_bio_flsh)) {
> +                               blk_run_queues();
> +                               flushcnt = 0;
> +                       }

Call blk_run_queues() every now and then (so that requests hopefully get
processed before free buffer/merge-bios run out), and especially after all
pending requests have been sent to underlying layer. It is very important
that blk_run_queues() is called after que#1 and #2 are emptied, because some
higher level code may have sent requests to loop and then called
blk_run_queues() once. Due to buffering, generic_make_request() for
underlying device may be called _after_ that. If loop does not run
blk_run_queues(), requests may get stuck unflushed.

> +
> +                       /* other vecs may need processing too */
> +                       if (y)
> +                               goto try_next_bio_vec;
> +
> +                       /* request not completely processed yet */
> +                       continue;
> +               }

Try to allocate buffer-bio for next vec.

> +
> +               if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
> +                       /* request is for file backed device */
> +                       y = do_bio_filebacked(lo, bio);
> +                       bio->bi_next = NULL;
> +                       bio_endio(bio, !y);

File backed loop handled by do_bio_filebacked()

> +               } else {
> +                       /* device backed read has completed, do decrypt now */
> +                       extension = bio->bi_private;
> +                       merge = extension->bioext_merge;
> +                       y = extension->bioext_index;
> +                       xbio = merge->bi_private;
> +                       if (lo_do_transfer(lo, READ, page_address(bio->bi_io_vec[0].bv_page), page_address(xbio->bi_io_vec[y].bv_page) + xbio->bi_io_vec[y].bv_offset, extension->bioext_size, extension->bioext_sector)) {
> +                               clear_bit(BIO_UPTODATE, &merge->bi_flags);
> +                       }
> +                       loop_put_buffer(lo, bio, 0);
> +                       if (!atomic_dec_and_test(&merge->bi_cnt))
> +                               continue;
> +                       xbio->bi_next = NULL;
> +                       bio_endio(xbio, test_bit(BIO_UPTODATE, &merge->bi_flags));
> +                       loop_put_buffer(lo, merge, 1);
>                 }
> -               loop_handle_bio(lo, bio);

Device backed loop read handling. buffer-bio is freed and if buffer-bio was
last one (merge bio is used as rendezvous point for multi-vec bios),
bio_endio() is called for original BIO and merge-bio is freed.

> 
>                 /*
> -                * upped both for pending work and tear-down, lo_pending
> +                * woken both for pending work and tear-down, lo_pending
>                  * will hit zero then
>                  */
>                 if (atomic_dec_and_test(&lo->lo_pending))
> @@ -647,6 +864,7 @@
>         struct block_device *lo_device;
>         int             lo_flags = 0;
>         int             error;
> +       int             bs;
> 
>         MOD_INC_USE_COUNT;
> 
> @@ -665,33 +883,43 @@
>         if (!(file->f_mode & FMODE_WRITE))
>                 lo_flags |= LO_FLAGS_READ_ONLY;
> 
> +       lo->lo_bio_free1 = lo->lo_bio_free0 = lo->lo_bio_que2 = lo->lo_bio_que1 = lo->lo_bio_que0 = NULL;
> +       lo->lo_bio_need = lo->lo_bio_flsh = 0;
> +       init_waitqueue_head(&lo->lo_bio_wait);

Initialize new loop struct.

>         if (S_ISBLK(inode->i_mode)) {
>                 lo_device = inode->i_bdev;
>                 if (lo_device == bdev) {
>                         error = -EBUSY;
> -                       goto out;
> +                       goto out_putf;
> +               }
> +               if (loop_prealloc_init(lo, 0)) {
> +                       error = -ENOMEM;
> +                       goto out_putf;
>                 }

Pre-allocate pages and bios for device backed loops.

>         } else if (S_ISREG(inode->i_mode)) {
> -               struct address_space_operations *aops = inode->i_mapping->a_ops;
>                 /*
>                  * If we can't read - sorry. If we only can't write - well,
>                  * it's going to be read-only.
>                  */
> -               if (!aops->readpage)
> +               if (!file->f_op || !file->f_op->read)
>                         goto out_putf;
> 
> -               if (!aops->prepare_write || !aops->commit_write)
> +               if (!file->f_op->write)
>                         lo_flags |= LO_FLAGS_READ_ONLY;
> 

Check that filesystem backed loop has required callbacks.

>                 lo_device = inode->i_sb->s_bdev;
>                 lo_flags |= LO_FLAGS_DO_BMAP;
> +               if (loop_prealloc_init(lo, 1)) {
> +                       error = -ENOMEM;
> +                       goto out_putf;
> +               }
>                 error = 0;
>         } else
>                 goto out_putf;

File backed loops need to pre-allocate 1 page.

> 
>         get_file(file);
> 
> -       if (IS_RDONLY (inode) || bdev_read_only(lo_device)
> +       if ((S_ISREG(inode->i_mode) && IS_RDONLY(inode)) || bdev_read_only(lo_device)
>             || !(lo_file->f_mode & FMODE_WRITE))
>                 lo_flags |= LO_FLAGS_READ_ONLY;
> 

Only set read-only if a _file_ resides on ro filesystem. If it is a device
node on ro filesystem, let it be setup as rw. This makes losetup work early
on init scripts when root partition (or initrd) is still mounted as ro, and
losetup is used to setup encrypted swap partitions and/or encrypted root
partition.

> @@ -702,13 +930,28 @@
>         lo->lo_backing_file = file;
>         lo->transfer = NULL;
>         lo->ioctl = NULL;
> -       figure_loop_size(lo);
> +       if (figure_loop_size(lo)) {
> +               loop_prealloc_cleanup(lo);
> +               error = -EFBIG;
> +               fput(file);
> +               goto out_putf;
> +       }
>         lo->old_gfp_mask = inode->i_mapping->gfp_mask;
>         inode->i_mapping->gfp_mask = GFP_NOIO;

Part of Large-Block-Devices fixes. If sector_t is 32 bits
and file size is larger than 2 TB, return error.

> 
> -       set_blocksize(bdev, block_size(lo_device));
> +       bs = block_size(lo_device);
> +       if (S_ISREG(inode->i_mode)) {
> +               int x = (int) loop_sizes[lo->lo_number];
> +
> +               if ((bs == 8192) && (x & 7))
> +                       bs = 4096;
> +               if ((bs == 4096) && (x & 3))
> +                       bs = 2048;
> +               if ((bs == 2048) && (x & 1))
> +                       bs = 1024;
> +       }
> +       set_blocksize(bdev, bs);
> 
> -       lo->lo_bio = lo->lo_biotail = NULL;
>         kernel_thread(loop_thread, lo, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
>         down(&lo->lo_sem);
> 

Sets default filesystem soft-blocksize so that all of file backed loop is
accessible by default. Otherwise if looped to file resides on 4 KB
soft-blocksize fs, and file size is 125 KB, last 1 KB is unaccessible to
userland tools like fsck and mtools). Mounting the file sets correct
soft-blocksize, and thereafter all is ok.

> @@ -767,11 +1010,12 @@
>         spin_lock_irq(&lo->lo_lock);
>         lo->lo_state = Lo_rundown;
>         if (atomic_dec_and_test(&lo->lo_pending))
> -               up(&lo->lo_bh_mutex);
> +               wake_up_interruptible(&lo->lo_bio_wait);
>         spin_unlock_irq(&lo->lo_lock);
> 
>         down(&lo->lo_sem);
> 
> +       loop_prealloc_cleanup(lo);
>         lo->lo_backing_file = NULL;
> 
>         loop_release_xfer(lo);

Cleanup that frees pre-allocated pages and bios.

> @@ -798,6 +1042,7 @@
>         struct loop_info info;
>         int err;
>         unsigned int type;
> +       loff_t offset;
> 
>         if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid &&
>             !capable(CAP_SYS_ADMIN))
> @@ -813,13 +1058,23 @@
>                 return -EINVAL;
>         if (type == LO_CRYPT_XOR && info.lo_encrypt_key_size == 0)
>                 return -EINVAL;
> +
>         err = loop_release_xfer(lo);
>         if (!err)
>                 err = loop_init_xfer(lo, type, &info);
> +
> +       offset = lo->lo_offset;
> +       if (offset != info.lo_offset) {
> +               lo->lo_offset = info.lo_offset;
> +               if (figure_loop_size(lo)){
> +                       err = -EFBIG;
> +                       lo->lo_offset = offset;
> +               }
> +       }
> +
>         if (err)
>                 return err;
> 
> -       lo->lo_offset = info.lo_offset;
>         strncpy(lo->lo_name, info.lo_name, LO_NAME_SIZE);
> 
>         lo->transfer = xfer_funcs[type]->transfer;
> @@ -832,7 +1087,7 @@
>                        info.lo_encrypt_key_size);
>                 lo->lo_key_owner = current->uid;
>         }
> -       figure_loop_size(lo);
> +
>         return 0;
>  }
> 

Large-Block-Device fixes.

> @@ -926,7 +1181,7 @@
>  static int lo_open(struct inode *inode, struct file *file)
>  {
>         struct loop_device *lo;
> -       int     dev, type;
> +       int     dev;
> 
>         if (!inode)
>                 return -EINVAL;
> @@ -941,10 +1196,6 @@
>         lo = &loop_dev[dev];
>         MOD_INC_USE_COUNT;
>         down(&lo->lo_ctl_mutex);
> -
> -       type = lo->lo_encrypt_type;
> -       if (type && xfer_funcs[type] && xfer_funcs[type]->lock)
> -               xfer_funcs[type]->lock(lo);
>         lo->lo_refcnt++;
>         up(&lo->lo_ctl_mutex);
>         return 0;

External cipher module locking fixed. When setting up or tearing down a
loop, xfer_funcs[type] is not set symmerically. On setup, it is zero on
open, but nonzero on close. On teardown, it is nonzero on open, but zero on
close. This screws the locking royally. Locking works fine if it is done
only from loop_init_xfer() and loop_release_xfer().

> @@ -953,7 +1204,7 @@
>  static int lo_release(struct inode *inode, struct file *file)
>  {
>         struct loop_device *lo;
> -       int     dev, type;
> +       int     dev;
> 
>         if (!inode)
>                 return 0;
> @@ -968,11 +1219,7 @@
> 
>         lo = &loop_dev[dev];
>         down(&lo->lo_ctl_mutex);
> -       type = lo->lo_encrypt_type;
>         --lo->lo_refcnt;
> -       if (xfer_funcs[type] && xfer_funcs[type]->unlock)
> -               xfer_funcs[type]->unlock(lo);
> -
>         up(&lo->lo_ctl_mutex);
>         MOD_DEC_USE_COUNT;
>         return 0;

External cipher module locking fixed. See above.

> @@ -1047,7 +1294,7 @@
>         if (!loop_dev)
>                 return -ENOMEM;
> 
> -       loop_sizes = kmalloc(max_loop * sizeof(int), GFP_KERNEL);
> +       loop_sizes = kmalloc(max_loop * sizeof(loop_sizes[0]), GFP_KERNEL);
>         if (!loop_sizes)
>                 goto out_mem;
> 

Large-Block-Devices fixes.

> @@ -1059,16 +1306,23 @@
>                 memset(lo, 0, sizeof(struct loop_device));
>                 init_MUTEX(&lo->lo_ctl_mutex);
>                 init_MUTEX_LOCKED(&lo->lo_sem);
> -               init_MUTEX_LOCKED(&lo->lo_bh_mutex);

Semaphore is now replaced with wait queue.

>                 lo->lo_number = i;
>                 spin_lock_init(&lo->lo_lock);
>         }
> 
> -       memset(loop_sizes, 0, max_loop * sizeof(int));
> +       memset(loop_sizes, 0, max_loop * sizeof(*loop_sizes));

Large-Block-Devices fixes.

>         blk_size[MAJOR_NR] = loop_sizes;
>         for (i = 0; i < max_loop; i++)
>                 register_disk(NULL, mk_kdev(MAJOR_NR, i), 1, &lo_fops, 0);
> 
> +       for (i = 0; i < (sizeof(lo_prealloc) / sizeof(int)); i += 2) {
> +               if (!lo_prealloc[i])
> +                       continue;
> +               if (lo_prealloc[i] < LO_PREALLOC_MIN)
> +                       lo_prealloc[i] = LO_PREALLOC_MIN;
> +               if (lo_prealloc[i] > LO_PREALLOC_MAX)
> +                       lo_prealloc[i] = LO_PREALLOC_MAX;
> +       }
>         printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
>         return 0;
> 

Sanity check lo_prealloc[] values from userland.

> diff -urN linux-2.5.25/fs/block_dev.c linux-2.5.25-loopfix/fs/block_dev.c
> --- linux-2.5.25/fs/block_dev.c Sat Jul  6 19:55:59 2002
> +++ linux-2.5.25-loopfix/fs/block_dev.c Wed Jul 10 23:51:20 2002
> @@ -539,10 +539,10 @@
>                 bdev->bd_op = get_blkfops(major(dev));
>                 if (!bdev->bd_op)
>                         goto out;
> -               owner = bdev->bd_op->owner;
> -               if (owner)
> -                       __MOD_INC_USE_COUNT(owner);
>         }
> +       owner = bdev->bd_op->owner;
> +       if (owner)
> +               __MOD_INC_USE_COUNT(owner);
>         if (!bdev->bd_contains) {
>                 unsigned minor = minor(dev);
>                 struct gendisk *g = get_gendisk(dev);

Fix non-symmetric module use count locking. Old code only increments module
use count on first open, but decrements on all closes.

> diff -urN linux-2.5.25/include/linux/loop.h linux-2.5.25-loopfix/include/linux/loop.h
> --- linux-2.5.25/include/linux/loop.h   Wed Jun 19 12:14:15 2002
> +++ linux-2.5.25-loopfix/include/linux/loop.h   Wed Jul 10 21:53:19 2002
> @@ -17,6 +17,11 @@
> 
>  #ifdef __KERNEL__
> 
> +/* definitions for IV metric -- cryptoapi specific */
> +#define LOOP_IV_SECTOR_BITS 9
> +#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)
> +typedef /*FIXME sector_t*/int loop_iv_t;
> +
>  /* Possible states of device */
>  enum {
>         Lo_unbound,

Cryptoapi people need these.

> @@ -33,7 +38,7 @@
>         int             lo_flags;
>         int             (*transfer)(struct loop_device *, int cmd,
>                                     char *raw_buf, char *loop_buf, int size,
> -                                   int real_block);
> +                                   /*FIXME sector_t*/int real_block);
>         char            lo_name[LO_NAME_SIZE];
>         char            lo_encrypt_key[LO_KEY_SIZE];
>         __u32           lo_init[2];

Above FIXMEs are just preparing for Large-Block-Devices patch.

> @@ -49,13 +54,18 @@
>         int             old_gfp_mask;
> 
>         spinlock_t              lo_lock;
> -       struct bio              *lo_bio;
> -       struct bio              *lo_biotail;
> +       struct bio              *lo_bio_que0;
> +       struct bio              *lo_bio_que1;
>         int                     lo_state;
>         struct semaphore        lo_sem;
>         struct semaphore        lo_ctl_mutex;
> -       struct semaphore        lo_bh_mutex;
>         atomic_t                lo_pending;
> +       struct bio              *lo_bio_que2;
> +       struct bio              *lo_bio_free0;
> +       struct bio              *lo_bio_free1;
> +       int                     lo_bio_flsh;
> +       int                     lo_bio_need;
> +       wait_queue_head_t       lo_bio_wait;
>  };
> 
>  typedef        int (* transfer_proc_t)(struct loop_device *, int cmd,

New entries to struct loop_device.

> @@ -69,7 +79,6 @@
>   */
>  #define LO_FLAGS_DO_BMAP       1
>  #define LO_FLAGS_READ_ONLY     2
> -#define LO_FLAGS_BH_REMAP      4

LO_FLAGS_BH_REMAP is not needed any more.

> 
>  /*
>   * Note that this structure gets the wrong offsets when directly used
> @@ -114,6 +123,8 @@
>  #define LO_CRYPT_IDEA     6
>  #define LO_CRYPT_DUMMY    9
>  #define LO_CRYPT_SKIPJACK 10
> +#define LO_CRYPT_AES      16
> +#define LO_CRYPT_CRYPTOAPI 18
>  #define MAX_LO_CRYPT   20
> 
>  #ifdef __KERNEL__

Cryptoapi people need LO_CRYPT_CRYPTOAPI.

> diff -urN linux-2.5.25/kernel/ksyms.c linux-2.5.25-loopfix/kernel/ksyms.c
> --- linux-2.5.25/kernel/ksyms.c Sat Jul  6 19:56:00 2002
> +++ linux-2.5.25-loopfix/kernel/ksyms.c Wed Jul 10 21:21:19 2002
> @@ -88,6 +88,7 @@
>  EXPORT_SYMBOL(do_munmap);
>  EXPORT_SYMBOL(do_brk);
>  EXPORT_SYMBOL(exit_mm);
> +EXPORT_SYMBOL(exit_files);
> 
>  /* internal kernel memory management */
>  EXPORT_SYMBOL(_alloc_pages);

Needed if loop is compiled as a module. 2.4 kernels have this too.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

