Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264139AbTEGWwC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbTEGWwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:52:02 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:3116 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264139AbTEGWwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:52:00 -0400
Date: Wed, 7 May 2003 16:00:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.69-mm2] Very slow read syscall
Message-Id: <20030507160049.4352009b.akpm@digeo.com>
In-Reply-To: <200305080055.23653.schlicht@uni-mannheim.de>
References: <200305080055.23653.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 23:04:30.0960 (UTC) FILETIME=[045E4F00:01C314ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> Hi,
> 
> I've noticed that the read syscall is very slow with 2.5.69-mm2 compared to 
> 2.5.69-bk2. I especially could 'feel' it while using kmail. When kmail is 
> closed and it compresses its Mail folder I could measure it.
> 
> The straces and oprofiles for this action are attached for the two kernel 
> versions mentioned above.
> 
> As you can see the time for closing kmail increased from about 2 seconds to 
> about 155 seconds. A read system call needs 931usecs instead of 12usecs...
> The profile shows that the most time is spent in __copy_to_user_ll.
> As CONFIG_X86_WP_WORKS_OK is defined in my config this function should be the 
> same in -mm2 and -bk2, so it seems it simply is called more often...
> 
> I am using the anticipatory scheduling elevator, but it 'feels' the same with 
> CFQ or DL. But I can mesure it if you want...

This is due to a bug in kmail, and the reiserfs_file_write patch.

One thing which that patch does is to increase the stat.st_blksize hint
which reiserfs provides to applications.  By a lot - from 4k to 128k I
think.

Problem is, some KDE apps see that hint and then promptly balls it up. 
They read 128k at offset 0, then 128k at offset 4k, then 128k at offset 8k,
etc.

Apparently, upgrading kmail will fix it.
