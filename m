Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262287AbSI1Ra2>; Sat, 28 Sep 2002 13:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbSI1Ra2>; Sat, 28 Sep 2002 13:30:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43517 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262287AbSI1R2P>;
	Sat, 28 Sep 2002 13:28:15 -0400
Message-ID: <3D95E776.D94BFCBA@mvista.com>
Date: Sat, 28 Sep 2002 10:31:34 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "george@mvista.com" <george@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 4/6] High-res-timers part 4 (support-lib) take 2
Content-Type: multipart/mixed;
 boundary="------------870587E2DCC423C090A79CB6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------870587E2DCC423C090A79CB6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The 4th, 5th, and 6th parts are support code and not really
part of the kernel.

This part contains the user land library build code, change
log, and readme stuff.

There are two library stub generation bits, one for a shared
library and one for an archive library.  The archive library
is arch neutral, the share is i386 only.


The whole of this patch will create and populate the
Documentation/high-res-timers/ directory.  It , with the
remaining parts, is very useful for testing correct
functioning of the new system calls.  It
also contains a test program (performance.c) that will
generate graph data for gnuplot showing interesting
performance numbers WRT to large numbers timers.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------870587E2DCC423C090A79CB6
Content-Type: text/plain; charset=iso-8859-1;
 name="hrtimers-lib-etc-2.5.34-1.0.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="hrtimers-lib-etc-2.5.34-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/CHANGELOG linux/Documentation/high-res-timers/C=
HANGELOG
--- linux-2.5.36-kb/Documentation/high-res-timers/CHANGELOG	Wed Dec 31 16=
:00:00 1969
+++ linux/Documentation/high-res-timers/CHANGELOG	Fri Sep 27 11:05:08 200=
2
@@ -0,0 +1,107 @@
+For version 2.4.18-3.0
+
+This version is the first to have the clock_nanosleep absolute feature
+which POSIX says, if the clock is set under the sleep, it will still
+expire when it should (unless that time is now past, in which case it
+should expire immediately).
+
+We now have a clock_nanosleep test with help from Robert Love and
+George.	 It actually verifies the above feature as well as that signals
+that don't get delivered to the user do not cause clock_nanosleep to
+stop, while those that do, do.	We tested using SIGSTOP and SIGCONT.
+
+It turns out that, if we are not doing high res (either because it is
+turned off or because there are no high res timers expiring) that the
+PIT (which is to give us periodic interrupts) drifts with respect to the=

+clock, be it TSC or ACPI pm timer.  This causes the jiffie interrupts to=

+drift around causing varying and significant latency in the delivery
+of low res timers.  We now have code to detect this drift and "touch"
+the PIT as needed to get it to give us interrupts much closer to when we=

+want them.  I suppose we could use this as an indication that we have
+not done as good a job of calibrating the TSC as we would like.	 But
+even the ACPI drifts and it should be on the same "rock".
+
+The man pages have been updated to (hopefully) get the arguments right.
+
+A bug was found and fixed in the test to see if a timer was referenced
+to CLOCK_MONOTONIC.  It caused nasty errors when converting such timers
+to the system base.
+
+After spending a LOT of time getting clock_nanosleep and its test to
+work, I decided to error out requests for times beyond what can be fit
+in the (size of long) jiffie.  In the past these were just set to the
+max value.  This just caused such obvious errors to look like normal
+timers, not fun to debug.
+
+AND, least I forget, we have moved to a shared system call stub library.=

+This should allow you to not reload your using code, even if the system
+call numbers change.  It did take a few more files (purloined from
+glibc) to do it, however.
+
+The library make file will also figure out if the itimer struct is neede=
d
+in posix_lib.h and do the right thing.
+
+For version 2.4.18-1.0
+
+Made the sub_expire member of the timer_list structure unconditional.
+This should allow modules compiled against high res on or off to play
+regardless of how the kernel is compiled.
+
+Also moved jiffies out of the #define name space.  It is now defined by
+the linker and is only in the extern name space.  You are free to use it=

+as a dummy variable, local variable or member of a struct or union.
+
+For version 2.4.17-3.0
+
+Found a fixed a major bug that lost (or delayed) timers for a LONG time.=

+All timers, not just POSIX timers.
+
+Also removed changes to limits.h and changed config.in to default to
+3000 timers and to use the TSC clock.  Also disabled some debug code
+that was getting turned on if CONFIG_KGDB was defined.
+
+For version 2.4.17-2.2
+
+Fixed the set up of the arch_to_latch conversion constant so we actually=

+do get sub jiffies interrupts, thanks to Jim Houston for spotting this
+one.
+
+Put normalize code in the clock_gettime() call so we no longer return
+un-normalized time (i.e. nanoseconds > 1 sec.).
+
+Changed the run_timer_list code to get the latest version of "NOW" just
+prior to the scan.
+
+Changed schedule_next_interrupt() to accept a flag indicating how to
+return if the requested time has already elapsed (it was indicating
+"time elapsed" and not scheduling an interrupt which does not work well
+if we REALLY need the interrupt).
+
+For version 2.4.17-2.1
+
+Since 2.4.17-3.1 (the last to go to sourceforge)
+
+Fixed compile problems with high-res-timers turned off (who would do
+such a thing?)
+
+Changed all the ex_ math code to sc_ (it is scaled math after all).
+
+Added man pages
+
+Changed to no longer try to measure the minimun interval we can
+support.  It is now fixed at 500 micro seconds.	 Looking for a new way
+to do this.  The old one ran into NMI issues on SMP machines.
+
+Fixed config.in "] problem (must be " ]).
+
+Picked up several more name space collisions on jiffies.
+
+Added the rest of the system call links for all archs, save, I think sh.=

+
+Fixed a bug where a call to clock_gettime messed up gettimeofday.
+
+Simplified the lib stuff and moved the whole thing into the kernel tree.=

+It no longer depends on links in /usr/include.
+
+I am sure I am forgetting something, but sigh, lets ship this thing.
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/README linux/Documentation/high-res-timers/READ=
ME
--- linux-2.5.36-kb/Documentation/high-res-timers/README	Wed Dec 31 16:00=
:00 1969
+++ linux/Documentation/high-res-timers/README	Fri Sep 27 11:05:23 2002
@@ -0,0 +1,138 @@
+
+This is the read me file for the high-res-timer patch.
+
+New with this release (2.4.18-3.0):
+
+The info below has changed.  Please read it again rather than assume it
+is the same.
+
+
+This file and those "near" it are in the kernel tree.  You may move it
+out if you like, however, if you build the library file where it is you
+should not need to mess with the links to the kernel tree as described
+below.	Also, should you want to send me a patch, I would like it to be
+in this location.
+
+Be aware that the patch is not just to the kernel.  There are four
+parts:
+
+1.)The kernel patch, =

+2.)A library file (contains the system call stubs and a header file), an=
d
+3.)A patch to a header files to expand some of the signal structures and=

+such. =

+4.)A set of test programs.
+
+For the newer glibc library, the bits/types.h file is ok as it stands.
+An old version is included just in case, but it is renamed to stay out
+of the way (see ./usr_incl/bits/).  The bits/signinfo.h file provided
+is, I think, compatable with both the new and old libraries.  I included=

+a patched version from the Red Hat 7.3 distro.	There is also a patch in
+case you want to know what changed or what to use some other version.  I=

+think the patch file for this header will work with both old and new
+libraries.  In any case you have the desired result and can act
+accordinly.
+
+There are a bunch of other header files under usr_incl.	 These are used
+ONLY to make the system call stub library.  The only file you may want
+to move to /usr/include is the bits/siginfo.h file.
+
+If you like, you can copy siginfo.h file to a separate directory (called=

+"bits"), and then use "-I/xxx" in the cc command, where "xxx" is the
+path to then new bits directory. (Don't include "bits" in xxx, the
+#include <bits/yyy.h> has the "bits" in it.)  This is what I am doing
+for testing so as not to affect my include files till I am REALLY sure
+this is what I want.  The test program Makefile is set up to pick up the=

+include files from the directory created for them by applying this
+patch.	The patch includes a patched version of siginfo.h, but you may
+want to patch your own to be sure you have current versions for your
+system (this is from glib-2.2.4-13).
+
+Header file issues: In addition to the headers called out in the
+standard and the man pages you will want to include the lib/posix_time.h=

+file in this patch.  This file is automaticly configured by the library
+make file to remove a possible conflict with your standard headers.  It
+has everything you need to use glibc versions as old as 2.1.2.	New
+glibc versions have almost all of this stuff included in them.	If you
+have trouble with the auto configure stuff, all it changes is an #ifdef
+NEED_ITIMERSPEC.  Do let me know if this does not work on your system.
+
+You will need to build the library file (make is included in the patch)
+AFTER you patch the kernel as it uses the system call definitions the
+patch puts in (also after the first make on the tree so that the asm
+link in include is defined in the kernel tree).	 In order for this to
+work you need to have a symbolic link in /usr/include for asm that
+points to the kernel include asm directory.  You already have this link,=

+but it may point to a different kernel if you have more than one on your=

+system.	 Again, you can provide an alternative for this by putting
+"-Ipath/include" in the CPPFLAGS macro in the library build make file. =

+Here path should be to the top directory of your new kernel (i.e. where
+include is found).  Note, the Makefile trys to point to a directory in
+the tar ball but this will not exist and should be harmless if you have =
the
+correct asm link.  A recommended link for asm in /usr/include is:
+
+ln -s ../src/linux/include/asm asm
+
+This assumes that you have your kernel(s) located in the /usr/src
+directory and have a symbolic link to the current kernel (which you will=

+need to do the patch).	If you should move to a new kernel, changing the
+link in /usr/src will allow the /usr/include/asm to follow.
+
+After building the library, install it in your /usr/lib directory on
+your target. Then rebuild your kernel, and you should be set to build
+timer calls into your applications.
+
+MAN PAGES
+
+We now have man pages (Thanks to Robert Love).	=

+
+However, we did the man pages for the system we would like to have, but
+don't just yet.	 Here are the known deficiencies:
+
+The SIGEV_THREAD stuff in timer_create() requires glibc or thread
+package support which we just don't have yet.
+
+The SIGEV_THREAD in timer_create() requires thread groups be supported
+in the thread package.	Linux threads does not yet use thread groups so
+this will not work.  If you do create your own, or use a thread package
+that does use thread groups, be aware that the thread id that is to be
+passed to the kernel must be a pid, not a pthread_t id.	 Again glibc
+will do this translation once it gets to using thread groups.
+
+The clock_* man pages talk about two CLOCK_*CPU* clocks.  These will be
+supported someday, but not just yet.  For now, expect bad clock id
+errors on these clocks.
+
+The man pages on *_getcpuclockid actually describe functions in the
+existing glibc, at least at newer revs.	 You may or may not actually
+find the functions depending on your glibc version.  Not that it
+matters, because, as we said above, we don't yet support these clocks in=

+the kernel.
+
+Installing the man pages:
+
+In the .../man directory there is a make file that will install the
+pages.	The target directory must exist and is determined as follows:
+
+# If the  enviroment variable MANPATH is  defined and not  null, use the=

+# first entry in it.
+
+# Otherwise, if "/etc/man.config" exists, use the first MANPATH entry in=

+# it.  If both of these fail, print an error and quit.
+
+# If you  want to override this to  put the pages in  directory foo use:=

+# make MANPATH=3Dfoo
+
+# If you  want to  force it to	use the	 /etc/man.config and you  have a
+# MANPATH use: make MANPATH=3D
+
+Usually you will need root capability to store into the man page
+directory.
+
+Thats all the problems I can think of.	As always, let me know if there
+is more to be said here, or anywhere.
+
+Let me know if you have any problems.  I would like to keep these
+instructions for the next user...  Be nice if they were correct :)
+
+George Anzinger george@mvista.com
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/lib/Makefile linux/Documentation/high-res-timer=
s/lib/Makefile
--- linux-2.5.36-kb/Documentation/high-res-timers/lib/Makefile	Wed Dec 31=
 16:00:00 1969
+++ linux/Documentation/high-res-timers/lib/Makefile	Fri Sep 27 11:03:55 =
2002
@@ -0,0 +1,24 @@
+LIBPOSIXTIME =3D libposixtime.so
+
+SOURCES =3D syscall_timer.c =

+OBJECTS =3D $(SOURCES:.c=3D.o)
+
+SYSASM =3D  -I../../../include/ -I../usr_incl/
+CPPFLAGS =3D -D_POSIX_TIMERS=3D1 -D_POSIX_C_SOURCE=3D199309L -D_XOPEN_SO=
URCE -D_LIBC $(SYSASM)
+CFLAGS =3D -g -Wall -shared -fpic -fPIC
+
+all: $(LIBPOSIXTIME)($(OBJECTS))
+
+clean:
+	rm -f *.o *.a *.so *~ core .depend t--* tmp
+
+.depend: $(SOURCES) test_itimerspec
+	$(CC) $(CPPFLAGS)  -M $(SOURCES) | \
+		sed -e '/:/s|^[^ :]*|$(LIBPOSIXTIME)(&)|' > .depend
+	chmod +x test_itimerspec
+	./test_itimerspec $(CC) $(CPPFLAGS) &>/dev/null
+	make
+
+# The above make insures that "all:" is done with the newly created .dep=
end
+
+include .depend
Binary files linux-2.5.36-kb/Documentation/high-res-timers/lib/libposixti=
me.so and linux/Documentation/high-res-timers/lib/libposixtime.so differ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/lib/posix_time.h linux/Documentation/high-res-t=
imers/lib/posix_time.h
--- linux-2.5.36-kb/Documentation/high-res-timers/lib/posix_time.h	Wed De=
c 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/lib/posix_time.h	Fri Sep 27 11:03=
:37 2002
@@ -0,0 +1,151 @@
+/*
+ * Copyright (C) 1997 by the University of Kansas Center for Research,
+ * Inc.	 This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. Thi=
s
+ * software may be used and distributed according to the terms of the GN=
U
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus=
=2E
+ *
+ * Authors: Shyam Pather, Balaji Srinivasan =

+ *
+ * Please send bug-reports/suggestions/comments to posix@ittc.ukans.edu
+ *
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/posix/
+ *
+ * Currently part of the high-res-timers project:
+ *	   http://sourceforge.net/projects/high-res-timers/
+ *
+ */
+
+/*********************** NOTES on this file.****************************=

+ *
+ * This is a header file for use with the POSIX timers.	 If you have a
+ * current glibc, most of what is here is already defined and thus, not
+ * needed. The only part you would need with the latest glibc (2.2.5)
+ * for example, is the CLOCK_MONOTONIC, and the CLOCK_*_HR defines.
+ *
+ * When this code is integerated into glibc this file will go away.
+ *
+ * An effort was made to avoid errors because something is already defin=
ed
+ * however, this is life, so there will always be some issues.	If anythi=
ng
+ * here collides with your normal libc header files, you can most likey
+ * just comment out the offending parts.
+ *
+ ***********************************************************************=
*/
+
+
+
+#ifndef __POSIX_TIME_H
+#define __POSIX_TIME_H
+
+#include <signal.h>
+#include <time.h>
+
+#ifdef _POSIX_TIMERS
+
+#ifndef CLOCK_REALTIME
+#define CLOCK_REALTIME		 0
+#endif
+#ifndef CLOCK_MONOTONIC
+#define CLOCK_MONOTONIC		 1
+#endif
+#ifndef CLOCK_PROCESS_CPUTIME_ID
+#define CLOCK_PROCESS_CPUTIME_ID 2
+#endif
+#ifndef CLOCK_THREAD_CPUTIME_ID
+#define CLOCK_THREAD_CPUTIME_ID	 3
+#endif
+#ifndef CLOCK_REALTIME_HR
+#define CLOCK_REALTIME_HR	 4
+#endif
+#ifndef CLOCK_MONOTONIC_HR
+#define CLOCK_MONOTONIC_HR	 5
+#endif
+
+#define NOF_CLOCKS 10
+
+#undef	TIMER_ABSTIME
+#define TIMER_ABSTIME 0x01
+
+#undef TIMER_MAX
+#define TIMER_MAX 32000
+
+#ifndef NSEC_PER_SEC
+#define NSEC_PER_SEC 1000000000L
+#endif
+
+#if !defined __clockid_t_defined
+typedef int clockid_t;
+# define __clockid_t_defined	1
+#endif
+
+#ifndef __timer_t_defined
+# define __timer_t_defined	1
+typedef int timer_t;
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+#if 0	     // fix confused pretty printer
+}
+#endif
+/* POSIX.1b structure for timer start values and intervals.  */
+/* If the following is already defined, just change the 1 to a 0 */
+#define NEED_ITIMERSPEC
+#ifndef NEED_ITIMERSPEC
+struct itimerspec
+  {
+    struct timespec it_interval;
+    struct timespec it_value;
+  };
+#endif
+/*
+ * Proto types can be repeated, so this should cause no errors even
+ * if time.h already defined it.
+*/
+
+#ifndef __THROW
+#define __THROW
+#endif
+
+extern int timer_create(clockid_t which_clock, =

+			struct sigevent *timer_event_spec,
+			timer_t *created_timer_id) __THROW;
+
+extern int timer_gettime(timer_t timer_id, struct itimerspec *setting) _=
_THROW;
+
+extern int timer_settime(timer_t timer_id,
+			 int flags,
+			 const struct itimerspec *new_setting,
+			 struct itimerspec *old_setting) __THROW;
+
+extern int timer_getoverrun(timer_t timer_id) __THROW;
+
+extern int timer_delete(timer_t timer_id) __THROW;
+
+extern int clock_gettime(clockid_t which_clock, struct timespec *ts) __T=
HROW;
+
+extern int clock_settime(clockid_t which_clock, =

+			 const struct timespec *setting) __THROW;
+
+extern int clock_getres(clockid_t which_clock, =

+			struct timespec *resolution) __THROW;
+
+extern int clock_nanosleep(clockid_t which_clock,
+		    int flags,
+		    const struct timespec *new_setting, =

+		    struct timespec *old_setting) __THROW;
+ =

+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* POSIX_TIMERS */
+
+#endif /* __POSIX_TIME_H */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/lib/syscall_timer.c linux/Documentation/high-re=
s-timers/lib/syscall_timer.c
--- linux-2.5.36-kb/Documentation/high-res-timers/lib/syscall_timer.c	Wed=
 Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/lib/syscall_timer.c	Fri Sep 27 11=
:03:19 2002
@@ -0,0 +1,94 @@
+//#include <signal.h>
+//#include <time.h>
+#include <linux/unistd.h>
+#include "posix_time.h"
+#include <sysdeps/i386/sysdep.h>
+#include <errno.h>
+//#include "syscall_timer.h"
+
+#define __NR___timer_create	__NR_timer_create
+#define __NR___timer_gettime	__NR_timer_gettime
+#define __NR___timer_settime	__NR_timer_settime
+#define __NR___timer_getoverrun __NR_timer_getoverrun
+#define __NR___timer_delete	__NR_timer_delete
+
+#define __NR___clock_settime   __NR_clock_settime
+#define __NR___clock_gettime   __NR_clock_gettime
+#define __NR___clock_getres    __NR_clock_getres
+#define __NR___clock_nanosleep __NR_clock_nanosleep
+
+#undef _syscall1
+#define _syscall1(type,name,type1,arg1) \
+type name(type1 arg1) \
+{ \
+     return INLINE_SYSCALL( name, 1, arg1); \
+}
+
+
+#undef _syscall2
+#define _syscall2(type,name,type1,arg1,type2,arg2) \
+type name(type1 arg1,type2 arg2) \
+{ \
+     return INLINE_SYSCALL( name, 2, arg1, arg2); \
+}
+
+
+#undef _syscall3
+#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
+type name(type1 arg1,type2 arg2,type3 arg3) \
+{ \
+     return INLINE_SYSCALL( name, 3, arg1, arg2, arg3); \
+}
+
+_syscall3(int, timer_create, clockid_t, which_clock, struct sigevent *,
+	  timer_event_spec, timer_t *, created_timer_id)
+
+#undef _syscall4
+#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4)=
 \
+type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
+{ \
+     return INLINE_SYSCALL( name, 4, arg1, arg2, arg3, arg4); \
+}
+
+/* This will expand into the timer_gettime system call stub. */
+_syscall2(int, timer_gettime, =

+	  timer_t, timer_id, =

+	  struct itimerspec *, setting)
+
+/* This will expand into the timer_settime system call stub. */
+_syscall4(int, timer_settime, =

+	  timer_t, timer_id, =

+	  int, flags, =

+	  const struct itimerspec *, new_setting,
+	  struct itimerspec *, old_setting)
+
+/* This will expand into the timer_gettime system call stub. */
+_syscall1(int, timer_getoverrun, =

+	  timer_t, timer_id)
+
+/* This will expand into the timer_delete system call stub. */
+_syscall1(int, timer_delete, =

+	  timer_t, timer_id)
+
+/* This will expand into the clock_getres system call stub. */
+_syscall2(int, clock_getres, =

+	  clockid_t, which_clock,
+	  struct timespec *,resolution)
+
+/* This will expand into the clock_gettime system call stub. */
+_syscall2(int, clock_gettime, =

+	  clockid_t, which_clock,
+	  struct timespec *,time)
+
+/* This will expand into the clock_settime system call stub. */
+_syscall2(int, clock_settime, =

+	  clockid_t, which_clock,
+	  const struct timespec *,time)
+
+/* This will expand into the clock_nanosleep system call stub. */
+_syscall4(int, clock_nanosleep, =

+	  clockid_t, which_clock,
+	  int, flags,
+	  const struct timespec *,rqtp,
+	  struct timespec *,rmtp)
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/lib/test_itimerspec linux/Documentation/high-re=
s-timers/lib/test_itimerspec
--- linux-2.5.36-kb/Documentation/high-res-timers/lib/test_itimerspec	Wed=
 Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/lib/test_itimerspec	Fri Sep 27 11=
:03:27 2002
@@ -0,0 +1,32 @@
+#!/bin/bash
+
+# This bit of nonsense fixes up posix_time.h to either define
+# sturct itimerspec or not, depending on if the library headers
+# have already defined it.  It does a test by compiling a trivial
+# program and testing if there are errors.  If there are errors
+# it inverts the inclusion of the definition.  That is it does not
+# matter if posix_time.h starts with the struc defined or not, if
+# the assumption is wrong we just change it.
+
+# The interesting thing is that even if the lib does not define it
+# the definition is still there, it is just not exposed because of
+# some dumb rules having to do with what flags are defined. =

+
+FILE=3D"posix_time.h"
+OUTFILE=3D"tmp"
+
+tf=3D"t--st"
+	rm -f $tf.c
+	echo "#include <linux/unistd.h>" >$tf.c
+	echo "#include \"$FILE\"">>$tf.c
+	echo "int main(struct itimerspec *t){t->it_interval.tv_sec++;return 0;}=
">>$tf.c
+	foo=3D`$* $tf.c -o $tf`&>/dev/null
+	result=3D"$?"
+#	echo $result
+#	echo "from file"$foo
+	if [ "$result" !=3D "0" ] ; then =

+	    awk '$0 =3D=3D "#ifdef NEED_ITIMERSPEC" {$0 =3D "#ifndef NEED_ITIME=
RSPEC";print;next} $0 =3D=3D "#ifndef NEED_ITIMERSPEC" {$0=3D"#ifdef NEED=
_ITIMERSPEC"}{print}' $FILE >$OUTFILE
+	    rm $FILE
+	    mv $OUTFILE $FILE
+	 fi
+	 rm -f $tf*
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/libX/Makefile linux/Documentation/high-res-time=
rs/libX/Makefile
--- linux-2.5.36-kb/Documentation/high-res-timers/libX/Makefile	Wed Dec 3=
1 16:00:00 1969
+++ linux/Documentation/high-res-timers/libX/Makefile	Fri Sep 27 11:04:21=
 2002
@@ -0,0 +1,25 @@
+LIBPOSIXTIME =3D libposixtime.so
+
+SOURCES =3D syscall_timer.c =

+OBJECTS =3D $(SOURCES:.c=3D.o)
+
+SYSASM =3D  -I../../../include/ -I../usr_incl/
+CPPFLAGS =3D -D_POSIX_TIMERS=3D1 -D_POSIX_C_SOURCE=3D199309L -D_XOPEN_SO=
URCE $(SYSASM)
+CFLAGS =3D -g -Wall -shared =

+
+all: $(LIBPOSIXTIME)($(OBJECTS))
+
+clean:
+	rm -f *.o *.a *.so *~ core .depend t--* tmp
+
+tf =3D t--st.c
+.depend: $(SOURCES)
+	$(CC) $(CPPFLAGS)  -M $(SOURCES) | \
+		sed -e '/:/s|^[^ :]*|$(LIBPOSIXTIME)(&)|' > .depend
+	rm -f $(tf)
+	./test_itimerspec $(CC) $(CPPFLAGS) &>/dev/null
+	make
+
+# The above make insures that "all:" is done with the newly created .dep=
end
+
+include .depend
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/libX/posix_time.h linux/Documentation/high-res-=
timers/libX/posix_time.h
--- linux-2.5.36-kb/Documentation/high-res-timers/libX/posix_time.h	Wed D=
ec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/libX/posix_time.h	Fri Sep 27 11:0=
4:31 2002
@@ -0,0 +1,151 @@
+/*
+ * Copyright (C) 1997 by the University of Kansas Center for Research,
+ * Inc.	 This software was developed by the Information and
+ * Telecommunication Technology Center (ITTC) at the University of
+ * Kansas.  Partial funding for this project was provided by Sprint. Thi=
s
+ * software may be used and distributed according to the terms of the GN=
U
+ * Public License, incorporated herein by reference.  Neither ITTC nor
+ * Sprint accept any liability whatsoever for this product.
+ *
+ * This project was developed under the direction of Dr. Douglas Niehaus=
=2E
+ *
+ * Authors: Shyam Pather, Balaji Srinivasan =

+ *
+ * Please send bug-reports/suggestions/comments to posix@ittc.ukans.edu
+ *
+ * Further details about this project can be obtained at
+ *    http://hegel.ittc.ukans.edu/projects/posix/
+ *
+ * Currently part of the high-res-timers project:
+ *	   http://sourceforge.net/projects/high-res-timers/
+ *
+ */
+
+/*********************** NOTES on this file.****************************=

+ *
+ * This is a header file for use with the POSIX timers.	 If you have a
+ * current glibc, most of what is here is already defined and thus, not
+ * needed. The only part you would need with the latest glibc (2.2.5)
+ * for example, is the CLOCK_MONOTONIC, and the CLOCK_*_HR defines.
+ *
+ * When this code is integerated into glibc this file will go away.
+ *
+ * An effort was made to avoid errors because something is already defin=
ed
+ * however, this is life, so there will always be some issues.	If anythi=
ng
+ * here collides with your normal libc header files, you can most likey
+ * just comment out the offending parts.
+ *
+ ***********************************************************************=
*/
+
+
+
+#ifndef __POSIX_TIME_H
+#define __POSIX_TIME_H
+
+#include <signal.h>
+#include <time.h>
+
+#ifdef _POSIX_TIMERS
+
+#ifndef CLOCK_REALTIME
+#define CLOCK_REALTIME		 0
+#endif
+#ifndef CLOCK_MONOTONIC
+#define CLOCK_MONOTONIC		 1
+#endif
+#ifndef CLOCK_PROCESS_CPUTIME_ID
+#define CLOCK_PROCESS_CPUTIME_ID 2
+#endif
+#ifndef CLOCK_THREAD_CPUTIME_ID
+#define CLOCK_THREAD_CPUTIME_ID	 3
+#endif
+#ifndef CLOCK_REALTIME_HR
+#define CLOCK_REALTIME_HR	 4
+#endif
+#ifndef CLOCK_MONOTONIC_HR
+#define CLOCK_MONOTONIC_HR	 5
+#endif
+
+#define NOF_CLOCKS 10
+
+#undef	TIMER_ABSTIME
+#define TIMER_ABSTIME 0x01
+
+#undef TIMER_MAX
+#define TIMER_MAX 32000
+
+#ifndef NSEC_PER_SEC
+#define NSEC_PER_SEC 1000000000L
+#endif
+
+#if !defined __clockid_t_defined
+typedef int clockid_t;
+# define __clockid_t_defined	1
+#endif
+
+#ifndef __timer_t_defined
+# define __timer_t_defined	1
+typedef int timer_t;
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+#if 0	     // fix confused pretty printer
+}
+#endif
+/* POSIX.1b structure for timer start values and intervals.  */
+/* If the following is already defined, just change the 1 to a 0 */
+#define NEED_ITIMERSPEC
+#ifndef NEED_ITIMERSPEC
+struct itimerspec
+  {
+    struct timespec it_interval;
+    struct timespec it_value;
+  };
+#endif
+/*
+ * Proto types can be repeated, so this should cause no errors even
+ * if time.h already defined it.
+*/
+
+#ifndef __THROW
+#define __THROW
+#endif
+
+extern int timer_create(clockid_t which_clock, =

+			struct sigevent *timer_event_spec,
+			timer_t *created_timer_id) __THROW;
+
+extern int timer_gettime(timer_t timer_id, struct itimerspec *setting) _=
_THROW;
+
+extern int timer_settime(timer_t timer_id,
+			 int flags,
+			 const struct itimerspec *new_setting,
+			 struct itimerspec *old_setting) __THROW;
+
+extern int timer_getoverrun(timer_t timer_id) __THROW;
+
+extern int timer_delete(timer_t timer_id) __THROW;
+
+extern int clock_gettime(clockid_t which_clock, struct timespec *ts) __T=
HROW;
+
+extern int clock_settime(clockid_t which_clock, =

+			 const struct timespec *setting) __THROW;
+
+extern int clock_getres(clockid_t which_clock, =

+			struct timespec *resolution) __THROW;
+
+extern int clock_nanosleep(clockid_t which_clock,
+		    int flags,
+		    const struct timespec *new_setting, =

+		    struct timespec *old_setting) __THROW;
+ =

+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* POSIX_TIMERS */
+
+#endif /* __POSIX_TIME_H */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/libX/syscall_timer.c linux/Documentation/high-r=
es-timers/libX/syscall_timer.c
--- linux-2.5.36-kb/Documentation/high-res-timers/libX/syscall_timer.c	We=
d Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/libX/syscall_timer.c	Fri Sep 27 1=
1:04:42 2002
@@ -0,0 +1,64 @@
+//#include <signal.h>
+//#include <time.h>
+#include <linux/unistd.h>
+#include "posix_time.h"
+//#include "syscall_timer.h"
+
+#define __NR___timer_create	__NR_timer_create
+#define __NR___timer_gettime	__NR_timer_gettime
+#define __NR___timer_settime	__NR_timer_settime
+#define __NR___timer_getoverrun __NR_timer_getoverrun
+#define __NR___timer_delete	__NR_timer_delete
+
+#define __NR___clock_settime   __NR_clock_settime
+#define __NR___clock_gettime   __NR_clock_gettime
+#define __NR___clock_getres    __NR_clock_getres
+#define __NR___clock_nanosleep __NR_clock_nanosleep
+
+/* This will expand into the timer_create system call stub. */
+_syscall3(int, timer_create, clockid_t, which_clock, struct sigevent *,
+	  timer_event_spec, timer_t *, created_timer_id)
+
+/* This will expand into the timer_gettime system call stub. */
+_syscall2(int, timer_gettime, =

+	  timer_t, timer_id, =

+	  struct itimerspec *, setting)
+
+/* This will expand into the timer_settime system call stub. */
+_syscall4(int, timer_settime, =

+	  timer_t, timer_id, =

+	  int, flags, =

+	  const struct itimerspec *, new_setting,
+	  struct itimerspec *, old_setting)
+
+/* This will expand into the timer_gettime system call stub. */
+_syscall1(int, timer_getoverrun, =

+	  timer_t, timer_id)
+
+/* This will expand into the timer_delete system call stub. */
+_syscall1(int, timer_delete, =

+	  timer_t, timer_id)
+
+/* This will expand into the clock_getres system call stub. */
+_syscall2(int, clock_getres, =

+	  clockid_t, which_clock,
+	  struct timespec *,resolution)
+
+/* This will expand into the clock_gettime system call stub. */
+_syscall2(int, clock_gettime, =

+	  clockid_t, which_clock,
+	  struct timespec *,time)
+
+/* This will expand into the clock_settime system call stub. */
+_syscall2(int, clock_settime, =

+	  clockid_t, which_clock,
+	  const struct timespec *,time)
+
+/* This will expand into the clock_nanosleep system call stub. */
+_syscall4(int, clock_nanosleep, =

+	  clockid_t, which_clock,
+	  int, flags,
+	  const struct timespec *,rqtp,
+	  struct timespec *,rmtp)
+
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/libX/test_itimerspec linux/Documentation/high-r=
es-timers/libX/test_itimerspec
--- linux-2.5.36-kb/Documentation/high-res-timers/libX/test_itimerspec	We=
d Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/libX/test_itimerspec	Fri Sep 27 1=
1:04:52 2002
@@ -0,0 +1,32 @@
+#!/bin/bash
+
+# This bit of nonsense fixes up posix_time.h to either define
+# sturct itimerspec or not, depending on if the library headers
+# have already defined it.  It does a test by compiling a trivial
+# program and testing if there are errors.  If there are errors
+# it inverts the inclusion of the definition.  That is it does not
+# matter if posix_time.h starts with the struc defined or not, if
+# the assumption is wrong we just change it.
+
+# The interesting thing is that even if the lib does not define it
+# the definition is still there, it is just not exposed because of
+# some dumb rules having to do with what flags are defined. =

+
+FILE=3D"posix_time.h"
+OUTFILE=3D"tmp"
+
+tf=3D"t--st"
+	rm -f $tf.c
+	echo "#include <linux/unistd.h>" >$tf.c
+	echo "#include \"$FILE\"">>$tf.c
+	echo "int main(struct itimerspec *t){t->it_interval.tv_sec++;return 0;}=
">>$tf.c
+	foo=3D`$* $tf.c`&>/dev/null
+	result=3D"$?"
+#	echo $result
+#	echo "from file"$foo
+	if [ "$result" !=3D "0" ] ; then =

+	    awk '$0 =3D=3D "#ifdef NEED_ITIMERSPEC" {$0 =3D "#ifndef NEED_ITIME=
RSPEC";print;next} $0 =3D=3D "#ifndef NEED_ITIMERSPEC" {$0=3D"#ifdef NEED=
_ITIMERSPEC"}{print}' $FILE >$OUTFILE
+	    rm $FILE
+	    mv $OUTFILE $FILE
+	 fi
+	 rm -f $tf*
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/usr_incl/bits/siginfo.h linux/Documentation/hig=
h-res-timers/usr_incl/bits/siginfo.h
--- linux-2.5.36-kb/Documentation/high-res-timers/usr_incl/bits/siginfo.h=
	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/usr_incl/bits/siginfo.h	Wed Sep 1=
8 17:39:54 2002
@@ -0,0 +1,292 @@
+/* siginfo_t, sigevent and constants.  Linux version.
+   Copyright (C) 1997, 1998 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Library General Public License a=
s
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Library General Public License for more details.
+
+   You should have received a copy of the GNU Library General Public
+   License along with the GNU C Library; see the file COPYING.LIB.  If n=
ot,
+   write to the Free Software Foundation, Inc., 59 Temple Place - Suite =
330,
+   Boston, MA 02111-1307, USA.  */
+
+#if !defined _SIGNAL_H && !defined __need_siginfo_t
+# error "Never include this file directly.  Use <signal.h> instead"
+#endif
+
+#if (!defined __have_siginfo_t \
+     && (defined _SIGNAL_H || defined __need_siginfo_t))
+# define __have_siginfo_t	1
+
+/* Type for data associated with a signal.  */
+typedef union sigval
+  {
+    int sival_int;
+    void *sival_ptr;
+  } sigval_t;
+
+# define __SI_MAX_SIZE     128
+# define __SI_PAD_SIZE     ((__SI_MAX_SIZE / sizeof (int)) - 3)
+
+typedef struct siginfo
+  {
+    int si_signo;		/* Signal number.  */
+    int si_errno;		/* If non-zero, an errno value associated with
+				   this signal, as defined in <errno.h>.  */
+    int si_code;		/* Signal code.  */
+
+    union
+      {
+	int _pad[__SI_PAD_SIZE];
+
+	 /* kill().  */
+	struct
+	  {
+	    __pid_t si_pid;	/* Sending process ID.  */
+	    __uid_t si_uid;	/* Real user ID of sending process.  */
+	  } _kill;
+
+	/* POSIX.1b timers.  */
+	struct
+	  {
+	    __timer_t _tid;	/* timer id */
+            int _overrun;	/* overrun count */
+	    sigval_t si_sigval;	/* Signal value, same as below  */
+	  } _timer;
+
+	/* POSIX.1b signals.  */
+	struct
+	  {
+	    __pid_t si_pid;	/* Sending process ID.  */
+	    __uid_t si_uid;	/* Real user ID of sending process.  */
+	    sigval_t si_sigval;	/* Signal value.  */
+	  } _rt;
+
+	/* SIGCHLD.  */
+	struct
+	  {
+	    __pid_t si_pid;	/* Which child.  */
+	    __uid_t si_uid;	/* Real user ID of sending process.  */
+	    int si_status;	/* Exit value or signal.  */
+	    __clock_t si_utime;
+	    __clock_t si_stime;
+	  } _sigchld;
+
+	/* SIGILL, SIGFPE, SIGSEGV, SIGBUS.  */
+	struct
+	  {
+	    void *si_addr;	/* Faulting insn/memory ref.  */
+	  } _sigfault;
+
+	/* SIGPOLL.  */
+	struct
+	  {
+	    int si_band;	/* Band event for SIGPOLL.  */
+	    int si_fd;
+	  } _sigpoll;
+      } _sifields;
+  } siginfo_t;
+
+
+/* X/Open requires some more fields with fixed names.  */
+# define si_pid		_sifields._kill.si_pid
+# define si_uid		_sifields._kill.si_uid
+# define si_tid		_sifields._timer._tid
+# define si_overrun	_sifields._timer._overrun
+# define si_status	_sifields._sigchld.si_status
+# define si_utime	_sifields._sigchld.si_utime
+# define si_stime	_sifields._sigchld.si_stime
+# define si_value	_sifields._rt.si_sigval
+# define si_int		_sifields._rt.si_sigval.sival_int
+# define si_ptr		_sifields._rt.si_sigval.sival_ptr
+# define si_addr	_sifields._sigfault.si_addr
+# define si_band	_sifields._sigpoll.si_band
+# define si_fd		_sifields._sigpoll.si_fd
+
+/* To be compatable with prior _timer members */
+
+#define _timer1 _tid
+#define _timer2 _overrun
+
+
+/* Values for `si_code'.  Positive values are reserved for kernel-genera=
ted
+   signals.  */
+enum
+{
+  SI_SIGIO =3D -5,		/* Sent by queued SIGIO. */
+# define SI_SIGIO	SI_SIGIO
+  SI_ASYNCIO,			/* Sent by AIO completion.  */
+# define SI_ASYNCIO	SI_ASYNCIO
+  SI_MESGQ,			/* Sent by real time mesq state change.  */
+# define SI_MESGQ	SI_MESGQ
+  SI_TIMER,			/* Sent by timer expiration.  */
+# define SI_TIMER	SI_TIMER
+  SI_QUEUE,			/* Sent by sigqueue.  */
+# define SI_QUEUE	SI_QUEUE
+  SI_USER			/* Sent by kill, sigsend, raise.  */
+# define SI_USER	SI_USER
+};
+
+
+/* `si_code' values for SIGILL signal.  */
+enum
+{
+  ILL_ILLOPC =3D 1,		/* Illegal opcode.  */
+# define ILL_ILLOPC	ILL_ILLOPC
+  ILL_ILLOPN,			/* Illegal operand.  */
+# define ILL_ILLOPN	ILL_ILLOPN
+  ILL_ILLADR,			/* Illegal addressing mode.  */
+# define ILL_ILLADR	ILL_ILLADR
+  ILL_ILLTRP,			/* Illegal trap. */
+# define ILL_ILLTRP	ILL_ILLTRP
+  ILL_PRVOPC,			/* Privileged opcode.  */
+# define ILL_PRVOPC	ILL_PRVOPC
+  ILL_PRVREG,			/* Privileged register.  */
+# define ILL_PRVREG	ILL_PRVREG
+  ILL_COPROC,			/* Coprocessor error.  */
+# define ILL_COPROC	ILL_COPROC
+  ILL_BADSTK			/* Internal stack error.  */
+# define ILL_BADSTK	ILL_BADSTK
+};
+
+/* `si_code' values for SIGFPE signal.  */
+enum
+{
+  FPE_INTDIV =3D 1,		/* Integer divide by zero.  */
+# define FPE_INTDIV	FPE_INTDIV
+  FPE_INTOVF,			/* Integer overflow.  */
+# define FPE_INTOVF	FPE_INTOVF
+  FPE_FLTDIV,			/* Floating point divide by zero.  */
+# define FPE_FLTDIV	FPE_FLTDIV
+  FPE_FLTOVF,			/* Floating point overflow.  */
+# define FPE_FLTOVF	FPE_FLTOVF
+  FPE_FLTUND,			/* Floating point underflow.  */
+# define FPE_FLTUND	FPE_FLTUND
+  FPE_FLTRES,			/* Floating point inexact result.  */
+# define FPE_FLTRES	FPE_FLTRES
+  FPE_FLTINV,			/* Floating point invalid operation.  */
+# define FPE_FLTINV	FPE_FLTINV
+  FPE_FLTSUB			/* Subscript out of range.  */
+# define FPE_FLTSUB	FPE_FLTSUB
+};
+
+/* `si_code' values for SIGSEGV signal.  */
+enum
+{
+  SEGV_MAPERR =3D 1,		/* Address not mapped to object.  */
+# define SEGV_MAPERR	SEGV_MAPERR
+  SEGV_ACCERR			/* Invalid permissions for mapped object.  */
+# define SEGV_ACCERR	SEGV_ACCERR
+};
+
+/* `si_code' values for SIGBUS signal.  */
+enum
+{
+  BUS_ADRALN =3D 1,		/* Invalid address alignment.  */
+# define BUS_ADRALN	BUS_ADRALN
+  BUS_ADRERR,			/* Non-existant physical address.  */
+# define BUS_ADRERR	BUS_ADRERR
+  BUS_OBJERR			/* Object specific hardware error.  */
+# define BUS_OBJERR	BUS_OBJERR
+};
+
+/* `si_code' values for SIGTRAP signal.  */
+enum
+{
+  TRAP_BRKPT =3D 1,		/* Process breakpoint.  */
+# define TRAP_BRKPT	TRAP_BRKPT
+  TRAP_TRACE			/* Process trace trap.  */
+# define TRAP_TRACE	TRAP_TRACE
+};
+
+/* `si_code' values for SIGCHLD signal.  */
+enum
+{
+  CLD_EXITED =3D 1,		/* Child has exited.  */
+# define CLD_EXITED	CLD_EXITED
+  CLD_KILLED,			/* Child was killed.  */
+# define CLD_KILLED	CLD_KILLED
+  CLD_DUMPED,			/* Child terminated abnormally.  */
+# define CLD_DUMPED	CLD_DUMPED
+  CLD_TRAPPED,			/* Traced child has trapped.  */
+# define CLD_TRAPPED	CLD_TRAPPED
+  CLD_STOPPED,			/* Child has stopped.  */
+# define CLD_STOPPED	CLD_STOPPED
+  CLD_CONTINUED			/* Stopped child has continued.  */
+# define CLD_CONTINUED	CLD_CONTINUED
+};
+
+/* `si_code' values for SIGPOLL signal.  */
+enum
+{
+  POLL_IN =3D 1,			/* Data input available.  */
+# define POLL_IN	POLL_IN
+  POLL_OUT,			/* Output buffers available.  */
+# define POLL_OUT	POLL_OUT
+  POLL_MSG,			/* Input message available.   */
+# define POLL_MSG	POLL_MSG
+  POLL_ERR,			/* I/O error.  */
+# define POLL_ERR	POLL_ERR
+  POLL_PRI,			/* High priority input available.  */
+# define POLL_PRI	POLL_PRI
+  POLL_HUP			/* Device disconnected.  */
+# define POLL_HUP	POLL_HUP
+};
+
+# undef __need_siginfo_t
+#endif	/* !have siginfo_t && (have _SIGNAL_H || need siginfo_t).  */
+
+
+#if defined _SIGNAL_H && !defined __have_sigevent_t
+# define __have_sigevent_t	1
+
+/* Structure to transport application-defined values with signals.  */
+# define __SIGEV_MAX_SIZE	64
+# define __SIGEV_PAD_SIZE	((__SIGEV_MAX_SIZE / sizeof (int)) - 3)
+
+typedef struct sigevent
+  {
+    sigval_t sigev_value;
+    int sigev_signo;
+    int sigev_notify;
+
+    union
+      {
+	int _pad[__SIGEV_PAD_SIZE];
+        int _tid;
+
+	struct
+	  {
+	    void (*_function) __PMT ((sigval_t)); /* Function to start.  */
+	    void *_attribute;			  /* Really pthread_attr_t.  */
+	  } _sigev_thread;
+      } _sigev_un;
+  } sigevent_t;
+
+/* POSIX names to access some of the members.  */
+# define sigev_notify_function   _sigev_un._sigev_thread._function
+# define sigev_notify_attributes _sigev_un._sigev_thread._attribute
+# define sigev_notify_thread_id  _sigev_un._tid
+
+/* `sigev_notify' values.  */
+enum
+{
+  SIGEV_SIGNAL =3D 0,		/* Notify via signal.  */
+# define SIGEV_SIGNAL	SIGEV_SIGNAL
+  SIGEV_NONE,			/* Other notification: meaningless.  */
+# define SIGEV_NONE	SIGEV_NONE
+  SIGEV_THREAD,			/* Deliver via thread creation.  */
+# define SIGEV_THREAD	SIGEV_THREAD
+  SIGEV_DUMMY,                  /* To allow binary enumeration */
+  SIGEV_THREAD_ID
+# define SIGEV_THREAD_ID SIGEV_THREAD_ID
+};
+
+#endif	/* have _SIGNAL_H.  */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/usr_incl/bits/siginfo.h-old linux/Documentation=
/high-res-timers/usr_incl/bits/siginfo.h-old
--- linux-2.5.36-kb/Documentation/high-res-timers/usr_incl/bits/siginfo.h=
-old	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/usr_incl/bits/siginfo.h-old	Wed S=
ep 18 17:39:54 2002
@@ -0,0 +1,314 @@
+/* siginfo_t, sigevent and constants.  Linux/SPARC version.
+   Copyright (C) 1997, 1998, 1999, 2000, 2001 Free Software Foundation, =
Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#if !defined _SIGNAL_H && !defined __need_siginfo_t \
+    && !defined __need_sigevent_t
+# error "Never include this file directly.  Use <signal.h> instead"
+#endif
+
+#include <bits/wordsize.h>
+
+#if (!defined __have_sigval_t \
+     && (defined _SIGNAL_H || defined __need_siginfo_t \
+	 || defined __need_sigevent_t))
+# define __have_sigval_t	1
+
+/* Type for data associated with a signal.  */
+typedef union sigval
+  {
+    int sival_int;
+    void *sival_ptr;
+  } sigval_t;
+#endif
+
+#if (!defined __have_siginfo_t \
+     && (defined _SIGNAL_H || defined __need_siginfo_t))
+# define __have_siginfo_t	1
+
+# define __SI_MAX_SIZE     128
+# if __WORDSIZE =3D=3D 64
+#  define __SI_PAD_SIZE     ((__SI_MAX_SIZE / sizeof (int)) - 4)
+# else
+#  define __SI_PAD_SIZE     ((__SI_MAX_SIZE / sizeof (int)) - 3)
+# endif
+
+typedef struct siginfo
+  {
+    int si_signo;		/* Signal number.  */
+    int si_errno;		/* If non-zero, an errno value associated with
+				   this signal, as defined in <errno.h>.  */
+    int si_code;		/* Signal code.  */
+
+    union
+      {
+	int _pad[__SI_PAD_SIZE];
+
+	 /* kill().  */
+	struct
+	  {
+	    __pid_t si_pid;	/* Sending process ID.  */
+	    __uid_t si_uid;	/* Real user ID of sending process.  */
+	  } _kill;
+
+	/* POSIX.1b timers.  */
+	struct
+	  {
+	    __timer_t _tid;	/* timer id */
+            int _overrun;	/* overrun count */
+	    sigval_t si_sigval;	/* Signal value, same as below  */
+          } _timer;
+
+	/* POSIX.1b signals.  */
+	struct
+	  {
+	    __pid_t si_pid;	/* Sending process ID.  */
+	    __uid_t si_uid;	/* Real user ID of sending process.  */
+	    sigval_t si_sigval;	/* Signal value.  */
+	  } _rt;
+
+	/* SIGCHLD.  */
+	struct
+	  {
+	    __pid_t si_pid;	/* Which child.  */
+	    __uid_t si_uid;	/* Real user ID of sending process.  */
+	    int si_status;	/* Exit value or signal.  */
+	    __clock_t si_utime;
+	    __clock_t si_stime;
+	  } _sigchld;
+
+	/* SIGILL, SIGFPE, SIGSEGV, SIGBUS.  */
+	struct
+	  {
+	    void *si_addr;	/* Faulting insn/memory ref.  */
+	  } _sigfault;
+
+	/* SIGPOLL.  */
+	struct
+	  {
+	    long int si_band;	/* Band event for SIGPOLL.  */
+	    int si_fd;
+	  } _sigpoll;
+      } _sifields;
+  } siginfo_t;
+
+
+/* X/Open requires some more fields with fixed names.  */
+# define si_pid		_sifields._kill.si_pid
+# define si_uid		_sifields._kill.si_uid
+# define si_timer1	_sifields._timer._timer1
+# define si_timer2	_sifields._timer._timer2
+# define si_status	_sifields._sigchld.si_status
+# define si_utime	_sifields._sigchld.si_utime
+# define si_stime	_sifields._sigchld.si_stime
+# define si_value	_sifields._rt.si_sigval
+# define si_int		_sifields._rt.si_sigval.sival_int
+# define si_ptr		_sifields._rt.si_sigval.sival_ptr
+# define si_addr	_sifields._sigfault.si_addr
+# define si_tid		_sifields._timer._tid
+# define si_overrun	_sifields._timer._overrun
+# define si_band	_sifields._sigpoll.si_band
+# define si_fd		_sifields._sigpoll.si_fd
+
+
+/* Values for `si_code'.  Positive values are reserved for kernel-genera=
ted
+   signals.  */
+enum
+{
+  SI_ASYNCNL =3D -6,		/* Sent by asynch name lookup completion.  */
+# define SI_ASYNCNL	SI_ASYNCNL
+  SI_SIGIO,			/* Sent by queued SIGIO. */
+# define SI_SIGIO	SI_SIGIO
+  SI_ASYNCIO,			/* Sent by AIO completion.  */
+# define SI_ASYNCIO	SI_ASYNCIO
+  SI_MESGQ,			/* Sent by real time mesq state change.  */
+# define SI_MESGQ	SI_MESGQ
+  SI_TIMER,			/* Sent by timer expiration.  */
+# define SI_TIMER	SI_TIMER
+  SI_QUEUE,			/* Sent by sigqueue.  */
+# define SI_QUEUE	SI_QUEUE
+  SI_USER,			/* Sent by kill, sigsend, raise.  */
+# define SI_USER	SI_USER
+  SI_KERNEL =3D 0x80		/* Send by kernel.  */
+#define SI_KERNEL	SI_KERNEL
+};
+
+
+/* `si_code' values for SIGILL signal.  */
+enum
+{
+  ILL_ILLOPC =3D 1,		/* Illegal opcode.  */
+# define ILL_ILLOPC	ILL_ILLOPC
+  ILL_ILLOPN,			/* Illegal operand.  */
+# define ILL_ILLOPN	ILL_ILLOPN
+  ILL_ILLADR,			/* Illegal addressing mode.  */
+# define ILL_ILLADR	ILL_ILLADR
+  ILL_ILLTRP,			/* Illegal trap. */
+# define ILL_ILLTRP	ILL_ILLTRP
+  ILL_PRVOPC,			/* Privileged opcode.  */
+# define ILL_PRVOPC	ILL_PRVOPC
+  ILL_PRVREG,			/* Privileged register.  */
+# define ILL_PRVREG	ILL_PRVREG
+  ILL_COPROC,			/* Coprocessor error.  */
+# define ILL_COPROC	ILL_COPROC
+  ILL_BADSTK			/* Internal stack error.  */
+# define ILL_BADSTK	ILL_BADSTK
+};
+
+/* `si_code' values for SIGFPE signal.  */
+enum
+{
+  FPE_INTDIV =3D 1,		/* Integer divide by zero.  */
+# define FPE_INTDIV	FPE_INTDIV
+  FPE_INTOVF,			/* Integer overflow.  */
+# define FPE_INTOVF	FPE_INTOVF
+  FPE_FLTDIV,			/* Floating point divide by zero.  */
+# define FPE_FLTDIV	FPE_FLTDIV
+  FPE_FLTOVF,			/* Floating point overflow.  */
+# define FPE_FLTOVF	FPE_FLTOVF
+  FPE_FLTUND,			/* Floating point underflow.  */
+# define FPE_FLTUND	FPE_FLTUND
+  FPE_FLTRES,			/* Floating point inexact result.  */
+# define FPE_FLTRES	FPE_FLTRES
+  FPE_FLTINV,			/* Floating point invalid operation.  */
+# define FPE_FLTINV	FPE_FLTINV
+  FPE_FLTSUB			/* Subscript out of range.  */
+# define FPE_FLTSUB	FPE_FLTSUB
+};
+
+/* `si_code' values for SIGSEGV signal.  */
+enum
+{
+  SEGV_MAPERR =3D 1,		/* Address not mapped to object.  */
+# define SEGV_MAPERR	SEGV_MAPERR
+  SEGV_ACCERR			/* Invalid permissions for mapped object.  */
+# define SEGV_ACCERR	SEGV_ACCERR
+};
+
+/* `si_code' values for SIGBUS signal.  */
+enum
+{
+  BUS_ADRALN =3D 1,		/* Invalid address alignment.  */
+# define BUS_ADRALN	BUS_ADRALN
+  BUS_ADRERR,			/* Non-existant physical address.  */
+# define BUS_ADRERR	BUS_ADRERR
+  BUS_OBJERR			/* Object specific hardware error.  */
+# define BUS_OBJERR	BUS_OBJERR
+};
+
+/* `si_code' values for SIGTRAP signal.  */
+enum
+{
+  TRAP_BRKPT =3D 1,		/* Process breakpoint.  */
+# define TRAP_BRKPT	TRAP_BRKPT
+  TRAP_TRACE			/* Process trace trap.  */
+# define TRAP_TRACE	TRAP_TRACE
+};
+
+/* `si_code' values for SIGCHLD signal.  */
+enum
+{
+  CLD_EXITED =3D 1,		/* Child has exited.  */
+# define CLD_EXITED	CLD_EXITED
+  CLD_KILLED,			/* Child was killed.  */
+# define CLD_KILLED	CLD_KILLED
+  CLD_DUMPED,			/* Child terminated abnormally.  */
+# define CLD_DUMPED	CLD_DUMPED
+  CLD_TRAPPED,			/* Traced child has trapped.  */
+# define CLD_TRAPPED	CLD_TRAPPED
+  CLD_STOPPED,			/* Child has stopped.  */
+# define CLD_STOPPED	CLD_STOPPED
+  CLD_CONTINUED			/* Stopped child has continued.  */
+# define CLD_CONTINUED	CLD_CONTINUED
+};
+
+/* `si_code' values for SIGPOLL signal.  */
+enum
+{
+  POLL_IN =3D 1,			/* Data input available.  */
+# define POLL_IN	POLL_IN
+  POLL_OUT,			/* Output buffers available.  */
+# define POLL_OUT	POLL_OUT
+  POLL_MSG,			/* Input message available.   */
+# define POLL_MSG	POLL_MSG
+  POLL_ERR,			/* I/O error.  */
+# define POLL_ERR	POLL_ERR
+  POLL_PRI,			/* High priority input available.  */
+# define POLL_PRI	POLL_PRI
+  POLL_HUP			/* Device disconnected.  */
+# define POLL_HUP	POLL_HUP
+};
+
+# undef __need_siginfo_t
+#endif	/* !have siginfo_t && (have _SIGNAL_H || need siginfo_t).  */
+
+
+#if (defined _SIGNAL_H || defined __need_sigevent_t) \
+    && !defined __have_sigevent_t
+# define __have_sigevent_t	1
+
+/* Structure to transport application-defined values with signals.  */
+# define __SIGEV_MAX_SIZE	64
+# if __WORDSIZE =3D=3D 64
+#  define __SIGEV_PAD_SIZE	((__SIGEV_MAX_SIZE / sizeof (int)) - 4)
+# else
+#  define __SIGEV_PAD_SIZE	((__SIGEV_MAX_SIZE / sizeof (int)) - 3)
+# endif
+
+/* Forward declaration of the `pthread_attr_t' type.  */
+struct __pthread_attr_s;
+
+typedef struct sigevent
+  {
+    sigval_t sigev_value;
+    int sigev_signo;
+    int sigev_notify;
+
+    union
+      {
+	int _pad[__SIGEV_PAD_SIZE];
+        int _tid;
+              =

+	struct
+	  {
+	    void (*_function) (sigval_t);	  /* Function to start.  */
+	    struct __pthread_attr_s *_attribute;  /* Really pthread_attr_t.  */=

+	  } _sigev_thread;
+      } _sigev_un;
+  } sigevent_t;
+
+/* POSIX names to access some of the members.  */
+# define sigev_notify_function   _sigev_un._sigev_thread._function
+# define sigev_notify_attributes _sigev_un._sigev_thread._attribute
+# define sigev_notify_thread_id  _sigev_un._tid
+
+/* `sigev_notify' values.  */
+enum
+{
+  SIGEV_SIGNAL =3D 0,		/* Notify via signal.  */
+# define SIGEV_SIGNAL	SIGEV_SIGNAL
+  SIGEV_NONE,			/* Other notification: meaningless.  */
+# define SIGEV_NONE	SIGEV_NONE
+  SIGEV_THREAD,			/* Deliver via thread creation.  */
+# define SIGEV_THREAD	SIGEV_THREAD
+  SIGEV_DUMMY,
+  SIGEV_THREAD_ID
+# define SIGEV_THREAD_ID SIGEV_THREAD_ID
+};
+
+#endif	/* have _SIGNAL_H.  */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/usr_incl/bits/types.h-should-not-need linux/Doc=
umentation/high-res-timers/usr_incl/bits/types.h-should-not-need
--- linux-2.5.36-kb/Documentation/high-res-timers/usr_incl/bits/types.h-s=
hould-not-need	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/usr_incl/bits/types.h-should-not-=
need	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,155 @@
+/* Copyright (C) 1991,92,94,95,96,97,98,99 Free Software Foundation, Inc=
=2E
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Library General Public License a=
s
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Library General Public License for more details.
+
+   You should have received a copy of the GNU Library General Public
+   License along with the GNU C Library; see the file COPYING.LIB.  If n=
ot,
+   write to the Free Software Foundation, Inc., 59 Temple Place - Suite =
330,
+   Boston, MA 02111-1307, USA.  */
+
+/*
+ * Never include this file directly; use <sys/types.h> instead.
+ */
+
+#ifndef	_BITS_TYPES_H
+#define	_BITS_TYPES_H	1
+
+#include <features.h>
+
+#define __need_size_t
+#include <stddef.h>
+
+/* Convenience types.  */
+typedef unsigned char __u_char;
+typedef unsigned short __u_short;
+typedef unsigned int __u_int;
+typedef unsigned long __u_long;
+#ifdef __GNUC__
+__extension__ typedef unsigned long long int __u_quad_t;
+__extension__ typedef long long int __quad_t;
+#else
+typedef struct
+  {
+    long int __val[2];
+  } __quad_t;
+typedef struct
+  {
+    __u_long __val[2];
+  } __u_quad_t;
+#endif
+typedef signed char __int8_t;
+typedef unsigned char __uint8_t;
+typedef signed short int __int16_t;
+typedef unsigned short int __uint16_t;
+typedef signed int __int32_t;
+typedef unsigned int __uint32_t;
+#ifdef __GNUC__
+__extension__ typedef signed long long int __int64_t;
+__extension__ typedef unsigned long long int __uint64_t;
+#endif
+typedef __quad_t *__qaddr_t;
+
+typedef __u_quad_t __dev_t;		/* Type of device numbers.  */
+typedef __u_int __uid_t;		/* Type of user identifications.  */
+typedef __u_int __gid_t;		/* Type of group identifications.  */
+typedef __u_long __ino_t;		/* Type of file serial numbers.  */
+typedef __u_int __mode_t;		/* Type of file attribute bitmasks.  */
+typedef __u_int __nlink_t; 		/* Type of file link counts.  */
+typedef long int __off_t;		/* Type of file sizes and offsets.  */
+typedef __quad_t __loff_t;		/* Type of file sizes and offsets.  */
+typedef int __pid_t;			/* Type of process identifications.  */
+typedef int __ssize_t;			/* Type of a byte count, or error.  */
+typedef long int __rlim_t;		/* Type of resource counts.  */
+typedef __quad_t __rlim64_t;		/* Type of resource counts (LFS).  */
+typedef __u_int __id_t;			/* General type for ID.  */
+
+typedef struct
+  {
+    int __val[2];
+  } __fsid_t;				/* Type of file system IDs.  */
+
+/* Everythin' else.  */
+typedef int __daddr_t;			/* The type of a disk address.  */
+typedef char *__caddr_t;
+typedef long int __time_t;
+typedef long int __swblk_t;		/* Type of a swap block maybe?  */
+=0C
+typedef long int __clock_t;
+typedef int __timer_t;
+typedef int __clockid_t;
+
+/* One element in the file descriptor mask array.  */
+typedef unsigned long int __fd_mask;
+
+/* Number of descriptors that can fit in an `fd_set'.  */
+#define __FD_SETSIZE	1024
+
+/* It's easier to assume 8-bit bytes than to get CHAR_BIT.  */
+#define __NFDBITS	(8 * sizeof (__fd_mask))
+#define	__FDELT(d)	((d) / __NFDBITS)
+#define	__FDMASK(d)	((__fd_mask) 1 << ((d) % __NFDBITS))
+
+/* fd_set for select and pselect.  */
+typedef struct
+  {
+    /* XPG4.2 requires this member name.  Otherwise avoid the name
+       from the global namespace.  */
+#ifdef __USE_XOPEN
+    __fd_mask fds_bits[__FD_SETSIZE / __NFDBITS];
+# define __FDS_BITS(set) ((set)->fds_bits)
+#else
+    __fd_mask __fds_bits[__FD_SETSIZE / __NFDBITS];
+# define __FDS_BITS(set) ((set)->__fds_bits)
+#endif
+  } __fd_set;
+
+
+typedef int __key_t;
+
+/* Used in `struct shmid_ds'.  */
+typedef unsigned short int __ipc_pid_t;
+
+
+/* Types from the Large File Support interface.  */
+
+/* Type to count number os disk blocks.  */
+typedef long int __blkcnt_t;
+typedef __quad_t __blkcnt64_t;
+
+/* Type to count file system blocks.  */
+typedef __u_long __fsblkcnt_t;
+typedef __u_quad_t __fsblkcnt64_t;
+
+/* Type to count file system inodes.  */
+typedef __u_long __fsfilcnt_t;
+typedef __u_quad_t __fsfilcnt64_t;
+
+/* Type of file serial numbers.  */
+typedef __u_long __ino64_t;
+
+/* Type of file sizes and offsets.  */
+typedef __loff_t __off64_t;
+
+/* Used in XTI.  */
+typedef int __t_scalar_t;
+typedef unsigned int __t_uscalar_t;
+
+/* Duplicates info from stdint.h but this is used in unistd.h.  */
+typedef int __intptr_t;
+
+
+/* Now add the thread types.  */
+#ifdef __USE_UNIX98
+# include <bits/pthreadtypes.h>
+#endif
+
+#endif /* bits/types.h */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/usr_incl/bp-asm.h linux/Documentation/high-res-=
timers/usr_incl/bp-asm.h
--- linux-2.5.36-kb/Documentation/high-res-timers/usr_incl/bp-asm.h	Wed D=
ec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/usr_incl/bp-asm.h	Wed Sep 18 17:3=
9:54 2002
@@ -0,0 +1,144 @@
+/* Bounded-pointer definitions for x86 assembler.
+   Copyright (C) 2000 Free Software Foundation, Inc.
+   Contributed by Greg McGary <greg@mcgary.org>
+   This file is part of the GNU C Library.  Its master source is NOT par=
t of
+   the C library, however.  The master source lives in the GNU MP Librar=
y.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#ifndef _bp_asm_h_
+# define _bp_asm_h_ 1
+
+# if __ASSEMBLER__
+
+#  if __BOUNDED_POINTERS__
+
+/* Bounded pointers occupy three words.  */
+#   define PTR_SIZE 12
+/* Bounded pointer return values are passed back through a hidden
+   argument that points to caller-allocate space.  The hidden arg
+   occupies one word on the stack.  */
+#   define RTN_SIZE 4
+/* Although the caller pushes the hidden arg, the callee is
+   responsible for popping it.  */
+#   define RET_PTR ret $RTN_SIZE
+/* Maintain frame pointer chain in leaf assembler functions for the bene=
fit
+   of debugging stack traces when bounds violations occur.  */
+#   define ENTER pushl %ebp; movl %esp, %ebp
+#   define LEAVE movl %ebp, %esp; popl %ebp
+/* Stack space overhead of procedure-call linkage: return address and
+   frame pointer.  */
+#   define LINKAGE 8
+/* Stack offset of return address after calling ENTER.  */
+#   define PCOFF 4
+
+/* Int 5 is the "bound range" exception also raised by the "bound"
+   instruction.  */
+#   define BOUNDS_VIOLATED int $5
+
+#   define CHECK_BOUNDS_LOW(VAL_REG, BP_MEM)	\
+	cmpl 4+BP_MEM, VAL_REG;			\
+	jae 0f; /* continue if value >=3D low */	\
+	BOUNDS_VIOLATED;			\
+    0:
+
+#   define CHECK_BOUNDS_HIGH(VAL_REG, BP_MEM, Jcc)	\
+	cmpl 8+BP_MEM, VAL_REG;				\
+	Jcc 0f; /* continue if value < high */		\
+	BOUNDS_VIOLATED;				\
+    0:
+
+#   define CHECK_BOUNDS_BOTH(VAL_REG, BP_MEM)	\
+	cmpl 4+BP_MEM, VAL_REG;			\
+	jb 1f; /* die if value < low */		\
+    	cmpl 8+BP_MEM, VAL_REG;			\
+	jb 0f; /* continue if value < high */	\
+    1:	BOUNDS_VIOLATED;			\
+    0:
+
+#   define CHECK_BOUNDS_BOTH_WIDE(VAL_REG, BP_MEM, LENGTH)	\
+	CHECK_BOUNDS_LOW(VAL_REG, BP_MEM);			\
+	addl LENGTH, VAL_REG;					\
+    	cmpl 8+BP_MEM, VAL_REG;					\
+	jbe 0f; /* continue if value <=3D high */			\
+	BOUNDS_VIOLATED;					\
+    0:	subl LENGTH, VAL_REG /* restore value */
+
+/* Take bounds from BP_MEM and affix them to the pointer
+   value in %eax, stuffing all into memory at RTN(%esp).
+   Use %edx as a scratch register.  */
+
+#   define RETURN_BOUNDED_POINTER(BP_MEM)	\
+	movl RTN(%esp), %edx;			\
+	movl %eax, 0(%edx);			\
+	movl 4+BP_MEM, %eax;			\
+	movl %eax, 4(%edx);			\
+	movl 8+BP_MEM, %eax;			\
+	movl %eax, 8(%edx)
+
+#   define RETURN_NULL_BOUNDED_POINTER		\
+	movl RTN(%esp), %edx;			\
+	movl %eax, 0(%edx);			\
+	movl %eax, 4(%edx);			\
+	movl %eax, 8(%edx)
+
+/* The caller of __errno_location is responsible for allocating space
+   for the three-word BP return-value and passing pushing its address
+   as an implicit first argument.  */
+#   define PUSH_ERRNO_LOCATION_RETURN		\
+	subl $8, %esp;				\
+	subl $4, %esp;				\
+	pushl %esp
+
+/* __errno_location is responsible for popping the implicit first
+   argument, but we must pop the space for the BP itself.  We also
+   dereference the return value in order to dig out the pointer value.  =
*/
+#   define POP_ERRNO_LOCATION_RETURN		\
+	popl %eax;				\
+	addl $8, %esp
+
+#  else /* !__BOUNDED_POINTERS__ */
+
+/* Unbounded pointers occupy one word.  */
+#   define PTR_SIZE 4
+/* Unbounded pointer return values are passed back in the register %eax.=
  */
+#   define RTN_SIZE 0
+/* Use simple return instruction for unbounded pointer values.  */
+#   define RET_PTR ret
+/* Don't maintain frame pointer chain for leaf assembler functions.  */
+#   define ENTER
+#   define LEAVE
+/* Stack space overhead of procedure-call linkage: return address only. =
 */
+#   define LINKAGE 4
+/* Stack offset of return address after calling ENTER.  */
+#   define PCOFF 0
+
+#   define CHECK_BOUNDS_LOW(VAL_REG, BP_MEM)
+#   define CHECK_BOUNDS_HIGH(VAL_REG, BP_MEM, Jcc)
+#   define CHECK_BOUNDS_BOTH(VAL_REG, BP_MEM)
+#   define CHECK_BOUNDS_BOTH_WIDE(VAL_REG, BP_MEM, LENGTH)
+#   define RETURN_BOUNDED_POINTER(BP_MEM)
+
+#   define RETURN_NULL_BOUNDED_POINTER
+
+#   define PUSH_ERRNO_LOCATION_RETURN
+#   define POP_ERRNO_LOCATION_RETURN
+
+#  endif /* !__BOUNDED_POINTERS__ */
+
+# endif /* __ASSEMBLER__ */
+
+#endif /* _bp_asm_h_ */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/usr_incl/bp-sym.h linux/Documentation/high-res-=
timers/usr_incl/bp-sym.h
--- linux-2.5.36-kb/Documentation/high-res-timers/usr_incl/bp-sym.h	Wed D=
ec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/usr_incl/bp-sym.h	Wed Sep 18 17:3=
9:54 2002
@@ -0,0 +1,26 @@
+/* Bounded-pointer symbol modifier.
+   Copyright (C) 2000 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Greg McGary <greg@mcgary.org>
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#define BP_SYM(name) _BP_SYM (name)
+#if __BOUNDED_POINTERS__
+# define _BP_SYM(name) __BP_##name
+#else
+# define _BP_SYM(name) name
+#endif
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/usr_incl/siginfo.patch linux/Documentation/high=
-res-timers/usr_incl/siginfo.patch
--- linux-2.5.36-kb/Documentation/high-res-timers/usr_incl/siginfo.patch	=
Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/usr_incl/siginfo.patch	Wed Sep 18=
 17:39:54 2002
@@ -0,0 +1,65 @@
+--- /usr/include/bits/siginfo.h	Tue Aug 13 17:11:34 2002
++++ bits/siginfo.h	Tue Aug 13 17:22:12 2002
+@@ -56,8 +56,9 @@
+ 	/* POSIX.1b timers.  */
+ 	struct
+ 	  {
+-	    unsigned int _timer1;
+-	    unsigned int _timer2;
++	    __timer_t _tid;	/* timer id */
++            int _overrun;	/* overrun count */
++	    sigval_t si_sigval;	/* Signal value, same as below  */
+ 	  } _timer;
+ =

+ 	/* POSIX.1b signals.  */
+@@ -97,6 +98,8 @@
+ /* X/Open requires some more fields with fixed names.  */
+ # define si_pid		_sifields._kill.si_pid
+ # define si_uid		_sifields._kill.si_uid
++# define si_tid		_sifields._timer._tid
++# define si_overrun	_sifields._timer._overrun
+ # define si_status	_sifields._sigchld.si_status
+ # define si_utime	_sifields._sigchld.si_utime
+ # define si_stime	_sifields._sigchld.si_stime
+@@ -107,6 +110,11 @@
+ # define si_band	_sifields._sigpoll.si_band
+ # define si_fd		_sifields._sigpoll.si_fd
+ =

++/* To be compatable with prior _timer members */
++
++#define _timer1 _tid
++#define _timer2 _overrun
++
+ =

+ /* Values for `si_code'.  Positive values are reserved for kernel-gener=
ated
+    signals.  */
+@@ -252,6 +260,7 @@
+     union
+       {
+ 	int _pad[__SIGEV_PAD_SIZE];
++        int _tid;
+ =

+ 	struct
+ 	  {
+@@ -264,6 +273,7 @@
+ /* POSIX names to access some of the members.  */
+ # define sigev_notify_function   _sigev_un._sigev_thread._function
+ # define sigev_notify_attributes _sigev_un._sigev_thread._attribute
++# define sigev_notify_thread_id  _sigev_un._tid
+ =

+ /* `sigev_notify' values.  */
+ enum
+@@ -272,8 +282,11 @@
+ # define SIGEV_SIGNAL	SIGEV_SIGNAL
+   SIGEV_NONE,			/* Other notification: meaningless.  */
+ # define SIGEV_NONE	SIGEV_NONE
+-  SIGEV_THREAD			/* Deliver via thread creation.  */
++  SIGEV_THREAD,			/* Deliver via thread creation.  */
+ # define SIGEV_THREAD	SIGEV_THREAD
++  SIGEV_DUMMY,                  /* To allow binary enumeration */
++  SIGEV_THREAD_ID
++# define SIGEV_THREAD_ID SIGEV_THREAD_ID
+ };
+ =

+ #endif	/* have _SIGNAL_H.  */
+
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/usr_incl/sysdeps/generic/sysdep.h linux/Documen=
tation/high-res-timers/usr_incl/sysdeps/generic/sysdep.h
--- linux-2.5.36-kb/Documentation/high-res-timers/usr_incl/sysdeps/generi=
c/sysdep.h	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/usr_incl/sysdeps/generic/sysdep.h=
	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,43 @@
+/* Generic asm macros used on many machines.
+   Copyright (C) 1991, 92, 93, 96, 98 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#ifndef C_LABEL
+
+/* Define a macro we can use to construct the asm name for a C symbol.  =
*/
+#ifdef	NO_UNDERSCORES
+#ifdef	__STDC__
+#define C_LABEL(name)		name##:
+#else
+#define C_LABEL(name)		name/**/:
+#endif
+#else
+#ifdef	__STDC__
+#define C_LABEL(name)		_##name##:
+#else
+#define C_LABEL(name)		_/**/name/**/:
+#endif
+#endif
+
+#endif
+
+/* Mark the end of function named SYM.  This is used on some platforms
+   to generate correct debugging information.  */
+#ifndef END
+#define END(sym)
+#endif
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/usr_incl/sysdeps/i386/sysdep.h linux/Documentat=
ion/high-res-timers/usr_incl/sysdeps/i386/sysdep.h
--- linux-2.5.36-kb/Documentation/high-res-timers/usr_incl/sysdeps/i386/s=
ysdep.h	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/usr_incl/sysdeps/i386/sysdep.h	We=
d Sep 18 17:39:54 2002
@@ -0,0 +1,294 @@
+/* Copyright (C) 1992, 93, 95, 96, 97, 98, 99, 00 Free Software Foundati=
on, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Ulrich Drepper, <drepper@gnu.org>, August 1995.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#ifndef _LINUX_I386_SYSDEP_H
+#define _LINUX_I386_SYSDEP_H 1
+
+/* There is some commonality.  */
+#include <sysdeps/unix/i386/sysdep.h>
+#include <bp-sym.h>
+#include <bp-asm.h>
+
+/* For Linux we can use the system call table in the header file
+	/usr/include/asm/unistd.h
+   of the kernel.  But these symbols do not follow the SYS_* syntax
+   so we have to redefine the `SYS_ify' macro here.  */
+#undef SYS_ify
+#define SYS_ify(syscall_name)	__NR_##syscall_name
+
+/* ELF-like local names start with `.L'.  */
+#undef L
+#define L(name)	.L##name
+
+#ifdef __ASSEMBLER__
+
+/* Linux uses a negative return value to indicate syscall errors,
+   unlike most Unices, which use the condition codes' carry flag.
+
+   Since version 2.1 the return value of a system call might be
+   negative even if the call succeeded.  E.g., the `lseek' system call
+   might return a large offset.  Therefore we must not anymore test
+   for < 0, but test for a real error by making sure the value in %eax
+   is a real error number.  Linus said he will make sure the no syscall
+   returns a value in -1 .. -4095 as a valid result so we can savely
+   test with -4095.  */
+
+/* We don't want the label for the error handle to be global when we def=
ine
+   it here.  */
+#ifdef PIC
+# define SYSCALL_ERROR_LABEL 0f
+#else
+# define SYSCALL_ERROR_LABEL syscall_error
+#endif
+
+#undef	PSEUDO
+#define	PSEUDO(name, syscall_name, args)				      \
+  .text;								      \
+  ENTRY (name)								      \
+    DO_CALL (args, syscall_name);					      \
+    cmpl $-4095, %eax;							      \
+    jae SYSCALL_ERROR_LABEL;						      \
+  L(pseudo_end):
+
+#undef	PSEUDO_END
+#define	PSEUDO_END(name)						      \
+  SYSCALL_ERROR_HANDLER							      \
+  END (name)
+
+#ifndef PIC
+#define SYSCALL_ERROR_HANDLER	/* Nothing here; code in sysdep.S is used.=
  */
+#else
+/* Store (- %eax) into errno through the GOT.  */
+#ifdef _LIBC_REENTRANT
+#define SYSCALL_ERROR_HANDLER						      \
+0:pushl %ebx;								      \
+  call 1f;								      \
+1:popl %ebx;								      \
+  xorl %edx, %edx;							      \
+  addl $_GLOBAL_OFFSET_TABLE_+[.-1b], %ebx;				      \
+  subl %eax, %edx;							      \
+  pushl %edx;								      \
+  PUSH_ERRNO_LOCATION_RETURN;						      \
+  call BP_SYM (__errno_location)@PLT;					      \
+  POP_ERRNO_LOCATION_RETURN;						      \
+  popl %ecx;								      \
+  popl %ebx;								      \
+  movl %ecx, (%eax);							      \
+  orl $-1, %eax;							      \
+  jmp L(pseudo_end);
+/* A quick note: it is assumed that the call to `__errno_location' does
+   not modify the stack!  */
+#else
+#define SYSCALL_ERROR_HANDLER						      \
+0:call 1f;								      \
+1:popl %ecx;								      \
+  xorl %edx, %edx;							      \
+  addl $_GLOBAL_OFFSET_TABLE_+[.-1b], %ecx;				      \
+  subl %eax, %edx;							      \
+  movl errno@GOT(%ecx), %ecx;						      \
+  movl %edx, (%ecx);							      \
+  orl $-1, %eax;							      \
+  jmp L(pseudo_end);
+#endif	/* _LIBC_REENTRANT */
+#endif	/* PIC */
+
+/* Linux takes system call arguments in registers:
+
+	syscall number	%eax	     call-clobbered
+	arg 1		%ebx	     call-saved
+	arg 2		%ecx	     call-clobbered
+	arg 3		%edx	     call-clobbered
+	arg 4		%esi	     call-saved
+	arg 5		%edi	     call-saved
+
+   The stack layout upon entering the function is:
+
+	20(%esp)	Arg# 5
+	16(%esp)	Arg# 4
+	12(%esp)	Arg# 3
+	 8(%esp)	Arg# 2
+	 4(%esp)	Arg# 1
+	  (%esp)	Return address
+
+   (Of course a function with say 3 arguments does not have entries for
+   arguments 4 and 5.)
+
+   The following code tries hard to be optimal.  A general assumption
+   (which is true according to the data books I have) is that
+
+	2 * xchg	is more expensive than	pushl + movl + popl
+
+   Beside this a neat trick is used.  The calling conventions for Linux
+   tell that among the registers used for parameters %ecx and %edx need
+   not be saved.  Beside this we may clobber this registers even when
+   they are not used for parameter passing.
+
+   As a result one can see below that we save the content of the %ebx
+   register in the %edx register when we have less than 3 arguments
+   (2 * movl is less expensive than pushl + popl).
+
+   Second unlike for the other registers we don't save the content of
+   %ecx and %edx when we have more than 1 and 2 registers resp.
+
+   The code below might look a bit long but we have to take care for
+   the pipelined processors (i586).  Here the `pushl' and `popl'
+   instructions are marked as NP (not pairable) but the exception is
+   two consecutive of these instruction.  This gives no penalty on
+   other processors though.  */
+
+#undef	DO_CALL
+#define DO_CALL(args, syscall_name)			      		      \
+    PUSHARGS_##args							      \
+    DOARGS_##args							      \
+    movl $SYS_ify (syscall_name), %eax;					      \
+    int $0x80								      \
+    POPARGS_##args
+
+#define PUSHARGS_0	/* No arguments to push.  */
+#define	DOARGS_0	/* No arguments to frob.  */
+#define	POPARGS_0	/* No arguments to pop.  */
+#define	_PUSHARGS_0	/* No arguments to push.  */
+#define _DOARGS_0(n)	/* No arguments to frob.  */
+#define	_POPARGS_0	/* No arguments to pop.  */
+
+#define PUSHARGS_1	movl %ebx, %edx; PUSHARGS_0
+#define	DOARGS_1	_DOARGS_1 (4)
+#define	POPARGS_1	POPARGS_0; movl %edx, %ebx
+#define	_PUSHARGS_1	pushl %ebx; _PUSHARGS_0
+#define _DOARGS_1(n)	movl n(%esp), %ebx; _DOARGS_0(n-4)
+#define	_POPARGS_1	_POPARGS_0; popl %ebx
+
+#define PUSHARGS_2	PUSHARGS_1
+#define	DOARGS_2	_DOARGS_2 (8)
+#define	POPARGS_2	POPARGS_1
+#define _PUSHARGS_2	_PUSHARGS_1
+#define	_DOARGS_2(n)	movl n(%esp), %ecx; _DOARGS_1 (n-4)
+#define	_POPARGS_2	_POPARGS_1
+
+#define PUSHARGS_3	_PUSHARGS_2
+#define DOARGS_3	_DOARGS_3 (16)
+#define POPARGS_3	_POPARGS_3
+#define _PUSHARGS_3	_PUSHARGS_2
+#define _DOARGS_3(n)	movl n(%esp), %edx; _DOARGS_2 (n-4)
+#define _POPARGS_3	_POPARGS_2
+
+#define PUSHARGS_4	_PUSHARGS_4
+#define DOARGS_4	_DOARGS_4 (24)
+#define POPARGS_4	_POPARGS_4
+#define _PUSHARGS_4	pushl %esi; _PUSHARGS_3
+#define _DOARGS_4(n)	movl n(%esp), %esi; _DOARGS_3 (n-4)
+#define _POPARGS_4	_POPARGS_3; popl %esi
+
+#define PUSHARGS_5	_PUSHARGS_5
+#define DOARGS_5	_DOARGS_5 (32)
+#define POPARGS_5	_POPARGS_5
+#define _PUSHARGS_5	pushl %edi; _PUSHARGS_4
+#define _DOARGS_5(n)	movl n(%esp), %edi; _DOARGS_4 (n-4)
+#define _POPARGS_5	_POPARGS_4; popl %edi
+
+#else	/* !__ASSEMBLER__ */
+
+/* We need some help from the assembler to generate optimal code.  We
+   define some macros here which later will be used.  */
+asm (".L__X'%ebx =3D 1\n\t"
+     ".L__X'%ecx =3D 2\n\t"
+     ".L__X'%edx =3D 2\n\t"
+     ".L__X'%eax =3D 3\n\t"
+     ".L__X'%esi =3D 3\n\t"
+     ".L__X'%edi =3D 3\n\t"
+     ".L__X'%ebp =3D 3\n\t"
+     ".L__X'%esp =3D 3\n\t"
+     ".macro bpushl name reg\n\t"
+     ".if 1 - \\name\n\t"
+     ".if 2 - \\name\n\t"
+     "pushl %ebx\n\t"
+     ".else\n\t"
+     "xchgl \\reg, %ebx\n\t"
+     ".endif\n\t"
+     ".endif\n\t"
+     ".endm\n\t"
+     ".macro bpopl name reg\n\t"
+     ".if 1 - \\name\n\t"
+     ".if 2 - \\name\n\t"
+     "popl %ebx\n\t"
+     ".else\n\t"
+     "xchgl \\reg, %ebx\n\t"
+     ".endif\n\t"
+     ".endif\n\t"
+     ".endm\n\t"
+     ".macro bmovl name reg\n\t"
+     ".if 1 - \\name\n\t"
+     ".if 2 - \\name\n\t"
+     "movl \\reg, %ebx\n\t"
+     ".endif\n\t"
+     ".endif\n\t"
+     ".endm\n\t");
+
+/* Define a macro which expands inline into the wrapper code for a syste=
m
+   call.  */
+#undef INLINE_SYSCALL
+#define INLINE_SYSCALL(name, nr, args...) \
+  ({									      \
+    unsigned int resultvar;						      \
+    asm volatile (							      \
+    LOADARGS_##nr							      \
+    "movl %1, %%eax\n\t"						      \
+    "int $0x80\n\t"							      \
+    RESTOREARGS_##nr							      \
+    : "=3Da" (resultvar)							      \
+    : "i" (__NR_##name) ASMFMT_##nr(args) : "memory", "cc");		      \
+    if (resultvar >=3D 0xfffff001)					      \
+      {									      \
+	__set_errno (-resultvar);					      \
+	resultvar =3D 0xffffffff;						      \
+      }									      \
+    (int) resultvar; })
+
+#define LOADARGS_0
+#define LOADARGS_1 \
+    "bpushl .L__X'%k2, %k2\n\t"						      \
+    "bmovl .L__X'%k2, %k2\n\t"
+#define LOADARGS_2	LOADARGS_1
+#define LOADARGS_3	LOADARGS_1
+#define LOADARGS_4	LOADARGS_1
+#define LOADARGS_5	LOADARGS_1
+
+#define RESTOREARGS_0
+#define RESTOREARGS_1 \
+    "bpopl .L__X'%k2, %k2\n\t"
+#define RESTOREARGS_2	RESTOREARGS_1
+#define RESTOREARGS_3	RESTOREARGS_1
+#define RESTOREARGS_4	RESTOREARGS_1
+#define RESTOREARGS_5	RESTOREARGS_1
+
+#define ASMFMT_0()
+#define ASMFMT_1(arg1) \
+	, "acdSD" (arg1)
+#define ASMFMT_2(arg1, arg2) \
+	, "adCD" (arg1), "c" (arg2)
+#define ASMFMT_3(arg1, arg2, arg3) \
+	, "aCD" (arg1), "c" (arg2), "d" (arg3)
+#define ASMFMT_4(arg1, arg2, arg3, arg4) \
+	, "aD" (arg1), "c" (arg2), "d" (arg3), "S" (arg4)
+#define ASMFMT_5(arg1, arg2, arg3, arg4, arg5) \
+	, "a" (arg1), "c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5)
+
+#endif	/* __ASSEMBLER__ */
+
+#endif /* linux/i386/sysdep.h */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/usr_incl/sysdeps/unix/i386/sysdep.h linux/Docum=
entation/high-res-timers/usr_incl/sysdeps/unix/i386/sysdep.h
--- linux-2.5.36-kb/Documentation/high-res-timers/usr_incl/sysdeps/unix/i=
386/sysdep.h	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/usr_incl/sysdeps/unix/i386/sysdep=
=2Eh	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,36 @@
+/* Copyright (C) 1991, 92, 93, 95, 96, 97 Free Software Foundation, Inc.=

+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <sysdeps/unix/sysdep.h>
+#include <sysdeps/i386/sysdep.h>
+
+#ifdef	__ASSEMBLER__
+
+/* This is defined as a separate macro so that other sysdep.h files
+   can include this one and then redefine DO_CALL.  */
+
+#define DO_CALL(syscall_name, args)					      \
+  lea SYS_ify (syscall_name), %eax;					      \
+  lcall $7, $0
+
+#define	r0		%eax	/* Normal return-value register.  */
+#define	r1		%edx	/* Secondary return-value register.  */
+#define scratch 	%ecx	/* Call-clobbered register for random use.  */
+#define MOVE(x,y)	movl x, y
+
+#endif	/* __ASSEMBLER__ */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Docu=
mentation/high-res-timers/usr_incl/sysdeps/unix/sysdep.h linux/Documentat=
ion/high-res-timers/usr_incl/sysdeps/unix/sysdep.h
--- linux-2.5.36-kb/Documentation/high-res-timers/usr_incl/sysdeps/unix/s=
ysdep.h	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/usr_incl/sysdeps/unix/sysdep.h	We=
d Sep 18 17:39:54 2002
@@ -0,0 +1,53 @@
+/* Copyright (C) 1991, 92, 93, 96, 98 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <sysdeps/generic/sysdep.h>
+
+#include <sys/syscall.h>
+#define	HAVE_SYSCALLS
+
+/* Note that using a `PASTE' macro loses.  */
+#ifdef	__STDC__
+#define	SYSCALL__(name, args)	PSEUDO (__##name, name, args)
+#else
+#define	SYSCALL__(name, args)	PSEUDO (__/**/name, name, args)
+#endif
+#define	SYSCALL(name, args)	PSEUDO (name, name, args)
+
+/* Machine-dependent sysdep.h files are expected to define the macro
+   PSEUDO (function_name, syscall_name) to emit assembly code to define =
the
+   C-callable function FUNCTION_NAME to do system call SYSCALL_NAME.
+   r0 and r1 are the system call outputs.  MOVE(x, y) should be defined =
as
+   an instruction such that "MOVE(r1, r0)" works.  ret should be defined=

+   as the return instruction.  */
+
+#ifdef __STDC__
+#define SYS_ify(syscall_name) SYS_##syscall_name
+#else
+#define SYS_ify(syscall_name) SYS_/**/syscall_name
+#endif
+
+/* Terminate a system call named SYM.  This is used on some platforms
+   to generate correct debugging information.  */
+#ifndef PSEUDO_END
+#define PSEUDO_END(sym)
+#endif
+
+/* Wrappers around system calls should normally inline the system call c=
ode.
+   But sometimes it is not possible or implemented and we use this code.=
  */
+#define INLINE_SYSCALL(name, nr, args...) __syscall_##name (args)

--------------870587E2DCC423C090A79CB6--

