Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbTFMWBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 18:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265557AbTFMWBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 18:01:00 -0400
Received: from cox.ee.ed.ac.uk ([129.215.80.253]:23792 "EHLO
	postbox.ee.ed.ac.uk") by vger.kernel.org with ESMTP id S265552AbTFMWAl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 18:00:41 -0400
From: Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk>
Organization: The University of Edinburgh
To: Andrew Morton <akpm@digeo.com>, Andy Pfiffer <andyp@osdl.org>
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
Date: Fri, 13 Jun 2003 23:12:45 +0100
User-Agent: KMail/1.5.9
Cc: christophe@saout.de, adam@yggdrasil.com, linux-kernel@vger.kernel.org,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Max Valdez <maxvalde@fis.unam.mx>,
       Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net> <1055442331.1225.11.camel@andyp.pdx.osdl.net> <20030613010149.359cb4dd.akpm@digeo.com>
In-Reply-To: <20030613010149.359cb4dd.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200306132312.54493.Unai.Garro@ee.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I just got the time to checked. It works great, thanks! Where can I send this 
box of chocolates as gratitude? ;-)

On Friday 13 June 2003 09:01, Andrew Morton wrote:
> This should fix it.
>
>
>
> Once the blockdev inode for /dev/ram0 is dirtied we have a memory-backed
> inode on the blockdev superblock's s_dirty list.
>
> sync_sb_inodes() sees the memory-backed inode on the superblock and assumes
> that all the other inodes on the superblock are also memory-backed.  This
> is not true for the blockdev superblock!  We forget to write out dirty
> pages against the following blockdevs.
>
> Fix this by just leaving the inode dirty and moving on to inspect the other
> blockdev inodes on sb->s_io.
>
> (This is a little inefficient: an alternative is to leave dirtied
> memory-backed inodes on inode_in_use, so nobody ever even considers them
> for writeout.  But that introduces an inconsistency and is a bit kludgey).
>
>
>
>  fs/fs-writeback.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletion(-)
>
> diff -puN fs/fs-writeback.c~writeback-memory-backed-fix fs/fs-writeback.c
> --- 25/fs/fs-writeback.c~writeback-memory-backed-fix	2003-06-12
> 23:12:28.000000000 -0700 +++ 25-akpm/fs/fs-writeback.c	2003-06-12
> 23:14:07.000000000 -0700
> @@ -260,8 +260,21 @@ sync_sb_inodes(struct super_block *sb, s
>  		struct address_space *mapping = inode->i_mapping;
>  		struct backing_dev_info *bdi = mapping->backing_dev_info;
>
> -		if (bdi->memory_backed)
> +		if (bdi->memory_backed) {
> +			if (sb == blockdev_superblock) {
> +				/*
> +				 * Dirty memory-backed blockdev: the ramdisk
> +				 * driver does this.
> +				 */
> +				list_move(&inode->i_list, &sb->s_dirty);
> +				continue;
> +			}
> +			/*
> +			 * Assume that all inodes on this superblock are memory
> +			 * backed.  Skip the superblock.
> +			 */
>  			break;
> +		}
>
>  		if (wbc->nonblocking && bdi_write_congested(bdi)) {
>  			wbc->encountered_congestion = 1;
>
> _

- -- 
Coincidences are spiritual puns.
		-- G.K. Chesterton
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+6kxjhxDfDIoZlaURAsHrAKCRFnHCpzdBbtJ8C9vrY6P7T9+dYACgg+fL
XYizhhJD8KZ3bO4O/YzXr2c=
=Rwik
-----END PGP SIGNATURE-----
