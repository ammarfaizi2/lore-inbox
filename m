Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSFLSVY>; Wed, 12 Jun 2002 14:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317756AbSFLSVX>; Wed, 12 Jun 2002 14:21:23 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:19950 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317755AbSFLSVX>; Wed, 12 Jun 2002 14:21:23 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 12 Jun 2002 11:36:05 -0600
To: Anton Altaparmakov <aia21@cantab.net>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Rusty Russell <rusty@rustcorp.com.au>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Message-ID: <20020612173605.GA573@clusterfs.com>
Mail-Followup-To: Anton Altaparmakov <aia21@cantab.net>,
	vda@port.imtp.ilyichevsk.odessa.ua,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp,
	Andrew Morton <akpm@zip.com.au>
In-Reply-To: <5.1.0.14.2.20020611155046.00af3980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611114701.00aefec0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611155046.00af3980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612155646.048fd520@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2002  16:08 +0100, Anton Altaparmakov wrote:
> Buffer allocation at use time is NOT an option because the buffers are 
> allocated using vmalloc() which is extremely expensive and we would need to 
> allocate at every single initial ->readpage() call of a compressed file.
> 
> >CPU hotswap higlights the fact that per CPU allocation needs to be smarter
> >about doing its job (i.e. don't allocate if it won't be used ever,
> >defer allocation to CPU hotswap event).
> 
> The former is not possible for ntfs as there is no quick way to tell if use 
> will use decompression or not. And the latter creates a lot of complexity. 
> I gave an example using a callback of how it could be done in a previous 
> post but I don't like introducing complexity for a minority group of users.

I think the reasonable solution is as follows:
1) Allocate an array of NULL pointers which is NR_CPUs in size (you could do
   this all the time, as it would only be a few bytes)
2) If you need to do decompression on a cpu you check the array entry
   for that CPU and if is NULL you vmalloc() the decompression buffers once
   for that CPU.  This avoid vmalloc() overhead for each read.
3) Any allocated buffers are freed in the same manner they are now -
   when the last compressed volume is unmounted.  There may be some or
   all entries that are still NULL.

This also avoids allocating buffers when there are no files which are
actually compressed.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

