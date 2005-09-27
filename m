Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVI0HK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVI0HK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVI0HK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:10:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:18370 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964838AbVI0HK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:10:29 -0400
Date: Tue, 27 Sep 2005 08:10:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: torvalds@odsl.org, linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
Message-ID: <20050927071025.GS7992@ftp.linux.org.uk>
References: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk> <20050927.151301.189720995.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927.151301.189720995.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 03:13:01PM +0900, Hirokazu Takata wrote:
> Please don't specify __BIG_ENDIAN__.  ;-)
> We have supported both big- and little-endian for the m32r kernel.
> I hope it will be kept unconditional.
> 
> Now, the endianness is to be determined by a (cross)compiler:
> - For the big-endian, a compiler (m32r-linux-gcc or m32r-linux-gnu-gcc)
>   provides a predefined macro __BIG_ENDIAN__.
> - For little-endian, a compiler (m32rle-linux-gcc or m32rle-linux-gnu-gcc)
>   provides a predefined macro __LITTLE_ENDIAN__.
> 
> Here is a modified patch.
> 
> Thank you.

You do realize that this way sparse will get neither?  It does not
pick predefined symbols from gcc; thus the -D<your_arch>, etc.

One solution would be to really run cross-gcc on something like

#define HAVE(x) -D##x=x
#ifdef __LITTLE_ENDIAN__
HAVE(__LITTLE_ENDIAN__)
#endif
#ifdef __BIG_ENDIAN__
HAVE(__BIG_ENDIAN__)
#endif

with grep -- -D on the output and have it added to CHECKFLAGS.  The only
problem being, for a generic solution we want to make sure that this
sucker is run _after_ we have decided on gcc arguments.

Note that it's potentially more than just m32r - e.g. s390 wants
__s390x__ added only for case of 64bit target.  Similar for powerpc
if these get merged, etc.

Sam, any help in that area?  Ideally we want to have something equivalent
to
PREDEFINED_WE_MIGHT_WANT = __m32r__ __LITTLE_ENDIAN__ __BIG_ENDIAN__
and CHECKFLAGS done from that - basically, the subset of cross-gcc
predefined symbols reproduced for sparse.  Ideally with -m64 added
if we have sizeof(long) == 8 on target, to take care of all that
crap in one go.

Suggestions?
