Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbTC0SpI>; Thu, 27 Mar 2003 13:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261282AbTC0SpH>; Thu, 27 Mar 2003 13:45:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:12195 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261281AbTC0SpF>;
	Thu, 27 Mar 2003 13:45:05 -0500
Date: Thu, 27 Mar 2003 11:58:14 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: David Brownell <david-b@pacbell.net>
cc: <linux-kernel@vger.kernel.org>, <greg@kroah.com>, <andmike@us.ibm.com>
Subject: Re: 2.5.recent: device_remove_file() doesn't
In-Reply-To: <3E8275AD.40603@pacbell.net>
Message-ID: <Pine.LNX.4.33.0303271154080.1001-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Mar 2003, David Brownell wrote:

> I've noticed that recent kernels don't clean up device
> attribute files correctly when they're removed.  Instead,
> they're left in the directory with a refcount of zero.
> 
> That refcount stays even when the file is recreated later;
> and the contents can be read.  Delete them again, and now
> the refcount is 65535 ... though now reading the contents
> may cause oopsing.
> 
> This worked correctly at some point last month:  the file
> no longer appeared in sysfs after deletion.
> 
> Got Patch?

Yeah, and I apologize. File deletion has been causing some problems 
lately due to some bad assumptions of the dentry layer. This patch reverts 
a small bit of the patch that went in a couple of weeks ago, and should 
hopefully fix everything up. 

This should also take care of the problem that some have been seeing of 
symlinks not going away on device/module removal (though I've been unable 
to reproduce those). 

Greg/Mike, could you give this patch a shot and let me know if helps?

Thanks,


	-pat

===== fs/sysfs/inode.c 1.84 vs edited =====
--- 1.84/fs/sysfs/inode.c	Tue Mar 11 15:30:18 2003
+++ edited/fs/sysfs/inode.c	Thu Mar 27 11:53:44 2003
@@ -97,7 +97,7 @@
 				 atomic_read(&victim->d_count));
 
 			simple_unlink(dir->d_inode,victim);
-
+			d_delete(victim);
 		}
 		/*
 		 * Drop reference from sysfs_get_dentry() above.

