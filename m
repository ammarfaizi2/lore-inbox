Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSLPCMV>; Sun, 15 Dec 2002 21:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264795AbSLPCMV>; Sun, 15 Dec 2002 21:12:21 -0500
Received: from web13304.mail.yahoo.com ([216.136.175.40]:53605 "HELO
	web13304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264790AbSLPCMT>; Sun, 15 Dec 2002 21:12:19 -0500
Message-ID: <20021216022014.84302.qmail@web13304.mail.yahoo.com>
Date: Sun, 15 Dec 2002 18:20:14 -0800 (PST)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: subterfugue 0.2.1a for kernel testing - update
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SUBTERFUGUE UPDATE/PATCH:

  Since subterfugue is such a good tool for syscall tracing, &c, I have
updated syscallmap.table from syscallmap.py in the latest (0.2.1a) release
of subterfugue, to include all the syscalls added through kernel 2.5.51.

  It proved necessary to do this because of errors like the following:

$ sf --trick=Delay:delay=.000001 /bin/ls -l

Traceback (most recent call last):
  File "/usr/lib/subterfugue/subterfugue.py", line 572, in main
    do_main(allflags)
  File "/usr/lib/subterfugue/subterfugue.py", line 547, in do_main
    newkid = trace_syscall(wpid, flags, tricklist)
  File "/usr/lib/subterfugue/p_linux_i386.py", line 154, in trace_syscall
    assert (0 <= scno < len(syscallmap.table)
AssertionError: unknown system call (=229, ...


  Apparently some utilities (in this case from RH8) will attempt, in an
anticipatory manner, to use syscalls that _may_ be unimplemented in whatever
the current kernel happens to be (in this case 2.4.18):

$ strace ls -l

...
lstat64("COPYING", {st_mode=S_IFREG|0644, st_size=18454, ...}) = 0
getxattr("COPYING", "system.posix_acl_access", (nil), 0) = -1 ENOSYS
  (Function not implemented)
...


IMPLEMENTATION NOTE:

For those interested in doing further updating - the last field of
syscallmap.table is a tuple - 'None' stands for the empty tuple and a
non-empty tuple is presented only when the arg list for the given syscall 
includes one or more null-terminated strings.  Then it takes a form
such as:

    ( 3, TF,	"sys_open",		"open",	('P', None, None)),	# 5
                                                  ^   ^^^^   ^^^ 

where the 'P' in the tuple means a null-terminated string - in this case
it stands for the 'pathname' arg to open(2); and 'None,None' are placeholders
for the remaining non-string args.

RATIONALE (or rationalization):

  I don't consider posting this patch here to be off-topic since the majority
of the users of subterfugue are found right here on this list.



--------------------------------CUT HERE-------------------------------------
--- syscallmap.py.orig	2002-12-15 18:58:35.000000000 -0500
+++ syscallmap.py	2002-12-15 20:01:51.000000000 -0500
@@ -240,6 +240,43 @@
     ( 3, 0,	"sys_madvise",		"madvise",	None),# 219
     ( 3, 0,	"sys_getdents64",	"getdents64",	None),# 220
     ( 3, 0,	"sys_fcntl64",		"fcntl64",	None),# 221
+    ( 4, 0,	"printargs",		"SYS_222",	None),# 222
+    ( 3, 0,	"sys_security",		"security",	None),# 223
+    ( 0, 0,	"sys_gettid",		"gettid",	None),# 224
+    ( 3, 0,	"sys_readahead",	"readahead",	None),# 225
+    ( 5, TF,	"sys_setxattr",		"setxattr",	None),# 226
+    ( 5, TF,	"sys_setxattr",		"lsetxattr",	None),# 227
+    ( 5, TF,	"sys_fsetxattr",	"fsetxattr",	None),# 228
+    ( 4, TF,	"sys_getxattr",		"getxattr",	None),# 229
+    ( 4, TF,	"sys_getxattr",		"lgetxattr",	None),# 230
+    ( 4, TF,	"sys_fgetxattr",	"fgetxattr",	None),# 231
+    ( 3, TF,	"sys_listxattr",	"listxattr",	None),# 232
+    ( 3, TF,	"sys_listxattr",	"llistxattr",	None),# 233
+    ( 3, TF,	"sys_flistxattr",	"flistxattr",	None),# 234
+    ( 2, TF,	"sys_removexattr",	"removexattr",	None),# 235
+    ( 2, TF,	"sys_removexattr",	"lremovexattr",	None),# 236
+    ( 2, TF,	"sys_fremovexattr",	"fremovexattr",	None),# 237
+    ( 2, TS,	"sys_tkill",		"tkill",	None),# 238
+    ( 4, TF,	"sys_sendfile64",	"sendfile64",	None),# 239
+    ( 4, 0,	"sys_futex",		"futex",	None),# 240
+    ( 3, 0,	"sys_sched_setaffinity","sched_setaffinity",	None),# 241
+    ( 3, 0,	"sys_sched_getaffinity","sched_getaffinity",	None),# 242
+    ( 1, 0,	"sys_set_thread_area",	"set_thread_area",	None),# 243
+    ( 1, 0,	"sys_get_thread_area",	"get_thread_area",	None),# 244
+    ( 2, TI,	"sys_io_setup",		"io_setup",	None),# 245
+    ( 1, TI,	"sys_io_destroy",	"io_destroy",	None),# 246
+    ( 5, TI,	"sys_io_getevents",	"io_getevents",	None),# 247
+    ( 3, TI,	"sys_io_submit",	"io_submit",	None),# 248
+    ( 3, TI,	"sys_io_cancel",	"io_cancel",	None),# 249
+    ( 5, 0,	"sys_alloc_hugepages",	"alloc_hugepages",	None),# 250
+    ( 1, 0,	"sys_free_hugepages",	"free_hugepages",	None),# 251
+    ( 1, 0,	"sys_exit_group",	"exit_group",	None),# 252
+    ( 3, TF,	"sys_lookup_dcookie",	"lookup_dcookie",	None),# 253
+    ( 1, TF,	"sys_epoll_create",	"epoll_create",	None),# 254
+    ( 4, TF,	"sys_epoll_ctl",	"epoll_ctl",	None),# 255
+    ( 4, TF,	"sys_epoll_wait",	"epoll_wait",	None),# 256
+    ( 5, TF,	"sys_remap_file_pages",	"remap_file_pages",	None),# 257
+    ( 2, 0,	"sys_set_tid_address",	"set_tid_address",	None),# 258
     )
 
 

