Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVJJWZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVJJWZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVJJWZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 18:25:57 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:31122 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751288AbVJJWZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 18:25:56 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 10 Oct 2005 23:25:48 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk>
References: <20051010204517.GA30867@br.ibm.com>
 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
 <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2005, Mikulas Patocka wrote:
> On Mon, 10 Oct 2005, Glauber de Oliveira Costa wrote:
> > On Mon, Oct 10, 2005 at 10:20:07PM +0100, Anton Altaparmakov wrote:
> > > On Mon, 10 Oct 2005, Glauber de Oliveira Costa wrote:
> > > > I've just noticed that the use of sb_getblk differs between locations
> > > > inside the kernel. To be precise, in some locations there are tests
> > > > against its return value, and in some places there are not.
> > > > 
> > > > According to the comments in __getblk definition, the tests are not
> > > > necessary, as the function always return a buffer_head (maybe a wrong
> > > > one),
> > > 
> > > If you had read the source code rather than just the comments you would
> > > have seen that this is not true.  It can return NULL (see
> > > fs/buffer.c::__getblk_slow()).  Certainly I would prefer to keep the
> > > checks in NTFS, please.  They may only be good for catching bugs but I
> > > like catching bugs rather than segfaulting due to a NULL dereference.
> 
> The check should be rather a BUG() than dump_stack() and return NULL --- I
> think it's not right to write code to recover from programming errors.

Why programming errors?  It could be faulty memory or other corruption, 
perhaps even caused by a different driver altogether (e.g. I found a bug 
in ntfs last week which caused it to memset() to zero a random location in 
memory of a random size and it caused a lot of strange effects like my 
shell suddenly exiting and me being left on the login prompt...).  Also it 
could be that the function one day changes and it can return NULL.  It is 
far safer to do checking than to make assumptions about not being able to 
return NULL.

> Filesystem drivers are supposed to pass correct blocksize to getblk(). ---
> even for users it's better to crash, because user whose machine has locked up
> on BUG() will report bug more likely than user whose machine has written stack
> dump into log and corrupted filesystem --- by the time he discovers the
> corruption and mesage he might not even remember what triggered it.
> 
> As comment in buffer.c says, getblk will deadlock if the machine is out of
> memory. It is questionable whether to deadlock or return NULL and corrupt
> filesystem in this case --- deadlock is probably better.

What do you mean corrupt filesystem?  If a filesystem is written so badly 
that it will cause corruption when a NULL is returned somewhere, I 
certainly don't want to have anything to do with it.

Going BUG() is generally a bad thing if the error can be recovered from.  
Certainly all my code attempts to recover from all error conditions it can 
possibly encounter.

I would much rather see NULL and then handle the error gracefully with an 
error message than go BUG().  You can then still umount and remove the fs 
module and everything works fine (you may need an fsck you may not depends 
on how good your error handling is).  If you do a BUG() you are guaranteed 
to cause corruption...  I only use BUG() when something really cannot 
happen unless there is a bug in which case I want to know it...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
