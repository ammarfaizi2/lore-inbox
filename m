Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267237AbTAHL4D>; Wed, 8 Jan 2003 06:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTAHL4C>; Wed, 8 Jan 2003 06:56:02 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:20660 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267237AbTAHLzw>;
	Wed, 8 Jan 2003 06:55:52 -0500
Date: Wed, 8 Jan 2003 23:04:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: [PATCH][COMPAT] {get,put}_compat_timspec 6/8 s390x
Message-Id: <20030108230424.183dfe68.sfr@canb.auug.org.au>
In-Reply-To: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
References: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the s390x part of the patch. Martin has said that I should feed
these straight to you and he will fix up any problems later.  Please apply
if you apply the gerneic part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301081106-32bit.2/arch/s390x/kernel/linux32.c 2.5.54-200301081106-32bit.3/arch/s390x/kernel/linux32.c
--- 2.5.54-200301081106-32bit.2/arch/s390x/kernel/linux32.c	2003-01-08 11:40:35.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/arch/s390x/kernel/linux32.c	2003-01-08 17:14:08.000000000 +1100
@@ -1671,8 +1671,7 @@
 	set_fs (KERNEL_DS);
 	ret = sys_sched_rr_get_interval(pid, &t);
 	set_fs (old_fs);
-	if (put_user (t.tv_sec, &interval->tv_sec) ||
-	    __put_user (t.tv_nsec, &interval->tv_nsec))
+	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
 	return ret;
 }
@@ -1806,8 +1805,7 @@
 	signotset(&these);
 
 	if (uts) {
-		if (get_user (ts.tv_sec, &uts->tv_sec) ||
-		    get_user (ts.tv_nsec, &uts->tv_nsec))
+		if (get_compat_timespec(&ts, uts))
 			return -EINVAL;
 		if (ts.tv_nsec >= 1000000000L || ts.tv_nsec < 0
 		    || ts.tv_sec < 0)
@@ -4149,13 +4147,12 @@
 	mm_segment_t old_fs;
 	int ret;
 
-	if (get_user (tmp.tv_sec,  &timeout32->tv_sec)  ||
-	    get_user (tmp.tv_nsec, &timeout32->tv_nsec))
+	if (timeout32 && get_compat_timespec(&tmp, timeout32))
 		return -EINVAL;
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
-	ret = sys_futex(uaddr, op, val, &tmp);
+	ret = sys_futex(uaddr, op, val, timeout32 ? &tmp : NULL);
 	set_fs(old_fs);
 
 	return ret;
