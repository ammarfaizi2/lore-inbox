Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267151AbTAHLpX>; Wed, 8 Jan 2003 06:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267179AbTAHLpX>; Wed, 8 Jan 2003 06:45:23 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:24499 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267151AbTAHLpS>;
	Wed, 8 Jan 2003 06:45:18 -0500
Date: Wed, 8 Jan 2003 22:53:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ak@muc.de
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] {get,put}_compat_timspec 4/8 x86_64
Message-Id: <20030108225351.69782b43.sfr@canb.auug.org.au>
In-Reply-To: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
References: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

You asked for it ... x86_64 part.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301081106-32bit.2/arch/x86_64/ia32/ipc32.c 2.5.54-200301081106-32bit.3/arch/x86_64/ia32/ipc32.c
--- 2.5.54-200301081106-32bit.2/arch/x86_64/ia32/ipc32.c	2003-01-08 11:40:39.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/arch/x86_64/ia32/ipc32.c	2003-01-08 16:43:42.000000000 +1100
@@ -626,9 +626,7 @@
 		return -E2BIG;
 	if (!access_ok(VERIFY_READ, sb, nsops * sizeof(struct sembuf)))
 		return -EFAULT; 
-	if (ts32 && 
-	    (get_user(ts.tv_sec, &ts32->tv_sec)  || 
-	     __get_user(ts.tv_nsec, &ts32->tv_nsec)))
+	if (ts32 && get_compat_timespec(&ts, ts32))
 		return -EFAULT;
 
 	set_fs(KERNEL_DS);  
diff -ruN 2.5.54-200301081106-32bit.2/arch/x86_64/ia32/sys_ia32.c 2.5.54-200301081106-32bit.3/arch/x86_64/ia32/sys_ia32.c
--- 2.5.54-200301081106-32bit.2/arch/x86_64/ia32/sys_ia32.c	2003-01-08 11:40:39.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/arch/x86_64/ia32/sys_ia32.c	2003-01-08 17:19:37.000000000 +1100
@@ -1271,9 +1271,7 @@
 	set_fs (KERNEL_DS);
 	ret = sys_sched_rr_get_interval(pid, &t);
 	set_fs (old_fs);
-	if (verify_area(VERIFY_WRITE, interval, sizeof(struct compat_timespec)) ||
-	    __put_user (t.tv_sec, &interval->tv_sec) ||
-	    __put_user (t.tv_nsec, &interval->tv_nsec))
+	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
 	return ret;
 }
@@ -1440,14 +1438,11 @@
 	case 2: s.sig[1] = s32.sig[2] | (((long)s32.sig[3]) << 32);
 	case 1: s.sig[0] = s32.sig[0] | (((long)s32.sig[1]) << 32);
 	}
-	if (uts) {
-		if (verify_area(VERIFY_READ, uts, sizeof(struct compat_timespec)) ||
-		    __get_user (t.tv_sec, &uts->tv_sec) ||
-		    __get_user (t.tv_nsec, &uts->tv_nsec))
-			return -EFAULT;
-	}
+	if (uts && get_compat_timespec(&t, uts))
+		return -EFAULT;
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigtimedwait(&s, &info, &t, sigsetsize);
+	ret = sys_rt_sigtimedwait(&s, uinfo ? &info : NULL, uts ? &t : NULL,
+			sigsetsize);
 	set_fs (old_fs);
 	if (ret >= 0 && uinfo) {
 		if (copy_to_user (uinfo, siginfo64to32(&info32, &info),
@@ -2300,20 +2295,13 @@
 	mm_segment_t oldfs = get_fs(); 
 	int err;
 
-	if (utime32) {
-		if (verify_area(VERIFY_READ, utime32, sizeof(*utime32)))
-			return -EFAULT;
-
-		if (__get_user(t.tv_sec, &utime32->tv_sec) ||
-		    __get_user(t.tv_nsec, &utime32->tv_nsec))
-			return -EFAULT;
-		
-	}
+	if (utime32 && get_compat_timespec(&t, utime32))
+		return -EFAULT;
 
 	/* the set_fs is safe because futex doesn't use the seg limit 
 	   for valid page checking of uaddr. */ 
 	set_fs(KERNEL_DS); 
-	err = sys_futex(uaddr, op, val, &t);
+	err = sys_futex(uaddr, op, val, utime32 ? &t : NULL);
 	set_fs(oldfs); 
 	return err; 
 }
@@ -2392,22 +2380,18 @@
 { 	
 	long ret;
 	mm_segment_t oldfs; 
-	struct timespec t32;
+	struct timespec t;
 	/* Harden against bogus ptrace */
 	if (nr >= 0xffffffff || 
 	    !access_ok(VERIFY_WRITE, events, nr * sizeof(struct io_event)))
 		return -EFAULT;
-	if (timeout && 
-	    (get_user(t32.tv_sec, &timeout->tv_sec)  || 
-	     __get_user(t32.tv_nsec, &timeout->tv_nsec)))
+	if (timeout && get_compat_timespec(&t, timeout))
 		return -EFAULT; 
 	oldfs = get_fs();
 	set_fs(KERNEL_DS); 
-	ret = sys_io_getevents(ctx_id,min_nr,nr,events,timeout ? &t32 : NULL); 
+	ret = sys_io_getevents(ctx_id,min_nr,nr,events,timeout ? &t : NULL); 
 	set_fs(oldfs); 
-	if (timeout && 
-	    (__put_user(t32.tv_sec, &timeout->tv_sec) || 
-	     __put_user(t32.tv_nsec, &timeout->tv_nsec)))
+	if (timeout && put_compat_timespec(&t, timeout))
 		return -EFAULT; 		
 	return ret;
 } 
