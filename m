Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317915AbSGPXT3>; Tue, 16 Jul 2002 19:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317953AbSGPXT2>; Tue, 16 Jul 2002 19:19:28 -0400
Received: from egil.codesourcery.com ([66.92.14.122]:26757 "EHLO
	egil.codesourcery.com") by vger.kernel.org with ESMTP
	id <S317915AbSGPXT1>; Tue, 16 Jul 2002 19:19:27 -0400
Date: Tue, 16 Jul 2002 16:22:25 -0700
To: linux-kernel@vger.kernel.org
Subject: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020716232225.GH358@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207161337170.3452-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
From: Zack Weinberg <zack@codesourcery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder wrote:
> On Tue, 16 Jul 2002, Matthias Andree wrote:
> > Indeed, but OTOH, what error is close to report when the file is
> > opened read-only?
>
> Well, you can still get EIO, EINTR, EBADF. Whatever you say,
> disregarding the close return code is never any good.

Making use of the close return value is also never any good.

Consider: There is no guarantee that close will detect errors.  Only
NFS and Coda implement f_op->flush methods.  For files on all other
file systems, sys_close will always return success (assuming the file
descriptor was open in the first place); the data may still be sitting
in the page cache.  If you need the data pushed to the physical disk,
you have to call fsync.

Consider: If you have called fsync, and it returned successfully, an
immediate call to close is guaranteed to return successfully.  (Any
hypothetical f_op->flush method would have nothing to do; if not, that
filesystem does not correctly implement fsync.)

Therefore, I would argue that it is wrong for any application ever to
inspect close's return value.  Either the program does not need data
integrity guarantees, or it should be using fsync and paying attention
to that instead.

There's also an ugly semantic bind if you make close detect errors.
If close returns an error other than EBADF, has that file descriptor
been closed?  The standards do not specify.  If it has not been
closed, you have a descriptor leak.  But if it has been closed, it is
too late to recover from the error.  [As far as I know, Unix
implementations generally do close the descriptor.]

The manpage that was quoted earlier in this thread is incorrect in
claiming that errors will be detected by close; it should be fixed.

zw
