Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRBNRZf>; Wed, 14 Feb 2001 12:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRBNRZ0>; Wed, 14 Feb 2001 12:25:26 -0500
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:60425 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129311AbRBNRZO>; Wed, 14 Feb 2001 12:25:14 -0500
From: "" <simon@baydel.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Date: Wed, 14 Feb 2001 17:19:48 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: File IO performance
CC: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <46C587D9403D@baydel.com>
In-Reply-To: <Pine.LNX.4.21.0102140935370.30964-100000@freak.distro.conectiva>
Message-ID: <47BE860D6C4B@baydel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcello,

Thanks very much for your reply ! I have included additional 
information below.


> Date:          Wed, 14 Feb 2001 12:07:27 -0200 (BRST)
> From:          Marcelo Tosatti <marcelo@conectiva.com.br>
> To:            simon@baydel.com
> Cc:            lkml <linux-kernel@vger.kernel.org>
> Subject:       Re: File IO performance

> 
> On Wed, 14 Feb 2001,  wrote:
> 
> > I have been performing some IO tests under Linux on SCSI disks.
> 
> ext2 filesystem?

I have also tried XFS although I am currently using and some old
patches against 2.4.0-test1.
 
> 
> > I noticed gaps between the commands and decided to investigate.
> > I am new to the kernel and do not profess to underatand what 
> > actually happens. My observations suggest that the file 
> > structured part of the io consists of the following file phases 
> > which mainly reside in mm/filemap.c . The user read call ends up in
> > a generic file read routine. 
> >
> > If the requested buffer is not in the file cache then the data is
> > requested from disk via the disk readahead routine.
> >
> > When this routine completes the data is copied to user space. I have
> > been looking at these phases on an analyzer and it seems that none of
> > them overlap for a single user process.
> > 
> > This creates gaps in the scsi commands which significantly reduce
> > bandwidth, particularly at todays disk speeds.
> > 
> > I am interested in making changes to the readahead routine. In this 
> > routine there is a loop
> > 
> >  /* Try to read ahead pages.
> >   * We hope that ll_rw_blk() plug/unplug, coalescence, requests sort
> >   * and the scheduler, will work enough for us to avoid too bad 
> >   * actuals IO requests. 
> >   */ 
> > 
> >  while (ahead < max_ahead) {
> >   ahead ++;
> >   if ((raend + ahead) >= end_index)
> >    break;
> >   if (page_cache_read(filp, raend + ahead) < 0)
> >  }
> > 
> > 
> > this whole loop completes before the disk command starts. If the 
> > commands are large and it is for a maximum read ahead this loops 
> > takes some time and is followed by disk commands.
> 
> Well in reality its worse than you think ;)
> 
> > It seems that the performance could be improved if the disk commands 
> > were overlapped in some way with the time taken in this loop. 
> > I have not traced page_cache_read so I have no idea what is happening
> > but I guess this is some page location and entry onto the specific
> > device buffer queues ?
> 
> page_cache_read searches for the given page in the page cache and returns
> it in case its found. 
> 
> If the page is not already in cache, a new page is allocated.
> 
> This allocation can block if we're running out of free memory. To free
> more memory, the allocation routines may try to sync dirty pages and/or
> swap out pages.

This does not seem to happen during my tests

> 
> After the page is allocated, the mapping->readpage() function is called to
> read the page. The ->readpage() job is to map the page to its correct
> on-disk block (which may involve reading indirect blocks).
> 
> Finally, the page is queued to IO which again may block in case the
> request queue is full.
> 
> Another issue is that we do readahead of logically contiguous pages, which
> means we may be queuing pages for readahead which are not physically
> contiguous. In this case, we are generating disk seeks.
> 

I have been performing large sequential transfers, all of which I 
have observed lie physically contiguous. I do however see your point.


> > I am really looking for some help in underatanding what is happening 
> > here and suggestions in ways which operations may be overlapped.
> 
> I have some ideas...
> 
> The main problem of file readahead, IMHO, is its completly "per page"
> behaviour --- allocation, mapping, and queuing are done separately for
> each page and each of these three steps can block multiple times. This is
> bad because we can loose the chance for queuing the IOs together while
> we're blocked, resulting in several smaller reads which suck.
> 
> The nicest solution for that, IMHO, is to make the IO clustering at
> generic_file_read() context and send big requests to the IO layer instead
> "cluster if we're lucky", which is more or less what happens today.
> 
> Unfortunately stock Linux 2.4 maximum request size is one page.
> 
> SGI's XFS CVS tree contains a different kind of IO mechanism which can
> make bigger requests. We will probably have the current IO mechanism
> support bigger request sizes as well sometime in the future. However,
> both are 2.5 only things.
> 
> Additionaly, the way Linux caches on-disk physical block information is
> not very efficient and can be optimized, resulting in less reads of fs
> data to map pages and/or know if pages are physically contiguous (the
> latter is very welcome for write clustering, too).
> 
> However, we may still optimize readahead a bit on Linux 2.4 without too
> much efforts: an IO read command which fails (and returns an error code
> back to the caller) if merging with other requests fail. 
> 
> Using this command for readahead pages (and quitting the read loop if we
> fail) can "fix" the logically!=physically contiguous problem and it also
> fixes the case were we sleep and the previous IO commands have been
> already sent to disk when we wakeup. This fix ugly and not as good as the
> IO clustering one, but _much_ simpler and thats all we can do for 2.4, I
> suppose.
> 

as I mentioned earlier I have been working on 2.4.0-test1. I am very 
interested to hear what you have to say about the XFS IO mechanism.
I take it that this is what the current XFS development work is being 
performed on. So could I download this and give it a whirl ? My 
interest at the moment is only that of an initial investigation and 
nothing more.

If not is it possible I could get hold of the 2.4 changes you 
mentioned ? 


Thanks Again

Simon.


> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
