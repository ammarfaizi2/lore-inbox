Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129990AbQK1Mcm>; Tue, 28 Nov 2000 07:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130210AbQK1Mcd>; Tue, 28 Nov 2000 07:32:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43794 "EHLO
        atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
        id <S129990AbQK1Mc1>; Tue, 28 Nov 2000 07:32:27 -0500
Date: Tue, 28 Nov 2000 13:02:51 +0100
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Umount & quotas
Message-ID: <20001128130250.A32733@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

  After rewrite on umount code automagical turning of
quotas off stopped working - filesystem was considered
busy.
  I would restore the behaviour in 2.4 and probably
in 2.5 move this to userland together with other quota
changes...
  Following patch (written by Al Viro) should restore
the behaviour.

					Honza

--- fs/super.c     Thu Nov  2 22:38:59 2000
+++ fs/super.c     Tue Nov 21 11:36:05 2000
@@ -1037,13 +1037,13 @@
	}

	spin_lock(&dcache_lock);
-	if (atomic_read(&mnt->mnt_count) > 2) {
-		spin_unlock(&dcache_lock);
-		mntput(mnt);
-		return -EBUSY;
-	}

	if (mnt->mnt_instances.next != mnt->mnt_instances.prev) {
+		if (atomic_read(&mnt->mnt_count) > 2) {
+			spin_unlock(&dcache_lock);
+			mntput(mnt);
+			return -EBUSY;
+		}
		if (sb->s_type->fs_flags & FS_SINGLE)
			put_filesystem(sb->s_type);
		/* We hold two references, so mntput() is safe */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
