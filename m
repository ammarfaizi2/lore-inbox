Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266118AbRGDRxC>; Wed, 4 Jul 2001 13:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266119AbRGDRwv>; Wed, 4 Jul 2001 13:52:51 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:18299 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266118AbRGDRwt>; Wed, 4 Jul 2001 13:52:49 -0400
Date: Wed, 4 Jul 2001 18:52:30 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: O_DIRECT! or O_DIRECT?
Message-ID: <20010704185230.F28793@redhat.com>
In-Reply-To: <E15HWsV-0000lM-00@f12.port.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15HWsV-0000lM-00@f12.port.ru>; from _deepfire@mail.ru on Wed, Jul 04, 2001 at 12:34:35AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 04, 2001 at 12:34:35AM +0400, Samium Gromoff wrote:
> 
>         This is interesting, because one real advantage
>     of O_DIRECT are these greased weasel fast 15-20 Mb/s
>     file copies, which ones makes windoze users to look
>     on us as on lesser beings.

Not true.

O_DIRECT does not speed up sequential file accesses.  If anything, it
may well slow them down, especially for writes.  What O_DIRECT does is
twofold --- it guarantees physical IO to the disk (so that you know
for sure that the data is on disk for writes, or that the data on disk
is readable for reads); and it avoids the memory and CPU overhead of
keeping any cached copy of the data.

But because O_DIRECT is completely synchronous, it's not possible for
the kernel to implement its normal readahead and writebehind IO
clustering for direct IO.  If you use the normal approach of writing
4k at a time to an O_DIRECT file, things may well be *massively*
slower than usual because the kernel is sending individual 4k IOs to
the disk, and because it is waiting for each IO to complete before the
application provides the next one.

On the contrary, buffered writes allow the kernel to batch those 4k
writes into large disk IOs, perhaps 100k or more; and the kernel can
maintain a queue of more than one such IO, so that once the first IO
completes the next one is immediately ready to be sent out.

For these reasons, buffered IO is often faster than O_DIRECT for pure
sequential access.  The downside it its greater CPU cost and the fact
that it pollutes the cache (which, in turn, causes even _more_ CPU
overhead when the VM is forced to start reclaiming old cache data to
make room for new blocks.)

O_DIRECT is great for cases like multimedia (where you want to
maximise CPU available to the application and where you know in
advance that the data is unlikely to fit in cache) and databases
(where the application is caching things already and extra copies in
memory are just a waste of memory).  It is not an automatic win for
all applications.

Cheers,
 Stephen
