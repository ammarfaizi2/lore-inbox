Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbUKWEuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbUKWEuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 23:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbUKWEuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 23:50:03 -0500
Received: from [61.49.148.118] ([61.49.148.118]:54771 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S262184AbUKWESn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 23:18:43 -0500
Date: Mon, 22 Nov 2004 20:08:43 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411230408.iAN48hj03268@adam.yggdrasil.com>
To: maneesh@in.ibm.com
Subject: Re: [Patch] Delete sysfs_dirent.s_count, saving ~100kB on my system
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004 16:53:09 -0600, Maneesh Soni wrote:
>There can be open files (live dentries) but files getting removed.

	I think you're right.  I did have a problem with the
test that you suggested.  I think I may be able to accomodate
the problem though.

	I had not realized that file->f_dentry will keep the dentry
around even after the file has been removed, at which point
file->f_dentry->d_fsdata will point to garbage rather than a
valid sysfs_direntry.  This is a problem in fs/sysfs/file.c
where sysfs_read_file calls fill_read_buffer, which calls to_attr,
which tries to read sysfs_direnty->s_element.

	I believe I can avoid the need for any of the IO routines
to access sysfs_direntry->s_element by having create_file()
put a copy in inode->u.generic_ip.  If it works, I will send
you an updated patch.  However, it may be a day before I can
do it.

>IMO,
>without having ref count for sysfs_dirent, we could end up loosing the
>sysfs_dirent and end up in inconsistent sysfs_dirent tree with respect to
>dentry tree.

	I believe that, with the patch I posted, the sysfs_dirent
is still removed from the list of the parent directory's children
at exactly the same times as before.

[...]
>I will also test the patch tonight.

	No need.  I hope to have an updated patch for you soon though.
Thanks for the quick and detailed response.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
