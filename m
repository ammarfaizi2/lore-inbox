Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316780AbSGVLlx>; Mon, 22 Jul 2002 07:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSGVLlw>; Mon, 22 Jul 2002 07:41:52 -0400
Received: from ente.physik3.uni-rostock.de ([139.30.44.38]:36370 "EHLO
	ente.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S316780AbSGVLlw>; Mon, 22 Jul 2002 07:41:52 -0400
Date: Mon, 22 Jul 2002 13:44:51 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: A Guy Called Tyketto <tyketto@wizard.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.27-dj1
In-Reply-To: <20020722014351.GA9901@wizard.com>
Message-ID: <Pine.LNX.4.33.0207221329250.2233-100000@ente.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002, A Guy Called Tyketto wrote:

> fs/fs.o: In function `proc_pid_stat':
> fs/fs.o(.text+0x2214b): undefined reference to `jiffies_64_to_clock_t'
> fs/fs.o: In function `kstat_read_proc':
> fs/fs.o(.text+0x232f3): undefined reference to `jiffies_64_to_clock_t'
> fs/fs.o(.text+0x2335a): undefined reference to `jiffies_64_to_clock_t'

The following patch adds the missing definition of
jiffies_64_to_clock_t(). It still applies to 2.5.27-dj1.

Tim


--- linux-2.5.25-dj2/include/linux/times.h	Sat Jul 13 08:40:21 2002
+++ linux-2.5.25-dj2-jfix/include/linux/times.h	Sat Jul 13 09:06:05 2002
@@ -2,7 +2,22 @@
 #define _LINUX_TIMES_H

 #ifdef __KERNEL__
+#include <asm/div64.h>
+#include <asm/types.h>
+
 # define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
+
+/*
+ * returning a different type than the function name says is
+ * ugly as hell, and only intended to stay until I know what type
+ * should replace clock_t
+ */
+
+static inline u64 jiffies_64_to_clock_t(u64 x)
+{
+	do_div(x, HZ / USER_HZ);
+	return x;
+}
 #endif

 struct tms {

