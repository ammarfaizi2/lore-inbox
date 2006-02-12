Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWBLOyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWBLOyb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 09:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWBLOyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 09:54:31 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:30822 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750784AbWBLOya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 09:54:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=ZQriBcK8dBf8QWa/I+ghLB6ourdZKMS7bXLunevLSMHOZXcmnvfQXgE2lq8D3sIyVwugW9CJiR9oLNxZs5pKUeXG15EAhh/oLEbF5RShdGiWj5bRDayQM6bn1HLmpsGvJWsnVQQj51A2cM3r/g9fqlc7U2yVvtplVuwbJTzpacc=
Message-ID: <cfb54190602120654o3ca27733r2af5d2b0e9bc61cd@mail.gmail.com>
Date: Sun, 12 Feb 2006 16:54:29 +0200
From: Hai Zaar <haizaar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: setting CONFIG_HZ=2000 screws up ntpd
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1964_31653385.1139756069738"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1964_31653385.1139756069738
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear list,
I use attached patch to speed up HZ from 1000 to 2000. I use this hack
starting from kernel  2.6.7 and I have not experienced any particular
problems. Recently I've started to use NTP and  have noticed that ntp
client loose synchronization, if this patch is applied, i.e. it
connects, synchronizes, and then after a few polls,  jitter just jumps
to 5 digit number. I've rechecked the behavior on the kernel 2.6.11
and results are the same - applied patch just "skews up" ntpd, while
there are no any problems with vanilla kernels.

Is the patch incorrect in any way?

--
Zaar

------=_Part_1964_31653385.1139756069738
Content-Type: text/x-patch; name=kernel-2.6.15-2000HZ-2.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejlh24ya
Content-Disposition: attachment; filename="kernel-2.6.15-2000HZ-2.patch"

The patch ajusts kernel internal clock timer to 2000HZ instead of 1000HZ. This 
is required to decrease response time of some drivers (currently rocket.ko).

Author:	Igor Yanover <igor@yanover.name>
Crafted for 2.6.15 by:	Michael Goldman <haizaar@gmail.com>

--- kernel-2.6.15/include/linux/jiffies.h.orig	2006-02-07 12:59:20.000000000 +0200
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
 







------=_Part_1964_31653385.1139756069738--
