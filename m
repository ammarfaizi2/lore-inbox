Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTEWAEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 20:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTEWAEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 20:04:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:64231 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263458AbTEWAEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 20:04:50 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 23 May 2003 02:17:52 +0200 (MEST)
Message-Id: <UTC200305230017.h4N0Hqn05589.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com
Subject: Re: [patch?] truncate and timestamps
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Andrew Morton <akpm@digeo.com>

    > Investigating why some SuSE init script no longer works, I find:
    > The shell command
    >     > file
    > does not update the time stamp of file in case it existed and had size 0.

    oops.  That's due to me "don't call vmtruncate if i_size didn't change"
    speedup.  It was a pretty good speedup too.

    Does this look sane?

Well, before this 2.5.66 patch vmtruncate() was called, which called
foofs->truncate(), which probably did
	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
and it looks like you do the same now. So, yes.

[Why is this in foofs->truncate() and not in vfs code?]

[It looks like the only way ATTR_SIZE can be set is from the
do_truncate, so maybe your patch is equivalent to changing open.c:

88c88
<       newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
---
>       newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME | ATTR_MTIME;

("It looks like" means: nfs does unspeakable things,
intermezzo has izo_do_truncate(), a copy of do_truncate(),
hpfs_unlink() tries a truncate if there is no space for a delete,
ncp_notify_change() may have ATTR_SIZE without ATTR_MTIME.)]

On the other hand, my question was really a different one:
do we want to follow POSIX, also in the silly requirement
that truncate only sets mtime when the size changes, while
O_TRUNC and ftruncate always set mtime.

If so, we have to uglify do_truncate().

Andries
