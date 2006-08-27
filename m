Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWH0HiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWH0HiL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 03:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWH0HiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 03:38:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10724
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750768AbWH0HiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 03:38:09 -0400
Date: Sun, 27 Aug 2006 00:38:00 -0700 (PDT)
Message-Id: <20060827.003800.95504796.davem@davemloft.net>
To: akpm@osdl.org
Cc: miles.lane@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jeremy@goop.org
Subject: Re: 2.6.18-rc4-mm[1,2,3] -- Network card not getting assigned an
 "eth" device name
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060827001943.c559d37d.akpm@osdl.org>
References: <a44ae5cd0608270007gc6a919fx9e36562d8023635d@mail.gmail.com>
	<20060827001943.c559d37d.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 27 Aug 2006 00:19:43 -0700

> Jeremy reported that a while back too.  I do not know what is causing it
> and as far as I know no net developers have yet looked into it.

A debugging patch like this one should help figure out the culprit.

If we don't see the gibberish netdevice name printed in the kernel
logs, then likely something is corrupting the netdevice structure or
the memory holding the name.

diff --git a/net/core/dev.c b/net/core/dev.c
index d4a1ec3..45f9b19 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -738,6 +738,11 @@ int dev_change_name(struct net_device *d
 
 	if (!dev_valid_name(newname))
 		return -EINVAL;
+#if 1
+	printk("[%s:%d]: Changing netdevice name from [%s] to [%s]\n",
+	       current->comm, current->pid,
+	       dev->name, newname);
+#endif
 
 	if (strchr(newname, '%')) {
 		err = dev_alloc_name(dev, newname);
