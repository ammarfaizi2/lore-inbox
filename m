Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVLCOen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVLCOen (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 09:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVLCOen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 09:34:43 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:3011 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751266AbVLCOem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 09:34:42 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sat, 3 Dec 2005 14:34:39 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jeffm@suse.com,
       torvalds@osdl.org
Subject: Re: [PATCH] fs: remove s_old_blocksize from struct super_block
In-Reply-To: <1133609645.7989.3.camel@localhost>
Message-ID: <Pine.LNX.4.64.0512031429360.11664@hermes-1.csi.cam.ac.uk>
References: <1133558437.31065.6.camel@localhost> 
 <Pine.LNX.4.64.0512031058350.11664@hermes-1.csi.cam.ac.uk>
 <1133609645.7989.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 3 Dec 2005, Pekka Enberg wrote:
> On Fri, 2 Dec 2005, Pekka Enberg wrote:
> > > The s_old_blocksize field of struct super_block is only used as a temporary
> > > variable in get_sb_bdev(). This patch changes the function to use a local
> > > variable instead so we can kill the field from struct super_block.
> 
> On Sat, 2005-12-03 at 11:02 +0000, Anton Altaparmakov wrote:
> > s_old_blocksize used to be used to restore the blocksize after the 
> > filesystem had failed to mount or had unmounted.  Not restoring this leads 
> > to all sorts of problems since the blocksize may be set for example to 4k 
> > but some userspace app may need it to be set to 1k or whatever.  There 
> > used to be applications that failed which is why s_old_blocksize was 
> > introduced and it used to restore the blocksize.
> > 
> > I have no idea why/when the restoring has been removed but chances are the 
> > removal was wrong.  Now every file system will need to restore the 
> > blocksize itself (as it used to be before s_old_blocksize and blocksize 
> > restoral was introduced).  Except whoever removed the restoration failed 
> > to fix up all file systems.  )-:
> 
> It was removed in this commit, I think:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commit;h=294c42046966e927ef86c0d4ce71cff32d9b458c

Yes, it certainly was removed there.  Thanks for finding the commit.  That 
had gone past me unnoticed.

This means we are now back to the old behaviour where fs utilities will 
behave randomly/unpredictably depending on what fs was mounted (or even 
was tried to be mounted!) on the device last.  So for example a failing 
"mount -t auto" will leave the block size set to a random number when all 
fs utilities (at least used to) asume the block size is 1k and strangeness 
ensues.

I have no idea why Jeff (Mahoney) considered the setting to be 
unnecessary, when Al Viro added the resetting code a few years ago it 
was done precisely because utilities were behaving randomly/erratically...

IMHO the above commit consitutes a regression in 2.6 kernel.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
