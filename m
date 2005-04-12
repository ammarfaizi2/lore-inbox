Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVDLXo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVDLXo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbVDLXlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:41:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3429
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S263008AbVDLXjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:39:07 -0400
Date: Wed, 13 Apr 2005 01:40:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Eger <eger@havoc.gtf.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050412234005.GJ1521@opteron.random>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org> <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org> <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 02:21:58PM -0700, Linus Torvalds wrote:
> The full .git archive for 199 versions of the kernel (the 2.6.12-rc2 one
> and a test-run of 198 patches from Andrew) is 111MB. In other words,
> adding 198 "full" new kernels only grew the archive by 9MB (that's all
> "actual disk usage" btw - the files themselves are smaller, but since they
> all end up taking up a full disk block..)

reiserfs can do tail packing, plus the disk block is meaningless when
fetching the data from the network which is the real cost to worry about
when synchronizing and downloading (disk cost isn't a big deal).

The pagecache cost sounds a very minor one too, since you don't need
the whole data in ram, not even all dentries need to be in cache.  This
is one of the reasons why you don't need to run readdir, and why you can
discard the old trees anytime.

At the rate of 9M for every 198 changeset checkins, that means I'll have
to download 2.7G _uncompressible_ (i.e. already compressed with a bad
per-file ratio due the too-small files) for a whole pack including all
changesets without accounting the original 111MB of the original tree,
with rsync -z of git.  That compares with 514M _compressible_ with CVS
format on-disk, and with ~79M of the CVS-network download with rsync -z of
the CVS repository (assuming default gzip compression level).

What BKCVS provided with 79M of rsync -z, now is provided with 2.8G of
rsync -z, with a network-bound slowdown of -97.2%. Similar slowdowns
should be expected for synchronizations over time while fetching new
blobs etc...

Ok, BKCVS has less than 60000 checkins due the linearization and
coalescing of pulls that couldn't be represented losslessy in CVS, so
the network-bound slowdown is less than -97.2%, my math is
approximative, but the order of magnitude should remain the same.

Clearly one can write an ad-hoc network protocol instead of using
rsync/wget, but the server will need quite a bit of cpu and ram to do a
checkout/update/sync efficiently to unpack all data and create all
changesets to gzip and transfer.

Anyway git simplicity and immutable hashes robustness certainly makes it
an ideal interim format (and it may even be a very pratical local
live format on-disk, except for the backups), I'm only unsure if it's a
wise idea to build an SCM on top of the current git format or if it's
better to use something like SCCS or CVS to coalesce all diffs of a
single file together and to save space and make rsync -z very efficient
too (or an approach like arch and darcs that stores changesets per file,
i.e. patches).
