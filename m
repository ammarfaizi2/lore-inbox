Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbULWRDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbULWRDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 12:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULWRDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 12:03:05 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:7102 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261267AbULWRC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 12:02:57 -0500
Date: Thu, 23 Dec 2004 12:02:57 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Andries.Brouwer@cwi.nl
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix /etc/mtab updating with mount --move (was Re: [OT] util-linux 2.12p and a new maintainer)
Message-ID: <20041223170257.GA25295@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Andries.Brouwer@cwi.nl, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <200412230302.iBN32e229867@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412230302.iBN32e229867@apps.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 04:02:40AM +0100, Andries.Brouwer@cwi.nl wrote:
> Just released util-linux 2.12p.
> Find it the usual places, such as
> ftp://ftp.win.tue.nl/pub/linux-local/utils/util-linux
> 
> I am happy to announce that Adrian Bunk is willing to
> take over maintenance of util-linux.
 
Andries & Adrian,

Back in February I had sent the patch at the following URL against
util-linux-2.12pre to util-linux@math.uoi.no, but it was never applied.
[Perhaps it was never received.]

http://groups-beta.google.com/group/linux.kernel/browse_frm/thread/2ab78ad70d79508c/de0cfbb377bc6a94?q=insubject:Fix+insubject:%2Fetc%2Fmtab+insubject:updating+insubject:with+insubject:mount

The executive summary is that the sequence

	mkdir /tmp/a /tmp/b
	mount -t ramfs none /tmp/a
	mount --move /tmp/a /tmp/b

has the intended effect (according to /proc/mounts),
but corrupts /etc/mtab, which looks like:

	none /tmp/a ramfs rw 0 0
	/tmp/a /tmp/b none rw 0 0

i.e., as if we'd done --bind instead of --move.
The correct entry should be:

	none /tmp/b ramfs rw 0 0

The bug is still in 2.12p; a rediffed patch is appended.
Sorry for not following up earlier.

Regards,

	Bill Rugolsky


--- util-linux-2.12p/mount/fstab.c.mountmove	2004-12-21 14:09:24.000000000 -0500
+++ util-linux-2.12p/mount/fstab.c	2004-12-23 11:20:52.726564776 -0500
@@ -604,8 +604,12 @@
 				free(mc);
 			}
 		} else {
-			/* A remount */
+			/* A remount or move */
 			mc->m.mnt_opts = instead->mnt_opts;
+			if (!streq(mc->m.mnt_dir, instead->mnt_dir)) {
+				free(mc->m.mnt_dir);
+				mc->m.mnt_dir = xstrdup(instead->mnt_dir);
+			}
 		}
 	} else if (instead) {
 		/* not found, add a new entry */
--- util-linux-2.12p/mount/mount.c.mountmove	2004-12-21 17:00:36.000000000 -0500
+++ util-linux-2.12p/mount/mount.c	2004-12-23 11:20:52.729564320 -0500
@@ -660,7 +660,9 @@
 		print_one (&mnt);
 
 	if (!nomtab && mtab_is_writable()) {
-		if (flags & MS_REMOUNT)
+	if (flags & MS_MOVE)
+		update_mtab (mnt.mnt_fsname, &mnt);
+	else if (flags & MS_REMOUNT)
 			update_mtab (mnt.mnt_dir, &mnt);
 		else {
 			mntFILE *mfp;
