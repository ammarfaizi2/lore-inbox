Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbVI3QAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbVI3QAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbVI3QAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:00:05 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:8142 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030348AbVI3QAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:00:00 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: truncate(2) sometimes updates ctime and sometimes ctime and
	mtime!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0509300823160.3378@g5.osdl.org>
References: <1128092687.5715.12.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.64.0509300823160.3378@g5.osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 30 Sep 2005 16:59:53 +0100
Message-Id: <1128095994.3584.12.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 08:36 -0700, Linus Torvalds wrote:
> On Fri, 30 Sep 2005, Anton Altaparmakov wrote:
> > There is an inconsistency in the way truncate works which was introduced
> > (relatively) recently.
> > 
> > fs/open.c::sys_truncate
> >   -> do_sys_truncate
> >     -> do_truncate does:
> > 
> >         newattrs.ia_size = length;
> >         newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
> > 
> >         down(&dentry->d_inode->i_sem);
> >         err = notify_change(dentry, &newattrs);
> >         up(&dentry->d_inode->i_sem);
> > 
> > This changes the ctime only.
> 
> Hmm.. That looks wrong, partly because I don't think it should even set 
> ATTR_CTIME _either_. However, I don't see any recent changes to that code, 
> so it must have been logn for a long time. That line in do_truncate() has 
> been like that since at _least_ 2002.

Indeed.  What _has_ changed recently is that IIRC do_truncate used to
set ATTR_SIZE | ATTR_CTIME | ATTR_MTIME at which point the two were
consistent.  But (relatively) recently someone removed the ATTR_MTIME
from do_truncate and forgot to remove it from inode_setattr...

> So what changed to make you notice?

I have finished coding the initial cut of ntfs_truncate() (regular files
only, i.e. uncompressed, unencrypted, and
not-attribute-list-attribute-containing).  (-:

Now I am at the testing it stage and I was doing:

$ stat ntfs/file
$ truncate ntfs/file <someval>
$ stat ntfs/file

And noticed that the ctime was chaning but not the mtime so I read the
man page which suggested mtime ought to change so I had a quick look at
relevant kernel code and the inconsistency stared me in the face.  (-;

> The _code_ actually expects the low-level filesystem to just do it when it 
> does the actual truncate itself. That's certainly what ext3 does, for 
> example.

Ah, I thought the VFS took care of _all_ {a,c,m} time changes and we
filesystem developers only ever had to write the changed times to
disk...

Obviously I was wrong...

I will have a look at ext2/3.

> A comment or two to that effect might be useful, though.

Indeed, it would be useful for unsuspecting fs developers like me.  (-;

> In other words: some attributes are "implicit". For example, mtime is 
> supposed to be set automatically by the filesystem whenever it sees a 
> write. The VFS layer will _not_ do a "inode state notify" event for that.

Right.  I seem to remember this being different some time ago.  IIRC the
kernel did update {a,m,c}time in many places...

> The same is true of truncation.
> 
> But I agree that it's inconsistent. Anybody have any deep opinions?

I certainly don't.  It just should be consistent.  (-:

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

