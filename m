Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbTAHLdU>; Wed, 8 Jan 2003 06:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTAHLdT>; Wed, 8 Jan 2003 06:33:19 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:26802 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267242AbTAHLdS>;
	Wed, 8 Jan 2003 06:33:18 -0500
Date: Wed, 8 Jan 2003 22:41:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: anton@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] {get,put}_compat_timspec 2/8 ppc64
Message-Id: <20030108224151.6df670ae.sfr@canb.auug.org.au>
In-Reply-To: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
References: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

The ppc64 part.  This is relative to my previous patches.

This patch also fixes a strange bit of code in sys32_rt_sigtimedwait.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301081106-32bit.2/arch/ppc64/kernel/signal32.c 2.5.54-200301081106-32bit.3/arch/ppc64/kernel/signal32.c
--- 2.5.54-200301081106-32bit.2/arch/ppc64/kernel/signal32.c	2003-01-08 11:40:34.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/arch/ppc64/kernel/signal32.c	2003-01-08 17:17:13.000000000 +1100
@@ -720,18 +720,11 @@
 	case 2: s.sig[1] = s32.sig[2] | (((long)s32.sig[3]) << 32);
 	case 1: s.sig[0] = s32.sig[0] | (((long)s32.sig[1]) << 32);
 	}
-	if (uts) {
-		ret = get_user(t.tv_sec, &uts->tv_sec);
-		ret |= __get_user(t.tv_nsec, &uts->tv_nsec);
-		if (ret)
-			return -EFAULT;
-	}
+	if (uts && get_compat_timespec(&t, uts))
+		return -EFAULT;
 	set_fs(KERNEL_DS);
-	if (uts) 
-		ret = sys_rt_sigtimedwait(&s, &info, &t, sigsetsize);
-	else
-		ret = sys_rt_sigtimedwait(&s, &info, (struct timespec *)uts,
-				sigsetsize);
+	ret = sys_rt_sigtimedwait(&s, uinfo ? &info : NULL, uts ? &t : NULL,
+			sigsetsize);
 	set_fs(old_fs);
 	if (ret >= 0 && uinfo) {
 		if (copy_siginfo_to_user32(uinfo, &info))
diff -ruN 2.5.54-200301081106-32bit.2/arch/ppc64/kernel/sys_ppc32.c 2.5.54-200301081106-32bit.3/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.54-200301081106-32bit.2/arch/ppc64/kernel/sys_ppc32.c	2003-01-08 11:40:35.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/arch/ppc64/kernel/sys_ppc32.c	2003-01-08 17:17:55.000000000 +1100
@@ -3603,10 +3603,8 @@
 	set_fs (KERNEL_DS);
 	ret = sys_sched_rr_get_interval((int)pid, &t);
 	set_fs (old_fs);
-	if (put_user (t.tv_sec, &interval->tv_sec) ||
-	    __put_user (t.tv_nsec, &interval->tv_nsec))
+	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
-	
 	return ret;
 }
 

