Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVADBi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVADBi7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVADBi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:38:59 -0500
Received: from dp.samba.org ([66.70.73.150]:29836 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261472AbVADBi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 20:38:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16857.62250.259275.305392@samba.org>
Date: Tue, 4 Jan 2005 12:36:42 +1100
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <41D9EDF6.1060600@zytor.com>
References: <41D9C635.1090703@zytor.com>
	<16857.56805.501880.446082@samba.org>
	<41D9E3AA.5050903@zytor.com>
	<16857.59946.683684.231658@samba.org>
	<41D9EDF6.1060600@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > More or less what you seem to want is an ioctl() that takes a mask of 
 > what to write, similar to the way notify_change() works inside the 
 > kernel.  This is a legitimate API, but it requires knowledge of the 
 > internals, and isn't setxattr().  The big thing here is the need for a mask.

That API would make sense, but I didn't really expect the kernel to
provide it. What I expected to happen was for Samba4 to use the xattr
blobs like it does now, hopefully for Wine to learn to interpret those
same blobs, for backup/restore apps to learn to backup/restore them
(as blobs, with no interpretation) and for the proposed Samba LSM
module to do the dirty work of interpreting the contents of these
blobs in-kernel to provide raceless windows file serving. 

The LSM module would then expose a richer API to a user space library
via some yet to be determined mechanism (netlink? ioctl? sysfs? proc?
dunno yet). That API would include the ability to tell the LSM module
what "nt token" (the windows equivalent of euid, egid and
supplementary groups) to use for operations, thus allowing the module
to correctly interpret the NT ACLs for read/write access to each of
these attributes. The module would also cache the xattr blob contents,
in unpacked form, to allow access decisions to be made very fast.

The whole design was based on the idea that proposing anything more
intrusive would (quite rightly) get smacked down as "this is not NT,
go away".

 > Also see my previous note about endianness of structures carried
 > from place to place.

I specifically chose NDR (and specifically little-endian NDR) as it
solves the endianness and 32/64 bit problems. You can take these blobs
and put them on any platform and they will be interpreted the same.

We also have a mechanism (an external tdb) for storing these xattrs on
filesystems that have no xattr support. That allows Samba4 to be fully
functional on any platform, but just much more efficient and scalable
on platforms that do have xattrs.

Cheers, Tridge
