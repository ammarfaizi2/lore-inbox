Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTJWEmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 00:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTJWEmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 00:42:43 -0400
Received: from dp.samba.org ([66.70.73.150]:37796 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261463AbTJWEml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 00:42:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Erik van Konijnenburg <ekonijn@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 2.6.0-test8] MODULE_ALIAS_BLOCK 
In-reply-to: Your message of "Tue, 21 Oct 2003 23:20:22 +0200."
             <20031021232022.A19672@banaan.localdomain> 
Date: Thu, 23 Oct 2003 14:11:10 +1000
Message-Id: <20031023044241.309A52C0CC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031021232022.A19672@banaan.localdomain> you write:
> 
> Hi Rusty,
> 
> Automatic loading of the loop device does not work under 2.6.0-test8
> unless the loop device is explicitly mentioned in /etc/modules.conf.
> This shows up when doing a kernel make install: mkinitrd uses the
> loopback device.
> 
> This is because loop.c does not have MODULE_ALIAS_BLOCKDEV.
> After adding that, the following problem shows: a mismatch between
> the use of request_module in drivers/block/genhd.c:
> 
> 	request_module("block-major-%d", MAJOR(dev));
> 
> and the definition of MODULE_ALIAS_BLOCK in blkdev.h:
> 
> 	MODULE_ALIAS("block-major-" __stringify(major) "-*")
> 
> The following patch applies to 2.6.0-test8.  I tested under (mostly) RH9 that
> automatic loading of loop.ko works with this patch but not without it.
> The only other user of MODULE_ALIAS_BLOCK, floppy.c, also worked for
> me with this patch, no idea whether it works without.

Hmm.  Disagree with your change, prefer to go the other way.  Sure,
block drivers generally don't care about the minor, but (1) they might
one day, and (2) this matches with the way char devices are handled.

Linus, please apply.

Name: Block Alias Fix in genhd.c
Author: Rusty Russell
Status: Trivial

D: MODULE_ALIAS_BLOCK and genhd.c's request_module() don't match,
D: which breaks autoloading of loop devices.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2035-linux-2.6.0-test8-bk2/drivers/block/genhd.c .2035-linux-2.6.0-test8-bk2.updated/drivers/block/genhd.c
--- .2035-linux-2.6.0-test8-bk2/drivers/block/genhd.c	2003-10-09 18:02:51.000000000 +1000
+++ .2035-linux-2.6.0-test8-bk2.updated/drivers/block/genhd.c	2003-10-23 14:09:35.000000000 +1000
@@ -296,7 +296,7 @@ extern int blk_dev_init(void);
 
 static struct kobject *base_probe(dev_t dev, int *part, void *data)
 {
-	request_module("block-major-%d", MAJOR(dev));
+	request_module("block-major-%d-%d", MAJOR(dev), MINOR(dev));
 	return NULL;
 }
 


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
