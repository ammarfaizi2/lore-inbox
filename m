Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbUKOWzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUKOWzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUKOWxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:53:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:16795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261521AbUKOWxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:53:06 -0500
Date: Mon, 15 Nov 2004 14:57:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, wli@holomorphy.com,
       steiner@sgi.com, sandeen@sgi.com
Subject: Re: 21 million inodes is causing severe pauses.
Message-Id: <20041115145714.3f757012.akpm@osdl.org>
In-Reply-To: <20041115195551.GA15380@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
> One significant problem we are running into is autofs trying to umount the
> file systems.  This results in the umount grabbing the BKL and inode_lock,
> holding it while it scans through the inode_list and others looking for
> inodes used by this super block and attempting to free them.

You'll need invalidate_inodes-speedup.patch and
break-latency-in-invalidate_list.patch (or an equivalent).

That'll get you most of the way, but the BKL will still be a problem.

Removing lock_kernel() in the umount path is probably a major project so
for now, you can just drop and reacquire it by doing
release_kernel_lock()/reacquire_kernel_lock() around invalidate_inodes().

(You'll need to use that pair rather than unlock_kernel/lock_kernel because
it seems that invalidate_inodes can be called under various depths of
lock_kernel()).


