Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTGZSM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTGZSLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:11:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:14483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262710AbTGZSKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:10:53 -0400
Date: Sat, 26 Jul 2003 11:25:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniele Venzano <webvenza@libero.it>
Cc: wodecki@gmx.de, rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 devfs question
Message-Id: <20030726112553.2356cce0.akpm@osdl.org>
In-Reply-To: <20030726111221.GD9574@renditai.milesteg.arr>
References: <20030725110830.GA666@gmx.de>
	<20030726111221.GD9574@renditai.milesteg.arr>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Venzano <webvenza@libero.it> wrote:
>
> There is a bug with devfs and raid, see:
> http://bugzilla.kernel.org/show_bug.cgi?id=471
> 
> It's sitting there since 2.5.45, but no one seems interested and I 
> don't have the knowledge to fix it by myself (or the time to acquire 
> that knowledge).

Unfortunately, raising a bug in bugzilla doesn't actually mean that anyone
is paying any attention to it.  You need to keep shouting at people.

Is the problem simply that the device has moved from /dev/md1 to /dev/md/1?
If so, is this change sufficient?

diff -puN drivers/md/md.c~a drivers/md/md.c
--- 25/drivers/md/md.c~a	2003-07-26 11:24:58.000000000 -0700
+++ 25-akpm/drivers/md/md.c	2003-07-26 11:25:15.000000000 -0700
@@ -3505,7 +3505,7 @@ int __init md_init(void)
 	for (minor=0; minor < MAX_MD_DEVS; ++minor) {
 		devfs_mk_bdev(MKDEV(MAJOR_NR, minor),
 				S_IFBLK|S_IRUSR|S_IWUSR,
-				"md/%d", minor);
+				"md%d", minor);
 	}
 
 	register_reboot_notifier(&md_notifier);
@@ -3567,7 +3567,7 @@ static __exit void md_exit(void)
 	int i;
 	blk_unregister_region(MKDEV(MAJOR_NR,0), MAX_MD_DEVS);
 	for (i=0; i < MAX_MD_DEVS; i++)
-		devfs_remove("md/%d", i);
+		devfs_remove("md%d", i);
 	devfs_remove("md");
 
 	unregister_blkdev(MAJOR_NR,"md");

_

