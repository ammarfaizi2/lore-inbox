Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSJQJ6O>; Thu, 17 Oct 2002 05:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSJQJ6N>; Thu, 17 Oct 2002 05:58:13 -0400
Received: from ns.suse.de ([213.95.15.193]:46346 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261330AbSJQJ6L> convert rfc822-to-8bit;
	Thu, 17 Oct 2002 05:58:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Nathan Scott <nathans@sgi.com>
Subject: Re: [PATCH 1/5] Add POSIX Access Control Lists to ext2/3
Date: Thu, 17 Oct 2002 12:04:08 +0200
User-Agent: KMail/1.4.3
Cc: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       torvalds@transmeta.com, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
References: <E181a3b-0006Nu-00@snap.thunk.org> <20021016155012.GA8210@think.thunk.org> <20021017084836.B302869@wobbly.melbourne.sgi.com>
In-Reply-To: <20021017084836.B302869@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210171204.08922.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nathan,

On Thursday 17 October 2002 00:48, Nathan Scott wrote:
> Mornin' all,
>
> On Wed, Oct 16, 2002 at 11:50:12AM -0400, Theodore Ts'o wrote:
> > On Wed, Oct 16, 2002 at 02:11:04PM +0100, Christoph Hellwig wrote:
> > > Ted, please either go _always_ through the {get,set}_posix_acl methods
> > > or never.  Currently XFS doesn't know and doesn't want to know
> > > about the so called "egenric ACL representation" used by ext2/ext3. 
> > > With theses methods we'd have to add it to XFS which is fine for me as
> > > long as it the representation generally used for working with ACLs. 
> > > That would mean we'd have to add new syscall or at least VFS-level
> > > hooks to the xattr code.
> >
> > Fine.  I'll just yank the {get,set}_posix_acl methods for now.  The
>
> Please remove them permanently, IMO they are broken by design.

That's done, despite that I disagree with your line of argument (see below).

> They are an optimisization for the one special case (posix acls),
> and manage to pollute the VFS for that one special case - a much
> cleaner solution is to optimise the code sitting behind the xattr
> inode calls and preferably in ways that all of the ext2/3 EAs can
> benefit (users attrs, capabilities, MAC labels, etc), & not just
> ACLs.

Nathan, you are ignoring the design of the inode operations: They are on 
purpose passing extended attributes by value. This is good as a kernel/user 
space interface, but inappropriate for passing around references to kernel 
internal structures. There is no further optimizing to be done behind that 
interface.

In the current design no filesystem independent part of the kernel would 
benefit from a faster interface except that one NFS hack. Since that appears 
to be no serious performance bottleneck and the hack will eventually go away 
using ->getxattr() seems acceptable.

As soon as any filesystem independent part of the kernel needs an interface 
more efficient that pass-by-value we will again have exactly the same 
problem.

> Yes, this means nfsd has to do some more work to alloc some space
> and convert from syscall format to native before doing its thing
> with the attributes, but thats in the noise compared to going to
> disk and fetching the EA (which is what we really want to optimise
> here) and can also be wrapped in Andreas' lib code so that the nfsd
> changes are minimal.

I'm not sure if you have looked at how the [gs]et_posix_acl() operations are 
implemented for ext2/ext3/reiserfs/xfs. They are caching the ACLs per inode 
instead of repeatedly copying around the xattr values; permission() calls 
therefore are very efficient. XFS is the only exception; it always goes 
through the xattr interface and does not cache ACLs. I think XFS should also 
use caching, at least for ACL_TYPE_ACCESS ACLs.

Going to disk and fetching EAs only causes disk accesses once; afterwards the 
block is cached.

> > However, the reality is that at this point, we probably won't have
> > time to get support in for the NFS server ACL before feature freeze,
> > and changing the interface to ACL's (never mind the headaches of
> > trying to agree to a new syscall interface at this late date), given
> > the deployed userspace tools, just doesn't seem to be realistic.
>
> No additional syscalls are needed.  This would also be short sighted
> - we don't yet support any other system EAs (as I've said to Andreas
> on several occassions, capabilities look like a really good candidate
> since they also must be read in kernel space on exec and read/written
> from userspace), so any interface changes now based on a fairly weak
> optimisation for the single system attribute that the patches support
> today (posix acls) is premature at best.

File system capabilities are in a different league that ACLs. They only need 
to be read once for each exec(), so going through the xattr interface is no 
problem at all. (In comparison, all ACLs along the path to a file are 
accessed whenever that file is accessed.)

Cheers,
Andreas.

