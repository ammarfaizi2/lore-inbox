Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUCPNsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUCPNsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:48:30 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:59092 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261682AbUCPNs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:48:27 -0500
Date: Tue, 16 Mar 2004 14:47:58 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Arthur Corliss <corliss@digitalmages.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix HZ leaking to userspace in BSD accounting
Message-ID: <Pine.LNX.4.53.0403161414150.19052@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BSD accounting was missed in the conversion from HZ to USER_HZ.
I thought nobody cared, but apparently there are still users to it.

A larger patch with binary compatible 32 uid/gid support etc. is currently
cooking, but we want to fix this as soon as possible, before distris
pick up 2.6.

Thanks,
Tim


--- linux-2.6.5-rc1/kernel/acct.c	2004-03-11 10:33:04.000000000 +0100
+++ linux-2.6.5-rc1-acct/kernel/acct.c	2004-03-16 13:48:13.000000000 +0100
@@ -52,6 +52,7 @@
 #include <linux/security.h>
 #include <linux/vfs.h>
 #include <linux/jiffies.h>
+#include <linux/times.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <linux/blkdev.h> /* sector_div */
@@ -336,13 +337,13 @@ static void do_acct_process(long exitcod
 
 	strlcpy(ac.ac_comm, current->comm, sizeof(ac.ac_comm));
 
-	elapsed = get_jiffies_64() - current->start_time;
+	elapsed = jiffies_64_to_clock_t(get_jiffies_64() - current->start_time);
 	ac.ac_etime = encode_comp_t(elapsed < (unsigned long) -1l ?
 	                       (unsigned long) elapsed : (unsigned long) -1l);
-	do_div(elapsed, HZ);
+	do_div(elapsed, USER_HZ);
 	ac.ac_btime = xtime.tv_sec - elapsed;
-	ac.ac_utime = encode_comp_t(current->utime);
-	ac.ac_stime = encode_comp_t(current->stime);
+	ac.ac_utime = encode_comp_t(jiffies_to_clock_t(current->utime));
+	ac.ac_stime = encode_comp_t(jiffies_to_clock_t(current->stime));
 	/* we really need to bite the bullet and change layout */
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
