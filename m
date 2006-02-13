Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWBMG6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWBMG6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 01:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWBMG6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 01:58:15 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:3152 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750997AbWBMG6O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 01:58:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=P3DCncnWSy9skijeXgMZoqtGTnzfedvwBnakUJr6Ir9vlQVXPrCnTj00HoDJiAnZk5uyisnxYC7i7nuS6PT7nEGIXtGHnXHcSEwHhMplm/KCN+A+DZ6Vkw8Wo6pvd9+7rrtcK/2JjXEt8NhT8mHy9Q5miv9uwZN+jjrdE638Rps=
Message-ID: <cfb54190602122258j147d77e8ndbe40f4db57bf23a@mail.gmail.com>
Date: Mon, 13 Feb 2006 08:58:14 +0200
From: Hai Zaar <haizaar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: setting CONFIG_HZ=2000 makes ntpd go crazy
Cc: "Yanover, Igor" <igor.yanover@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,
I use the patch below to speed up HZ from 1000 to 2000. I use this hack
starting from kernel  2.6.7 and I have not experienced any particular
problems. Recently I've started to use NTP and  have noticed that ntp
client loose synchronization, if this patch is applied, i.e. it
connects, synchronizes, and then after a few polls,  jitter just jumps
to 5 digit number. I've rechecked the behavior on the kernel 2.6.11
and results are the same - applied patch just "skews up" ntpd, while
there are no any problems with vanilla kernels.

Is the patch incorrect in any way?

P.S. I'm not on the list, so please CC me. Thanks.
-------------------------------------------------------------------------------------------------------------------
The patch ajusts kernel internal clock timer to 2000HZ instead of 1000HZ. This
is required to decrease response time of some drivers (currently rocket.ko).

Author:	Igor Yanover <igor@yanover.name>
Crafted for 2.6.15 by:	Michael Goldman <haizaar@gmail.com>

--- kernel-2.6.15/include/linux/jiffies.h.orig	2006-02-07
12:59:20.000000000 +0200
+++ kernel-2.6.15/include/linux/jiffies.h	2006-02-07 13:00:50.000000000 +0200
@@ -38,6 +38,8 @@
 # define SHIFT_HZ	9
  #elif HZ >= 768 && HZ < 1536
 # define SHIFT_HZ	10
+#elif HZ >= 1536 && HZ < 3072
+# define SHIFT_HZ  11
 #else
 # error You lose.
 #endif
--- kernel-2.6.15/kernel/Kconfig.hz.orig	2006-01-03 05:21:10.000000000 +0200
+++ kernel-2.6.15/kernel/Kconfig.hz	2006-02-07 18:44:03.000000000 +0200
@@ -36,6 +36,11 @@
 	 1000 HZ is the preferred choice for desktop systems and other
 	 systems requiring fast interactive responses to events.

+	config HZ_2000
+		bool "2000 HZ"
+	help
+	 2000 HZ is hand crafted for software realtime. Use on your own risk.
+
 endchoice

 config HZ
@@ -43,4 +48,5 @@
 	default 100 if HZ_100
 	default 250 if HZ_250
 	default 1000 if HZ_1000
+	default 2000 if HZ_2000


--
Zaar
