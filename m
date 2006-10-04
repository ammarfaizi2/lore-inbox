Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWJDTW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWJDTW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWJDTW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:22:57 -0400
Received: from pat.uio.no ([129.240.10.4]:31723 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750861AbWJDTW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:22:56 -0400
Subject: Re: [RFC 0/3] Convert XFS inode hashes to radix trees
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Chinner <dgc@sgi.com>
Cc: Chris Wedgwood <cw@f00f.org>, xfs-dev@sgi.com, xfs@oss.sgi.com,
       dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061003222256.GW4695059@melbourne.sgi.com>
References: <20061003060610.GV3024@melbourne.sgi.com>
	 <20061003212335.GA13120@tuatara.stupidest.org>
	 <20061003222256.GW4695059@melbourne.sgi.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 15:22:19 -0400
Message-Id: <1159989739.5848.61.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.096, required 12,
	autolearn=disabled, AWL 1.90, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 08:22 +1000, David Chinner wrote:
> On Tue, Oct 03, 2006 at 02:23:35PM -0700, Chris Wedgwood wrote:
> > On Tue, Oct 03, 2006 at 04:06:10PM +1000, David Chinner wrote:
> > > Overall, the patchset removes more than 200 lines of code from the
> > > xfs inode caching and lookup code and provides more consistent
> > > scalability for large numbers of cached inodes. The only down side
> > > is that it limits us to 32 bit inode numbers of 32 bit platforms due
> > > to the way the radix tree uses unsigned longs for it's indexes
> > 
> >     commit afefdbb28a0a2af689926c30b94a14aea6036719
> >     tree 6ee500575cac928cd90045bcf5b691cf2b8daa09
> >     parent 1d32849b14bc8792e6f35ab27dd990d74b16126c
> >     author David Howells <dhowells@redhat.com> 1159863226 -0700
> >     committer Linus Torvalds <torvalds@g5.osdl.org> 1159887820 -0700
> > 
> >     [PATCH] VFS: Make filldir_t and struct kstat deal in 64-bit inode numbers
> > 
> >     These patches make the kernel pass 64-bit inode numbers internally when
> >     communicating to userspace, even on a 32-bit system.  They are required
> >     because some filesystems have intrinsic 64-bit inode numbers: NFS3+ and XFS
> >     for example.  The 64-bit inode numbers are then propagated to userspace
> >     automatically where the arch supports it.
> >     [...]
> > 
> > Doing this will mean XFS won't be able to support 32-bit inodes on
> > 32-bit platforms the above (merged) patch --- though given that cheap
> > 64-bit systems are now abundant does anyone really care?

Which completely ignored the fact that NFS systems are already having to
truncate 64-bit inode numbers to 32-bits and pass these truncated values
up to userspace. Collisions have been observed in the wild, and I've
already had to change the 64-bit->32-bit hashing algorithm on at least
one occasion.

By moving that truncation into userspace, we will at least give 64-bit
standards-compliant programs a chance to work correctly.

Trond

