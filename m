Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265000AbUELQqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbUELQqC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 12:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUELQqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 12:46:02 -0400
Received: from [217.73.129.129] ([217.73.129.129]:4563 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265000AbUELQp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 12:45:59 -0400
Date: Wed, 12 May 2004 19:45:07 +0300
Message-Id: <200405121645.i4CGj7Vh417606@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [CHECKER] 2 warnings in reiserfs linux 2.4.19
To: linux-kernel@vger.kernel.org, yjf@stanford.edu, mc@cs.Stanford.EDU,
       madan@cs.Stanford.EDU, reiser@namesys.com, mason@suse.com
References: <Pine.GSO.4.44.0405111833030.4121-100000@elaine24.Stanford.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Junfeng Yang <yjf@stanford.edu> wrote:

JY> We recently checked reiserfs on linux 2.4.19 and came across two warnings.
JY> The first one complained that NULL was dereferenced.  The second one
JY> complained that an IO failure got ignored (a warning would be printed out
JY> though).
JY> As usual, confirmations/clarifications are appreciated.
JY> -Junfeng
JY> -------------------------------------------------------------------------
JY> [BUG] derefence of must-be-NULL pointer

This one is real. It is only present in 2.4 kernels, 2.6 has a check
for jb->bitmaps == NULL in jb->bitmaps == NULL and returns if so.
But while looking for this, I noticed that both 2.6 and 2.4 are not checking for
the return value of reiserfs_allocate_list_bitmaps(), so even if we manage not
to crash in cleanup_bitmap_list(), then mount will still succeed and next
attempt to do something with journal will do NULL defererence.
I will submit patches for both 2.4 and 2.6 in a moment.


JY> -------------------------------------------------------------------------
JY> [BUG] reiserfs_create --> reiserfs_add_entry --> reiserfs_update_sd.  reiserfs_update_sd can fail if bread fails (search_item will call bread).  This error is ignored except a warning is printed out.  This causes the stat data for a inode to be out-of-date.

This one is a very often hit with bad disks.
It manifests itself in users seeing files with ls, but any access to file
results in permission denied, due to us unable to read inode directory
entry is pointing to. I believe the inode data cannot be out of date simply
because in order for updated inode data to get to the disk, it first needs to be
in memory. So we either have up-to-date inode in memory or we do not have
anything at all and in this later case any attempt to access such file
will result in error anyway.

Thank you.

Bye,
    Oleg
