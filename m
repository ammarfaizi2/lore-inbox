Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSGQAH5>; Tue, 16 Jul 2002 20:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318161AbSGQAH4>; Tue, 16 Jul 2002 20:07:56 -0400
Received: from egil.codesourcery.com ([66.92.14.122]:48773 "EHLO
	egil.codesourcery.com") by vger.kernel.org with ESMTP
	id <S318159AbSGQAHz>; Tue, 16 Jul 2002 20:07:55 -0400
Date: Tue, 16 Jul 2002 17:10:32 -0700
From: Zack Weinberg <zack@codesourcery.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020717001032.GI358@codesourcery.com>
References: <20020716232225.GH358@codesourcery.com> <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 02:03:02AM +0100, Alan Cox wrote:
> On Wed, 2002-07-17 at 00:22, Zack Weinberg wrote:
> > Making use of the close return value is also never any good.
> 
> This is untrue

I beg to differ.

> > Consider: There is no guarantee that close will detect errors.  Only
> > NFS and Coda implement f_op->flush methods.  For files on all other
> > file systems, sys_close will always return success (assuming the file
> > descriptor was open in the first place); the data may still be sitting
> > in the page cache.  If you need the data pushed to the physical disk,
> > you have to call fsync.
> 
> close() checking is not about physical disk guarantees. It's about more
> basic "I/O completed". In some future Linux only close() might tell you
> about some kinds of I/O error.

I think we're talking past each other.

My first point is that a portable application cannot rely on close to
detect any error.  Only fsync guarantees to detect any errors at all
(except ENOSPC/EDQUOT, which should come back on write; yes, I know
about the buggy NFS implementations that report them only on close).

My second point, which you deleted, is that if some hypothetical close
implementation reports an error under some circumstances, an
immediately preceding fsync call MUST also report the same error under
the same circumstances.

Therefore, if you've checked the return value of fsync, there's no
point in checking the subsequent close; and if you don't care to call
fsync, the close return value is useless since it isn't guaranteed to
detect anything.

> > There's also an ugly semantic bind if you make close detect errors.
> > If close returns an error other than EBADF, has that file descriptor
> > been closed?  The standards do not specify.  If it has not been
> > closed, you have a descriptor leak.  But if it has been closed, it is
> > too late to recover from the error.  [As far as I know, Unix
> > implementations generally do close the descriptor.]
> 
> If it bothers you close it again 8)

And watch it come back with an error again, repeat ad infinitum?

> > The manpage that was quoted earlier in this thread is incorrect in
> > claiming that errors will be detected by close; it should be fixed.
> 
> The man page matches the stsndard. Implementation may be a subset of the
> allowed standard right now, but don't program to implementation
> assumptions, it leads to nasty accidents

You missed the point.  The manpage asserts that I/O errors are
guaranteed to be detected by close; there is no such guarantee.

zw
