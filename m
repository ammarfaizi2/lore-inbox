Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUAVRsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 12:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266294AbUAVRsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 12:48:50 -0500
Received: from sandershosting.com ([69.26.136.138]:59619 "HELO
	sandershosting.com") by vger.kernel.org with SMTP id S266293AbUAVRsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 12:48:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: David Sanders <linux@sandersweb.net>
Reply-To: David Sanders <linux@sandersweb.net>
Organization: SandersWeb.net
Message-Id: <200401221241.44393@sandersweb.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH-BK-2.6] NTFS fix "du" and "stat" output (NTFS 2.1.6).
Date: Thu, 22 Jan 2004 12:48:20 -0500
X-Mailer: KMail [version 1.3.2]
References: <Pine.SOL.4.58.0401191413180.7391@yellow.csi.cam.ac.uk> <200401211318.53776@sandersweb.net> <1074763252.16782.25.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1074763252.16782.25.camel@imp.csi.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 January 2004 04:20 am, you wrote:
> On Wed, 2004-01-21 at 18:24, David Sanders wrote:
> > On Monday 19 January 2004 09:15 am, Anton Altaparmakov wrote:
> > > This fixes the erroneous "du" and "stat" output people reported
> > > on ntfs partitions containing compressed directories.
> >
> > Thanks for the quick patch.  There are still problems with the
> > reported disk usage.
>
> No there are not.  It is a feature, not a bug.  (-:  I will explain
> below...
>
> > I use as an example the file win.ini.  With the 2.4.24
> > kernel I get the following results:
> > $ ls -l win.ini
> > -r--r-----    1 root     staff         399 Jan 27  2003 win.ini
> >
> > $ stat win.ini
> >   File: "win.ini"
> >   Size: 399       	Blocks: 2          IO Block: 1024   Regular File
> > Device: 305h/773d	Inode: 1023        Links: 1
> > Access: (0440/-r--r-----)  Uid: (    0/    root)   Gid: (   50/  
> > staff) Access: Thu Jan 15 15:34:09 2004
> > Modify: Mon Jan 27 18:54:00 2003
> > Change: Sun Sep 22 07:23:44 2002
> >
> > $ du -h win.ini
> > 1.0k	win.ini
>
> This is wrong.  The file size is 399 bytes,  and knowing from my own
> systems, win.ini is a resident file (which is consistent with the
> small size).  This means the file doesn't occupy any disk blocks at
> all.  All the data is stored inside the on-disk inode itself (that is
> the MFT record in NTFS speak).
>
> Further, the table of inodes (the system file $MFT) already has its
> own size (do "ls -l \$MFT" or "du \$MFT" in the main NTFS directory
> and you will see it together with its size).
>
> The size of the inode itself (1024 bytes) is already accounted for in
> the size of the $MFT system file (the table of inodes).
>
> Since the 399 bytes of win.ini are part of those 1024 bytes we would
> be counting them twice if we were to give them in the "Blocks:" field
> of stat, which is what "du" uses to calculate sizes.
>
> So by returning the above "Blocks: 2", the old NTFS driver (which is
> what you used by using an unpatched 2.4.24 kernel), du will actually
> tell you that you are using more space than you are as it would count
> 2 Blocks from win.ini and then the same 2 Blocks from $MFT which
> clearly
>
> is silly.  (-:
> > But, under the 2.6.1 kernel:
> > $ ls -l win.ini
> > -r-xr-x---    1 root     staff         399 Jan 27  2003 win.ini
> >
> > $ stat win.ini
> >   File: "win.ini"
> >   Size: 399       	Blocks: 0          IO Block: 4096   Regular File
> > Device: 305h/773d	Inode: 1023        Links: 1
> > Access: (0550/-r-xr-x---)  Uid: (    0/    root)   Gid: (   50/  
> > staff) Access: Thu Jan 15 15:34:09 2004
> > Modify: Mon Jan 27 18:54:00 2003
> > Change: Mon Jan 27 18:54:00 2003
>
> Correct.  No disk blocks are occupied as explained above.
>
> > $ du -h win.ini
> > 0	win.ini
>
> That is correct.  To quote from the man page for "du":
>
> 	"Summarize disk usage of each FILE"
>
> It is "disk usage" not "file size" and the file "win.ini" does not
> use any disk space as explained above.
>
> > Now, surely the 2.4.24 kernel is reporting the more accurate disk
> > usage since with 2.6.1 it reports 0 blocks (vice 2).
>
> Nope.  Sometimes things are not what they seem.  (-:
>
> Hope this clears the confusion up.
>
> Best regards,
>
> 	Anton
Yes, I think that clears it up in my mind, but I think the output of du 
is a little misleading to the uninitiated.

Thanks, David
-- 
David Sanders
linux@sandersweb.net
