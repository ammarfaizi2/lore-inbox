Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281191AbRKPAJY>; Thu, 15 Nov 2001 19:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281192AbRKPAJP>; Thu, 15 Nov 2001 19:09:15 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:59376 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281191AbRKPAJA>;
	Thu, 15 Nov 2001 19:09:00 -0500
Date: Thu, 15 Nov 2001 17:07:42 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115170742.W5739@lynx.no>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no> <20011115170628.J329@visi.net> <20011115162149.U5739@lynx.no> <20011115183858.N329@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011115183858.N329@visi.net>; from bcollins@debian.org on Thu, Nov 15, 2001 at 06:38:58PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  18:38 -0500, Ben Collins wrote:
> I wont say that I am absolutely 100% sure that ext3 was never tried on
> this filesystem. I am pretty certain, but I'm guessing it doesn't really
> make much difference at this point. Your scenario of the corruption
> makes sense. I'll see if I can test your patch at some point (but I most
> likely cannot).
> 
> Filesystem features:      has_journal filetype sparse_super
> ...
> Journal inode:            48

What I'm thinking happened here is at some point long ago (maybe before
the server was put into production, who knows) someone tested ext3 on
it.  When they were done, they deleted the .journal file (inode #48)
but e2fsck didn't clean up the superblock journal fields, and it went
unnoticed until now.

The other alternative is that you have some sort of random single-bit
data corruption going on (the journal inode is also a single bit set,
48 = 0x30, but a different bit than has_journal, = 0x0004).

In any case, with e2fsprogs 1.18 (and probably _only_ that version)
it doesn't complain about has_journal, but it also doesn't check if the
journal is bad and clean it up.  When you try to start with an ext3-aware
kernel, it conspires to corrupt inode 48 when it tries to unload the
journal, even when it knows the journal is bad.

What would be interesting to correlate is what inode 48 is (probably a
directory, or you wouldn't have noticed it at all), with the corruption
problems you are having while ext3 is loaded.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

