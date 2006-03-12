Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWCLRBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWCLRBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWCLRBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:01:09 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:10636 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751569AbWCLRBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:01:07 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sun, 12 Mar 2006 17:00:51 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Christoph Hellwig <hch@lst.de>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: truncate and {m,c}time on ntfs
In-Reply-To: <Pine.LNX.4.64.0603121641380.29271@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603121651360.29271@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603121641380.29271@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2006, Anton Altaparmakov wrote:
> Hi Christoph,
> 
> A patch of yours modified fs/ntfs/inode.c::ntfs_truncate() and inserted 
> this comment:
> 
> [snip]
> 	/* normally ->truncate shouldn't update ctime or mtime,
> 	 * but ntfs did before so it got a copy & paste version
> 	 * of file_update_time.  one day someone should fix this
> 	 * for real.
> 	 */
> [snip]
> 
> Did you realise that all (local) file systems in Linux kernel set both 
> {m,c}time in their ->truncate function.  E.g. from 
> fs/ext3.c/inode.c::ext3_truncate():
> 
> inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
> 
> Would you be so kind to explain what is your problem with ntfs doing it, 
> too?  And if your statement is correct and no file system should touch 
> {m,c}time in their ->truncate() method, could you explain to me how the 
> {m,c}time would be set otherwise when open(O_TRUNC) or {f,}truncate() is 
> executed on a file?

Sorry, I know how open(O_TRUNC) sets it as it calls do_truncate(,, 
ATTR_MTIME|ATTR_CTIME,) but at present both {f,}truncate() call 
do_truncate(,, 0,) and I do not see anywhere else where the setting 
would/could be done, other than in the file system ->truncate method.

In fact if I take the setting of {m,c}time out of ntfs_truncate(), doing:

touch
stat foo
truncate foo 10
stat foo

Does not result in a change in the {m,c}time...

Given posix/sus3 requires setting of {m,c}time on truncate, it would 
appear that a file system ->truncate function needs to set {m,c}time 
itself...

Please explain why you added your comment to ntfs...

Thanks a lot in advance.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
