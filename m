Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313808AbSDPS0S>; Tue, 16 Apr 2002 14:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313810AbSDPS0R>; Tue, 16 Apr 2002 14:26:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57360 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313808AbSDPS0P>;
	Tue, 16 Apr 2002 14:26:15 -0400
Message-ID: <3CBC6CB7.C716911B@zip.com.au>
Date: Tue, 16 Apr 2002 11:25:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: readahead
In-Reply-To: <UTC200204161354.g3GDsFO28323.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> [readahead.c has badly readable comments, on a standard
> 80-column display: many lines have a size just slightly
> over 80 chars]

Sigh.  At least it has comments.  Agree with the 80-column
thing, but I find for the kernel coding style, 80 is just
5-10 columns too short, often.

> In the good old days we had tunable readahead.
> Very good, especially for special purposes.

readahead is tunable, but the window size is stored
at the request queue layer.  If it has never been
set, or if the device doesn't have a request queue,
you get the defaults.

Do these cards not have a request queue?  Suggestions
are sought.
 
> I recall the days where I tried to get something off
> a bad SCSI disk, and the kernel would die in the retries
> trying to read a bad block, while the data I needed was
> not in the block but just before. Set readahead to zero
> and all was fine.

Yes, but things should be OK as-is.  If the readahead attempt
gets an I/O error, do_generic_file_read will notice the non-uptodate
page and will issue a single-page read.  So everything up to
a page's distance from the bad block should be recoverable.
That's the theory; can't say that I've tested it.

If the driver is actually dying over the bad block, well, foo.

> Yesterday evening I was playing with my sddr09 driver,
> reading SmartMedia cards, and found to my dismay that
> the kernel wants to do a 128 block readahead.
> Not only is that bad on a slow medium, one is waiting
> a noticeable time for unwanted data, but it is worse
> that setting the readahead no longer works.
> 
> [Indeed, it is very desirable to be able to set readahead
> to zero. It is also desirable to be able to set it to a
> small value. Today on 2.5.8 both are impossible, readahead.c
> insists on a minimum readahead of 16 sectors.]

Yup.  Permitting a window size of zero is on my todo list,
but it would require that the device have a request queue.
Maybe the readahead size should be placed in struct blk_dev_struct,
and not in the request queue?

-
