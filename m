Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbRGJSwq>; Tue, 10 Jul 2001 14:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267090AbRGJSwg>; Tue, 10 Jul 2001 14:52:36 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:61172 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267089AbRGJSw1>; Tue, 10 Jul 2001 14:52:27 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107101851.f6AIpTV2022429@webber.adilger.int>
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
In-Reply-To: <018101c1096a$17e2afc0$b6562341@cfl.rr.com> "from Mike Black at
 Jul 10, 2001 01:59:40 pm"
To: Mike Black <mblack@csihq.com>
Date: Tue, 10 Jul 2001 12:51:29 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black writes:
> Also, having it in files allows me to easily add more swap as needed.

But you usually have a base amount of swap, and only add more files as
needed, right?  Put the base swap into its own partition, and then only
put "extra" swap into files.

> As far as journalling mode I just used tune2fs to put a journal on with
> default parameters so I assume that's full journaling.

The default is metadata-only journaling mode, called ordered data mode.
This gives the best performance in many cases, and also prevents you
from getting garbage in new/modified files after a crash.  It does so
by forcing data writes to the disk before the metadata changes in the
journal are committed to the filesystem.  This is also good for performance
because you separate writes to the journal from writes to the fs to avoid
excess seeking.

There is full data journaling, which slows down all I/O by half, because
it writes everything once to the journal and then again to the filesystem.

There is also writeback journaling mode, which writes all data directly
to the disk whenever it can, independent of metadata writes to the journal
and filesystem.  This allows the possibility of bad data in files if a
change was added to the journal/fs but the data write did not make it to
disk.  This is the only mode that reiserfs can use right now, but Chris
Mason is working on getting ordered data mode to work as well.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
