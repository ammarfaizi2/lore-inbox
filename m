Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKURnp>; Tue, 21 Nov 2000 12:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129426AbQKURnf>; Tue, 21 Nov 2000 12:43:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3333 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129208AbQKURnW>; Tue, 21 Nov 2000 12:43:22 -0500
Date: Tue, 21 Nov 2000 18:13:31 +0100
From: Jan Kara <jack@atrey.karlin.mff.cuni.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Umount & quotas
Message-ID: <20001121181331.D9762@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20001121134459.E2457@atrey.karlin.mff.cuni.cz> <Pine.GSO.4.21.0011210748460.754-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.GSO.4.21.0011210748460.754-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Nov 21, 2000 at 08:20:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

> --- fs/super.c     Thu Nov  2 22:38:59 2000
> +++ fs/super.c.new Tue Nov 21 11:36:05 2000
> @@ -1037,13 +1037,13 @@
>         }
> 
>         spin_lock(&dcache_lock);
> -       if (atomic_read(&mnt->mnt_count) > 2) {
> -               spin_unlock(&dcache_lock);
> -               mntput(mnt);
> -               return -EBUSY;
> -       }
> 
>         if (mnt->mnt_instances.next != mnt->mnt_instances.prev) {
> +               if (atomic_read(&mnt->mnt_count) > 2) {
> +                       spin_unlock(&dcache_lock);
> +                       mntput(mnt);
> +                       return -EBUSY;
> +               }
>                 if (sb->s_type->fs_flags & FS_SINGLE)
>                         put_filesystem(sb->s_type);
>                 /* We hold two references, so mntput() is safe */
> 
> Not ideal, but not worse than the variant before the fs/super.c rewrite.
> And yes, that's what was intended to be there. Said that, removing the
> automagical DQUOT_OFF completely looks like a good idea. If there is no
> serious reason to keep it in the kernel I would prefer to move it to
> userland. We already have to do quota-related stuff if umount(2) fails...
  I think the only problem is that some people may rely on this behaviour.
There isn't probably any other reason as races with quotaoff before
someone does write are there even if we do quotaoff in kernel.
And these races aren't probably worth the work with fixing...
  But I'm not sure whether we can just now stand up and say 'Umount doesn't
do quotaoff any more...'

							Honza
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
