Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269807AbRHQIDE>; Fri, 17 Aug 2001 04:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269849AbRHQIC4>; Fri, 17 Aug 2001 04:02:56 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:22518 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269807AbRHQICq>; Fri, 17 Aug 2001 04:02:46 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 17 Aug 2001 02:02:41 -0600
To: Enver Haase <ehaase@inf.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 not NULLing deleted files?
Message-ID: <20010817020241.C32617@turbolinux.com>
Mail-Followup-To: Enver Haase <ehaase@inf.fu-berlin.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01081709381000.08800@haneman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01081709381000.08800@haneman>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2001  09:38 +0200, Enver Haase wrote:
> "The Other OS" in its professional version does of course clear the deleted 
> blocks with 0's for security reasons; I would have bet a thousand bucks Linux 
> would do so, too [seems I should have read the source code, good thing no-one 
> wanted to take on the bet :) ].
> 
> So how to go about this? With that feature wanted, which fs should one choose 
> under Linux? Is there a patch for ext2 for that feature? Am I the only one 
> liking the idea?

While there is an ext2 file attribute which sets "secure deletion" on a
per-file basis, it has never been implemented in the kernel.  Several
reasons for this:

1) Deleting a file really securely takes more than just a single write
   of zeros to the disk.
2) It would be a huge performance hit to overwrite a file the 15? or so
   times (some random, some patterned data) to really securely delete a
   file.
3) This is easily implemented in user-space, either by aliasing "rm" to
   a new function, or actually putting in your own "rm" binary which
   checks for the "S" attribute on ext2 files, and overwrites properly
   it if it a file only has a single link.  Then people can implement a
   level of security they are comfortable with for their particular needs.
4) Anything that really needs to be secure should not be stored in an
   insecure manner to begin with.  It should only be written to disk
   in encrypted form (see (a) and (b) above for why), and you also need
   something like tmpfs + encrypted swap so that you don't get unencrypted
   copies written to disk by mistake. Reasons for this are manyfold.
   With enough money and technology it is nearly impossible to really
   "delete" anything that was written to disk.  If it gets written on
   another part of the disk, you also have to scrub that (think /tmp or
   swap for editing documents).  If you make any backups of the disk,
   you need to scrub the tapes for every deletion (while keeping copies
   of all your other documents), very hard.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

