Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316777AbSE3Rq2>; Thu, 30 May 2002 13:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316778AbSE3Rq1>; Thu, 30 May 2002 13:46:27 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:44678 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316777AbSE3RqZ>; Thu, 30 May 2002 13:46:25 -0400
Message-ID: <3CF66560.4020406@us.ibm.com>
Date: Thu, 30 May 2002 10:46:08 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Keith Owens <kaos@ocs.com.au>, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: [RFC] better spinlock profiling for readprofile
Content-Type: multipart/mixed;
 boundary="------------060603080402050400000008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060603080402050400000008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Lockmeter tends to be a pretty blunt object for most jobs.  In a lot 
of cases, I just want to see if any locks are taking a significant 
amount of CPU time.

Right now, the profile looks like this:
	21 .text.lock.sched		              1.3125
the "sched" comes from a define on the gcc command line, like this:
gcc ... -DKBUILD_BASENAME=sched -c -o sched.o sched.c

What I really want to know is not in which file, but which lock is 
being contended.  After beating myself over the head I decided that 
this is  impossible to do with the compiler itself.  The best I could 
come up with was to use __LINE__ and __FUNCTION__.  Because of 
__FUNCTION__ I had to make spin_lock() a macro again (at least for 
386), but it lets me get results like this:

	21 .text.lock.sched.schedule.848              1.3125

Now, I know that the contention comes from this line: 
reacquire_kernel_lock(current);
as opposed to one of the runqueue locks or something else funky in 
sched.c.

Changing the inline function spin_lock() to a macro causes a loss of 
type safety.  Some of that can be regained by the new inline function: 
_spin_lock_typecheck().

Is extra profiling something that could be useful in the mainline 
kernel, maybe as a config option?  We could allow the user to select 
any combination of filename/function name/line.  Is the System.map 
bloat acceptable?

WARNING!  This patch may cause nausea or vomiting in people who have 
some concept of code decency.  SPINLOCK_DEBUG is broken, and all 
non-x86 architectures probably don't profile correctly.

BTW, is profile=2 broken in 2.5.19?  I'm only getting about 1/8 of the 
  the load I expect:
...
   2316 schedule                                   2.1604
   7793 do_page_fault                              5.6966
170298 default_idle                             2660.9062
187908 total                                      1.4447

I have the feeling that it is only profiling 1 of my 8 cpus and 
calling the rest idle.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------060603080402050400000008
Content-Type: text/plain;
 name="better_spinlock_profile-2.5.19-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="better_spinlock_profile-2.5.19-1.patch"

diff -ur linux-2.5.19-clean/include/asm-i386/spinlock.h linux-2.5.19/include/asm-i386/spinlock.h
--- linux-2.5.19-clean/include/asm-i386/spinlock.h	Wed May 29 11:42:49 2002
+++ linux-2.5.19/include/asm-i386/spinlock.h	Wed May 29 16:21:48 2002
@@ -123,21 +123,15 @@
 	return oldval > 0;
 }
 
-static inline void _raw_spin_lock(spinlock_t *lock)
-{
-#if SPINLOCK_DEBUG
-	__label__ here;
-here:
-	if (lock->magic != SPINLOCK_MAGIC) {
-printk("eip: %p\n", &&here);
-		BUG();
-	}
-#endif
-	__asm__ __volatile__(
-		spin_lock_string
-		:"=m" (lock->lock) : : "memory");
-}
+static inline void _spin_lock_typecheck(spinlock_t *lock) {}
 
+#define _raw_spin_lock(spinlock)\
+do {\
+	_spin_lock_typecheck(spinlock);\
+	__asm__ __volatile__(\
+		spin_lock_string\
+		:"=m" ((spinlock)->lock) : : "memory");\
+} while(0)
 
 /*
  * Read-write spinlocks, allowing multiple readers
diff -ur linux-2.5.19-clean/include/linux/spinlock.h linux-2.5.19/include/linux/spinlock.h
--- linux-2.5.19-clean/include/linux/spinlock.h	Wed May 29 11:42:55 2002
+++ linux-2.5.19/include/linux/spinlock.h	Wed May 29 17:16:05 2002
@@ -44,7 +44,7 @@
 #include <linux/stringify.h>
 
 #define LOCK_SECTION_NAME			\
-	".text.lock." __stringify(KBUILD_BASENAME)
+	".text.lock." __stringify(KBUILD_BASENAME) "." __FUNCTION__ "." __stringify(__LINE__)
 
 #define LOCK_SECTION_START(extra)		\
 	".subsection 1\n\t"			\

--------------060603080402050400000008--

