Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVCJE3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVCJE3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVCIXL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:11:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:30182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262420AbVCIWkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:40:51 -0500
Date: Wed, 9 Mar 2005 14:39:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: suparna@in.ibm.com, daniel@osdl.org, sebastien.dugue@bull.net,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-Id: <20050309143936.046f163a.akpm@osdl.org>
In-Reply-To: <1110403885.24286.216.camel@dyn318077bld.beaverton.ibm.com>
References: <1110189607.11938.14.camel@frecb000686>
	<20050307223917.1e800784.akpm@osdl.org>
	<20050308090946.GA4100@in.ibm.com>
	<1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com>
	<1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com>
	<1110324434.6521.23.camel@ibm-c.pdx.osdl.net>
	<1110326043.24286.134.camel@dyn318077bld.beaverton.ibm.com>
	<20050309040757.GY27331@ca-server1.us.oracle.com>
	<20050309152047.GA4588@in.ibm.com>
	<20050309115348.2b86b765.akpm@osdl.org>
	<1110403885.24286.216.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Wed, 2005-03-09 at 11:53, Andrew Morton wrote:
> > Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> > >
> > >  > 	Solaris, which does forcedirectio as a mount option, actually
> > >  > will do buffered I/O on the trailing part.  Consider it like a bounce
> > >  > buffer.  That way they don't DMA the trailing data and succeed the I/O.
> > >  > The I/O returns actual bytes till EOF, just like read(2) is supposed to.
> > >  > 	Either this or a fully DMA'd number 4 is really what we should
> > >  > do.  If security can only be solved via a bounce buffer, who cares?  If
> > >  > the user created themselves a non-aligned file to open O_DIRECT, that's
> > >  > their problem if the last part-sector is negligably slower.
> > > 
> > >  If writes/truncates take care of zeroing out the rest of the sector
> > >  on disk, might we still be OK without having to do the bounce buffer
> > >  thing ?
> > 
> > We can probably rely on the rest of the sector outside i_size being zeroed
> > anyway.  Because if it contains non-zero gunk then the fs already has a
> > problem, and the user can get at that gunk with an expanding truncate and
> > mmap() anyway.
> > 
> 
> Rest of the sector or rest of the block ?

The filesystem-sized block (1<<i_blkbits) which straddles i_size should
have zeroes outside i_size.

There's one situation where it might not be zeroed out, and that's when the
final page is mapped MAP_SHARED and the application modifies that page
outside i_size while writeout is actually in flight.  We can't do much about
that.

> Are you implying that, we
> already do this, so there is no problem reading beyond EOF to user
> buffer ? Or we need to zero out the userbuffer beyond EOF ?

It should be acceptable to assume that the final (1<<i_blkbits) block of
the file contains zeroes outside i_size.

And if it doesn't contain those zeroes, well, applications are able to read
that data already.  Although I wouldn't count that as a security hole: that
data is something which an application wrote there while writing the file,
rather than being left-over uncontrolled stuff.


