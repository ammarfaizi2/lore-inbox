Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130436AbQLGRl2>; Thu, 7 Dec 2000 12:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbQLGRlS>; Thu, 7 Dec 2000 12:41:18 -0500
Received: from north.net.CSUChico.EDU ([132.241.66.18]:12297 "EHLO
	north.net.csuchico.edu") by vger.kernel.org with ESMTP
	id <S130436AbQLGRlM>; Thu, 7 Dec 2000 12:41:12 -0500
Date: Thu, 7 Dec 2000 09:10:45 -0800
From: John Kennedy <jk@csuchico.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: attempt to access beyond end of device
Message-ID: <20001207091045.A29789@north.csuchico.edu>
In-Reply-To: <20001207165659.A1167@gondor.com> <20001207173428.A23936@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001207173428.A23936@veritas.com>; from aeb@veritas.com on Thu, Dec 07, 2000 at 05:34:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 05:34:28PM +0100, Andries Brouwer wrote:
> On Thu, Dec 07, 2000 at 04:56:59PM +0100, Jan Niehusmann wrote:
> > That means that if blk_size[major][MINOR(bh->b_rdev)] == 0, the request
> > is canceled but no message is printed. Shouldn't there be a warning message?
> 
> Maybe that code fragment is mine. If so, then at some point
> in time I decided that the answer to your question is no.

  As a potential real-world case (but possibly unrelated), I had an
interesting situation crop-up while I was playing with the loopback
filesystems.

  If you just use the program-tools, you end up with a situation like:

	losetup <blah> [close all] dd <blah> [close all] losetup -d [blah]

  In my case, I was making a standalone program that did it all in one
program and I messed up in the ordering of the close() and the LOOP_CLR_FD.

  I'm pretty sure that (with my small 10K test dataset) the I/O between
the loopback device and the looped file was never hitting the disk.
If I LOOP_CLR_FD before I closed, I ended up with bad data in the looped
file and kernel errors syslogged:

	kernel: attempt to access beyond end of device
	kernel: 07:00: rw=1, want=1, limit=0
	kernel: dev 07:00 blksize=0 blocknr=0 sector=0 size=1024 count=1

  I tended to get 10 of those, one for each of the 10 1K blocks in
my test dataset.

  Doing the close() then the LOOP_CLR_FD got rid of the errors.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
