Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312317AbSCaTBA>; Sun, 31 Mar 2002 14:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312336AbSCaTAu>; Sun, 31 Mar 2002 14:00:50 -0500
Received: from imladris.infradead.org ([194.205.184.45]:34313 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312317AbSCaTAm>; Sun, 31 Mar 2002 14:00:42 -0500
Date: Sun, 31 Mar 2002 20:00:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.19pre5aa1 and splitted vm-33
Message-ID: <20020331200038.B18052@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
In-Reply-To: <20020331164815.A1331@dualathlon.random> <20020331191059.A16769@phoenix.infradead.org> <20020331203830.D1331@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 08:38:30PM +0200, Andrea Arcangeli wrote:
> Hmm that's a problem. BTW, is there any valid reason xfs isn't
> implementing O_DIRECT via the direct_IO address space operation like the
> other filesystems ext2/reiserfs/nfs? (of course I'm talking long term, I
> don't pretend to change that in one day, for the short term we should
> still allow xfs to use its own internal methods of doing O_DIRECT)

For definitve answers you have to ask Steve or some else from the XFS crow,
but if you look at the XFS data I/O path is is completly different from
the generic Linux filesystems due to the IRIX history/compatiblity and the
'need' for features not present in the core kernel.  Before 2.4.10 one
of those was O_DIRECT, btw..

> Fixing that should be a one liner setting a_ops->direct_IO to
> ERR_PTR(-1L) within xfs. Comments?

Looks good to me.

> 
> > For the open case putting the check into generic_file_open sounds good to me,
> 
> One problem with generic_file_open is that we'd need to rely on all
> lowlevel open callbacks to do the check properly if they don't support
> O_DIRECT and we'd need to duplicate code, only a few fs uses
> generic_file_open.  Lefting it in the vfs looked cleaner, it reduces the
> check to a few liner patch.
> 
> The lowlevel callback can always drop the kiovec during its own ->open
> if they don't need it, even if they uses direct_IO, like nfs.

I don't think this is a good design decision, but I can live with it for
2.4 - for 2.5 I'm still hoping for bcrls kvec to replace the current kiobuf
stuff and we have to see what that means for O_DIRECT.

> > kiobufs even if XFS doesn't need them..
> 
> Chuck's patch is handling fcntl as well, do you see any problem there?
> (modulo the fact the kiovec is pre-allocated even if not necessary, like
> in open(2)?)

It's this same issue, there is no other problem in my eyes.

