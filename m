Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUG0NTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUG0NTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 09:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUG0NTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 09:19:54 -0400
Received: from [61.49.234.202] ([61.49.234.202]:50664 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S265215AbUG0NTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 09:19:52 -0400
Date: Tue, 27 Jul 2004 21:16:02 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200407280416.i6S4G1P04614@freya.yggdrasil.com>
To: mpm@selenic.com
Subject: Re: Future devfs plans (sorry for previous incomplete message)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
>On Mon, Jul 26, 2004 at 10:37:41AM -0700, Adam J. Richter wrote:
>>       devfs allows for creation of devices when user level programs
>> need them rather than based on "hot plug" or modprobe-related events,
>> neither of which do not exist for many devices and do not necessarily
>> indicate need for the driver.
>
>One wonders if autofs can be made to do the same.

	Although I never experimentally confirmed it, from reading
the autofs and autofs4 sources, it appears that neither of them
provide a mknod operation.  They both use simple_inode_operations,
which has a NULL mknod, which will cause vfs_mknod to return -EPERM.
I believe autofs and autofs4 only allow creation of directories
and symlinks.

	Also, as I mentioned previously, trapping
inode_operations.lookup() can deadlock driver initialization
if it is doing mknod's that would also trigger that lookup
trap.  The VFS interface to lookup() could be changed slightly
via an extra parameter or an extra field in dentry or nameidata
to allow the lookup() trap to skip mknod and mkdir attempts,
but it might require some 1 line changes in a 50 file systems,
and I think doing it as an extension to dnotify might have
other minor benefits, such as demand loading appropriate modules
when files like /proc/apm or /proc/microcode are opened.  However, I
think it's a very close call whether to do the lookup trapping as a
file system modification or a VFS/dnotify modification.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
