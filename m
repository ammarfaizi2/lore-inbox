Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbUBLP5s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 10:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUBLP5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 10:57:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:12217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264300AbUBLP5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 10:57:46 -0500
Date: Thu, 12 Feb 2004 07:57:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PPC64 PowerMac G5 support available
In-Reply-To: <1076563481.2285.167.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402120757120.5816@home.osdl.org>
References: <1076563481.2285.167.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> Finally, ieee1394 triggers an oops in kobject since 2.6.3-rc2, 100%
> reproduceable for me (and apparently x86 users too), so that's also
> unrelated to the G5 code.

Does the appended fix it?

		Linus

---
===== drivers/base/bus.c 1.52 vs edited =====
--- 1.52/drivers/base/bus.c	Tue Sep 30 08:59:35 2003
+++ edited/drivers/base/bus.c	Thu Feb 12 07:40:44 2004
@@ -158,17 +158,18 @@
 int bus_for_each_dev(struct bus_type * bus, struct device * start, 
 		     void * data, int (*fn)(struct device *, void *))
 {
-	struct list_head * head, * entry;
+	struct device *dev;
+	struct list_head * head;
 	int error = 0;
 
 	if (!(bus = get_bus(bus)))
 		return -EINVAL;
 
-	head = start ? &start->bus_list : &bus->devices.list;
+	head = &bus->devices.list;
+	dev = start ? : to_dev(head);
 
 	down_read(&bus->subsys.rwsem);
-	list_for_each(entry,head) {
-		struct device * dev = get_device(to_dev(entry));
+	list_for_each_entry_continue(dev, head, node) {
 		error = fn(dev,data);
 		put_device(dev);
 		if (error)
