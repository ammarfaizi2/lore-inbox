Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317409AbSFMCZf>; Wed, 12 Jun 2002 22:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317414AbSFMCZe>; Wed, 12 Jun 2002 22:25:34 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:13319 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S317409AbSFMCZd>; Wed, 12 Jun 2002 22:25:33 -0400
Date: Wed, 12 Jun 2002 19:25:26 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
Message-ID: <20020612192526.B6679@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3D06FEA9.AB40CC79@zip.com.au> <Pine.LNX.4.21.0206121455560.1032-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 03:52:34PM +0100, Hugh Dickins wrote:
> On Wed, 12 Jun 2002, Andrew Morton wrote:
> > 
> > A more serious form of data loss occurs when an application has a shared
> > mapping over a sparse file.  If the filesystem is out of space when
> > the VM decides to write back some pages, your data simply gets dropped
> > on the floor.  Even a subsequent msync() won't tell you that you have
> > a shiny new bunch of zeroes in your file.
> > 
> > It's not simple to fix.  Approaches might be:
> > 
> > 1: Map the page to disk at fault time, generate SIGBUS on
> >    ENOSPC  (the standards don't seem to address this issue, and
> >    this is a non-standard overload of SIGBUS).
> 
> I believe your option 1 is closest to the right direction; and SIGBUS
> is entirely appropriate, I don't see it as a non-standard overload.

I concur that #1 is closest.  I'd prefer it to happen on a
write fault rather read but the frequency with which
this should occur is low enough i wouldn't sweat it.

It is a non-standard overload of SIGBUS.  SIGBUS is to
indicate an unaligned memory access or otherwise malformed
address. Many confuse SIGBUS with SIGSEGV because they are
usually symptoms of the same problems but a SIGSEGV is to
indicate memory protection violation (unresolvable page
fault) which is not the same as a malformed address.  I
believe Linux, at least on x86 maps both errors to SIGSEGV.
I would think SIGXFSZ might be a better fit.

> 
> But you didn't spell out the worst news on that option: read faults
> into a read-only shared mapping of a file which the application had
> open for read-write when it mmapped: the page must be mapped to disk
> at read fault time (because the mapping just might be mprotected for
> read-write later on, and the page then dirtied).
> 
> 

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
