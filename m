Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264371AbSIQQuG>; Tue, 17 Sep 2002 12:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264380AbSIQQuG>; Tue, 17 Sep 2002 12:50:06 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:5363 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264371AbSIQQuE>; Tue, 17 Sep 2002 12:50:04 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 17 Sep 2002 10:53:00 -0600
To: Simon Kirby <sim@netnation.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 throughput woes on certain (possibly heavily fragmented) files
Message-ID: <20020917165300.GB11665@clusterfs.com>
Mail-Followup-To: Simon Kirby <sim@netnation.com>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
References: <20020903092419.GA5643@vitelus.com> <20020906170614.A7946@redhat.com> <15736.57972.202889.872554@laputa.namesys.com> <20020906182457.F3029@redhat.com> <20020916223911.GA1658@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020916223911.GA1658@netnation.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 16, 2002  15:39 -0700, Simon Kirby wrote:
> We recently switched a large mail spool from ext2 to ext3 with default
> journalling, and we are now having huge problems with disk I/O load.
> 
> We have fsync and friends disabled for performance reasons.  With ext2,
> the machine would happily hum along with an average load of 0.2 and a
> usual 400 kB - 800 kB write every 5 seconds, with about 10 kB/sec read in
> every second.
> 
> This box is primarily running a POP3 server (written in-house to cache
> mbox offsets, so that it can handle a huge volume of mail), and also
> exports the mail spool via NFS to other servers which run exim (-fsync). 
> nfsd is exported async.  Everything is mounted noatime, nodiratime.  No
> applications should be calling sync/fsync/fdatasync or using O_SYNC. 
> It's a mail server, so everything is fragmented.

Hmm, it seems strange (and rather unsafe) that you would run a mail
spool without using sync I/O.  Unfortunate too, because sync I/O with
a large journal (and perhaps an external journal disk) would give you
very fast throughput on ext3.

> We're using dotlocking.  Would this cause metadata journalling?
> I estimate about 200 - 300 dotlock files are created per second, but
> these should all be asynchronous. 

Lots of it.  So, that is 250 * (1 dir block + 1 inode bitmap + 1 inode
table block (+ 1 block bitmap + 1 data block, if there is data in the
dotlock file)) = 1250 blocks/second or so.

> Would switching to fctnl() locking (if this works over NFS) solve the
> problem?

Probably (no disk I/O generated), but I don't know the state of NFS locking.

> We had to hash the mail spool a long time ago do to system time eating all
> CPU (the ext2 linear directory scan to find a slot available in the spool
> directory to add the dotlock file).

One reason why we are adding hash-indexed directory support to ext3, so
that you don't have to implement it in each application.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

