Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUIGOTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUIGOTu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIGOTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:19:50 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:21986 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268080AbUIGOTp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:19:45 -0400
Subject: Re: [PATCH 4/4] copyfile: copyfile
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Steve French <smfltc@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de>
	 <20040907121118.GA27297@wohnheim.fh-wedel.de>
	 <20040907121235.GB27297@wohnheim.fh-wedel.de>
	 <20040907121520.GC27297@wohnheim.fh-wedel.de>
	 <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org>
Content-Type: text/plain; charset=UTF-8
Organization: University of Cambridge Computing Service, UK
Message-Id: <1094566775.25420.13.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Sep 2004 15:19:36 +0100
Content-Transfer-Encoding: 8BIT
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 15:06, Linus Torvalds wrote:
> On Tue, 7 Sep 2004, Jörn Engel wrote:
> >
> > Again, the syscall itself may be a stupid idea, but Steve indicated
> > interest for cifs.  I'll hide behind his back and let him fight for
> > it. ;)
> 
> Well, this isn't useful for cifs.
> 
> For cifs to be able to use it, the "copyfile()" interface needs to
> basically just be a pathname operation (ie a "dir->i_op->copy()"), not a
> "struct file" operation.  It's more like the VFS "->rename()" or "->link"
> operations, in other words. And it should return -EXDEV the same way
> rename returns EXDEV if the files aren't on the same filesystem.

Indeed.  A pathname based operation would be useful for any fs with
"added features".  For example, on NTFS it could be used to preserve
named streams and extended attributes which would otherwise be lost. 
Mind you, the current NTFS driver cannot create files yet so it will be
a while until such a "copyfile()" is useful there...

> Then you could (and should) make a "generic_file_copy()" function that
> takes that pathname format, and then uses sendfile() to do the copy for
> regular disk-based filesystems.
> 
> I think you should be able to copy the "sys_link()" code for almost all of 
> the top-level stuff. The only real difference being
> 
> -	error = dir->i_op->link(old_dentry, dir, new_dentry);
> +	error = dir->i_op->copy(old_dentry, dir, new_dentry);
> 
> or something.
> 
> And no, I don't know how to handle interruptability. I think the right
> answer may be that filesystems that don't support this as a "native op"  
> and can't do it quickly should just return an error, and then users can
> copy their multi-gigabyte files by hand, like they used to.
> 
> So if we do this, we do this _right_. We also make sure that we error out 
> "too much" rather than "too little", so that people don't start depending 
> on behaviour that we don't want them to depend on. 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

