Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265527AbUATOMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 09:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUATOMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 09:12:37 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:45449
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265527AbUATOMc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 09:12:32 -0500
Subject: Re: Awful NFS performance with attached test program
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org, cmp@synopsys.com
In-Reply-To: <20040120132803.GA2830@ncsu.edu>
References: <20040119211649.GA20200@ncsu.edu>
	 <1074549226.1560.59.camel@nidelv.trondhjem.org>
	 <20040120132803.GA2830@ncsu.edu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074607946.1871.37.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 09:12:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 20/01/2004 klokka 08:28, skreiv jlnance@unity.ncsu.edu:
> I must admit that I am.  I could see that it would take somewhat longer
> because a logicial way for the kernel to implement this would be as a
> read-modify-write operation.  So a 2X slowdown would not supprise me.
> But the slowdown is more than 10X, and that does.

No... Do the math: your program is literally writing to
5000*4096/PAGE_SIZE times as many pages in the fseek()+fwrite() case.
You are creating 5000 times as many non-contiguous NFS write requests
that need to be flushed out somehow.
You will have the same problem even when writing to a local filesystem.
Just try adding a fflush()+fsync() before the gettimeofday(&b, 0) and
you'll see an equivalent slowdown there too.

For NFS, we could possibly "optimize" the process of flushing them out a
little bit by doing read-modify-write and then coalescing two 4byte
requests into a single 8k write, but that offers no reductions at all
here 'cos you first have to read in said 8k request in a single 8k read.

Even with a 32k r/wsize, the reduction in the number of generated
requests would at best be a factor of 8. That's still more than a factor
500 short.

> Also, for what its worth, Solaris performs like this:
> 
>     flame> ./a.out 
>     Creating file: 3.886 seconds
>     Updating file: 1.259 seconds
> 
> While Linux performs like this:
> 
>     jesse> ./a.out
>     Creating file: 43.042 seconds
>     Updating file: 555.796 seconds
> 
> 
> Both machines are writing to the same directory (not at the same time) on
> an x86_64 Linux server running a kernel which identifies itself as
> 2.4.21-4.ELsmp.  The network connection between the Solaris machine and
> the NFS server actually seems to be slightly slower than that between
> the Linux machine and the NFS server:

Oh. It's an x86_64? You didn't say originally, so I assumed an ia32. OK,
I believe my modified math above is correct.

If the your kernel was compiled using the default larger page size
(isn't that 16K?), then the explanation is simple: Linux generates
synchronous writes in all cases where the r/wsize is less than the
actual page size. Chuck Lever is currently working on a set of patches
that will fix that, but his work when completed will first have to go
into 2.6.

The other 2.4 limitation that will slow you down (even if you compile
with 4k pages) is that the NFS client is not allowed to cache more than
256 pages at a time. This hard limit exists in 2.4.x because there is no
mechanism for the MM to otherwise notify NFS if there is a low memory
situation that would require it to flush out all cached writes.
This limitation has already been removed in 2.6.x: there the number of
pages you can cache is only limited by the available free memory.

Cheers,
  Trond
