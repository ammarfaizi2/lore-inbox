Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbSJPWm7>; Wed, 16 Oct 2002 18:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbSJPWm7>; Wed, 16 Oct 2002 18:42:59 -0400
Received: from rj.SGI.COM ([192.82.208.96]:63458 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S261432AbSJPWm6>;
	Wed, 16 Oct 2002 18:42:58 -0400
Date: Thu, 17 Oct 2002 08:48:36 +1000
From: Nathan Scott <nathans@sgi.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Gruenbacher <agruen@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Add POSIX Access Control Lists to ext2/3
Message-ID: <20021017084836.B302869@wobbly.melbourne.sgi.com>
References: <E181a3b-0006Nu-00@snap.thunk.org> <20021016141103.A8393@infradead.org> <20021016155012.GA8210@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021016155012.GA8210@think.thunk.org>; from tytso@mit.edu on Wed, Oct 16, 2002 at 11:50:12AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mornin' all,

On Wed, Oct 16, 2002 at 11:50:12AM -0400, Theodore Ts'o wrote:
> On Wed, Oct 16, 2002 at 02:11:04PM +0100, Christoph Hellwig wrote:
> > Ted, please either go _always_ through the {get,set}_posix_acl methods
> > or never.  Currently XFS doesn't know and doesn't want to know
> > about the so called "egenric ACL representation" used by ext2/ext3.  With
> > theses methods we'd have to add it to XFS which is fine for me as long as
> > it the representation generally used for working with ACLs.  That would mean
> > we'd have to add new syscall or at least VFS-level hooks to the xattr code.
> 
> Fine.  I'll just yank the {get,set}_posix_acl methods for now.  The

Please remove them permanently, IMO they are broken by design.

They are an optimisization for the one special case (posix acls),
and manage to pollute the VFS for that one special case - a much
cleaner solution is to optimise the code sitting behind the xattr
inode calls and preferably in ways that all of the ext2/3 EAs can
benefit (users attrs, capabilities, MAC labels, etc), & not just
ACLs.

Yes, this means nfsd has to do some more work to alloc some space
and convert from syscall format to native before doing its thing
with the attributes, but thats in the noise compared to going to
disk and fetching the EA (which is what we really want to optimise
here) and can also be wrapped in Andreas' lib code so that the nfsd
changes are minimal.

> However, the reality is that at this point, we probably won't have
> time to get support in for the NFS server ACL before feature freeze,
> and changing the interface to ACL's (never mind the headaches of
> trying to agree to a new syscall interface at this late date), given
> the deployed userspace tools, just doesn't seem to be realistic.

No additional syscalls are needed.  This would also be short sighted
- we don't yet support any other system EAs (as I've said to Andreas
on several occassions, capabilities look like a really good candidate
since they also must be read in kernel space on exec and read/written
from userspace), so any interface changes now based on a fairly weak
optimisation for the single system attribute that the patches support
today (posix acls) is premature at best.

> now.  Later on, we can figure out what changes are necessary to all of
> the various filesystems so that nfsd can get what information it
> needs.

No changes are needed to other filesystems, these new "generic posix
acl" inode_operations just need to go away, permanently - nfsd can
get everything it needs using the existing interfaces.  Requests for
some data showing any performance improvement at all with these VFS
extensions haven't produced anything to date, let alone a compelling
case for extending the VFS just for posix acls.

Just my AUS2c.

cheers.

-- 
Nathan
