Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUFBLow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUFBLow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 07:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUFBLow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 07:44:52 -0400
Received: from mivlgu.ru ([81.18.140.87]:5851 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S262008AbUFBLoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 07:44:19 -0400
Date: Wed, 2 Jun 2004 15:44:11 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Paul Serice <paul@serice.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iso9660 Inodes Anywhere and NFS
Message-Id: <20040602154411.0032d0f5.vsu@altlinux.ru>
In-Reply-To: <40BD2841.2050509@serice.net>
References: <40BD2841.2050509@serice.net>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__2_Jun_2004_15_44_11_+0400_DIbJYKCOWmft=oC2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__2_Jun_2004_15_44_11_+0400_DIbJYKCOWmft=oC2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 01 Jun 2004 20:07:13 -0500 Paul Serice wrote:

> This is my fourth attempt to patch the isofs code.  It is similar to
> the last posting except this one implements the NFS get_parent()
> method which has always been missing.
> 
> The original problem I set out to addresses is that the current
> iso9660 file system cannot reach inodes located beyond the 4GB
> barrier.  This is caused by using the inode number as the byte offset
> of the inode data.  Being 32-bits wide, the inode number is unable to
> reach inode data that does not reside on the first 4GB of the file
> system.
> 
> This causes real problems with "growisofs"
> 
>      http://fy.chalmers.se/~appro/linux/DVD+RW/#isofs4gb
> 
> and my pet project "shunt"
> 
>      http://www.serice.net/shunt/
> 
> This patch switches the isofs code from iget() to iget5_locked() which
> allows extra data to be passed into isofs_read_inode() so that inode
> data anywhere on the disk can be reached.
> 
> The inode number scheme was also changed.  Continuing to use the byte
> offset would have resulted in non-unique inodes in many common
> situations, but because the inode number no longer plays any role in
> reading the meta-data off the disk, I was free to set the inode number
> to some unique characteristic of the file.  I have chosen to use the
> block offset which is also 32-bits wide.
> 
> Lastly, the pre-patch code uses the default export_operations to
> handle accessing the file system through NFS.  The problem with this
> is that the default NFS operations assume that iget() works which is
> no longer the case because of the necessity of switching to
> iget5_locked().  So, I had to implement the NFS operations too.  As a
> bonus, I went ahead and implemented the NFS get_parent() method which
> has always been missing.
> 
> Thanks,
> Paul Serice

> diff -uprN -X dontdiff linux-2.6.7-rc2/fs/isofs/export.c linux-2.6.7-rc2-isofs.3/fs/isofs/export.c
> --- linux-2.6.7-rc2/fs/isofs/export.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.7-rc2-isofs.3/fs/isofs/export.c	2004-06-01 15:42:51.000000000 -0500
...
> +/* The .get_parent method should be added, but .get_parent has never
> + * been implemented in the isofs code.  So, its absence will not be
> + * sorely missed. */

Obviously this comment is stale.

> diff -uprN -X dontdiff linux-2.6.7-rc2/fs/isofs/inode.c linux-2.6.7-rc2-isofs.3/fs/isofs/inode.c
> --- linux-2.6.7-rc2/fs/isofs/inode.c	2004-05-31 03:53:07.000000000 -0500
> +++ linux-2.6.7-rc2-isofs.3/fs/isofs/inode.c	2004-06-01 16:39:10.000000000 -0500
> @@ -740,17 +728,14 @@ root_found:
>  	   
>  	/* RDE: data zone now byte offset! */

This comment is now wrong too.

> -	first_data_zone = ((isonum_733 (rootp->extent) +
> -			  isonum_711 (rootp->ext_attr_length))
> -			 << sbi->s_log_zone_size);
> +	first_data_zone = isonum_733 (rootp->extent) +
> +			  isonum_711 (rootp->ext_attr_length);
>  	sbi->s_firstdatazone = first_data_zone;

--Signature=_Wed__2_Jun_2004_15_44_11_+0400_DIbJYKCOWmft=oC2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAvb2OW82GfkQfsqIRAi9+AJ9/zzIX/009KubylLbHW0ddfbWr9wCffNYI
s9ihlkJnECCAoeEPa2QSFKM=
=kyTp
-----END PGP SIGNATURE-----

--Signature=_Wed__2_Jun_2004_15_44_11_+0400_DIbJYKCOWmft=oC2--
