Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUKPTQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUKPTQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUKPTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:14:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:40685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262097AbUKPTNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:13:37 -0500
Date: Tue, 16 Nov 2004 11:13:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: holt@sgi.com, linux-kernel@vger.kernel.org, dev@sw.ru, wli@holomorphy.com,
       steiner@sgi.com, sandeen@sgi.com
Subject: Re: 21 million inodes is causing severe pauses.
Message-Id: <20041116111321.36a6cd06.akpm@osdl.org>
In-Reply-To: <20041116162859.GA5594@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com>
	<20041115145714.3f757012.akpm@osdl.org>
	<20041116162859.GA5594@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
> I guess I am very concerned at this point.  If I can do a
>  release/reacquire, why not just change generic_shutdown_super() so the
>  lock_kernel() does not happen until the first pass has occurred.  ie:
> 
>  --- super.c.orig        2004-11-16 10:22:17 -06:00
>  +++ super.c     2004-11-16 10:22:41 -06:00
>  @@ -232,10 +232,10 @@
>                  dput(root);
>                  fsync_super(sb);
>                  lock_super(sb);
>  -               lock_kernel();
>                  sb->s_flags &= ~MS_ACTIVE;
>                  /* bad name - it should be evict_inodes() */
>                  invalidate_inodes(sb);
>  +               lock_kernel();
> 
>                  if (sop->write_super && sb->s_dirt)
>                          sop->write_super(sb);
> 
>  This at least makes the lock_kernel time much smaller than it is right
>  now.  It also does not affect any callers that may really need the BKL.

lock_kernel() is also taken way up in do_umount(), hence the need for
release_kernel_lock()/reacquire_kernel_lock().

> 
>  I guess I am really asking for an indication of what the BKL is supposed
>  to be protecting.  I have not dug for the intent down the VFS code paths
>  at all.

It's not protecting anything around invalidate_inodes().  There may be
other things in the higher-level umount path which need it.

