Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312334AbSCaSiy>; Sun, 31 Mar 2002 13:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312317AbSCaSip>; Sun, 31 Mar 2002 13:38:45 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16432 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312334AbSCaSif>; Sun, 31 Mar 2002 13:38:35 -0500
Date: Sun, 31 Mar 2002 20:38:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre5aa1 and splitted vm-33
Message-ID: <20020331203830.D1331@dualathlon.random>
In-Reply-To: <20020331164815.A1331@dualathlon.random> <20020331191059.A16769@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 07:10:59PM +0100, Christoph Hellwig wrote:
> On Sun, Mar 31, 2002 at 04:48:15PM +0200, Andrea Arcangeli wrote:
> > Only in 2.4.19pre5aa1: 00_o_direct-open-check-1
> > 
> > 	Move the check for O_DIRECT support into the open(2) syscall. Make
> > 	sense, also the xine folks asked for that feature to cleanup
> > 	some userspace. Patch from Chuck Lever.
> 
> This breaks XFS O_DIRECT handling, which is not implemented through ->direct_IO.

Hmm that's a problem. BTW, is there any valid reason xfs isn't
implementing O_DIRECT via the direct_IO address space operation like the
other filesystems ext2/reiserfs/nfs? (of course I'm talking long term, I
don't pretend to change that in one day, for the short term we should
still allow xfs to use its own internal methods of doing O_DIRECT)

Fixing that should be a one liner setting a_ops->direct_IO to
ERR_PTR(-1L) within xfs. Comments?

> For the open case putting the check into generic_file_open sounds good to me,

One problem with generic_file_open is that we'd need to rely on all
lowlevel open callbacks to do the check properly if they don't support
O_DIRECT and we'd need to duplicate code, only a few fs uses
generic_file_open.  Lefting it in the vfs looked cleaner, it reduces the
check to a few liner patch.

The lowlevel callback can always drop the kiovec during its own ->open
if they don't need it, even if they uses direct_IO, like nfs.

> but I have no idea on how to handle the fcntl case - which btw already allocates
> kiobufs even if XFS doesn't need them..

Chuck's patch is handling fcntl as well, do you see any problem there?
(modulo the fact the kiovec is pre-allocated even if not necessary, like
in open(2)?)

Andrea
