Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTJANPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTJANPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:15:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57227 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261850AbTJANPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:15:00 -0400
Date: Wed, 1 Oct 2003 14:14:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Al Smith <Al.Smith@aeschi.ch.eu.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: include/linux/efs_fs.h declares a symbol
Message-ID: <20031001131456.GR7665@parcelfarce.linux.theplanet.co.uk>
References: <20031001121643.GD31698@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001121643.GD31698@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Al Viro: There is no maintainer for efs in the kernel MAINTAINERS
> file.  Is this filesystem orphaned?

Beats me.  As far as I can see, all updates to it were 3rd-party.  It's
either abandoned, or never required specific patches too badly (also
quite possible in this case).

It went into the tree in 2.3.2 and from there to 2.6.0-test6 I see nothing
that would look like maintainer's update.  OTOH, it's read-only and shouldn't
be too badly broken (or hard to keep alive).

Outside of trunk (i.e. in 2.4.16--) we have a backport of global 2.5 change
(sb_bread()) and check for set_blocksize() failures (from Alan).  BTW, the
latter patch is missing in 2.5.  Its equivalent would be

--- B6/fs/efs/super.c	Mon Jun 23 07:23:09 2003
+++ B6-efs/fs/efs/super.c	Wed Oct  1 08:58:35 2003
@@ -218,7 +218,11 @@
 	memset(sb, 0, sizeof(struct efs_sb_info));
  
 	s->s_magic		= EFS_SUPER_MAGIC;
-	sb_set_blocksize(s, EFS_BLOCKSIZE);
+	if (!sb_set_blocksize(s, EFS_BLOCKSIZE)) {
+		printk(KERN_ERR "EFS: device does not support %d byte blocks\n",
+			EFS_BLOCKSIZE);
+		goto out_no_fs_ul;
+	}
   
 	/* read the vh (volume header) block */
 	bh = sb_bread(s, 0);

