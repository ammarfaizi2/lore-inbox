Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266339AbRGTAjB>; Thu, 19 Jul 2001 20:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbRGTAim>; Thu, 19 Jul 2001 20:38:42 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:8245 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S266339AbRGTAig>;
	Thu, 19 Jul 2001 20:38:36 -0400
From: Tad Dolphay <tbd@sgi.com>
Message-Id: <200107200038.TAA40153@fsgi158.americas.sgi.com>
Subject: Re: Busy inodes after umount
To: mjacob@feral.com
Date: Thu, 19 Jul 2001 19:38:15 -0500 (CDT)
Cc: xfs@ragnark.vestdata.no (=?iso-8859-1?Q?Ragnar_Kj=F8rstad?=),
        chip.christian@storageapps.com (Christian Chip), linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010719165758.D50024-100000@wonky.feral.com> from "Matthew Jacob" at Jul 19, 2001 04:58:36 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I know there was a fix for a "Busy inodes after unmount" problem in
2.4.6-pre3. Here's an excerpt from a posting to the NFS mailing list
from Neil Brown:

-------------Included message-----------------------
  Previously anonymous dentries were hashed (though with no name, the
  hash was pretty meaningless).  This meant that they would hang around
  after the last reference was dropped.  This was actually fairly
  pointless as they would never get referenced again, and caused a real
  problem as umount wouldn't discard them and so you got the message
                printk("VFS: Busy inodes after unmount. "
                        "Self-destruct in 5 seconds.  Have a nice day...\n");

  In 2.4.6-pre3 I stopped hashing those dentries so now when the last
  reference is dropped, the dentry is freed.  So now there will never be
  more anonymous dentries than there are active nfsd threads.
---------------end included message-------------------

Tad

> 
> I reported this a couple of months back. It's reassuring to know that it's a
> consistent problem.
> 
> On Fri, 20 Jul 2001, [iso-8859-1] Ragnar Kjørstad wrote:
> 
> > On Thu, Jul 19, 2001 at 04:22:07PM -0400, Christian, Chip wrote:
> > > I found the same thing happening.  Tracked it down in our case to using fdisk to re-read disk size before mounting.  Replaced it with "blockdev --readpt" and the problem seems to have gone away.  YMMV.
> >
> > I've now been able to reproduce:
> >
> > * make a filesystem
> > * mount it
> > * export it (nfs)
> > * mount on remote machine
> > * lock file (fcntl)
> > * unexport
> > * unmount
> >
> > Then you get the VFS message about self-destruct. Tested with both ext2
> > and xfs.
> >
> > The lock is still present in /proc/locks after the umount.
> >
> > With ext2 I can remount the filesystem successfully, but with XFS I get
> > the message about duplicate UUIDs and the mount failes. I believe this is a totally
> > different problem from the one you were experiencing. (and blockdev doesn't help for me)
> >
> > I suppose this is a generic kernel bug?
> >
> >
> >
> 

