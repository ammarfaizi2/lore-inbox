Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291544AbSBHJh3>; Fri, 8 Feb 2002 04:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291522AbSBHJhX>; Fri, 8 Feb 2002 04:37:23 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:30918 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291560AbSBHJhJ>; Fri, 8 Feb 2002 04:37:09 -0500
Date: Fri, 8 Feb 2002 15:10:09 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: patch: aio + bio for raw io
Message-ID: <20020208151009.A1810@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20020208025313.A11893@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020208025313.A11893@redhat.com>; from bcrl@redhat.com on Fri, Feb 08, 2002 at 02:53:13AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 02:53:13AM -0500, Benjamin LaHaise wrote:
> Quick message: this patch makes aio use bio directly for brw_kvec_async.  
> This is against yesterday's patchset.  Comments?
> 

I was looking for this in yesterday's aio patchset for 2.5 and was just 
about to send you a note asking you about this :)

You chose to add a kvec_cb field to the bio structure rather than use
bi_private ?
 
For the raw path, you are OK since you never have to copy data out of 
the kvecs after i/o completion, and unmap_kvec only looks at veclet pages. 
So the fact block can change the offset and len fields in the veclets 
doesn't affect you, but thought I'd mention it as a point of caution
anyhow ...

> 		-ben
> 
> ===== fs/Makefile 1.15 vs 1.16 =====
> --- 1.15/fs/Makefile	Wed Jan 30 02:21:55 2002
> +++ 1.16/fs/Makefile	Fri Feb  8 14:57:54 2002
> @@ -22,6 +22,7 @@
>  obj-y += noquot.o
>  endif
>  
> +export-objs += aio.o
>  obj-y += aio.o
>  
>  subdir-$(CONFIG_PROC_FS)	+= proc
> ===== fs/buffer.c 1.60 vs 1.61 =====
> --- 1.60/fs/buffer.c	Tue Jan 15 05:53:34 2002
> +++ 1.61/fs/buffer.c	Fri Feb  8 17:22:14 2002
> @@ -54,6 +54,8 @@
>  #include <asm/bitops.h>
>  #include <asm/mmu_context.h>
>  
> +extern struct bio *bio_setup_from_kvec(int gfp_mask, struct kvec *kvec);
> +
>  #define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
>  #define NR_RESERVED (10*MAX_BUF_PER_PAGE)
>  #define MAX_UNUSED_BUFFERS NR_RESERVED+20 /* don't ever have more than this 
> @@ -2764,16 +2766,26 @@
>   * It is up to the caller to make sure that there are enough blocks
>   * passed in to completely map the iobufs to disk.
>   */
> +static int brw_kvec_end_io(struct bio *bio, int nr_sectors)
> +{
> +	kvec_cb_t cb = bio->cb;
> +	int res = nr_sectors * 512;
> +	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
> +		res = -EIO;
> +	bio_put(bio);
> +	cb.fn(cb.data, cb.vec, res);
> +	return 0;
> +}
>  
> -int brw_kvec_async(int rw, kvec_cb_t cb, kdev_t dev, unsigned blocks, unsigned long blknr, int sector_shift)
> +int brw_kvec_async(int rw, kvec_cb_t cb, kdev_t dev, unsigned blocks, sector_t blknr, int sector_shift)
>  {
>  	struct kvec	*vec = cb.vec;
>  	struct kveclet	*veclet;
> -	int		err;
>  	int		length;
>  	unsigned	sector_size = 1 << sector_shift;
>  	int		i;
>  
> +	struct bio	*bio;
>  	struct brw_cb	*brw_cb;
>  
>  	if (!vec->nr)
> @@ -2795,125 +2807,21 @@
>  	if (length < (blocks << sector_shift))
>  		BUG();
>  
> -	/* 
> -	 * OK to walk down the iovec doing page IO on each page we find. 
> -	 */
> -	err = 0;
> -
>  	if (!blocks) {
>  		printk("brw_kiovec_async: !i\n");
>  		return -EINVAL;
>  	}
>  
> -	/* FIXME: tie into userbeans here */
> -	brw_cb = kmalloc(sizeof(*brw_cb) + (blocks * sizeof(struct buffer_head *)), GFP_KERNEL);
> -	if (!brw_cb)
> +	bio = bio_setup_from_kvec(GFP_KERNEL, vec);
> +	if (unlikely(!bio))
>  		return -ENOMEM;
> -
> -	brw_cb->cb = cb;
> -	brw_cb->nr = 0;
> -
> -	/* This is ugly.  FIXME. */
> -	for (i=0, veclet=vec->veclet; i<vec->nr; i++,veclet++) {
> -		struct page *page = veclet->page;
> -		unsigned offset = veclet->offset;
> -		unsigned length = veclet->length;
> -
> -		if (!page)
> -			BUG();
> -
> -		while (length > 0) {
> -			struct buffer_head *tmp;
> -			tmp = kmem_cache_alloc(bh_cachep, GFP_NOIO);
> -			err = -ENOMEM;
> -			if (!tmp)
> -				goto error;
> -
> -			tmp->b_dev = B_FREE;
> -			tmp->b_size = sector_size;
> -			set_bh_page(tmp, page, offset);
> -			tmp->b_this_page = tmp;
> -
> -			init_buffer(tmp, end_buffer_io_kiobuf_async, NULL);
> -			tmp->b_dev = dev;
> -			tmp->b_blocknr = blknr++;
> -			tmp->b_state = (1 << BH_Mapped) | (1 << BH_Lock)
> -					| (1 << BH_Req);
> -			tmp->b_private = brw_cb;
> -
> -			if (rw == WRITE) {
> -				set_bit(BH_Uptodate, &tmp->b_state);
> -				clear_bit(BH_Dirty, &tmp->b_state);
> -			}
> -
> -			brw_cb->bh[brw_cb->nr++] = tmp;
> -			length -= sector_size;
> -			offset += sector_size;
> -
> -			if (offset >= PAGE_SIZE) {
> -				offset = 0;
> -				break;
> -			}
> -
> -			if (brw_cb->nr >= blocks)
> -				goto submit;
> -		} /* End of block loop */
> -	} /* End of page loop */		
> -
> -submit:
> -	atomic_set(&brw_cb->io_count, brw_cb->nr+1);
> -	/* okay, we've setup all our io requests, now fire them off! */
> -	for (i=0; i<brw_cb->nr; i++) 
> -		submit_bh(rw, brw_cb->bh[i]);
> -	brw_cb_put(brw_cb);
> +	bio->cb = cb;
> +	bio->bi_sector = blknr;
> +	bio->bi_dev = dev;
> +	bio->bi_vcnt = vec->nr;
> +	bio->bi_size = length;
> +	bio->bi_end_io = brw_kvec_end_io;
> +	submit_bio(rw, bio);
>  
>  	return 0;
> -
> -error:
> -	/* Walk brw_cb_table freeing all the goop associated with each kiobuf */
> -	if (brw_cb) {
> -		/* We got an error allocating the bh'es.  Just free the current
> -		   buffer_heads and exit. */
> -		for (i=0; i<brw_cb->nr; i++)
> -			kmem_cache_free(bh_cachep, brw_cb->bh[i]);
> -		kfree(brw_cb);
> -	}
> -
> -	return err;
> -}
> -#if 0
> -int brw_kiovec(int rw, int nr, struct kiobuf *iovec[],
> -		kdev_t dev, int nr_blocks, unsigned long b[], int sector_size)
> -{
> -	int i;
> -	int transferred = 0;
> -	int err = 0;
> -
> -	if (!nr)
> -		return 0;
> -
> -	/* queue up and trigger the io */
> -	err = brw_kiovec_async(rw, nr, iovec, dev, nr_blocks, b, sector_size);
> -	if (err)
> -		goto out;
> -
> -	/* wait on the last iovec first -- it's more likely to finish last */
> -	for (i=nr; --i >= 0; )
> -		kiobuf_wait_for_io(iovec[i]);
> -
> -	run_task_queue(&tq_disk);
> -
> -	/* okay, how much data actually got through? */
> -	for (i=0; i<nr; i++) {
> -		if (iovec[i]->errno) {
> -			if (!err)
> -				err = iovec[i]->errno;
> -			break;
> -		}
> -		transferred += iovec[i]->length;
> -	}
> -
> -out:
> -	return transferred ? transferred : err;
>  }
> -#endif
> ===== fs/bio.c 1.14 vs 1.15 =====
> --- 1.14/fs/bio.c	Thu Feb  7 16:13:25 2002
> +++ 1.15/fs/bio.c	Fri Feb  8 17:22:14 2002
> @@ -151,6 +151,22 @@
>  	return NULL;
>  }
>  
> +struct bio *bio_setup_from_kvec(int gfp_mask, struct kvec *kvec)
> +{
> +	struct bio *bio = mempool_alloc(bio_pool, gfp_mask);
> +	struct bio_vec *bvl = NULL;
> +
> +	if (unlikely(!bio))
> +		return NULL;
> +
> +	bio->bi_max = kvec->max_nr;
> +	bio_init(bio);
> +	bio->bi_destructor = bio_destructor;
> +	bio->bi_io_vec = (struct bio_vec *)kvec->veclet;	/* shoot me */
> +	bio->bi_flags |= 1 << BIO_CLONED;	/* don't free the vec */
> +	return bio;
> +}
> +
>  /**
>   * bio_put - release a reference to a bio
>   * @bio:   bio to release reference to
> ===== include/linux/kiovec.h 1.1 vs 1.2 =====
> --- 1.1/include/linux/kiovec.h	Sat Jan 12 02:19:10 2002
> +++ 1.2/include/linux/kiovec.h	Fri Feb  8 15:00:54 2002
> @@ -6,8 +6,8 @@
>  
>  struct kveclet {
>  	struct page	*page;
> -	unsigned	offset;
>  	unsigned	length;
> +	unsigned	offset;
>  };
>  
>  struct kvec {
> ===== include/linux/bio.h 1.11 vs 1.12 =====
> --- 1.11/include/linux/bio.h	Wed Feb  6 01:23:04 2002
> +++ 1.12/include/linux/bio.h	Fri Feb  8 17:22:23 2002
> @@ -26,6 +26,8 @@
>  #define BIO_VMERGE_BOUNDARY	0
>  #endif
>  
> +#include <linux/kiovec.h>
> +
>  #define BIO_DEBUG
>  
>  #ifdef BIO_DEBUG
> @@ -91,6 +93,7 @@
>  	void			*bi_private;
>  
>  	bio_destructor_t	*bi_destructor;	/* destructor */
> +	kvec_cb_t		cb;
>  };
>  
>  /*
> ===== fs/aio.c 1.1 vs 1.2 =====
> --- 1.1/fs/aio.c	Wed Jan 30 13:12:34 2002
> +++ 1.2/fs/aio.c	Fri Feb  8 14:58:10 2002
> @@ -37,6 +37,7 @@
>  #include <linux/smp_lock.h>
>  #include <linux/compiler.h>
>  #include <linux/poll.h>
> +#include <linux/module.h>
>  
>  #include <asm/uaccess.h>
>  
> @@ -964,3 +965,8 @@
>  }
>  
>  __initcall(aio_setup);
> +EXPORT_SYMBOL_GPL(generic_file_kvec_read);
> +EXPORT_SYMBOL_GPL(generic_file_aio_read);
> +EXPORT_SYMBOL_GPL(generic_file_kvec_write);
> +EXPORT_SYMBOL_GPL(generic_file_aio_write);
> +EXPORT_SYMBOL_GPL(generic_file_new_read);
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
