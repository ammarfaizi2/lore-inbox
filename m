Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266697AbRGFNmB>; Fri, 6 Jul 2001 09:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266699AbRGFNlv>; Fri, 6 Jul 2001 09:41:51 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:10360 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266697AbRGFNlj>; Fri, 6 Jul 2001 09:41:39 -0400
Date: Fri, 6 Jul 2001 15:41:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "ZINKEVICIUS,MATT (HP-Loveland,ex1)" <matt_zinkevicius@hp.com>
Subject: Re: patch: highmem zero-bounce
Message-ID: <20010706154138.O2425@athlon.random>
In-Reply-To: <20010626182215.C14460@suse.de> <20010627114155.A31910@athlon.random> <20010627182745.D17905@suse.de> <20010627184908.E17905@suse.de> <20010627190626.E24623@athlon.random> <20010627191229.G17905@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010627191229.G17905@suse.de>; from axboe@suse.de on Wed, Jun 27, 2001 at 07:12:29PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 07:12:29PM +0200, Jens Axboe wrote:
> Humm yes, I agree. I'll redo it tonight and send an updated
> incremental. Hopefully I'll be able to upload a new full version too.

I was going to integrate the avoid-bounce-buffer support but I don't
find anything recent except the bio patch for 2.5 that you uploaded
yesterday:

andrea@athlon:~/mirror/kernel.org/people/axboe > find -mtime -1 
./v2.5
./v2.5/bio-14-pre4
andrea@athlon:~/mirror/kernel.org/people/axboe > find -mtime -25
./v2.5
./v2.5/bio-14-pre4
andrea@athlon:~/mirror/kernel.org/people/axboe > 

The bio patch would better be 2.5 material, I'd prefer only skipping the
bounce between 1G to 4G in 2.4. Could you make a new patch with only the
bounce skip between 1G and 4G against pre3?

btw, the latest bio patch from yesterday is still broken with respect to
nested irqs:

+static inline void *kmap_atomic(struct page *page, enum km_type type)
+{
+       unsigned long flags;
+       void *vaddr;
+
+       __save_flags(flags);
+       __cli();
+       vaddr = __kmap_atomic(page, type);
+       __restore_flags(flags);
+
+       return vaddr;
+}
[..]
+static inline void kunmap_atomic(void *kvaddr, enum km_type type)
+{
+#if HIGHMEM_DEBUG
+       unsigned long flags;
+
+       __save_flags(flags);
+       __cli();
+       __kunmap_atomic(kvaddr, type);
+       __restore_flags(flags);
 #endif
 }
[..]
+#define bio_kmap_irq(bio) (kmap_atomic(bio_page((bio)), KM_BIO_IRQ) + bio_offset((bio)))
+#define bio_kunmap_irq(ptr) kunmap_atomic((void *) (((unsigned long) (ptr)) & PAGE_MASK), KM_BIO_IRQ)
[..]
+extern inline void *ide_map_buffer(struct request *rq)
+{
+       return bio_kmap_irq(rq->bio) + ide_rq_offset(rq);
+}
+
+extern inline void ide_unmap_buffer(char *buffer)
+{
+       bio_kunmap_irq(buffer);
+}
[..]
+                               char *to = ide_map_buffer(rq);
+                               idedisk_output_data (drive, to, SECTOR_WORDS);
+                               ide_unmap_buffer(to);
[..] 

the __cli() and __restore_flags() are not needed in kmap_atomic, and the
bio_kmap_irq is still broken, the suprious __restore_flags in
kmap_atomic is enabling irq again before you do the PIO, that will
corrupt the pte of the KM_BIO_IRQ if a nested irq runs under us.

In short you don't need to __save_flags(); __cli() for all the KM but
the BIO_IRQ one, and in the BIO_IRQ case you need to __restore_flags not
after setting the pagetable, but after also all the I/O is finished (so
in the kunmap, not in the kmap).

Andrea
