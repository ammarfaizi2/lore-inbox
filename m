Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267213AbTAHLxF>; Wed, 8 Jan 2003 06:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbTAHLxF>; Wed, 8 Jan 2003 06:53:05 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:1204 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267213AbTAHLwe>;
	Wed, 8 Jan 2003 06:52:34 -0500
Date: Wed, 8 Jan 2003 23:01:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] {get,put}_compat_timspec 5/8 ia64
Message-Id: <20030108230101.4693f4d4.sfr@canb.auug.org.au>
In-Reply-To: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
References: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Here is the ia64 part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301081106-32bit.2/arch/ia64/ia32/ia32_signal.c 2.5.54-200301081106-32bit.3/arch/ia64/ia32/ia32_signal.c
--- 2.5.54-200301081106-32bit.2/arch/ia64/ia32/ia32_signal.c	2002-12-27 15:15:38.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/arch/ia64/ia32/ia32_signal.c	2003-01-08 17:05:48.000000000 +1100
@@ -607,14 +607,11 @@
 
 	if (copy_from_user(&s.sig, uthese, sizeof(sigset32_t)))
 		return -EFAULT;
-	if (uts) {
-		ret = get_user(t.tv_sec, &uts->tv_sec);
-		ret |= get_user(t.tv_nsec, &uts->tv_nsec);
-		if (ret)
-			return -EFAULT;
-	}
+	if (uts && get_compat_timespec(&t, uts))
+		return -EFAULT;
 	set_fs(KERNEL_DS);
-	ret = sys_rt_sigtimedwait(&s, &info, &t, sigsetsize);
+	ret = sys_rt_sigtimedwait(&s, uinfo ? &info : NULL, uts ? &t : NULL,
+			sigsetsize);
 	set_fs(old_fs);
 	if (ret >= 0 && uinfo) {
 		if (copy_siginfo_to_user32(uinfo, &info))
diff -ruN 2.5.54-200301081106-32bit.2/arch/ia64/ia32/sys_ia32.c 2.5.54-200301081106-32bit.3/arch/ia64/ia32/sys_ia32.c
--- 2.5.54-200301081106-32bit.2/arch/ia64/ia32/sys_ia32.c	2003-01-08 12:03:33.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/arch/ia64/ia32/sys_ia32.c	2003-01-08 17:08:05.000000000 +1100
@@ -3536,7 +3536,7 @@
 	set_fs(KERNEL_DS);
 	ret = sys_sched_rr_get_interval(pid, &t);
 	set_fs(old_fs);
-	if (put_user (t.tv_sec, &interval->tv_sec) || put_user (t.tv_nsec, &interval->tv_nsec))
+	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
 	return ret;
 }
