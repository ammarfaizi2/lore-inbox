Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSFOFZE>; Sat, 15 Jun 2002 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSFOFZD>; Sat, 15 Jun 2002 01:25:03 -0400
Received: from merlin.webone.com.au ([210.8.44.18]:54537 "EHLO
	merlin.webone.com.au") by vger.kernel.org with ESMTP
	id <S314101AbSFOFZD>; Sat, 15 Jun 2002 01:25:03 -0400
Date: Sat, 15 Jun 2002 15:24:43 +1000
To: hugh@veritas.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
Message-ID: <20020615152443.A22396@beernut.flames.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Kevin Easton <s3159795@student.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, 12 Jun 2002, Andrew Morton wrote: 
> > 
> > A more serious form of data loss occurs when an application has a shared 
> > mapping over a sparse file. If the filesystem is out of space when 
> > the VM decides to write back some pages, your data simply gets dropped 
> > on the floor. Even a subsequent msync() won't tell you that you have 
> > a shiny new bunch of zeroes in your file. 
> > 
> > It's not simple to fix. Approaches might be: 
> > 
> > 1: Map the page to disk at fault time, generate SIGBUS on 
> > ENOSPC (the standards don't seem to address this issue, and 
> > this is a non-standard overload of SIGBUS). 
> 
> 
> I've looked at this issue in the past: it's a familiar problem 
> for various filesystems on various flavours of UNIX. Some of the 
> strangeness in tmpfs (shmem_recalc_inode, or ac's shmem_removepage) 
> can be traced to this issue, I believe. The filesystem does not 
> know when a clean page is dirtied, and somehow has to cope afterwards. 
> 
> 
> I believe your option 1 is closest to the right direction; and SIGBUS 
> is entirely appropriate, I don't see it as a non-standard overload. 
> 
> 
> But you didn't spell out the worst news on that option: read faults 
> into a read-only shared mapping of a file which the application had 
> open for read-write when it mmapped: the page must be mapped to disk 
> at read fault time (because the mapping just might be mprotected for 
> read-write later on, and the page then dirtied). 
> 

Can't the page be mapped to disk at the page-dirtying-fault time? I 
was under the impression that even after the mapping has been mprotected
for read-write, the first write to each page will still cause a page
fault that results in the page being marked dirty.

	- Kevin.

