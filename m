Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264506AbRFMDm0>; Tue, 12 Jun 2001 23:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264530AbRFMDmR>; Tue, 12 Jun 2001 23:42:17 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:12549 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S264506AbRFMDmI>; Tue, 12 Jun 2001 23:42:08 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Wed, 13 Jun 2001 13:41:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15142.57598.708971.905304@notabene.cse.unsw.edu.au>
Cc: John Covici <covici@ccs.covici.com>, linux-kernel@vger.kernel.org
Subject: Re: is there a way to export a fat32 file system using nfs?
In-Reply-To: message from Alexander Viro on Tuesday June 12
In-Reply-To: <15142.55093.846398.117560@notabene.cse.unsw.edu.au>
	<Pine.GSO.4.21.0106122304190.942-100000@weyl.math.psu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 12, viro@math.psu.edu wrote:
> 
> 
> On Wed, 13 Jun 2001, Neil Brown wrote:
> 
> >    Call fat_iget(i_location).
> >     If this finds something, check i_logstart. 
> >     If it matches, assume SUCCESS.
> > 
> >    Then comes the tricky bit:  read the directory entry
> >     indicated by i_location, check the i_logstart is right,
> >     if it is, try to get it into the inode cache properly.
> 
> Uh-huh. Suppose that directory had been removed and space had been
> reused by a regular file. Which had been filled with the right
> contents. It's really not hard to do. Now, remove that file and
> you've got a nice data corruption waiting to happen.

Told you it was tricky!!

Let's see now... We could also store the disc address of the start of
the directory in the filehandle.
Then we examine the FAT to see if the file starting at that block
looks like a directory, and contains the target directory entry.
If it does, we extract the ".." entry (do FAT directories have and
analogue of ".." entries?) and keep going up the tree until we find
the root, or we have tried too hard.

Once we hit the root we will have collected a full path name for the
file, so we just do lots of lookups to get it into the caches.

Ugh.

I might just do that first step (find_ino) and offer it as as an
experimental patch to the growing number of people who have asked for
nfs exporting of FAT filesystems, and see how reliable it is in
practice.

NeilBrown
