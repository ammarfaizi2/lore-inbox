Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312045AbSCYFcf>; Mon, 25 Mar 2002 00:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312133AbSCYFcZ>; Mon, 25 Mar 2002 00:32:25 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:3969 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S312045AbSCYFcP>;
	Mon, 25 Mar 2002 00:32:15 -0500
Date: Mon, 25 Mar 2002 00:31:59 -0500
From: Theodore Tso <tytso@mit.edu>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-mips@oss.sgi.com,
        linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Does e2fsprogs-1.26 work on mips?
Message-ID: <20020325003159.A2340@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	"H . J . Lu" <hjl@lucon.org>, Andrew Morton <akpm@zip.com.au>,
	linux-mips@oss.sgi.com, linux kernel <linux-kernel@vger.kernel.org>,
	GNU C Library <libc-alpha@sources.redhat.com>
In-Reply-To: <20020323140728.A4306@lucon.org> <3C9D1C1D.E30B9B4B@zip.com.au> <20020323221627.A10953@lucon.org> <3C9D7A42.B106C62D@zip.com.au> <20020324012819.A13155@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 01:28:19AM -0800, H . J . Lu wrote:
> 
> The problem is not all arches use (~0UL) for RLIM_INFINITY.
> 
> What should we do about it? I know e2fsprogs-1.26 doesn't work on mips
> nor alpha because of this. I don't think it works on sparc.

Yeah, I forced the release of e2fsprogs 1.27 because of this, back on
March 8th.  That was my fault, and I fixed it as soon as I discovered
it.  (1.26 was released on Feb 3, and I released 1.27 on March 8th).

In e2fsprogs 1.27, I do the following:

#ifdef __linux__
#undef RLIM_INFINITY
#if (defined(__alpha__) || ((defined(__sparc__) || defined(__mips__)) && (SIZEOF_LONG == 4)))
#define RLIM_INFINITY	((unsigned long)(~0UL>>1))
#else
#define RLIM_INFINITY  (~0UL)
#endif

Basically because I can't depend on the RLIM_INFINITY being "right".
(Remember, I'm trying to make sure that e2fsprogs can compile on any
arbitrary glibc, and then run on any other-not-necessarily-the-same
glibc, which gets "challenging".)

The problem now is that some older glibcs are capping RLIM_INFINITY
with the older value, and so a combination of a new kernel, new
e2fsprogs, and old glibc results in problems.  My current feeling
about how to fix this is to bypass glibc altogether, and simply call
the setrlimit system call directly.  This is ugly-ugly-ugly, but I
can't see another way around this.

And just to be clear ---- although in the past I've been really
annoyed when glibc has made what I've considered to be arbitrary
changes which have screwed ABI, compile-time, or link-time
compatibility, and have spoken out against it --- in this particular
case, I consider the fault to be purely the fault of the kernel
developers, so there's no need having the glibc folks get all
defensive....

						- Ted

