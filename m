Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUAPAws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 19:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUAPAws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 19:52:48 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:58244 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S264361AbUAPAwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 19:52:45 -0500
Date: Fri, 16 Jan 2004 01:52:41 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: Slow NFS performance [was: over wireless!]
Message-ID: <20040116005241.GE594@drinkel.cistron.nl>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange> <200401130155.32894.hackeron@dsl.pipex.com> <1074025508.1987.10.camel@lumiere> <1074026758.4524.65.camel@nidelv.trondhjem.org> <bu4pd6$anf$1@news.cistron.nl> <1074134135.1522.52.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1074134135.1522.52.camel@nidelv.trondhjem.org> (from trond.myklebust@fys.uio.no on Thu, Jan 15, 2004 at 03:35:35 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004 03:35:35, Trond Myklebust wrote:
> På on , 14/01/2004 klokka 20:12, skreiv Miquel van Smoorenburg:
> > On an NFS client (2.6.1-mm3, filesystem mounted with options
> > udp,nfsvers=3,rsize=32768,wsize=32768) I get for the same share as
> > write/rewrite/read speeds 36 / 4 / 38 MB/sec. CPU load is also
> > very high on the client for the rewrite case (80%).
> > 
> > That's with back-to-back GigE, full duplex, MTU 9000, P IV 3.0 Ghz.
> > (I tried MTU 5000 and 1500 as well, doesn't really matter).
> > 
> > Is that what would be expected ?
> 
> Err.. no...
> 
> I didn't have a 2.6.1-mm3 machine ready to go in our GigE testbed (I'm
> busy compiling one up right now). However I did run a quick test on
> 2.6.0-test11. Iozone rather than bonnie, but the results should be
> comparable:

Hmm OK. After the readahead fixes, my read speeds have increased
dramatically. Write speed is still slower than on local disk (30-40
MB/sec over NFS vs 80-100 MB/sec locally) but that might be a problem
with the 3ware driver, I'm looking at it. Or is it expected that NFS
writes are slower over the net (yes, I'm using fsync() at the end
both locally and remote) ?

Anyway, the bonnie rewrite case is still slow. It's something else than
the iozone rewrite, because that is pretty fast. From the README:

  Rewrite. Each BUFSIZ of the file is read with read(2), dirtied, and
  rewritten with write(2), requiring an lseek(2). Since no space
  allocation is done, and the I/O is well-localized, this should test the
  effectiveness of the filesystem cache and the speed of data transfer.

I created a 1 GB ext2 image on ramdisk on the NFS server and exported
that to the client, then ran bonnie++ on the client:

# bonnie++ -u root:root -f -n 0 -r 256
Using uid:0, gid:0.
Writing intelligently...done
Rewriting...done
Reading intelligently...done
start 'em...done...done...done...
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
meghan         512M           118985  30  5173  99           294404  25 +++++ +++

The client has 512 MB RAM, and bonnie uses files of 2*RAM, but that wouldn't
fit on the 1 GB ramdisk so I told bonnie "I have 256 MB of ram (-r 256),
that's why the sequential input numbers are a bit skewed.

I'm not sure if this operation is supposed to be that slow, but if you
want something to hack on during the weekend, install bonnie++ and see
why its rewrite test is so slow over NFS ;) Note the 99% CPU ..

Oh, the rewrite test is also slow on local filesystems, I get about
25% of sequential write speed locally.

Mike.
