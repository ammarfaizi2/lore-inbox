Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbVGHUML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbVGHUML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVGHUKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:10:05 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22532 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262856AbVGHUHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:07:08 -0400
Date: Fri, 8 Jul 2005 22:07:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: akpm@osdl.org
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: [-mm patch] is_broadcast_ether_addr() is still required
Message-ID: <20050708200704.GH3671@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch by Bernhard Rosenkraenzer <bero@arklinux.org> is still 
required to fix the following compile error:

<--  snip  -->

...
  CC      drivers/net/wireless/ipw2200.o
...
drivers/net/wireless/ipw2200.c: In function `ipw_rx':
drivers/net/wireless/ipw2200.c:4937: warning: implicit declaration of function `is_broadcast_ether_addr'
...
  CC      net/ieee80211/ieee80211_tx.o
net/ieee80211/ieee80211_tx.c: In function `ieee80211_xmit':
net/ieee80211/ieee80211_tx.c:341: warning: implicit declaration of function `is_broadcast_ether_addr'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x422abc): In function `ipw_rx':
: undefined reference to `is_broadcast_ether_addr'
drivers/built-in.o(.text+0x4233f6): In function `ipw_rx':
: undefined reference to `is_broadcast_ether_addr'
drivers/built-in.o(.text+0x426b9f): In function 
`ipw_net_hard_start_xmit':
: undefined reference to `is_broadcast_ether_addr'
drivers/built-in.o(.text+0x426f9d): In function 
`ipw_net_hard_start_xmit':
: undefined reference to `is_broadcast_ether_addr'
net/built-in.o(.text+0x1e73c6): In function `ieee80211_xmit':
: undefined reference to `is_broadcast_ether_addr'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


is_broadcast_ether_addr() was removed but it's still used.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc1/include/net/ieee80211.h.ark	2005-07-01 17:46:22.000000000 +0200
+++ linux-2.6.13-rc1/include/net/ieee80211.h	2005-07-01 17:47:26.000000000 +0200
@@ -627,6 +627,11 @@
 #define MAC_FMT "%02x:%02x:%02x:%02x:%02x:%02x"
 #define MAC_ARG(x) ((u8*)(x))[0],((u8*)(x))[1],((u8*)(x))[2],((u8*)(x))[3],((u8*)(x))[4],((u8*)(x))[5]
 
+extern inline int is_broadcast_ether_addr(const u8 *addr)
+{
+	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&
+		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
+}
 
 #define CFG_IEEE80211_RESERVE_FCS (1<<0)
 #define CFG_IEEE80211_COMPUTE_FCS (1<<1)


