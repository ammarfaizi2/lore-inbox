Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWB1TPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWB1TPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWB1TPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:15:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:38324 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932438AbWB1TPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:15:07 -0500
From: Chris Mason <mason@suse.com>
To: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>,
       agruen@suse.de
Subject: Re: cramfs mounts provide corrupted content since 2.6.15
Date: Tue, 28 Feb 2006 14:14:55 -0500
User-Agent: KMail/1.9.1
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
References: <20060225110844.GA18221@suse.de> <20060225220130.GA2748@suse.de> <17411.10591.927433.619327@zeus.sw.starentnetworks.com>
In-Reply-To: <17411.10591.927433.619327@zeus.sw.starentnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602281414.57084.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 11:31, Dave Johnson wrote:

> I think I've spotted an issue.
>
> Both ifind() and find_inode() will call the test function on inodes
> that still have I_LOCK|I_NEW set.  This means everything that the
> test function needs _must_ be set in the set function (which is called
> while the inode_lock is still held).
>
> This could cause issues for inodes of 1 (only i_ino is getting set
> right now).

The problem is that two files are getting the same inode number because 
their offsets are the same.

ls -lai:
3412140 -rw-r--r--  1 root root       0 Jan  1  1970 ./etc/mtab
3412140 -rw-r--r--  1 root root    1220 Jan  1  1970 ./etc/nsswitch.conf

So, if /etc/mtab is read first, /etc/nsswitch.conf ends up with size zero, 
because it uses the mtab inode.

Andreas Gruenbacher suggested this change.  Along with your patch, things 
are working here again:

-chris

diff -r 0f4fc87886c2 fs/cramfs/inode.c
--- a/fs/cramfs/inode.c	Fri Feb 24 16:18:23 2006 -0500
+++ b/fs/cramfs/inode.c	Tue Feb 28 14:00:11 2006 -0500
@@ -36,7 +36,7 @@ static DECLARE_MUTEX(read_mutex);
 
 /* These two macros may change in future, to provide better st_ino
    semantics. */
-#define CRAMINO(x)	((x)->offset?(x)->offset<<2:1)
+#define CRAMINO(x)	(((x)->offset && (x)->size)?(x)->offset<<2:1)
 #define OFFSET(x)	((x)->i_ino)
 
 
