Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbQKUNuQ>; Tue, 21 Nov 2000 08:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbQKUNuG>; Tue, 21 Nov 2000 08:50:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:43740 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129745AbQKUNuE>;
	Tue, 21 Nov 2000 08:50:04 -0500
Date: Tue, 21 Nov 2000 08:20:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Kara <jack@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Umount & quotas
In-Reply-To: <20001121134459.E2457@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0011210748460.754-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Nov 2000, Jan Kara wrote:

>   Hello.
> 
>   After rewrite of umount checks some time ago (just now reading your mail
> I realized I never asked) filesystem doesn't umount when quotas are
> turned on on it - it fails on check (atomic_read(&mnt->mnt_count) > 2)
> in do_umount().
>   Is this intended behaviour? If so, we can remove later DQUOT_OFF() call
> and maybe make somewhere a note about changed behaviour otherwise we should fix
> it...

Oh, fsck...
--- fs/super.c     Thu Nov  2 22:38:59 2000
+++ fs/super.c.new Tue Nov 21 11:36:05 2000
@@ -1037,13 +1037,13 @@
        }

        spin_lock(&dcache_lock);
-       if (atomic_read(&mnt->mnt_count) > 2) {
-               spin_unlock(&dcache_lock);
-               mntput(mnt);
-               return -EBUSY;
-       }

        if (mnt->mnt_instances.next != mnt->mnt_instances.prev) {
+               if (atomic_read(&mnt->mnt_count) > 2) {
+                       spin_unlock(&dcache_lock);
+                       mntput(mnt);
+                       return -EBUSY;
+               }
                if (sb->s_type->fs_flags & FS_SINGLE)
                        put_filesystem(sb->s_type);
                /* We hold two references, so mntput() is safe */

Not ideal, but not worse than the variant before the fs/super.c rewrite.
And yes, that's what was intended to be there. Said that, removing the
automagical DQUOT_OFF completely looks like a good idea. If there is no
serious reason to keep it in the kernel I would prefer to move it to
userland. We already have to do quota-related stuff if umount(2) fails...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
