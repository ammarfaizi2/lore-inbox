Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSIEQJI>; Thu, 5 Sep 2002 12:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSIEQJI>; Thu, 5 Sep 2002 12:09:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39436 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317851AbSIEQJG>;
	Thu, 5 Sep 2002 12:09:06 -0400
Message-ID: <3D7785B4.A35C9BC8@zip.com.au>
Date: Thu, 05 Sep 2002 09:26:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
References: <20020905123331.A1984@in.ibm.com> <Pine.LNX.4.44.0209050744520.14066-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
> I would suggest:
> 
>  - add a "nr of sectors completed" argument to the "bi_end_io()" function,
>    so that it looks like
> 
>         void xxx_bio_end_io(struct bio *bio, unsigned long completed)
>         {
>                 /*
>                  * Old completion handlers that don't understand it
>                  * should just return immediately for partial bio
>                  * completion notifiers
>                  */
>                 if (bio->b_size)
>                         return;
>                 ...
>         }
> 
>    which would allow things like mpage_end_io_read() to unlock pages as
>    they complete, instead of unlocking them all in one go.

It's a feature!  We don't want to have to soak up 20,000 context
switches a second just reading a file from an 80MB/sec disk.

> Comments? It looks trivial to do this from a bio level, and it would not
> be hard to update the existing end_io functions (because you can always
> just update them with the one-liner "if not totally done, return" to get
> the old behaviour).
> 
> Andrew? I really dislike the lack of concurrency in our current mpage
> read-ahead thing. Whaddayathink?

Well it is supposed to lay out two BIOs, but if that happens, it's
fragile - it relies on BIO_MAX_SIZE=64k and default readahead=128k.

What I think we need to do here is to get Jens' bio_add_page() stuff
up and running and to then go through the device drivers and set their
max BIO size to something which is inversely proportional to the
device's expected bandwidth.

This way, the floppy readahead would lay out 1- or 2-page BIOs, and
the honking FC array would lay out 128k or larger BIOs.

(In fact, I would prefer that the device's nominal read- and write-
bandwidths be made available in some manner.  This way the VM can
make these granularity-size decisions for readahead, and the VM
can then solve the machine-full-of-dirty-memory-against-a-slow-device
problem.  But the non-blocking page reclaim code probably solves that
too).
