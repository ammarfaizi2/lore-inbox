Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276743AbRJHBWX>; Sun, 7 Oct 2001 21:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276745AbRJHBWP>; Sun, 7 Oct 2001 21:22:15 -0400
Received: from zok.SGI.COM ([204.94.215.101]:23993 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S276743AbRJHBWH>;
	Sun, 7 Oct 2001 21:22:07 -0400
Date: Mon, 8 Oct 2001 12:22:02 +1100
From: Nathan Scott <nathans@sgi.com>
To: monkeyiq <monkeyiq@users.sourceforge.net>
Cc: Andreas Gruenbacher <ag@bestbits.at>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: ENOATTR and other error enums
Message-ID: <20011008122201.W472533@wobbly.melbourne.sgi.com>
In-Reply-To: <200110060624.f966OeV30354@monkeyiq.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110060624.f966OeV30354@monkeyiq.dnsalias.org>; from monkeyiq@users.sourceforge.net on Sat, Oct 06, 2001 at 04:24:40PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

On Sat, Oct 06, 2001 at 04:24:40PM +1000, monkeyiq wrote:
> Hi,
>   Anyone know where these are defined in Linux? I dont seem
> to be able to find them, even with find/grep in /usr/include.

ENOATTR is not a blessed errno in Linux.  In XFS we have simply
defined it to be the same as ENODATA for the time being.  The
ext2 extended attributes project define it to be EDOM, also as
a stop-gap solution I imagine.

A similar problem exists with ENOTSUP (defined by POSIX 1003.1b?)
- this is only supported via linux/asm-parisc/errno.h as a real
errno, among all the architectures.  Both the XFS and ext2 extended
attributes implementations define this errno to be EOPNOTSUPP as an
interim solution.  Ah, wait - from a quick test, glibc does seem to
do exactly this also, so this one is not a problem (except perhaps
on the parisc port? -- hmm, that could actually be a bug on parisc).

On a related topic, but not specific to extended attributes - for
XFS in general, we needed one other errno - EFSCORRUPTED.  This is
used when XFS goes into forced shutdown mode for a filesystem that
has been detected as on-disk corrupt, to stop making the situation
any worse (user must umount/xfs_repair).  We couldn't find any pre-
existing Linux errno vaguely similar to this one, so it was defined
to "990" until a real solution could be found.

Obviously, these are not the correct long-term solutions ... they
need to become real Linux errno's, I think, and ENOTSUP could be
defined to EOPNOTSUPP? - EWOULDBLOCK, EDEADLOCK seem to do this.
I'm not sure how to reach that point though (CC'ing linux-kernel
for any advice) - for reference, in IRIX these errnos are defined
as follows:

ENOATTR = Attribute not found
EFSCORRUPTED = Filesystem is corrupted

> Also, is there a function to get a string rep of the error
> that occured in the attr code?

Someday it should become a part of asm-XXXXX/errno.h (errno's are
architecture specific) and the libc strerror(3) routine should be
able to provide a meaningful string.  But currently that does not
happen.

cheers.

-- 
Nathan
