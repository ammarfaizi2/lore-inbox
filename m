Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261952AbSITJUP>; Fri, 20 Sep 2002 05:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261964AbSITJUP>; Fri, 20 Sep 2002 05:20:15 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:63711 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261952AbSITJUN>; Fri, 20 Sep 2002 05:20:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Seaman Hu <seaman_hu@yahoo.com>, ext3-users@redhat.com
Subject: Re: What will happen when disk(ext3) is full while i continue to operate files ?
Date: Fri, 20 Sep 2002 11:25:09 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20020920091114.46162.qmail@web40502.mail.yahoo.com>
In-Reply-To: <20020920091114.46162.qmail@web40502.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209201125.09062.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 September 2002 11:11, Seaman Hu wrote:
> Sorry. I probably didn't make it clear.
> My system is ok when first msg "EXT3-fs error (device
> sd(8,2)) in ext3_new_inode: error 28" appears.
> However, it will crash after millions of the same msg.
> Is there some kind of buffer full to cause the crash?

It looks like you have run out of inodes (df -i will tell you how
many inodes you have left).  When you format your disk as
ext2 or ext3, you specify the number of inodes to be allocated
on the disk.  This number does not change later.  The inodes
are used for storing file information.  It is possible to run out of
inodes while still having plenty of space free on the disk.  The
ext3 code in 2.4 up to and including 2.4.19 contains a bug: it
fails nastily if you run out of inodes (it fails gracefully if you run
out of free space).  This has been fixed in the latest 2.5 kernels
and in the -ac kernels I think.

The problem is that it is quite tricky to recover from this.  What
you need to do is delete files on the disk in order to have some
free inodes.  Then you can apply a kernel patch to fix the bug
(Andrew Morton sent me this patch against 2.5.20:

--- linux-2.5.20/fs/ext3/ialloc.c       Wed May 29 12:48:15 2002
+++ 25/fs/ext3/ialloc.c Mon Jun  3 16:05:36 2002
@@ -534,7 +534,8 @@ repeat:
 fail:
        unlock_super(sb);
        iput(inode);
-       ext3_std_error(sb, err);
+       if (err != -ENOSPC)
+               ext3_std_error(sb, err);
        return ERR_PTR(err);
 }

Thanks Andrew!)

Now, how to recover?  When this happened to me I did something
along these lines (I don't remember too well):
(1) force an fsck on reboot
(2) reboot quickly after the fsck and before any files get created (otherwise
you are back where you started)
(3) mount the disk as ext2 via the rootfstype=ext2 boot option
(4) delete lots of files.

Probably there is a better way...

I hope this helps,

Duncan.
