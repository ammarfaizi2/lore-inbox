Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVADBca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVADBca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVADBca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:32:30 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:38333 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261938AbVADBcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 20:32:01 -0500
Subject: Re: FAT, NTFS, CIFS and DOS attributes
From: Nicholas Miell <nmiell@comcast.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: tridge@samba.org, Michael B Allen <mba2000@ioplex.com>, sfrench@samba.org,
       linux-ntfs-dev@lists.sourceforge.net, samba-technical@lists.samba.org,
       aia21@cantab.net, hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41D9E23A.4010608@zytor.com>
References: <41D9C635.1090703@zytor.com>
	 <54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
	 <41D9D65D.7050001@zytor.com> <16857.57572.25294.431752@samba.org>
	 <41D9E23A.4010608@zytor.com>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 17:31:59 -0800
Message-Id: <1104802319.3604.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 16:24 -0800, H. Peter Anvin wrote:
> Right, it's the "design is broken so everything ends up in user.*". 

The design isn't broken, you're just missing an important detail of what
the system namespace entails:

xattrs in the system namespace have a format defined by the kernel and
(more importantly -- this is the important detail) modify kernel
behavior.

If the xattr namespace was flat, I would have no way of knowing whether
or not the kernel will set the Archived bit in fatattrs (or DosAttrib)
xattr when I write to a file that has that xattr or whether or not the
kernel will choose to enforce the ACL I store in the posix_acl_access
xattr.

With the system namespace, I can rely on the fact that xattrs in that
namespace actually have a meaning and are in sync with what the kernel
believes to be true about the file.

If I cannot rely on this to be true, than at best that's a bug and at
worst it's a gaping security hole. (NT ACLs can specify Allow and Deny,
if I create a NT ACL xattr that denies somebody access, the kernel damn
well better enforce it.)

Earlier you mentioned a desire to be able to backup the various pieces
of metadata that a filesystem exports via xattrs simply by copying the
files to another filesystem, and the fact that the destination
filesystem may not allow you to store the same attributes in the system
namespace as the source prevented you from being able to do this.

This is akin to complaining that you cannot make an accurate backup of
an ext3 filesystem simply by copying it's files to a vfat filesystem,
because vfat doesn't support the same notions of timestamps, ownership
or permissions that ext3 does.

Tools such as tar or cpio exist to store Unix files and their metadata
in a flat format, and they can be extended to understand the extra
metadata made available in Linux xattrs.

-- 
Nicholas Miell <nmiell@comcast.net>

