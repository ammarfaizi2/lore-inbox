Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263409AbRFNRM5>; Thu, 14 Jun 2001 13:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbRFNRMs>; Thu, 14 Jun 2001 13:12:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12333 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263405AbRFNRMb>; Thu, 14 Jun 2001 13:12:31 -0400
Date: Thu, 14 Jun 2001 19:12:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@redhat.com>
Subject: unregistered changes to the user<->kernel API
Message-ID: <20010614191219.A30567@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of changes in kernel API visisble to userspace that
are unregistered in 2.4 mainline. I recommend to merge them ASAP to
avoid generating collisions across different versions of the kernel.

I'll attach here a number of patches that should make us to return in
sync. They must be applied incrementally. (really the very last one is
mostly here for comments, not intendeted for merging in mainline)

here the first that defines O_DIRECT (NOTE: the O_DIRECT value for alpha
is not definitive yet, O_DIRECTIO of tru64 is our O_NOFOLLOW so we're
just screwed as we just need a wrapper anyways to make complex programs like
dbms to run correctly without having to natively port them to linux,
02000000 in tru64 is O_DSYNC, maybe I should move it to 010000000
instead which maybe unused in tru64, but still we would have no
guarantee that it won't be used in the future, I was waiting Richard's
comment about it).

The sparc64 values are approved by Dave.

diff -urN 2.4.6pre3/include/asm-alpha/fcntl.h o_direct/include/asm-alpha/fcntl.h
--- 2.4.6pre3/include/asm-alpha/fcntl.h	Thu Nov 16 15:37:42 2000
+++ o_direct/include/asm-alpha/fcntl.h	Thu Jun 14 17:34:56 2001
@@ -17,10 +17,10 @@
 #define O_NDELAY	O_NONBLOCK
 #define O_SYNC		040000
 #define FASYNC		020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	040000	/* direct disk access - should check with OSF/1 */
 #define O_DIRECTORY	0100000	/* must be a directory */
 #define O_NOFOLLOW	0200000 /* don't follow links */
 #define O_LARGEFILE	0400000 /* will be set by the kernel on every open */
+#define O_DIRECT	02000000 /* direct disk access - should check with OSF/1 */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN 2.4.6pre3/include/asm-i386/fcntl.h o_direct/include/asm-i386/fcntl.h
--- 2.4.6pre3/include/asm-i386/fcntl.h	Thu Nov 16 15:37:33 2000
+++ o_direct/include/asm-i386/fcntl.h	Thu Jun 14 17:33:41 2001
@@ -16,7 +16,7 @@
 #define O_NDELAY	O_NONBLOCK
 #define O_SYNC		 010000
 #define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint - currently ignored */
+#define O_DIRECT	 040000	/* direct disk access hint */
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
diff -urN 2.4.6pre3/include/asm-sparc/fcntl.h o_direct/include/asm-sparc/fcntl.h
--- 2.4.6pre3/include/asm-sparc/fcntl.h	Thu Nov 16 15:37:42 2000
+++ o_direct/include/asm-sparc/fcntl.h	Thu Jun 14 17:33:41 2001
@@ -20,6 +20,7 @@
 #define O_DIRECTORY	0x10000	/* must be a directory */
 #define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
+#define O_DIRECT        0x100000 /* direct disk access hint */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN 2.4.6pre3/include/asm-sparc64/fcntl.h o_direct/include/asm-sparc64/fcntl.h
--- 2.4.6pre3/include/asm-sparc64/fcntl.h	Thu Nov 16 15:37:42 2000
+++ o_direct/include/asm-sparc64/fcntl.h	Thu Jun 14 17:33:41 2001
@@ -20,6 +20,8 @@
 #define O_DIRECTORY	0x10000	/* must be a directory */
 #define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
+#define O_DIRECT        0x100000 /* direct disk access hint */
+
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */


Here the second patch that defines the PF_ATOMICALLOC (strictly speaking
this is not visible from userspace but it also cleanups a bit the
definitions).

--- atomicalloc/include/linux/sched.h.~1~	Thu Apr 26 02:04:44 2001
+++ atomicalloc/include/linux/sched.h	Thu Apr 26 04:05:28 2001
@@ -403,18 +403,15 @@
 /*
  * Per process flags
  */
-#define PF_ALIGNWARN	0x00000001	/* Print alignment warning msgs */
-					/* Not implemented yet, only for 486*/
-#define PF_STARTING	0x00000002	/* being created */
-#define PF_EXITING	0x00000004	/* getting shut down */
-#define PF_FORKNOEXEC	0x00000040	/* forked but didn't exec */
-#define PF_SUPERPRIV	0x00000100	/* used super-user privileges */
-#define PF_DUMPCORE	0x00000200	/* dumped core */
-#define PF_SIGNALED	0x00000400	/* killed by a signal */
-#define PF_MEMALLOC	0x00000800	/* Allocating memory */
-#define PF_VFORK	0x00001000	/* Wake up parent in mm_release */
-
-#define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
+#define PF_EXITING	(1UL<<0)	/* getting shut down */
+#define PF_FORKNOEXEC	(1UL<<1)	/* forked but didn't exec */
+#define PF_SUPERPRIV	(1UL<<2)	/* used super-user privileges */
+#define PF_DUMPCORE	(1UL<<3)	/* dumped core */
+#define PF_SIGNALED	(1UL<<4)	/* killed by a signal */
+#define PF_MEMALLOC	(1UL<<5)	/* Allocating memory */
+#define PF_VFORK	(1UL<<6)	/* Wake up parent in mm_release */
+#define PF_USEDFPU	(1UL<<7)	/* task used FPU this quantum (SMP) */
+#define PF_ATOMICALLOC	(1UL<<8)	/* do not block during memalloc */
 
 /*
  * Ptrace flags


Here the third, it registers the tux syscall at for the alpha so other
people won't use such same syscall for something else (I didn't remove
the #ifdefs since they don't hurt as they're undefined in mainline).

diff -urN ref/arch/alpha/kernel/entry.S tuxsys/arch/alpha/kernel/entry.S
--- ref/arch/alpha/kernel/entry.S	Sat Apr 28 18:37:45 2001
+++ tuxsys/arch/alpha/kernel/entry.S	Sun Apr 29 17:52:44 2001
@@ -1004,7 +1004,15 @@
 	.quad alpha_ni_syscall
 	.quad alpha_ni_syscall			/* 220 */
 	.quad alpha_ni_syscall
+#ifdef CONFIG_TUX
+	.quad __sys_tux
+#else
+# ifdef CONFIG_TUX_MODULE
+	.quad sys_tux
+# else
 	.quad alpha_ni_syscall
+# endif
+#endif
 	.quad alpha_ni_syscall
 	.quad alpha_ni_syscall
 	.quad alpha_ni_syscall			/* 225 */
diff -urN ref/arch/i386/kernel/entry.S tuxsys/arch/i386/kernel/entry.S
--- ref/arch/i386/kernel/entry.S	Sun Apr 29 17:00:20 2001
+++ tuxsys/arch/i386/kernel/entry.S	Sun Apr 29 17:53:36 2001
@@ -645,7 +645,15 @@
 	.long SYMBOL_NAME(sys_madvise)
 	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
 	.long SYMBOL_NAME(sys_fcntl64)
+#ifdef CONFIG_TUX
+	.long SYMBOL_NAME(__sys_tux)
+#else
+# ifdef CONFIG_TUX_MODULE
+	.long SYMBOL_NAME(sys_tux)
+# else
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for TUX */
+# endif
+#endif
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)


Here the forth, this defines the O_ATOMICLOOKUP and EWOULDBLOCKIO for the
non blocking dcache and pagecache lookups (the LOOKUP_ATOMIC isn't
visible from userspace but I defined it since I was there, if you want
you can drop the include/linux/fs.h part of the patch):

diff -urN ref/include/asm-alpha/fcntl.h atomiclookup/include/asm-alpha/fcntl.h
--- ref/include/asm-alpha/fcntl.h	Thu Jun 14 17:46:45 2001
+++ atomiclookup/include/asm-alpha/fcntl.h	Thu Jun 14 17:47:18 2001
@@ -20,6 +20,7 @@
 #define O_DIRECTORY	0100000	/* must be a directory */
 #define O_NOFOLLOW	0200000 /* don't follow links */
 #define O_LARGEFILE	0400000 /* will be set by the kernel on every open */
+#define O_ATOMICLOOKUP  01000000 /* do atomic file lookup */
 #define O_DIRECT	02000000 /* direct disk access - should check with OSF/1 */
 
 #define F_DUPFD		0	/* dup */
diff -urN ref/include/asm-i386/fcntl.h atomiclookup/include/asm-i386/fcntl.h
--- ref/include/asm-i386/fcntl.h	Thu Jun 14 17:46:45 2001
+++ atomiclookup/include/asm-i386/fcntl.h	Thu Jun 14 17:47:01 2001
@@ -20,6 +20,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_ATOMICLOOKUP	01000000 /* do atomic file lookup */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN ref/include/asm-ia64/fcntl.h atomiclookup/include/asm-ia64/fcntl.h
--- ref/include/asm-ia64/fcntl.h	Thu Nov 16 15:37:42 2000
+++ atomiclookup/include/asm-ia64/fcntl.h	Thu Jun 14 17:47:01 2001
@@ -28,6 +28,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_ATOMICLOOKUP  01000000 /* do atomic file lookup */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN ref/include/asm-sparc/fcntl.h atomiclookup/include/asm-sparc/fcntl.h
--- ref/include/asm-sparc/fcntl.h	Thu Jun 14 17:46:45 2001
+++ atomiclookup/include/asm-sparc/fcntl.h	Thu Jun 14 17:47:01 2001
@@ -20,6 +20,7 @@
 #define O_DIRECTORY	0x10000	/* must be a directory */
 #define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
+#define O_ATOMICLOOKUP  0x80000 /* do atomic file lookup */
 #define O_DIRECT        0x100000 /* direct disk access hint */
 
 #define F_DUPFD		0	/* dup */
diff -urN ref/include/asm-sparc64/fcntl.h atomiclookup/include/asm-sparc64/fcntl.h
--- ref/include/asm-sparc64/fcntl.h	Thu Jun 14 17:46:45 2001
+++ atomiclookup/include/asm-sparc64/fcntl.h	Thu Jun 14 17:47:01 2001
@@ -20,6 +20,7 @@
 #define O_DIRECTORY	0x10000	/* must be a directory */
 #define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
+#define O_ATOMICLOOKUP  0x80000 /* do atomic file lookup */
 #define O_DIRECT        0x100000 /* direct disk access hint */
 
 
diff -urN ref/include/linux/errno.h atomiclookup/include/linux/errno.h
--- ref/include/linux/errno.h	Fri Feb 23 21:20:14 2001
+++ atomiclookup/include/linux/errno.h	Thu Jun 14 17:47:01 2001
@@ -21,6 +21,9 @@
 #define EBADTYPE	527	/* Type not supported by server */
 #define EJUKEBOX	528	/* Request initiated, but will not complete before timeout */
 
+/* Defined for TUX async IO */
+#define EWOULDBLOCKIO	530	/* Would block due to block-IO */
+
 #endif
 
 #endif
diff -urN ref/include/linux/fs.h atomiclookup/include/linux/fs.h
--- ref/include/linux/fs.h	Thu Jun 14 17:46:45 2001
+++ atomiclookup/include/linux/fs.h	Thu Jun 14 17:47:01 2001
@@ -1227,6 +1227,7 @@
 #define LOOKUP_POSITIVE		(8)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
+#define LOOKUP_ATOMIC		(64)
 /*
  * Type of the last component on LOOKUP_PARENT
  */

Here the fifth, this defines the tux sysctl numbers (OTOH the sysctl by
number gets broken all the time and nobody should use sysctl by number
with new sysctls anyways).

diff -urN 2.4.5pre5/include/linux/sysctl.h tux-sysctl/include/linux/sysctl.h
--- 2.4.5pre5/include/linux/sysctl.h	Tue May 22 22:04:27 2001
+++ tux-sysctl/include/linux/sysctl.h	Wed May 23 19:20:48 2001
@@ -157,7 +157,8 @@
 	NET_TR=14,
 	NET_DECNET=15,
 	NET_ECONET=16,
-	NET_KHTTPD=17
+	NET_KHTTPD=17,
+	NET_TUX=18
 };
 
 /* /proc/sys/kernel/random */
@@ -471,6 +472,55 @@
 	NET_DECNET_DST_GC_INTERVAL = 9,
 	NET_DECNET_CONF = 10,
 	NET_DECNET_DEBUG_LEVEL = 255
+};
+
+/* /proc/sys/net/tux/ */
+enum {
+	NET_TUX_DOCROOT			=  1,
+	NET_TUX_LOGFILE			=  2,
+	NET_TUX_EXTCGI			=  3,
+	NET_TUX_STOP			=  4,
+	NET_TUX_CLIENTPORT		=  5,
+	NET_TUX_LOGGING			=  6,
+	NET_TUX_SERVERPORT		=  7,
+	NET_TUX_THREADS			=  8,
+	NET_TUX_KEEPALIVE_TIMEOUT	=  9,
+	NET_TUX_MAX_KEEPALIVE_BW	= 10,
+	NET_TUX_DEFER_ACCEPT		= 11,
+	NET_TUX_MAX_FREE_REQUESTS	= 12,
+	NET_TUX_MAX_CONNECT		= 13,
+	NET_TUX_MAX_BACKLOG		= 14,
+	NET_TUX_MODE_FORBIDDEN		= 15,
+	NET_TUX_MODE_ALLOWED		= 16,
+	NET_TUX_MODE_USERSPACE		= 17,
+	NET_TUX_MODE_CGI		= 18,
+	NET_TUX_CGI_UID			= 19,
+	NET_TUX_CGI_GID			= 20,
+	NET_TUX_CGIROOT			= 21,
+	NET_TUX_LOGENTRY_ALIGN_ORDER	= 22,
+	NET_TUX_NONAGLE			= 23,
+	NET_TUX_ACK_PINGPONG		= 24,
+	NET_TUX_PUSH_ALL		= 25,
+	NET_TUX_ZEROCOPY_PARSE		= 26,
+	NET_CONFIG_TUX_DEBUG_BLOCKING	= 27,
+	NET_TUX_PAGE_AGE_START		= 28,
+	NET_TUX_PAGE_AGE_ADV		= 29,
+	NET_TUX_PAGE_AGE_MAX		= 30,
+	NET_TUX_VIRTUAL_SERVER		= 31,
+	NET_TUX_MAX_OBJECT_SIZE		= 32,
+	NET_TUX_COMPRESSION		= 33,
+	NET_TUX_NOID			= 34,
+	NET_TUX_CGI_INHERIT_CPU		= 35,
+	NET_TUX_CGI_CPU_MASK		= 36,
+	NET_TUX_ZEROCOPY_HEADER		= 37,
+	NET_TUX_ZEROCOPY_SENDFILE	= 38,
+	NET_TUX_ALL_USERSPACE		= 39,
+	NET_TUX_REDIRECT_LOGGING	= 40,
+	NET_TUX_REFERER_LOGGING		= 41,
+	NET_TUX_MAX_HEADER_LEN		= 42,
+	NET_TUX_404_PAGE		= 43,
+	NET_TUX_APPLICATION_PROTOCOL	= 44,
+	NET_TUX_MAX_KEEPALIVES		= 45,
 };
 
 /* /proc/sys/net/khttpd/ */


This last one gets visible in /proc/stat and I definitely hate it, it
should be really put somewhere else, it doesn't belong to /proc/stat, so
I'd vote to change tux to put it in a directory specific to tux that is
just present of course (but for now I'll keep it in my tree to avoid
generating userspace incompatibilities).

diff -urN 2.4.5pre5/fs/proc/proc_misc.c tux-kstat/fs/proc/proc_misc.c
--- 2.4.5pre5/fs/proc/proc_misc.c	Tue May  1 19:35:29 2001
+++ tux-kstat/fs/proc/proc_misc.c	Wed May 23 19:07:26 2001
@@ -259,6 +259,66 @@
 }
 #endif
 
+
+/*
+ * print out TUX internal statistics into /proc/stat.
+ * (Most of them are not maintained if CONFIG_TUX_DEBUG is off.)
+ */
+
+static int print_tux_procinfo (char *page)
+{
+	unsigned int len = 0, i;
+
+#define P(x) \
+	do { len += sprintf(page + len, #x ": %u\n", x); } while(0)
+
+	P(kstat.input_fastpath);
+	P(kstat.input_slowpath);
+	P(kstat.inputqueue_got_packet);
+	P(kstat.inputqueue_no_packet);
+	P(kstat.nr_keepalive_optimized);
+	P(kstat.parse_static_incomplete);
+	P(kstat.parse_static_redirect);
+	P(kstat.parse_static_cachemiss);
+	P(kstat.parse_static_nooutput);
+	P(kstat.parse_static_normal);
+	P(kstat.parse_dynamic_incomplete);
+	P(kstat.parse_dynamic_redirect);
+	P(kstat.parse_dynamic_cachemiss);
+	P(kstat.parse_dynamic_nooutput);
+	P(kstat.parse_dynamic_normal);
+	P(kstat.complete_parsing);
+	P(kstat.nr_free_pending);
+	P(kstat.nr_allocated);
+	P(kstat.nr_idle_input_pending);
+	P(kstat.nr_output_space_pending);
+	P(kstat.nr_input_pending);
+	P(kstat.nr_cachemiss_pending);
+	P(kstat.nr_secondary_pending);
+	P(kstat.nr_output_pending);
+	P(kstat.nr_redirect_pending);
+	P(kstat.nr_finish_pending);
+	P(kstat.nr_userspace_pending);
+	P(kstat.nr_postpone_pending);
+	P(kstat.static_lookup_cachemisses);
+	P(kstat.static_sendfile_cachemisses);
+	P(kstat.user_lookup_cachemisses);
+	P(kstat.user_fetch_cachemisses);
+	P(kstat.user_sendobject_cachemisses);
+	P(kstat.user_sendobject_write_misses);
+	P(kstat.nr_keepalive_reqs);
+	P(kstat.nr_nonkeepalive_reqs);
+
+	len += sprintf(page + len, "keephist: ");
+	for (i = 0; i < KEEPALIVE_HIST_SIZE; i++)
+		if (kstat.keepalive_hist[i])
+			len += sprintf(page + len, "%d(%d) ",
+					i, kstat.keepalive_hist[i]);
+	len += sprintf(page + len, "\n");
+#undef P
+
+	return len;
+}
 static int kstat_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -333,6 +393,8 @@
 		kstat.context_swtch,
 		xtime.tv_sec - jif / HZ,
 		total_forks);
+
+	len += print_tux_procinfo(page+len);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
diff -urN 2.4.5pre5/include/linux/kernel_stat.h tux-kstat/include/linux/kernel_stat.h
--- 2.4.5pre5/include/linux/kernel_stat.h	Tue May 15 21:40:17 2001
+++ tux-kstat/include/linux/kernel_stat.h	Wed May 23 19:06:38 2001
@@ -33,6 +33,53 @@
 	unsigned int ierrors, oerrors;
 	unsigned int collisions;
 	unsigned int context_swtch;
+	unsigned int context_swtch_cross;
+	unsigned int nr_free_pending;
+	unsigned int nr_allocated;
+	unsigned int nr_idle_input_pending;
+	unsigned int nr_output_space_pending;
+	unsigned int nr_work_pending;
+	unsigned int nr_input_pending;
+	unsigned int nr_cachemiss_pending;
+	unsigned int nr_secondary_pending;
+	unsigned int nr_output_pending;
+	unsigned int nr_redirect_pending;
+	unsigned int nr_postpone_pending;
+	unsigned int nr_finish_pending;
+	unsigned int nr_userspace_pending;
+	unsigned int static_lookup_cachemisses;
+	unsigned int static_sendfile_cachemisses;
+	unsigned int user_lookup_cachemisses;
+	unsigned int user_fetch_cachemisses;
+	unsigned int user_sendobject_cachemisses;
+	unsigned int user_sendobject_write_misses;
+	unsigned int user_sendbuf_cachemisses;
+	unsigned int user_sendbuf_write_misses;
+#define URL_HIST_SIZE 1000
+	unsigned int url_hist_hits[URL_HIST_SIZE];
+	unsigned int url_hist_misses[URL_HIST_SIZE];
+	unsigned int input_fastpath;
+	unsigned int input_slowpath;
+	unsigned int inputqueue_got_packet;
+	unsigned int inputqueue_no_packet;
+	unsigned int nr_keepalive_optimized;
+
+	unsigned int parse_static_incomplete;
+	unsigned int parse_static_redirect;
+	unsigned int parse_static_cachemiss;
+	unsigned int parse_static_nooutput;
+	unsigned int parse_static_normal;
+	unsigned int parse_dynamic_incomplete;
+	unsigned int parse_dynamic_redirect;
+	unsigned int parse_dynamic_cachemiss;
+	unsigned int parse_dynamic_nooutput;
+	unsigned int parse_dynamic_normal;
+	unsigned int complete_parsing;
+
+	unsigned int nr_keepalive_reqs;
+	unsigned int nr_nonkeepalive_reqs;
+#define KEEPALIVE_HIST_SIZE 100
+	unsigned int keepalive_hist[KEEPALIVE_HIST_SIZE];
 };
 
 extern struct kernel_stat kstat;


Andrea
