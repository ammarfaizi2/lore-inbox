Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTEFJwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTEFJwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:52:16 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:6395 "HELO
	vaxjo.synopsys.com") by vger.kernel.org with SMTP id S262429AbTEFJwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:52:15 -0400
Date: Tue, 6 May 2003 12:04:35 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, Eric Lammerts <eric@lammerts.org>
Subject: Fwd: allow rename to "--bind"-mounted filesystem
Message-ID: <20030506100435.GH890@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i just came over this patch, and wondered why is it missing
in both 2.4 and 2.5 (the code in do_rename is identical in both
kernels).

Are such renames really not allowed, or was it just fixed differently?

-alex

----- Forwarded message from Eric Lammerts <eric@lammerts.org> -----

Date: 	Sun, 19 Jan 2003 00:34:59 +0100
Subject: [PATCH] allow rename to "--bind"-mounted filesystem 
From: Eric Lammerts <eric@lammerts.org>
To: linux-kernel@vger.kernel.org
Message-ID: <20030118233459.GA18011@ally.lammerts.org>
X-Mailing-List: 	linux-kernel@vger.kernel.org


Hi,
I just discovered that rename(2) does not allow you to rename a file within
the same filesystem if there is a "--bind" in the way. For example:

# mkdir mydir
# mount --bind . mydir
# touch myfile
# strace -erename perl -e 'rename "myfile", "mydir/myfile2"'
rename("myfile", "mydir/myfile2") = -1 EXDEV (Invalid cross-device link)

IMHO it should be possible to do a rename in this situation.

I propose to remove the check in do_rename() altogether. It shouldn't be
necessary, since there's also a check for a cross-device rename in
vfs_rename_dir() and vfs_rename_other().

Patch below has been tested.

Eric


--- linux-2.4.21-pre3/fs/namei.c.orig	2003-01-18 23:56:46.000000000 +0100
+++ linux-2.4.21-pre3/fs/namei.c	2003-01-18 23:57:30.000000000 +0100
@@ -1860,10 +1860,6 @@
 	if (error)
 		goto exit1;
 
-	error = -EXDEV;
-	if (oldnd.mnt != newnd.mnt)
-		goto exit2;
-
 	old_dir = oldnd.dentry;
 	error = -EBUSY;
 	if (oldnd.last_type != LAST_NORM)
