Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTI3FYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 01:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTI3FX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 01:23:58 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:17075 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263152AbTI3FX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 01:23:56 -0400
Date: Mon, 29 Sep 2003 22:23:45 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: effect of nfs blocksize on I/O ?
Message-ID: <20030929222345.A3043@google.com>
References: <20030928234236.A16924@google.com> <16247.56578.861224.328086@charged.uio.no> <20030929005250.A9110@google.com> <16247.60679.415937.295532@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16247.60679.415937.295532@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Sep 29, 2003 at 01:27:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 01:27:51AM -0700, Trond Myklebust wrote:
> >>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:
> 
>     >> OTOH, bsize is of informational interest to programs that wish
>     >> to optimize I/O throughput by grouping their data into
>     >> appropriately sized records.
> 
>      > So then isn't the optimal record size 8192 for r/wsize=8192?
>      > Since the data is going to be grouped into 8192-byte reads and
>      > writes over the wire, shouldn't bsize match that?  Why should I
>      > make 16x 512-byte write() syscalls (if "optimal" I/O size is
>      > bsize=512) instead of 1x 8192-byte syscall?
> 
> Yes. It is already on my list of bugs.
> 
> We basically need to feed 'wtpref' (a.k.a. 'wsize') into the f_bsize,
> and 'wtmult' into f_frsize.

Then it sounds like the current wtmult/512 value for f_bsize is a bug.
Until such time as you get f_frsize going, just directly plugging
wsize into s_blocksize seems like a win.  Doesn't it?  At least, I don't
see the advantage of using wtmult.  (but could easily be missing it!)

> OTOH, the s_blocksize (and inode->i_blkbits) might well want to stay
> with wtmult.

ISTM that f_frsize is pretty useless for NFS.  Even if the server gives
you this value (as wtmult), what use besides conversion of tbytes/abytes
values does it have?

If you like, I can supply such a patch.

- s_blocksize, either
  . leave it as is (wtmult?wtmult:512)
  . set to wsize (ie, my first patch in this thread)
- statfs, both
  . report wtpref as f_bsize (already done if s_blocksize = wsize)
  . report (wtmult?wtmult:wtpref) as f_frsize

I think the second s_blocksize option is better because not only statfs()
but also stat() will use this value without any additional work.

/fc
