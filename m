Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVCVTmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVCVTmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVCVTmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:42:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:6356 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261750AbVCVTlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:41:14 -0500
Subject: Re: [CHECKER] writes not always synchronous on JFS with O_SYNC?
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: blp@cs.stanford.edu
Cc: JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, mc@cs.stanford.edu
In-Reply-To: <1111498992.8107.5.camel@localhost>
References: <87vf7kr9gs.fsf@benpfaff.org>
	 <1111498992.8107.5.camel@localhost>
Content-Type: multipart/mixed; boundary="=-YZm7d+qMS6rxRdb3QmFz"
Date: Tue, 22 Mar 2005 13:41:11 -0600
Message-Id: <1111520471.8082.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YZm7d+qMS6rxRdb3QmFz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-03-22 at 07:43 -0600, Dave Kleikamp wrote:
> On Mon, 2005-03-21 at 13:10 -0800, Ben Pfaff wrote:
> > Hi.  We've been running some tests on JFS and other file systems
> > and believe we've found an issue whereby O_SYNC does not always
> > cause data to be committed synchronously.  On Linux 2.6.11, we
> > found that the program appended below causes
> > /mnt/sbd0/0006/0010/0029/0033 to contain all zeros, despite the
> > use of O_SYNC on the write calls and the fsyncs on the
> > directories.  It seems to be pretty sensitive to the existence of
> > the rmdir calls: if I omit one of them, the data does get
> > written.

The problem is in the journal-replay code and it is triggered by the
reuse of a directory inode by a regular file inode, so reproducing the
bug requires the journal containing both changes to the inode as a
directory and then as a file.

This patch to jfs_fsck fixes the problem.  It wasn't really an issue
with O_SYNC at all, although I believe there are O_SYNC issues that need
to be resolved.  The data itself should be sync'd correctly, as
generic_file_write checks for the O_SYNC flag.  The missing piece in jfs
is that metadata changes to the inode may not always be making it to the
disk when they should.
-- 
David Kleikamp
IBM Linux Technology Center

--=-YZm7d+qMS6rxRdb3QmFz
Content-Disposition: attachment; filename=fsck-logredo.patch
Content-Type: text/x-patch; name=fsck-logredo.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: jfsutils/libfs/log_work.c
===================================================================
RCS file: /cvsroot/jfs/jfsutils/libfs/log_work.c,v
retrieving revision 1.21
diff -u -p -r1.21 log_work.c
--- jfsutils/libfs/log_work.c	15 Dec 2004 15:53:45 -0000	1.21
+++ jfsutils/libfs/log_work.c	22 Mar 2005 19:23:17 -0000
@@ -1,5 +1,5 @@
 /*
- *   Copyright (c) International Business Machines Corp., 2000-2002
+ *   Copyright (C) International Business Machines Corp., 2000-2005
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -2758,6 +2758,11 @@ int updatePage(struct lrd *ld, int32_t l
 						off += 1;
 						data += linesize;
 						seglen -= linesize;
+						/*
+						 * i_data overlaps btroot.
+						 * Strip of 32 bytes
+						 */
+						seglen -= 32;
 					} else if (db->db_idata & mask_8) {
 						/* Only update ibase */
 						db->db_ibase |= mask_8;
@@ -2766,6 +2771,11 @@ int updatePage(struct lrd *ld, int32_t l
 						/* update both */
 						db->db_ibase |= mask_8;
 						db->db_idata |= mask_8;
+						/*
+						 * i_data overlaps btroot.
+						 * Strip of 32 bytes
+						 */
+						seglen -= 32;
 					}
 				}
 			} else if (ino_rem == 1) {	/* inline data */

--=-YZm7d+qMS6rxRdb3QmFz--

