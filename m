Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVIKSTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVIKSTc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVIKSTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:19:32 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:52674 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S965009AbVIKSTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:19:32 -0400
Date: Sun, 11 Sep 2005 21:19:19 +0300
From: mikukkon@iki.fi
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix allnoconfig compile with gcc 4 (take 2)
Message-ID: <20050911181919.GA1096@miku.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With allnoconfig and gcc 4 from SUSE 10 RC1:
	gcc version 4.0.2 20050901 (prerelease) (SUSE Linux)
I get following error:
  CC      init/main.o
In file included from include/linux/netdevice.h:29,
		 from include/net/sock.h:48,
		 from init/main.c:50:
include/linux/if_ether.h:114: error: array type has incomplete element type

Fixed by surrounding offending line with #ifdef CONFIG_SYSCTL as
discussed.

When I turned CONFIG_NET and CONFIG_SYSCTL on, I noticed also that
net/sysctl_net.c should #include <net/sock.h> unconditionally to avoid
similar error with core_table[] (also fixed in following patch).

Signed-of-by: Mika Kukkonen <mikukkon@iki.fi>

Index: linux-2.6/net/sysctl_net.c
===================================================================
--- linux-2.6.orig/net/sysctl_net.c
+++ linux-2.6/net/sysctl_net.c
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/sysctl.h>
+#include <net/sock.h>
 
 #ifdef CONFIG_INET
 #include <net/ip.h>
Index: linux-2.6/include/linux/if_ether.h
===================================================================
--- linux-2.6.orig/include/linux/if_ether.h
+++ linux-2.6/include/linux/if_ether.h
@@ -111,7 +111,10 @@ static inline struct ethhdr *eth_hdr(con
 	return (struct ethhdr *)skb->mac.raw;
 }
 
+#ifdef CONFIG_SYSCTL
 extern struct ctl_table ether_table[];
 #endif
 
+#endif
+
 #endif	/* _LINUX_IF_ETHER_H */
