Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318814AbSHLUlv>; Mon, 12 Aug 2002 16:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318815AbSHLUlv>; Mon, 12 Aug 2002 16:41:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40718 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318814AbSHLUlu>;
	Mon, 12 Aug 2002 16:41:50 -0400
Message-ID: <3D581DE7.59C7A58@zip.com.au>
Date: Mon, 12 Aug 2002 13:43:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Simon Kirby <sim@netnation.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <3D57594B.C56A1932@zip.com.au> <15704.4092.969062.891558@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Andrew Morton <akpm@zip.com.au> writes:
> 
>      > Simon Kirby wrote:
>     >>
>     >> On Sun, Aug 11, 2002 at 08:28:12PM -0700, Andrew Morton wrote:
>     >>
>     >> > So I'd appreciate it if Simon could invetigate a little
>     >> > further with the test app I posted.  Something is up, and it
>     >> > may not be just an NFS thing.  But note that nfs_readpage
>     >> > will go synchronous if rsize is less than PAGE_CACHE_SIZE, so
>     >> > it has to be set up right.
>     >>
>     >> You're right -- my NFS page size is set to 2048.  I can't
>     >> remember if I did this because I was trying to work around huge
>     >> read-ahead or because I was trying to work around the bursts of
>     >> high latency from my Terayon cable modem (which idles at a slow
>     >> line speed and "falls forward" to higher speeds once it detects
>     >> traffic, but with a delay, causing awful latency at the expense
>     >> of "better noise immunity").  Anyway, I will test this
>     >> tomorrow.  I recall that 1024 byte-sized blocks were too small
>     >> because the latency of the cable modem would cause it to not
>     >> have high enough throughput, so I settled with 2048.
> 
>      > OK, thanks.
> 
> Sorry if somebody already covered this (I'm still a bit jetlagged so I
> may have missed part of the argument) but if the read is synchronous,
> why should we care about doing readahead at all?

Well, all reads are synchronous, in a way....

In this case, where the application's data-processing bandwidth is
vastly higher than the media bandwidth, readahead isn't doing anything
useful, apart from allowing the submission of nice big chunks to the IO
layers.  Batching.

If the application is processing data more slowly then readahead
will allow the IO to be overlapped with that processing.  But with
rsize < PAGE_CACHE_SIZE, all NFS reads are synchronous and everything
has gone bad.   It may be sensible for NFS to disable readahead
in this case.

> Wasn't the 2.4.x code designed so that you first scheduled the read
> for the page you are interested in, and only if the page was not
> immediately made available would you then schedule some readahead?

2.4 will schedule readahead whether or not the requested page is
uptodate.  Same in 2.5.

2.4 readahead has an explicit "don't do more readahead if the 
current page is still under IO", whereas 2.5 has "don't readahead
pages in a previously-submitted window".  They'll have the same
effect.
