Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVADAUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVADAUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVADAL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:11:28 -0500
Received: from dp.samba.org ([66.70.73.150]:32681 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262011AbVADAIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:08:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16857.56805.501880.446082@samba.org>
Date: Tue, 4 Jan 2005 11:05:57 +1100
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <41D9C635.1090703@zytor.com>
References: <41D9C635.1090703@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I noticed that CIFS has a placeholder "user.DosAttrib" in cifs/xattr.c, 
 > although it doesn't seem to be implemented.

Thats taken from Samba4, where it is fully implemented. I guess Steve
is planning on integrating cifsfs with the Samba4 way of handling EAs,
NT ACLs, attribs, streams etc at some stage.

See 
  http://samba.org/ftp/unpacked/samba4/source/librpc/idl/xattr.idl 
for a full definition of the structures we use. 

I used a NDR encoding in each of the xattrs to provide a well defined
architecture independent encoding, and an easy way to extend the
structure in the future (thats why DosAttrib is a union with a version
switch). 

The place where this will really interact a lot with the kernel is in
the Samba LSM module that tpot and myself have been looking at
writing. That module will provide the in-kernel implementation of
these attributes that is needed to make them raceless (especially for
NT ACLs).

These xattr structures are also the key to solving the
case-insensitivity problem that has been plaguing Samba for so
long. We have come up with a very simple scheme for making
case-insensiitive filenames work very efficiently on any filesystem
that supports xattrs. It requires no additional kernel support beyond
xattrs, and gets rid of the need for a large user-space name
cache.

Cheers, Tridge
