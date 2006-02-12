Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWBLTV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWBLTV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWBLTV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:21:28 -0500
Received: from master.altlinux.org ([62.118.250.235]:60428 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751426AbWBLTV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:21:27 -0500
Date: Sun, 12 Feb 2006 22:21:15 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Bernd Schubert <bernd-schubert@gmx.de>, Chris Wright <chrisw@sous-sol.org>,
       John M Flinchbaugh <john@hjsoft.com>, reiserfs-list@namesys.com,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 Bug? New security model?
Message-ID: <20060212192115.GB8544@procyon.home>
References: <200602080212.27896.bernd-schubert@gmx.de> <200602081314.59639.bernd-schubert@gmx.de> <20060208205033.GB22771@shell0.pdx.osdl.net> <200602082246.15613.bernd-schubert@gmx.de> <20060208221124.GN30803@sorel.sous-sol.org> <20060212005541.107f7011.vsu@altlinux.ru> <20060212175740.GB8805@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <20060212175740.GB8805@locomotive.unixthugs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 12, 2006 at 12:57:40PM -0500, Jeff Mahoney wrote:
> diff -ruNpX dontdiff linux-2.6.15/fs/reiserfs/inode.c linux-2.6.15-reiserfs/fs/reiserfs/inode.c
> --- linux-2.6.15/fs/reiserfs/inode.c	2006-02-06 19:54:10.000000000 -0500
> +++ linux-2.6.15-reiserfs/fs/reiserfs/inode.c	2006-02-12 12:43:00.000000000 -0500
> @@ -1195,6 +1195,7 @@ static void init_inode(struct inode *ino
>  		/* nopack is initially zero for v1 objects. For v2 objects,
>  		   nopack is initialised from sd_attrs */
>  		REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
> +		REISERFS_I(inode)->i_attrs = 0;

This part of the patch works fine for my test case - no more bogus
attributes, even when mounting with the "attrs" option.

>  	} else {
>  		// new stat data found, but object may have old items
>  		// (directories and symlinks)
> diff -ruNpX dontdiff linux-2.6.15/fs/reiserfs/super.c linux-2.6.15-reiserfs/fs/reiserfs/super.c
> --- linux-2.6.15/fs/reiserfs/super.c	2006-02-06 19:54:27.000000000 -0500
> +++ linux-2.6.15-reiserfs/fs/reiserfs/super.c	2006-02-12 12:48:41.000000000 -0500
> @@ -1121,7 +1121,9 @@ static void handle_attrs(struct super_bl
>  					 "reiserfs: cannot support attributes until flag is set in super-block");
>  			REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
>  		}
> -	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
> +	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared &&
> +	           get_inode_item_key_version(s->s_root->d_inode) == KEY_FORMAT_3_6) {
> +		/* Enable attrs by default on v3.6-native file systems */
>  		REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
>  	}
>  }

This part, however, does not work - apparently the condition is never
true, even on a freshly created 3.6-format filesystem:

# mkreiserfs --format 3.6 -f tmp2.img
# mount -t reiserfs -o loop tmp2.img /mnt/disk/
# lsattr -d /mnt/disk/
lsattr: Inappropriate ioctl for device While reading flags on /mnt/disk/


Apparently directories always have old key format, even on new
filesystems:

	if (old_format_only(sb) || S_ISDIR(mode) || S_ISLNK(mode))
		set_inode_item_key_version(inode, KEY_FORMAT_3_5);
	else
		set_inode_item_key_version(inode, KEY_FORMAT_3_6);

However, checking the stat data format works:

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index b33d67b..a2ea7ed 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -1195,6 +1195,7 @@ static void init_inode(struct inode *ino
 		/* nopack is initially zero for v1 objects. For v2 objects,
 		   nopack is initialised from sd_attrs */
 		REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
+		REISERFS_I(inode)->i_attrs = 0;
 	} else {
 		// new stat data found, but object may have old items
 		// (directories and symlinks)
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index ef5e541..acafe32 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1124,7 +1124,9 @@ static void handle_attrs(struct super_bl
 					 "reiserfs: cannot support attributes until flag is set in super-block");
 			REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
 		}
-	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
+	} else if ((le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) &&
+		(get_inode_sd_version(s->s_root->d_inode) == STAT_DATA_V2)) {
+		/* Enable attrs by default on v3.6-native file systems */
 		REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
 	}
 }

But this patch has another problem - it forces the "attrs" option on
for such filesystems, leaving no way to turn it off - the "noattrs"
option is ignored.  This does not look good.

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD74qrW82GfkQfsqIRAp0GAJ0eZzPd1Wu0AvZ9KepWkMHcT3RtUACfRHXD
WJLT1w8F2wMIoJ8CjA0k7Gw=
=SZhq
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
