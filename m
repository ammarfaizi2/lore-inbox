Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVATTDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVATTDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVATS7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:59:48 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:29713 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261383AbVATS5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:57:00 -0500
Message-Id: <200501201856.j0KIuiif016865@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Tridgell <tridge@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fix ea-in-inode default ACL creation 
In-Reply-To: Your message of "Thu, 20 Jan 2005 19:22:25 +0100."
             <1106245344.15959.13.camel@winden.suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <1106245344.15959.13.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106247403_12559P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Jan 2005 13:56:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106247403_12559P
Content-Type: text/plain; charset=us-ascii

On Thu, 20 Jan 2005 19:22:25 +0100, Andreas Gruenbacher said:

> When a new inode is created, ext3_new_inode sets the EXT3_STATE_NEW
> flag, which tells ext3_do_update_inode to zero out the inode before
> filling in the inode's data. When a file is created in a directory with
> a default acl, the new inode inherits the directory's default acl; this
> generates attributes. The attributes are created before
> ext3_do_update_inode is called to write out the inode. In case of
> in-inode attributes, the new inode's attributes are written, and then
> zeroed out again by ext3_do_update_inode. Bad thing.
> 
> Fix this by recognizing the EXT3_STATE_NEW case in
> ext3_xattr_set_handle, and zeroing out the inode there already when
> necessary.
> 
> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
> 
> Index: linux-2.6.11-latest/fs/ext3/xattr.c
> ===================================================================
> --- linux-2.6.11-latest.orig/fs/ext3/xattr.c
> +++ linux-2.6.11-latest/fs/ext3/xattr.c
> @@ -954,6 +954,13 @@ ext3_xattr_set_handle(handle_t *handle, 
>  	error = ext3_get_inode_loc(inode, &is.iloc);
>  	if (error)
>  		goto cleanup;
> +
> +	if (EXT3_I(inode)->i_state & EXT3_STATE_NEW) {
> +		struct ext3_inode *raw_inode = ext3_raw_inode(&is.iloc);
> +		memset(raw_inode, 0, EXT3_SB(inode->i_sb)->s_inode_size);
> +		EXT3_I(inode)->i_state &= ~EXT3_STATE_NEW;
> +	}
> +
>  	error = ext3_xattr_ibody_find(inode, &i, &is);
>  	if (error)
>  		goto cleanup;

Maybe I'm a total idiot, but I'm failing to see how adding *another* zero
operation (although quite likely needed at that point) is going to help the
fact that we zero something out after we've stored data we want to keep in it.
Is there a missing hunk that *removes* the too-late memset-to-zero in
ext3_do_update_inode?


--==_Exmh_1106247403_12559P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB7/7rcC3lWbTT17ARAqB2AJ9gHWMcp6DkX+sINTBdmR2Unu8wjwCfS/Sn
sM7CpPe0wtbNmblXwVE97Ok=
=Xyv2
-----END PGP SIGNATURE-----

--==_Exmh_1106247403_12559P--
