Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289091AbSA1CGk>; Sun, 27 Jan 2002 21:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289092AbSA1CGb>; Sun, 27 Jan 2002 21:06:31 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28185 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289091AbSA1CGZ>; Sun, 27 Jan 2002 21:06:25 -0500
Date: Mon, 28 Jan 2002 03:06:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT broken in 2.5.3-preX ?
Message-ID: <20020128030611.T25170@athlon.random>
In-Reply-To: <20020115145549.M31878@suse.de> <200201242152.g0OLq4n08807@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200201242152.g0OLq4n08807@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Thu, Jan 24, 2002 at 01:52:04PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 01:52:04PM -0800, Badari Pulavarty wrote:
> Hi,
> 
> I am reading the O_DIRECT code patch for 2.5.3-pre4. I was wondering
> how is this working in 2.5.X ? Here is my concern:
> 
> generic_direct_IO() creates a blocks[] list and passes it to
> brw_kiovec() with a single kiobuf.
> 	
> 	retval = brw_kiovec(rw, 1, &iobuf, inode->i_dev, blocks, blocksize);
> 
> But brw_kiovec() uses only b[0] to call ll_rw_bio().
> 
> 	for (i = 0; i < nr; i++) {
>                 iobuf = iovec[i];
>                 iobuf->errno = 0;
> 
>                 ll_rw_kio(rw, iobuf, dev, b[i] * (size >> 9));
>         }
> 
> 
> Note that nr = 1 here. ll_rw_kio() uses b[0] as starting sector
> and does the entire IO (for iobuf->length). This is wrong !!!
> It is doing IO from wrong blocks.  Some one should use other 
> block numbers from blocks[] list. Isn't it ?

correct. It seems like somebody broke the semantics of the block field
of brw_kiovec without updating the callers, and furthmore now it is
impossible to use brw_kiovec for O_DIRECT because it is not going to
submit physically contigous I/O.

Andrea
