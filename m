Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271875AbRIDBQZ>; Mon, 3 Sep 2001 21:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271873AbRIDBQQ>; Mon, 3 Sep 2001 21:16:16 -0400
Received: from mailhost.opengroup.fr ([62.160.165.1]:7348 "EHLO
	mailhost.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S271871AbRIDBQI>; Mon, 3 Sep 2001 21:16:08 -0400
Date: Tue, 4 Sep 2001 03:16:08 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
In-Reply-To: <Pine.GSO.4.21.0108311558430.15931-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.31.0109031558050.15486-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001, Alexander Viro wrote:

> > In 2.4.9, I have encountered a strange condition while playing with file
> > structs chained on a superblock list (sb->s_files) : some of them can have
> > a NULL f_dentry pointer. The only case I found which can cause this is
> > when fput is called and f_count drops to zero. Is that the only case ?
>
> Yes, it is, and yes, it's legitimate - code that scans that list should
> (and in-tree one does) deal with such case.

AFAICT fput (and also dentry_open, BTW) nullifies f_dentry without any
lock held, so code that scans the list (such as fs_may_remount_ro, I
haven't looked for other instances) can never assume that a file struct
found in the list has or even will keep what looks like a valid f_dentry.

> fs_may_remount_ro() is, indeed, racy and had been since very long.

Sure, let's consider code in fs_may_remount_ro :

	file_list_lock();
	/* loop over files in sb->s_files */
		if (!file->f_dentry)
			continue;
		/* now a concurrent fput may set f_dentry to NULL */
		inode = file->f_dentry->d_inode; /* oops */

Maybe the file struct should be removed from the list /before/ f_dentry is
assigned NULL ?

> However, the main problem is not in opening something after the
> check - the check itself is not exact enough.

I agree fs_may_remount_ro can report wrong results (ie. "you may remount
ro" while you really can't) because of how it is used, but as stated
above, I think it also has a small but real potential for directly
crashing the system, and should be fixed.


-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:saffroy@ri.silicomp.fr

