Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262679AbSKDTuP>; Mon, 4 Nov 2002 14:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbSKDTuO>; Mon, 4 Nov 2002 14:50:14 -0500
Received: from mhost.enel.ucalgary.ca ([136.159.102.8]:1423 "EHLO
	mhost.enel.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262679AbSKDTuL>; Mon, 4 Nov 2002 14:50:11 -0500
Date: Mon, 4 Nov 2002 12:56:29 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Tomas Szepe <szepe@pinerecords.com>,
       Alexander Zarochentcev <zam@Namesys.COM>,
       Hans Reiser <reiser@Namesys.COM>, lkml <linux-kernel@vger.kernel.org>,
       Oleg Drokin <green@Namesys.COM>, umka <umka@Namesys.COM>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Message-ID: <20021104125629.A13158@munet-d.enel.ucalgary.ca>
Mail-Followup-To: Nikita Danilov <Nikita@Namesys.COM>,
	Tomas Szepe <szepe@pinerecords.com>,
	Alexander Zarochentcev <zam@Namesys.COM>,
	Hans Reiser <reiser@Namesys.COM>,
	lkml <linux-kernel@vger.kernel.org>,
	Oleg Drokin <green@Namesys.COM>, umka <umka@Namesys.COM>
References: <200210312334.18146.Dieter.Nuetzel@hamburg.de> <3DC1B2FA.8010809@namesys.com> <3DC1D63A.CCAD78EF@digeo.com> <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com> <3DC1DF02.7060307@namesys.com> <20021101102327.GA26306@louise.pinerecords.com> <15810.46998.714820.519167@crimson.namesys.com> <20021102132421.GJ28803@louise.pinerecords.com> <15814.21309.758207.21416@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15814.21309.758207.21416@laputa.namesys.com>; from Nikita@Namesys.COM on Mon, Nov 04, 2002 at 02:00:13PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 04, 2002  14:00 +0300, Nikita Danilov wrote:
>  > Jup, this fixes the leak, but free space still isn't reported accurately
>  > until after sync gets called, which I believe is a bug too.
> 
> In reiser4 allocation of disk space is delayed to transaction commit. It
> is not possible to estimate precisely amount of disk space that will be
> allocated during commit, and hence statfs(2) results are not updated
> until one does sync(2) (forcing commit) or transaction is committed due
> to age (10 minutes by default).

I find this more than a bit frightening, and it could obviously be a
huge source of reiser4's dramatic performance improvements - nothing is
being written to disk until long after a benchmark is complete (provided
you have enough RAM) if it isn't explicitly syncing before completing
the test (benchmarks like dbench and iozone don't necessarily sync).

Even more importantly, people losing 10 minutes of work is pretty
unacceptable, IMHO.  The default flush interval is 30 seconds for a
reason, and in realistic scenarios files don't grow over a 10 minute
period, and even if they do you would want to start flushing that to
disk long before you have a few GB of outstanding changes.  Also, this
would be a real source of problems (as I previously read was hinted at
in another reiser4 email) with filesystem full conditions.

At the very least, you need to reserve blocks in the filesystem for writes
that are under delayed allocation.  Overestimating space requirements
(i.e. reserve a full block for each file, regardless of whether it will be
packed in the future or not) is far preferrable to underestimating and
running out of space after a write which already "completed" suddenly
finding itself out of space.  If you get close to filling the filesystem,
then you can always flush the transaction to disk to "solidify your
estimates" before returning a needless ENOSPC.  This will also make your
"statfs" space reporting fairly consistent, because you will return the
"reserved" stats even if they are only slightly off.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
