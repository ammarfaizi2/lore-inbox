Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbSITJq6>; Fri, 20 Sep 2002 05:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261998AbSITJq6>; Fri, 20 Sep 2002 05:46:58 -0400
Received: from pc-80-195-34-180-ed.blueyonder.co.uk ([80.195.34.180]:45440
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261997AbSITJq5>; Fri, 20 Sep 2002 05:46:57 -0400
Date: Fri, 20 Sep 2002 10:51:53 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Seaman Hu <seaman_hu@yahoo.com>, ext3-users@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: What will happen when disk(ext3) is full while i continue to operate files ?
Message-ID: <20020920105153.H2585@redhat.com>
References: <20020920091114.46162.qmail@web40502.mail.yahoo.com> <200209201125.09062.duncan.sands@math.u-psud.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209201125.09062.duncan.sands@math.u-psud.fr>; from duncan.sands@math.u-psud.fr on Fri, Sep 20, 2002 at 11:25:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Sep 20, 2002 at 11:25:09AM +0200, Duncan Sands wrote:

> The problem is that it is quite tricky to recover from this.

Actually, mounting with "errors=continue" should let the filesystem
ignore the failure.

> What
> you need to do is delete files on the disk in order to have some
> free inodes.  Then you can apply a kernel patch to fix the bug
> (Andrew Morton sent me this patch against 2.5.20:

The official patch in 2.4 is attached.

Cheers,
 Stephen

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0827-inode-enospc.patch"

---------------------
PatchSet 827
Date: 2002/04/10 18:02:19
Author: sct
Log:
Don't consider ENOSPC as a fatal error when allocating an inode.  Otherwise
running out of inodes marks the fs as having an error, potentially taking
the kernel down if we are in panic-on-error fs mode.

Members: 
	fs/ext3/ialloc.c:1.19.4.4->1.19.4.5 [ext3-1_0-branch]

--- linux-ext3-2.4merge/fs/ext3/ialloc.c.=K0001=.orig	Sat Aug 17 20:09:51 2002
+++ linux-ext3-2.4merge/fs/ext3/ialloc.c	Mon Aug 19 18:48:50 2002
@@ -392,7 +392,7 @@
 
 	err = -ENOSPC;
 	if (!gdp)
-		goto fail;
+		goto out;
 
 	err = -EIO;
 	bitmap_nr = load_inode_bitmap (sb, i);
@@ -523,9 +523,10 @@
 	return inode;
 
 fail:
+	ext3_std_error(sb, err);
+out:
 	unlock_super(sb);
 	iput(inode);
-	ext3_std_error(sb, err);
 	return ERR_PTR(err);
 }
 

--nFreZHaLTZJo0R7j--
