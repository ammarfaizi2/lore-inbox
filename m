Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWAEN7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWAEN7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWAEN7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:59:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35088 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750831AbWAEN7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:59:44 -0500
Date: Thu, 5 Jan 2006 14:59:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: wensong@linux-vs.org, horms@verge.net.au, ja@ssi.bg
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix ipvs compilation
Message-ID: <20060105135943.GA3831@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know which change broke it, but I'm getting the following 
compile error in Linus' tree:

<--  snip  -->

...
  CC      net/ipv4/ipvs/ip_vs_sched.o
net/ipv4/ipvs/ip_vs_sched.c: In function 'ip_vs_sched_getbyname':
net/ipv4/ipvs/ip_vs_sched.c:110: warning: implicit declaration of function 'local_bh_disable'
net/ipv4/ipvs/ip_vs_sched.c:124: warning: implicit declaration of function 'local_bh_enable'
...
  CC      net/ipv4/ipvs/ip_vs_est.o
net/ipv4/ipvs/ip_vs_est.c: In function 'ip_vs_new_estimator':
net/ipv4/ipvs/ip_vs_est.c:147: warning: implicit declaration of function 'local_bh_disable'
net/ipv4/ipvs/ip_vs_est.c:156: warning: implicit declaration of function 'local_bh_enable'
...
  LD      .tmp_vmlinux1
net/built-in.o: In function `ip_vs_sched_getbyname':ip_vs_sched.c:(.text+0x99cfa): undefined reference to `local_bh_disable'
net/built-in.o: In function `register_ip_vs_scheduler': undefined reference to `local_bh_disable'
net/built-in.o: In function `unregister_ip_vs_scheduler': undefined reference to `local_bh_disable'
net/built-in.o: In function `ip_vs_new_estimator': undefined reference to `local_bh_disable'
net/built-in.o: In function `ip_vs_kill_estimator': undefined reference to `local_bh_disable'
net/built-in.o: more undefined references to `local_bh_disable' follow
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


This patch fixes them by #include'ing linux/interrupt.h.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-git/net/ipv4/ipvs/ip_vs_sched.c.old	2006-01-05 14:56:44.000000000 +0100
+++ linux-git/net/ipv4/ipvs/ip_vs_sched.c	2006-01-05 14:56:59.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 #include <asm/string.h>
 #include <linux/kmod.h>
 
--- linux-git/net/ipv4/ipvs/ip_vs_est.c.old	2006-01-05 14:57:15.000000000 +0100
+++ linux-git/net/ipv4/ipvs/ip_vs_est.c	2006-01-05 14:57:27.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/interrupt.h>
 
 #include <net/ip_vs.h>
 

