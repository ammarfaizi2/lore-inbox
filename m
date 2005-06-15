Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVFOXBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVFOXBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVFOW7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:59:32 -0400
Received: from mail.dif.dk ([193.138.115.101]:30172 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261619AbVFOWz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:55:59 -0400
Date: Thu, 16 Jun 2005 01:01:21 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
       Corey Minyard <wf-rch!minyard@relay.EU.net>,
       "Donald J. Becker" <becker@cesdis.gsfc.nasa.gov>,
       Alan Cox <Alan.Cox@linux.org>, "Bjorn Ekwall." <bj0rn@blox.se>,
       Pekka Riikonen <priikone@poseidon.pspt.fi>
Subject: [PATCH] fix gcc -W warning in netdevice.h
Message-ID: <Pine.LNX.4.62.0506160053210.3842@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This might be a slightly controversial patch in that it adds a cast purely 
to shut up a gcc -W warning, but this header file is used in *lots* of 
places, so when building with gcc -W this warning shows up all over the 
place :
	include/linux/netdevice.h:781: warning: comparison between signed and unsigned
With my normal .config I over 120 instances of this one, so shutting it up 
cuts down on the stuff I have to wade through to try and spot real 
potential problems quite a bit.
The cast is completely harmless since the unsigned value that gcc is 
complaining about will never exceed the storage capacity of a plain int, 
and it will not change any actual code behaviour.

Please consider merging.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 include/linux/netdevice.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc6-mm1-orig/include/linux/netdevice.h	2005-06-12 15:58:58.000000000 +0200
+++ linux-2.6.12-rc6-mm1/include/linux/netdevice.h	2005-06-16 00:52:14.000000000 +0200
@@ -778,7 +778,7 @@ enum {
 static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 {
 	/* use default */
-	if (debug_value < 0 || debug_value >= (sizeof(u32) * 8))
+	if (debug_value < 0 || debug_value >= (int)(sizeof(u32) * 8))
 		return default_msg_enable_bits;
 	if (debug_value == 0)	/* no output */
 		return 0;



