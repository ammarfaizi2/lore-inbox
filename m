Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130650AbRADT1m>; Thu, 4 Jan 2001 14:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131593AbRADT1X>; Thu, 4 Jan 2001 14:27:23 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:38405 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130650AbRADT1L>; Thu, 4 Jan 2001 14:27:11 -0500
Date: Thu, 04 Jan 2001 14:27:11 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsync on unmounting root
Message-ID: <126800000.978636431@tiny>
In-Reply-To: <Pine.GSO.4.21.0101041354530.20875-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, January 04, 2001 01:58:47 PM -0500 Alexander Viro
<viro@math.psu.edu> wrote:
> On Thu, 4 Jan 2001, Chris Mason wrote:
> 
>> Looks like the prerelease, and at least test13 don't fsync the device
>> when someone does an unmount on /
>> 
>> mount -o remount works, just unmounting the root misses the fsync.
>> [snip]
> 
> I have a better suggestion: 
> 
>         if (mnt == current->fs->rootmnt && !umount_root) {
>                 mntput(mnt);
>		 return do_remount("/", 0, NULL);
>	 }
> 

Ok, but I thought we would need an MS_RDONLY in there somewhere...How about
this:

-chris

--- linux/fs/super.c.1	Thu Jan  4 13:38:55 2001
+++ linux/fs/super.c	Thu Jan  4 14:14:04 2001
@@ -54,6 +54,7 @@
 extern int root_mountflags;
 
 static int do_remount_sb(struct super_block *sb, int flags, char * data);
+static int do_remount(const char *dir, int flags, char * data);
 
 /* this is initialized in init/main.c */
 kdev_t ROOT_DEV;
@@ -1025,15 +1026,12 @@
 	 * call reboot(9). Then init(8) could umount root and exec /reboot.
 	 */
 	if (mnt == current->fs->rootmnt && !umount_root) {
-		int retval = 0;
 		/*
 		 * Special case for "unmounting" root ...
 		 * we just try to remount it readonly.
 		 */
 		mntput(mnt);
-		if (!(sb->s_flags & MS_RDONLY)) 
-			retval = do_remount_sb(sb, MS_RDONLY, 0);
-		return retval;
+		return do_remount("/", MS_RDONLY, NULL);
 	}
 
 	spin_lock(&dcache_lock);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
