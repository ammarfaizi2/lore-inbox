Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbUKVPAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUKVPAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUKVO65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:58:57 -0500
Received: from [61.51.204.161] ([61.51.204.161]:40958 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S261463AbUKVO6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:58:12 -0500
Date: Mon, 22 Nov 2004 22:54:01 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411221454.iAMEs1t02247@freya.yggdrasil.com>
To: gjwucherpfennig@gmx.net, greg@kroah.com
Subject: Re: Kernel thoughts of a Linux user
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>        Please correct me if I am wrong, but, as far as I can tell,
>in 2.6.10-rc2-bk6, a struct dentry is held for each node in the sysfs
>tree at all times.  I infer this from noticing that sysfs_drop_dentry
>and sysfs_hash_and_remove in fs/sysfs/inode.c only seem to be called
>on operations to delete a node.  If I've missed something and the dentry
>structures are all or mostly released, I would love to be corrected about
>it as that would be really good news to me.

	I should correct myself, although this correction suggests
that sysfs currently uses slightly _more_ memory than I previously
thought in the case of my computer (1100 directories and 2305
non-directories in sysfs).

	In 2.6.10-rc2-bk6, it looks like sysfs releases the dname
structures as well in the case of a file (attribute) or symlink,
but keeps these structures *and* a struct inode for every directory
(kobject).  So, it looks like the non-swappable memory usage of my
/sys is actually about 900kB.

			directories		non-directories
	dentry		144			0
	inode		344			0
	sysfs_dirent	36			36

	Bytes per:	524			36
	#of nodes:	1100			2305
	Subtotal:	576,400			82,980

	Total:		659,380 bytes


	Perhaps the code that allows non-directories in sysfs to free
their inode and dname structures will in the future be extended to allow
directories do so also, which would reduce that total to 122kB.
However, even then, one might still consider how much of the 57kB of
kobject's and 36kB of attribute's and pointers to them in kset's
are due soley to sysfs, and therefore still consider it a RAM
overhead worth avoiding in some cases.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
