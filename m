Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbUKILv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUKILv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUKILvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:51:52 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:65469 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261517AbUKILvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:51:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=k1KPmmKcDvs0DyDteJeeZzmsO541sA/lpCqxcKDL+T49AbVd1L9Hd6q8M+n/tLD5hdyyBEjKe0zKNasSWnu5d7wLubJc3lMR+E5N5eBbII9tsSwomVCah5kGKVCmLa5aywR0ms3yZP0FbCcrnraBt8yAQ3fKrOux2rnGv+MQTZ4=
Message-ID: <58cb370e0411090351e01c953@mail.gmail.com>
Date: Tue, 9 Nov 2004 12:51:25 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Terry Kyriacopoulos <terryk@echo-on.net>
Subject: Re: [PATCH] ide-scsi: DMA alignment bug fixed
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, linux-ide@vger.kernel.org
In-Reply-To: <Pine.LNX.4.56.0411082320320.348@fast.tk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.56.0411082320320.348@fast.tk.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why can't you simply change alignment in ide-scsi to 32 bytes?

On Mon, 8 Nov 2004 23:22:39 -0500 (EST), Terry Kyriacopoulos
<terryk@echo-on.net> wrote:
> 
> 
> 
> 
> On Fri, 5 Nov 2004, Jens Axboe wrote:
> 
> > I don't think this is the right way to go. The design of ide-scsi's dma
> > setup is based on the old buffer_heads, where you can only have a single
> > page at the time so you need to string them manually. We actually have
> > kernel helpers for mapping _user_ data to a request, we could add one
> > for mapping kernel data to a request as well.
> >
> > Here's a patch that I did some time ago for mapping a kernel pointer to
> > a bio. bio_copy_user() would be good inspiration, too. Mapping an sglist
> > to a new bio should be even simpler and it would clean up the ide-scsi
> > stuff a lot. It's not exactly pretty.
> 
> ...
> 
> 
> 
> >
> > +struct bio *bio_map_data(request_queue_t *q, unsigned char *ptr,
> > +                      unsigned int len, int read)
> > +{
> > +
> > +     unsigned long data = (unsigned long) ptr;
> > +     unsigned long end = (data + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +     unsigned long start = data >> PAGE_SHIFT;
> > +     const int nr_pages = end - start;
> > +     unsigned int bytes, offset;
> > +     struct bio *bio;
> > +     struct page *page;
> > +     int i;
> > +
> > +     if (!len || !nr_pages)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     bio = bio_alloc(GFP_KERNEL, nr_pages);
> > +     if (!bio)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     for (i = 0; i < nr_pages; i++) {
> > +             if (len <= 0)
> > +                     break;
> > +
> > +             page = virt_to_page(ptr);
> > +             offset = offset_in_page(ptr);
> > +
> > +             bytes = PAGE_SIZE - offset;
> > +             if (bytes > len)
> > +                     bytes = len;
> > +
> > +             if (__bio_add_page(q, bio, page, bytes, offset) < bytes)
> > +                     break;
> > +
> > +             len -= bytes;
> > +             offset = 0;
> > +             ptr += bytes;
> > +     }
> > +
> > +     bio->bi_end_io = bio_map_data_endio;
> > +     bio->bi_rw |= (!read << BIO_RW);
> > +     return bio;
> > +}
> > +
> 
> This code maps a pointer+length into a bio, but ide-scsi is fed an sglist,
> just like all low-level SCSI drivers, so this doesn't really help.
> 
> Please understand the way I handle misalignment.  Originally I used
> bounce buffers for the entire transfer if there was any misalignment,
> but this doesn't give optimal performance.  To maintain security, the
> bounce buffers must be zeroed before the I/O, otherwise a data scavenger
> can read potentially sensitive data if a transfer doesn't fully overwrite
> them.
> 
> This is where I got the idea to minimize the size of the extra bounce
> buffers by using the largest aligned subset of the user area.  If the
> base isn't aligned, the data must be shifted into place, hence the need
> for the overlapped copying in 'idescsi_bounce_dma'.  If only the length
> is misaligned, a small bounce buffer is appended to the bio just for the
> partial block.  Notice what it does for performance:
> 
> - Extra memory allocation is minimized
> - The user area doesn't need to be zeroed
> - Copying is limited to the last block if the base is aligned
> 
> cdda2wav/cdrecord/cdrdao use buffers much larger than 512 bytes and
> typically provide base aligned buffers, so this advanced technique
> really pays off.
> 
> Yes, some code is ugly, but the bug it fixes is uglier.
> 
> Another goal of mine was to confine the patch to the ide-scsi module.
> Making changes to high-level SCSI drivers or to IDE services would
> definitely not be a good approach.
> 
> Given the above, the code you presented can't really simplify ide-scsi.
> (If you have something that maps an sglist to a single contiguous block,
> I could use it.:-)
