Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbTF1IX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 04:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTF1IX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 04:23:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:29065 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265135AbTF1IX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 04:23:56 -0400
Date: Sat, 28 Jun 2003 11:38:10 +0300
From: Dan Aloni <da-x@gmx.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: [TRIVIAL] avoid Oops in net/core/dev.c
Message-ID: <20030628083810.GA2793@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.
Patrick, please read on.

This fixes the kernel crash in the case when we do an SIOCSIFNAME
ioctl on /proc/net/dev to rename a network interface, and
we supply a string such as "foo%sbar".

BTW, I've seen more places of this phenomenon, but they
are not with strings that come right from userspace like
this one.

BTW2, the attempt to rename the device here doesn't affect
sysfs. Patrick, we need a class_device_* interface that does 
this.

--- linux-2.5.73/net/core/dev.c	2003-06-27 10:46:59.000000000 +0300
+++ linux-2.5.73/net/core/dev.c	2003-06-28 10:10:39.000000000 +0300
@@ -2346,7 +2346,7 @@
 				return -EEXIST;
 			memcpy(dev->name, ifr->ifr_newname, IFNAMSIZ);
 			dev->name[IFNAMSIZ - 1] = 0;
-			snprintf(dev->class_dev.class_id, BUS_ID_SIZE, dev->name);
+			strlcpy(dev->class_dev.class_id, dev->name, BUS_ID_SIZE);
 			notifier_call_chain(&netdev_chain,
 					    NETDEV_CHANGENAME, dev);
 			return 0;



-- 
Dan Aloni
da-x@gmx.net
