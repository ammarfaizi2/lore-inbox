Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbUBHR5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 12:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbUBHR5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 12:57:41 -0500
Received: from [217.73.129.129] ([217.73.129.129]:33982 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263983AbUBHR5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 12:57:40 -0500
Date: Sun, 8 Feb 2004 19:57:34 +0200
Message-Id: <200402081757.i18HvYV2074606@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Reiserfs flags question
To: linux-kernel@vger.kernel.org, bart@samwel.tk, nikita@namesys.com
References: <401D3E97.5080902@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Bart Samwel <bart@samwel.tk> wrote:

BS> I was looking at fs/reiserfs/inode.c, and I noticed that the functions 
BS> sd_attrs_to_i_attrs and i_attrs_to_sd_attrs are not exact inverses: 
BS> i_attrs_to_sd_attrs doesn't convert the S_APPEND flag to 
BS> REISERFS_APPEND_FL, but sd_attrs_to_i_attrs does convert 
BS> REISERFS_APPEND_FL to S_APPEND. I was wondering, is this intentional?

Indeed this is a mistake.
Everything was still working as expected because i_attrs_to_sd_attrs cannot
change anything these days, since the only way to change inode attributes is
through special ioctl, that directly assigns passed flags value to i_attrs
field of reiserfs specific part of inode.

For the sakr of correctness and also in case there would be another path
to change file attrubutes besides the ioctl, this patch below is needed
for both 2.4 and 2.6
Thank you very much.

Bye,
    Oleg

===== fs/reiserfs/inode.c 1.87 vs edited =====
--- 1.87/fs/reiserfs/inode.c	Mon Jan 19 08:22:24 2004
+++ edited/fs/reiserfs/inode.c	Sun Feb  8 19:41:43 2004
@@ -2317,6 +2317,11 @@
 			*sd_attrs |= REISERFS_IMMUTABLE_FL;
 		else
 			*sd_attrs &= ~REISERFS_IMMUTABLE_FL;
+		if( inode -> i_flags & S_APPEND )
+			*sd_attrs |= REISERFS_APPEND_FL;
+		else
+			*sd_attrs &= ~REISERFS_APPEND_FL;
+
 		if( inode -> i_flags & S_SYNC )
 			*sd_attrs |= REISERFS_SYNC_FL;
 		else

