Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRBNRnp>; Wed, 14 Feb 2001 12:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbRBNRnf>; Wed, 14 Feb 2001 12:43:35 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:33651 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129227AbRBNRnU>; Wed, 14 Feb 2001 12:43:20 -0500
Message-Id: <200102141744.f1EHib628724@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: simon@baydel.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: File IO performance 
In-Reply-To: Message from Marcelo Tosatti <marcelo@conectiva.com.br> 
   of "Wed, 14 Feb 2001 12:07:27 -0200." <Pine.LNX.4.21.0102140935370.30964-100000@freak.distro.conectiva> 
Date: Wed, 14 Feb 2001 11:44:37 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, 14 Feb 2001,  wrote:
> 
> > I have been performing some IO tests under Linux on SCSI disks.
> 
> ext2 filesystem? 
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

We could break the loop apart somewhat and grab pages first, map them,
then submit all the I/Os together. This has other costs assoiated with
it, the earlier pages in the readahead - the ones likely to be used
first, will be delayed by the setup of the other pages. So the calling
thread is less likely to find the first of these pages in cache next
time it somes around looking for them. Of course, most of the time, the
thread doing the setup of readahead is the thread doing the reading, so
it gets to wait anyway.

I am not sure that the fact we do readahead on non contiguous data matters,
since that is the data the user will want anyway. A break in the on disk
mapping of data could be used to stop readahead I suppose, especially if
getting that readahead page is going to involve evicting other pages. I
suspect that doing this time of thing is probably getting too complex for
it's own good though.

Try breaking the readahead loop apart, folding the page_cache_read into
the loop, doing all the page allocates first, and then all the readpage
calls. I suspect you really need to go a bit further and get the
mapping of all the pages fixed up before you do the actual reads.

Commenting on a later message:


simon@baydel.com said:
>> as I mentioned earlier I have been working on 2.4.0-test1. I am very
>> interested to hear what you have to say about the XFS IO mechanism. I
>> take it that this is what the current XFS development work is being
>> performed on. So could I download this and give it a whirl ? My
>> interest at the moment is only that of an initial investigation and
>> nothing more.
>>
>> If not is it possible I could get hold of the 2.4 changes you
>> mentioned ?  

The xfs read path is on my list to rewrite at the moment - since it does
not do readahead very well. For larger size reads this does not appear to
be a problem for smaller reads we can become disk bound (ext2 is cpu bound
on the same hardware) suggesting that we could benefit from better readahead
logic.

All the XFS code is available here: http://oss.sgi.com/projects/xfs/

there is a download link and a pointer to a cvs tree.

Steve

Steve


