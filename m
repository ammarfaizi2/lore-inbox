Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVADBKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVADBKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVADBCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:02:42 -0500
Received: from dp.samba.org ([66.70.73.150]:28116 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261885AbVADBAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 20:00:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16857.59946.683684.231658@samba.org>
Date: Tue, 4 Jan 2005 11:58:18 +1100
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <41D9E3AA.5050903@zytor.com>
References: <41D9C635.1090703@zytor.com>
	<16857.56805.501880.446082@samba.org>
	<41D9E3AA.5050903@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Oh geez.  Couldn't you have split out the various data items into 
 > separate xattrs?

fetching and setting this stuff is _really_ common, so I have arranged
to store them in a way to make it as efficient as possible. For
example, when a remote client asks for a directory listing we need to
fetch just one xattr from the kernel per file (directory listings
in the windows world usually return the equivalent of a full stat
structure for every name).

Similarly, when these are set the client tends to set more than one at
a time. The most commonly used set call takes this structure:

	/* RAW_SFILEINFO_BASIC_INFO and
	   RAW_SFILEINFO_BASIC_INFORMATION interfaces */
	struct {
		enum smb_setfileinfo_level level;
		union setfileinfo_file file;

		struct {
			NTTIME create_time;
			NTTIME access_time;
			NTTIME write_time;
			NTTIME change_time;
			uint32_t attrib;
		} in;
	} basic_info;

Having the items that tend to get read/written together grouped
together allowed me to make it all quite efficient, while still having
a reasonable chance of the EAs all fitting in-inode on filesystems
that support that.

Obviously it is racy when dealt with from user space, but there really
is no way to avoid all these races without a user space accessible
"lock the files meta-data" call and that is why I'm looking forward to
having a Samba LSM module to avoid these races.

 > Samba clearly has other needs than other users, although of course
 > it would be unfortunate if Samba then can't export this
 > information.

I think you'll find that all users of dos attributes on Linux will
have very similar needs to Samba, and will want these things grouped
together. For example:

 - backup/restore apps will want to backup/restore these attributes as
   lumps
 - wine implements essentially the same APIs as Samba, just in a
   different form, and so tends to get the same groupings of
   attributes get/set calls that Samba does (the SMB protocol is to a
   large degree a on-the-wire version of Win32).

Are there any other significant users of DOS attributes on Linux that
want something different?

Cheers, Tridge
