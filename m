Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWG0Ljg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWG0Ljg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWG0Ljg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:39:36 -0400
Received: from server077.de-nserver.de ([62.27.12.245]:32645 "EHLO
	server077.de-nserver.de") by vger.kernel.org with ESMTP
	id S1750720AbWG0Ljg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:39:36 -0400
X-User-Auth: Auth by hostmaster@profihost.com through 84.134.46.66
Message-ID: <44C8A5F1.7060604@profihost.com>
Date: Thu, 27 Jul 2006 13:39:29 +0200
From: ProfiHost - Stefan Priebe <s.priebe@profihost.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: XFS / Quota Bug in  2.6.17.x and 2.6.18x
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The crash only occurs if you use quota and IDE without barrier support.

The Problem is, that on a new mount of a root filesystem - the flag 
VFS_RDONLY is set - and so no barrier check is done before checking 
quota. With this patch barrier check is done always. The partition 
should not be mounted at that moment. For mount -o remount, rw or 
something like this it uses another function where VFS_RDONLY is checked.

Error Message:
ns2 Wed Jul 26 14:22:58 2006 "I/O error in filesystem ("hda6") meta-data 
dev
hda6 block 0x23db5ab       ("xlog_iodone") error 5 buf count 1024"
ns2 Wed Jul 26 14:22:58 2006 "xfs_force_shutdown(hda6,0x2) called from line
959 of file fs/xfs/xfs_log.c.  Return address = 0xc0211535"
ns2 Wed Jul 26 14:22:58 2006 "Filesystem "hda6": Log I/O Error Detected.
Shutting down filesystem: hda6"
ns2 Wed Jul 26 14:22:58 2006 "Please umount the filesystem, and rectify the
problem(s)"
ns2 Wed Jul 26 14:22:58 2006 "xfs_force_shutdown(hda6,0x1) called from line
338 of file fs/xfs/xfs_rw.c.  Return address = 0xc0211535"
ns2 Wed Jul 26 14:22:58 2006 "xfs_force_shutdown(hda6,0x1) called from line
338 of file fs/xfs/xfs_rw.c.  Return address = 0xc0211535"

Patch:
*** fs/xfs/xfs_vfsops.c.orig	Thu Jul 27 13:10:23 2006
--- fs/xfs/xfs_vfsops.c	Thu Jul 27 13:11:17 2006
*************** xfs_mount(
*** 524,528 ****
   		goto error2;

! 	if ((mp->m_flags & XFS_MOUNT_BARRIER) && !(vfsp->vfs_flag &
VFS_RDONLY))
   		xfs_mountfs_check_barriers(mp);

--- 524,528 ----
   		goto error2;

! 	if (mp->m_flags & XFS_MOUNT_BARRIER)
   		xfs_mountfs_check_barriers(mp);


Best regards,
Ihr ProfiHost Team
------------------------------------------
ProfiHost e.K.
Lindener Str 15
38300 Wolfenbüttel

Tel.: 05331 996890
Fax: 05331 996899
URL: http://www.profihost.com
E-Mail: support@profihost.com
