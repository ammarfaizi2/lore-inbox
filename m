Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVADAhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVADAhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVADAfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:35:25 -0500
Received: from dp.samba.org ([66.70.73.150]:38830 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262021AbVADAVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:21:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16857.57572.25294.431752@samba.org>
Date: Tue, 4 Jan 2005 11:18:44 +1100
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Michael B Allen <mba2000@ioplex.com>, sfrench@samba.org,
       linux-ntfs-dev@lists.sourceforge.net, samba-technical@lists.samba.org,
       aia21@cantab.net, hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <41D9D65D.7050001@zytor.com>
References: <41D9C635.1090703@zytor.com>
	<54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
	<41D9D65D.7050001@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > 	system.dosattrib	- DOS attributes (single byte)
 > 	system.dosshortname	- DOS short name (e.g. for VFAT)

you need more than one byte for DOS attrib. These are the bits Samba4
defines:

/* FileAttributes (search attributes) field */
#define FILE_ATTRIBUTE_READONLY		0x0001
#define FILE_ATTRIBUTE_HIDDEN		0x0002
#define FILE_ATTRIBUTE_SYSTEM		0x0004
#define FILE_ATTRIBUTE_VOLUME		0x0008
#define FILE_ATTRIBUTE_DIRECTORY	0x0010
#define FILE_ATTRIBUTE_ARCHIVE		0x0020
#define FILE_ATTRIBUTE_DEVICE		0x0040
#define FILE_ATTRIBUTE_NORMAL		0x0080
#define FILE_ATTRIBUTE_TEMPORARY	0x0100
#define FILE_ATTRIBUTE_SPARSE		0x0200
#define FILE_ATTRIBUTE_REPARSE_POINT	0x0400
#define FILE_ATTRIBUTE_COMPRESSED	0x0800
#define FILE_ATTRIBUTE_OFFLINE		0x1000
#define FILE_ATTRIBUTE_NONINDEXED	0x2000
#define FILE_ATTRIBUTE_ENCRYPTED	0x4000

while most apps don't care about the bits beyond 0xFF at the moment, I
think that might change, especially for win32 clients accessing linux
filesystems via wine and Samba.

Also, there are many other bits of windows meta-data that matter for
apps that care about dos attributes, including the extra 1.5 time
fields (windows has 4 settable time fields, posix has 2 settable and 3
readable time fields), the 8.3 name, the allocation size and all the
DOS EAs (important for OS/2 clients).

We use the following xattrs in Samba4:

 user.DosAttrib     : structure holding basic non-privileged attribute information
 user.DosEAs        : all the DOS (OS/2) style EAs
 user.DosStreams    : list of alternate data steams, flagged as internal or external
 user.DosStream.name: the stream data itself for internal streams
 security.NTACL     : the NT ACL

the rationale for making most of them in the user namespace is that it
is 'mostly harmless' to allow the owner of the file to change those
ones. The NTACL needs to be in the security namespace as it contains
elements that the user must not be able to control without system
permission (everyone can read it, but only root can write).

see xattr.idl for the full definitions of the above.

Cheers, Tridge
