Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289055AbSBDQGb>; Mon, 4 Feb 2002 11:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289054AbSBDQGV>; Mon, 4 Feb 2002 11:06:21 -0500
Received: from rj.sgi.com ([204.94.215.100]:13754 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289053AbSBDQGK>;
	Mon, 4 Feb 2002 11:06:10 -0500
Subject: Re: O_DIRECT fails in some kernel and FS
From: Steve Lord <lord@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Garzik <garzik@havoc.gtf.org>,
        Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <akpm@zip.com.au>, Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16XlK0-0007Wu-00@the-village.bc.nu>
In-Reply-To: <E16XlK0-0007Wu-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Feb 2002 10:02:26 -0600
Message-Id: <1012838546.26363.588.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-04 at 09:46, Alan Cox wrote:
> > If an application is multithreaded and is doing mmap and direct I/O
> > from different threads without doing its own synchronization, then it
> > is broken, there is no ordering guarantee provided by the kernel as
> > to what happens first.
> 
> Providing we don't allow asynchronous I/O with O_DIRECT once asynchronous
> I/O is merged.

But async I/O itself needs synchronisation (being English in this email ;-)
to be meaningful. If I issue a bunch of async I/O calls which overlap with
each other then the outcome is really undefined in terms of what ends up
on the disk. Scheduling of the actual I/O operations is really no different
from them being synchronous calls from different user space threads.

The only questions you can really ask is 'is read atomic with respect to
write?' and 'are writes atomic with respect to each other?'. So when you
perform a read it sees data from before or after writes, but never sees
data from half way through a write. And for multiple write calls the output
appears as if one write happened after the other, not intermingled
with each other.

Irix actually takes the viewpoint that it only needs to make a best effort
at synchronizing between direct I/O and other modes of I/O. Multiple
direct writers are allowed into a file at once, and direct writers and
buffered readers are also allowed to operate in parallel. At this point
coherency is really up to the applications. I am not presenting this as
a recommended model for linux, just reporting what it does.

> 
> Alan

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
