Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVI1VnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVI1VnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVI1VnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:43:07 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:63562 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750988AbVI1VnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:43:05 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make if_ether.h compile with CONFIG_SYSCTL=n
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 28 Sep 2005 14:43:00 -0700
Message-ID: <52vf0kkgwr.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Sep 2005 21:43:01.0462 (UTC) FILETIME=[99735F60:01C5C475]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/if_ether.h> tries to declare a sysctl table even if
CONFIG_SYSCTL is not defined, which breaks the build as below:

      CC      init/main.o
    In file included from /scratch/Ksrc/linux-git/include/linux/netdevice.h:29,
                     from /scratch/Ksrc/linux-git/include/net/sock.h:48,
                     from /scratch/Ksrc/linux-git/init/main.c:50:
    /scratch/Ksrc/linux-git/include/linux/if_ether.h:114: error: array type has incomplete element type

This patch wraps the declaration inside an #ifdef CONFIG_SYSCTL and
fixes my allnoconfig build.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -104,6 +104,7 @@ struct ethhdr {
 } __attribute__((packed));
 
 #ifdef __KERNEL__
+#include <linux/config.h>
 #include <linux/skbuff.h>
 
 static inline struct ethhdr *eth_hdr(const struct sk_buff *skb)
@@ -111,7 +112,9 @@ static inline struct ethhdr *eth_hdr(con
 	return (struct ethhdr *)skb->mac.raw;
 }
 
+#ifdef CONFIG_SYSCTL
 extern struct ctl_table ether_table[];
 #endif
+#endif
 
 #endif	/* _LINUX_IF_ETHER_H */
