Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266847AbUFYTU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266847AbUFYTU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266852AbUFYTU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:20:28 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:27358 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S266847AbUFYTTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:19:41 -0400
Date: Fri, 25 Jun 2004 21:19:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Alexander Nyberg <alexn@telia.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] A generic_file_sendpage()
Message-ID: <20040625191924.GA8656@wohnheim.fh-wedel.de>
References: <20040608154438.GK18083@dualathlon.random> <20040608193621.GA12780@holomorphy.com> <1086783559.1194.24.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1086783559.1194.24.camel@boxen>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 14:19:19 +0200, Alexander Nyberg wrote:
> 
> The sendfile() for all file systems remain unusable as it is right now,
> only works for sending data to socket. But that should be as much performance
> enhancing as this yes?
> 
> Please hit me with cluebat for what I'm missing.
> (yes, rebooted between all copying)

A similar patch I've once written gave about 10% performance boost
with warm caches.  Your measurements are with could caches but still
give a noticeable boost.  Nice.

> --- include/linux/fs_orig.h     2004-06-09 00:37:29.000000000 +0200
> +++ include/linux/fs.h  2004-06-07 18:13:54.000000000 +0200
> @@ -1405,6 +1405,7 @@ extern ssize_t do_sync_write(struct file
>  ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
>                                 unsigned long nr_segs, loff_t *ppos);
>  extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void __user *);
> +extern ssize_t generic_file_sendpage(struct file *, struct page *, int, size_t, loff_t *, int);
>  extern void do_generic_mapping_read(struct address_space *mapping,
>                                     struct file_ra_state *, struct file *,
>                                     loff_t *, read_descriptor_t *, read_actor_t);
> --- mm/filemap_orig.c   2004-06-09 00:37:45.000000000 +0200
> +++ mm/filemap.c        2004-06-08 22:19:48.000000000 +0200
> @@ -961,7 +961,32 @@ generic_file_read(struct file *filp, cha
> 
>  EXPORT_SYMBOL(generic_file_read);
> 
> +ssize_t generic_file_sendpage(struct file *out_file, struct page *page,
> +                       int offset, size_t size, loff_t *pos, int more)
> +{
> +       void *addr;
> +       int ret;
> +       mm_segment_t old_fs;
> +
> +       old_fs = get_fs();
> +       set_fs(KERNEL_DS);
> +
> +       addr = kmap(page);
> +       if (!addr) {
> +               set_fs(old_fs);
> +               return -ENOMEM;
> +       }
> +
> +       ret = out_file->f_op->write(out_file, addr + offset, size, pos);
> +
> +       kunmap(addr);
> +
> +       set_fs(old_fs);
> +       return ret;
> +}

Your patch is *much* smaller than mine.  Looks lean and mean.  But you
depend on the struct file* passed to generic_file_sendpage().

One of my goals for 2.7 is to get rid of all users of struct file* in
the various read-, write- and send-functions.  Currently, there are
four of them, you would introduce number five.

Is is possible get around using out_file without making the patch much
bigger?

If you need a motivation for this, think cowlinks.  Copying inodes
would be trivial, if you didn't need a fscking file for every copy
operation.  If you actually open(), sendfile() and close(), you end up
with tons of possible errors and a nightmare of cleanup code.  Not
fun.

> --- fs/ext3/file_orig.c 2004-06-09 00:42:50.000000000 +0200
> +++ fs/ext3/file.c      2004-06-07 18:12:19.000000000 +0200
> @@ -129,6 +129,7 @@ struct file_operations ext3_file_operati
> +       .sendpage       = generic_file_sendpage,

Obviously also works for ext2.

Jörn

-- 
They laughed at Galileo.  They laughed at Copernicus.  They laughed at
Columbus. But remember, they also laughed at Bozo the Clown.
-- unknown
