Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263537AbREYFTw>; Fri, 25 May 2001 01:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263538AbREYFTm>; Fri, 25 May 2001 01:19:42 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:57260 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263537AbREYFTb>; Fri, 25 May 2001 01:19:31 -0400
Date: Fri, 25 May 2001 01:20:00 -0400 (EDT)
From: Scott Murray <scott@spiteful.org>
X-X-Sender: <scottm@godzilla.spiteful.org>
To: Maciek Nowacki <maciek@Voyager.powersurfr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Busy on BLKFLSBUF w/initrd
In-Reply-To: <20010524123943.A797@wintermute.starfire>
Message-ID: <Pine.LNX.4.33.0105250040520.15501-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Maciek Nowacki wrote:

> Problem seems to be solved. Here is what I did, for anyone who is interested
> in using a loopback file on a local disk as root:
[snip recipe]
> This method depends on the change_root() mechanism which I had assumed is
> becoming obsolete. It works, and there is no need to mess with
> /proc/sys/kernel/real_root_dev if the root is specified on the command line.
> Trying to use only pivot_root did not work as /dev/rd/0 could never be
> flushed (see previous messages in this thread).

I was having similiar problems a few months back.  I was also trying
to pivot_root out of an initial ramdisk and then unmount it.  I got it
working, but kept forgetting to post one of the fixes that I found
necessary to make it work when using auto-mounted devfs.

Here it is (exported from BitKeeper, hence the a and b):

diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Fri May 25 00:31:25 2001
+++ b/init/main.c	Fri May 25 00:31:25 2001
@@ -273,6 +273,9 @@
 #ifdef CONFIG_NFTL
 	{ "nftla", 0x5d00 },
 #endif
+#ifdef CONFIG_DEVFS_MOUNT
+	{ "rd/",     0x0100 },
+#endif
 	{ NULL, 0 }
 };

What this does is make /dev/rd/* parseable by name_to_kdev_t, with
the result that ROOT_DEV gets set correctly in root_dev_setup and
the initrd logic at the bottom of do_basic_setup doesn't automatically
trigger the change_root.  The same effect can be achieved by setting
real_root_dev in proc in your ramdisk, but since that's not required
for non-devfs ramdisks, it takes some digging for the uninitiated to
figure out why things don't work.

With this fix and the fix for the missing bldev_put in drivers/block/rd.c
(which has been in Alan's tree for ages), the pivot_root instructions
given in the file Documentation/initrd.txt have been working fine for me.

Scott


-- 
=============================================================================
Scott Murray                                        email: scott@spiteful.org
http://www.spiteful.org (coming soon)                 ICQ: 10602428
-----------------------------------------------------------------------------
     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"


