Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSGQSZW>; Wed, 17 Jul 2002 14:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSGQSYO>; Wed, 17 Jul 2002 14:24:14 -0400
Received: from egil.codesourcery.com ([66.92.14.122]:61063 "EHLO
	egil.codesourcery.com") by vger.kernel.org with ESMTP
	id <S316465AbSGQSYE>; Wed, 17 Jul 2002 14:24:04 -0400
Date: Wed, 17 Jul 2002 11:24:56 -0700
From: Zack Weinberg <zack@codesourcery.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020717182456.GC8656@codesourcery.com>
References: <20020716232225.GH358@codesourcery.com> <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020717001032.GI358@codesourcery.com> <1026870340.2119.122.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026870340.2119.122.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 02:45:40AM +0100, Alan Cox wrote:
> On Wed, 2002-07-17 at 01:10, Zack Weinberg wrote:
> > My first point is that a portable application cannot rely on close to
> > detect any error.  Only fsync guarantees to detect any errors at all
> > (except ENOSPC/EDQUOT, which should come back on write; yes, I know
> > about the buggy NFS implementations that report them only on close).
> 
> They are not buggy merely inconvenient. The reality of the NFS protocol
> makes it the only viable way to do it

You are referring to the way NFSv2 lacks any way to request space
allocation on the server without also flushing data to disk?  It was
my understanding that NFSv2 clients that did not accept the
performance hit and do all writes synchronously were considered
broken.  (since, for instance, POSIX write-visibility guarantees are
violated if writes are delayed on the client.)

In v3 or v4, the WRITE/COMMIT separation lets the implementor generate
prompt ENOSPC and EDQUOT errors without performance penalty.

Another thing to keep in mind is that an application is often in a
much better position to recover from an error, particularly a
disk-full error, if it's reported on write rather than on close.
That's just a quality-of-implementation question, though.

> > > If it bothers you close it again 8)
> > 
> > And watch it come back with an error again, repeat ad infinitum?
> 
> The use of intelligence doesn't help. Come on I know you aren't a cobol
> programmer. Check for -EBADF ...

I wasn't talking about EBADF.  How does the application know the
kernel will ever succeed in closing the file?

> Disagree. It says
> 
> It is quite possible that errors on a  previous  write(2)  operation 
> are first  reported  at  the  final  close
> 
> Not checking the return value when closing the file may lead to silent
> loss of  data.
> 
>        A successful close does not guarantee that  the  data  has
>        been  successfully  saved  to  disk,  as the kernel defers
>        writes. It is not common for a  filesystem  to  flush  the
>        buffers  when the stream is closed. If you need to be sure
>        that the data is physically stored use fsync(2).  (It will
>        depend on the disk hardware at this point.)
> 
> None of which guarantee what you say, and which agree about the use of
> fsync being appropriate now and then

That is not the text quoted upthread.  Looks like the manpage did get
fixed, although I think the current wording is still suboptimal.

zw
