Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUAVKeY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUAVKeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:34:23 -0500
Received: from snow.csi.cam.ac.uk ([131.111.8.15]:38568 "EHLO
	snow.csi.cam.ac.uk") by vger.kernel.org with ESMTP id S266221AbUAVKcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:32:43 -0500
Subject: Re: [PATCH-BK-2.6] NTFS fix "du" and "stat" output (NTFS 2.1.6).
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: David Sanders <linux@sandersweb.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       ntfsdev <linux-ntfs-dev@lists.sourceforge.net>
In-Reply-To: <200401211434.04749@sandersweb.net>
References: <Pine.SOL.4.58.0401191413180.7391@yellow.csi.cam.ac.uk>
	 <200401211318.53776@sandersweb.net>  <200401211434.04749@sandersweb.net>
Content-Type: text/plain
Organization: University of Cambridge
Message-Id: <1074767578.16782.57.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 10:32:59 +0000
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 19:38, David Sanders wrote:
[snip]
> I thought perhaps stat -f output would be usefull:
> From WINNT 4.0
> stat -f win.ini
>   File: "win.ini"
>     ID:        1078931058   (    404F2E72) Namelen:          255 Type: 
> NTFS
> Blocks: Total:    8385866 Free:    3808839 Available:    3808839 Size: 
> 512
> Inodes: Total:    8385866 Free:    3808839

Now _that_ is complete and utter garbage!  At an inode size of 1024
bytes you physically cannot fit 8385866 inodes into that volume and I am
sure there aren't that many inodes...  And the number of free inodes
quoted is garbage, too as you could not add that many inodes as you
would run out of space half way through.  Whoever wrote "stat" from
Windows was smocking crack...  Or alternatively they failed to read the
man page for statfs on a Unix/Linux system and had no clue as to what
the fields mean...

> From 2.4.24 kernel:
>   File: "win.ini"
>     ID: 0        0        Namelen: 255     Type: ntfs
> Blocks: Total: 8385866    Free: 3808930    Available: 3808930    Size: 
> 512
> Inodes: Total: 40642      Free: 0

That sounds a lot more sane.  Thought the free inodes output is just
seto to zero as is the ID.

> From 2.6.1 kernel:
>   File: "win.ini"
>     ID: 404f2e72 90404f42 Namelen: 255     Type: ntfs
> Blocks: Total: 1048233    Free: 476116     Available: 476116     Size: 
> 4096
> Inodes: Total: 40642      Free: 95        

This is the most sensible output, quoting the correct ID, the blocks count
is about the same as the output from the other stat runs as the block size
is 8 times bigger hence the number of blocks is 8 times smaller, and the
inodes count is sensible.  Where as the old driver simply returns 0 the new
driver returns how much space is left free inside the $MFT at its present
size.  So even if you had run out of disk space you could still create up
to 95 inodes on the volume before needing to free up space (as long as there
was space in the directory indices for them and as long as they were very
small so their data would be stored in the inode).

The free inodes count is still not quite right as $MFT can be extended
(until you run out of space or you hit 2^48 inodes) so the number of inodes
that could potentially be created is equal to = 95 + (the current free space
in bytes) / 1024 in the above example but more realistically you will not
be able to create that many because files will take up space on disk,
directories will do, too, etc, so the actual value will be somewhere in
between.  So when I wrote the new driver I decided to use the number of
unused inodes in the current $MFT, which in this case is 95, as the most
sensible output and just take the free inodes count to mean "at least so
many inodes can be created".

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/


