Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131964AbRADSsc>; Thu, 4 Jan 2001 13:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131967AbRADSsO>; Thu, 4 Jan 2001 13:48:14 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:19717 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131086AbRADSsB>; Thu, 4 Jan 2001 13:48:01 -0500
Date: Thu, 04 Jan 2001 13:47:59 -0500
From: Chris Mason <mason@suse.com>
To: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] fsync on unmounting root
Message-ID: <99660000.978634079@tiny>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Looks like the prerelease, and at least test13 don't fsync the device when
someone does an unmount on /

mount -o remount works, just unmounting the root misses the fsync.

This patch works for me:

-chris

--- linux/fs/super.c.1	Thu Jan  4 13:38:55 2001
+++ linux/fs/super.c	Thu Jan  4 13:38:39 2001
@@ -1031,8 +1031,12 @@
 		 * we just try to remount it readonly.
 		 */
 		mntput(mnt);
-		if (!(sb->s_flags & MS_RDONLY)) 
+		if (!(sb->s_flags & MS_RDONLY)) {
+			shrink_dcache_sb(sb);
+			fsync_dev(sb->s_dev);
+			acct_auto_close(sb->s_dev);
 			retval = do_remount_sb(sb, MS_RDONLY, 0);
+		}
 		return retval;
 	}
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
