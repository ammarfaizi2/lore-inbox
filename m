Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282673AbRK0ADb>; Mon, 26 Nov 2001 19:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282678AbRK0ADW>; Mon, 26 Nov 2001 19:03:22 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:57340 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282673AbRK0ADS>;
	Mon, 26 Nov 2001 19:03:18 -0500
Date: Mon, 26 Nov 2001 16:59:20 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Rob Landley <landley@trommello.org>
Cc: Andre Hedrick <andre@linux-ide.org>, Chris Wedgwood <cw@f00f.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011126165920.N730@lynx.no>
Mail-Followup-To: Rob Landley <landley@trommello.org>,
	Andre Hedrick <andre@linux-ide.org>, Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <0111261535070J.02001@localhost.localdomain>; from landley@trommello.org on Mon, Nov 26, 2001 at 03:35:07PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 26, 2001  15:35 -0500, Rob Landley wrote:
> The drive should block when it's fed sectors living on more than 2 tracks.  
> Don't bother having the drive implement an elevator algorithm: the OS already 
> has one.  Just don't cache sectors living on more than 2 tracks at a time: 
> treat it as a "cache full" situation and BLOCK.

The other thing that concerns a journaling fs is write ordering.  If you
can _guarantee_ that an entire track (or whatever) can be written to disk
in _all_ cases, then it is OK to reorder write requests within that track
AS LONG AS YOU DON'T REORDER WRITES WHERE YOU SKIP BLOCKS THAT ARE NOT
GUARANTEED TO COMPLETE.

Generally, in Linux, ext3 will wait on all of the journal transaction
blocks to be written before it writes a commit record, which is its way
of guaranteeing that everything before the commit is valid.  If you start
write cacheing the transaction blocks, return, and then write the commit
record to disk before the other transaction blocks are written, this is
SEVERELY BROKEN.  If it was guaranteed that the commit record would hit
the platters at the same time as the other journal transaction blocks,
that would be the minimum acceptable behaviour.

Obviously a working TCQ or write barrier would also allow you to optimize
all writes before the commit block is written, but that should be an
_enhancement_ above the basic write operations, only available if you
start using this feature.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

