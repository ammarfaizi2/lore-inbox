Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUGVWw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUGVWw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 18:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267336AbUGVWw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 18:52:56 -0400
Received: from cinke.fazekas.hu ([195.199.63.65]:33424 "EHLO cinke.fazekas.hu")
	by vger.kernel.org with ESMTP id S267212AbUGVWwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 18:52:54 -0400
Date: Fri, 23 Jul 2004 00:52:48 +0200 (CEST)
From: Balint Marton <cus@fazekas.hu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] get_random_bytes returns the same on every boot
Message-ID: <Pine.LNX.4.58.0407222254440.3652@pingvin.fazekas.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

At boot time, get_random_bytes always returns the same random data, as if
there were a constant random seed. For example, if I use the kernel level
ip autoconfiguration with dhcp, the kernel will create a dhcp request
packet with always the same transaction ID. (If you have more than one
computers, and they are booting at the same time, then this is a big
problem)

That happens, because only the primary entropy pool is initialized with
the system time, in function rand_initialize. The secondary pool is only
cleared. In this early stage of booting, there is usually no user
interaction, or usable disk interrupts, so the kernel can't add any real
random bytes to the primary pool. And altough the system time is in the
primary pool, the kernel does not consider it real random data, so you
can't read from the primary pool, before at least a part of it will be
filled with some real randomness (interrupt timing).
Therefore all random data will come from the secondary pool, and the
kernel cannot reseed the secondary pool, because there is no real 
randomness in the primary one.

The solution is simple: Initialize not just the primary, but also the 
secondary pool with the system time. My patch worked for me with 
2.6.8-rc2, but it was not tested too long. 

--- linux-2.6.8-rc2.orig/drivers/char/random.c	2004-06-16 07:18:57.000000000 +0200
+++ linux-2.6.8-rc2/drivers/char/random.c	2004-07-22 21:06:28.000000000 +0200
@@ -1537,6 +1537,7 @@
 	clear_entropy_store(random_state);
 	clear_entropy_store(sec_random_state);
 	init_std_data(random_state);
+	init_std_data(sec_random_state);
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif

bye, 
	Cus
