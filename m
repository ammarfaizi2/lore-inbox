Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317640AbSGOVNf>; Mon, 15 Jul 2002 17:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSGOVNe>; Mon, 15 Jul 2002 17:13:34 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:25341 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317640AbSGOVNc>; Mon, 15 Jul 2002 17:13:32 -0400
Date: Mon, 15 Jul 2002 15:14:48 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Sam Vilain <sam@vilain.net>
Cc: dax@gurulabs.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020715211448.GI442@clusterfs.com>
Mail-Followup-To: Sam Vilain <sam@vilain.net>, dax@gurulabs.com,
	linux-kernel@vger.kernel.org
References: <1026490866.5316.41.camel@thud> <1026679245.15054.9.camel@thud> <E17U1BD-0000m0-00@hofmann> <1026736251.13885.108.camel@irongate.swansea.linux.org.uk> <E17U4YE-0000TL-00@hofmann> <20020715160357.GD442@clusterfs.com> <E17U9x9-0001Dc-00@hofmann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17U9x9-0001Dc-00@hofmann>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 15, 2002  18:48 +0100, Sam Vilain wrote:
> Andreas Dilger <adilger@clusterfs.com> wrote:
> 
> > Amusingly, there IS directory hashing available for ext2 and ext3, and
> > it is just as fast as reiserfs hashed directories.  See:
> >    http://people.nl.linux.org/~phillips/htree/paper/htree.html
> 
> You learn something new every day.  So, with that in mind - what has
> reiserfs got that ext2 doesn't?
> 
>   - tail merging, giving much more efficient space usage for lots of small
>     files.

Well, there was a tail merging patch for ext2, but it has been dropped
for now.  In reality, any benchmarks with reiserfs (except the
very-small-files case) will run with tail packing disabled because it
kills performance.

>   - B*Tree allocation offering ``a 1/3rd reduction in internal
>     fragmentation in return for slightly more complicated insertions and
>     deletion algorithms'' (from the htree paper).
>   - online resizing in the main kernel (ext2 needs a patch -
>     http://ext2resize.sourceforge.net/).

Yes, I wrote it...

>   - Resizing does not require the use of `ext2prepare' run on the
>     filesystem while unmounted to resize over arbitrary boundaries.

That is coming this summer.  It will be part of some changes to support
"meta blockgroups", and the resizing comes for free at the same time.

>   - directory hashing in the main kernel

Probably will happen in 2.5, as Andrew is already testing htree support
for ext3.  It is also in the ext3 CVS tree for 2.4, so I wouldn't be
surprised if it shows up in 2.4 also.

> On the flipside, ext2 over reiserfs:
> 
>   - support for attributes without a patch or 2.4.19-pre4+ kernel
>   - support for filesystem quotas without a patch
>   - there is a `dump' command (but it's useless, because it hangs when you
>     run it on mounted filesystems - come on, who REALLY unmounts their
>     filesystems for a nightly dump?  You need a 3 way mirror to do it
>     while guaranteeing filesystem availability...)

Well, the dump can only be inconsistent for files that are being changed
during the dump itself.  As for hanging the system, that would be a bug
regardless of whether it was dump or "dd" reading from the block device.
A bug related to this was fixed, probably in 2.4.19-preX somewhere.

> I'd be very interested in seeing postmark results without the
> hierarchical directory structure (which an unpatched postfix doesn't
> support), with about 5000 mailboxes with and without the htree patch
> (or with the htree patch but without that directory indexed, if that
> is possible).

Let me know what you find.  It is possible to use an htree-patched
kernel and not have indexed directories - just don't mount with
"-o index".  Note that there is a data-corrupting bug somewhere in
the ext3 htree code, so I wouldn't suggest using indexed directories
except for test.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

