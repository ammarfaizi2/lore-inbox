Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVJDKbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVJDKbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 06:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVJDKbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 06:31:31 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:12245 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932202AbVJDKba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 06:31:30 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: [PATCH 2.6] Do not set ATTR_CTIME in do_truncate(). - was: Re:
	truncate(2) sometimes updates ctime and sometimes ctime and mtime!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <1128095994.3584.12.camel@imp.csi.cam.ac.uk>
References: <1128092687.5715.12.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.64.0509300823160.3378@g5.osdl.org>
	 <1128095994.3584.12.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Tue, 04 Oct 2005 11:31:19 +0100
Message-Id: <1128421880.3785.0.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a (tested) patch to remove the setting of ATTR_CTIME in
do_truncate() as you suggested.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

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
> > Hmm.. That looks wrong, partly because I don't think it should even set 
> > ATTR_CTIME _either_. However, I don't see any recent changes to that code, 
> > so it must have been logn for a long time. That line in do_truncate() has 
> > been like that since at _least_ 2002.

Having gone through looking at ext2/3 and having made ntfs_truncate()
behave the same way as ext2/3_truncate() wrt m/ctime, I now agree with
you.  do_truncate() should only set ATTR_SIZE, not ATTR_CTIME.  The file
system will set ATTR_CTIME and ATTR_MTIME anyway so it's a waste for the
attribute to also set ATTR_CTIME.  That way it happens twice.

Below is a patch to remove it...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

diff --git a/fs/open.c b/fs/open.c
--- a/fs/open.c
+++ b/fs/open.c
@@ -204,7 +204,7 @@ int do_truncate(struct dentry *dentry, l
 		return -EINVAL;
 
 	newattrs.ia_size = length;
-	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
+	newattrs.ia_valid = ATTR_SIZE;
 
 	down(&dentry->d_inode->i_sem);
 	err = notify_change(dentry, &newattrs);


