Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161034AbVJHBIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbVJHBIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 21:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbVJHBIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 21:08:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24303 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1161034AbVJHBIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 21:08:07 -0400
Message-ID: <43471BF8.9050603@mvista.com>
Date: Fri, 07 Oct 2005 18:08:08 -0700
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       Joe Green <jgreen@mvista.com>, Khem Raj <kraj@mvista.com>
Subject: Robust Futex glibc patches
Content-Type: multipart/mixed;
 boundary="------------030107080100030604020908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030107080100030604020908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo,
    here is a patch that cleans up futex.h a bit.  We've removed the 
duplicate defines in futex.c and
glibc code and put them all in futex.h.  We also changed the defines to 
make the assembly in
glibc simpler.
   
    There is also one fix for being the first waiter on a futex,  we now 
wait rather than return -EAGAIN.
   
    The other two patches are the glibc patches that make priority 
inheritance and robustness
separate (to make the POSIX people happy:-)

    With these patches we now have a matched set of kernel and 
glibc/nptl calls that
implement robustness and priority inheritance.

David



--------------030107080100030604020908
Content-Type: text/x-patch;
 name="futex.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="futex.diff"

diff -u linux-2.6.13.2/kernel/futex.c linux-2.6.13.3/kernel/futex.c
--- linux-2.6.13.2/kernel/futex.c
+++ linux-2.6.13.3/kernel/futex.c
@@ -746,11 +746,6 @@
  * the futex is not locked.
  */
 
-#define FUTEX_WAITERS		0x80000000
-#define FUTEX_OWNER_DIED	0x40000000
-#define FUTEX_NOT_RECOVERABLE	0x20000000
-#define FUTEX_PID		0x1fffffff
-
 /*
  * Used to track registered robust futexes. Attached to linked list in inodes.
  */
@@ -1071,16 +1066,6 @@
 		goto out_release_sem;
 	}
 
-	/*
-	 * user mode called us because futex had owner and waitflag was
-	 * set. That's not true now, so let user mode try again
-	 */
-	if ((curval & FUTEX_PID) && !(curval & FUTEX_WAITERS)) {
-		ret = -EAGAIN;
-		queue_unlock(&q, bh);
-		goto out_release_sem;
-	}
-
 	/* if owner has died, we don't want to wait */
 	if ((curval & FUTEX_OWNER_DIED)) {
 		ret = -EOWNERDEAD;
diff -u linux-2.6.13.2/include/linux/futex.h linux-2.6.13.3/include/linux/futex.h
--- linux-2.6.13.2/include/linux/futex.h
+++ linux-2.6.13.3/include/linux/futex.h
@@ -1,8 +1,6 @@
 #ifndef _LINUX_FUTEX_H
 #define _LINUX_FUTEX_H
 
-#include <linux/fs.h>
-
 /* Second argument to futex syscall */
 
 
@@ -18,8 +16,18 @@
 #define FUTEX_DEREGISTER (9)
 #define FUTEX_RECOVER (10)
 
-#define MUTEX_PRIORITY_QUEUING		0x10000000
-#define MUTEX_PRIORITY_INHERITANCE	0x20000000
+#define FUTEX_ATTR_PRIORITY_QUEUING		0x10000000
+#define FUTEX_ATTR_PRIORITY_INHERITANCE		0x20000000
+#define FUTEX_ATTR_PRIORITY_PROTECT		0x40000000
+#define FUTEX_ATTR_ROBUST			0x80000000
+#define FUTEX_ATTR_SHARED			0x01000000
+#define FUTEX_ATTR_MASK				0xff000000
+
+#define FUTEX_WAITERS				0x80000000
+#define FUTEX_OWNER_DIED			0x40000000
+#define FUTEX_NOT_RECOVERABLE			0x20000000
+#define FUTEX_FLAGS (FUTEX_WAITERS | FUTEX_OWNER_DIED | FUTEX_NOT_RECOVERABLE)
+#define FUTEX_PID 				~(FUTEX_FLAGS)
 
 #ifdef __KERNEL__
 

--------------030107080100030604020908
Content-Type: text/x-patch;
 name="glibc-bull-nptl-robustmutexes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="glibc-bull-nptl-robustmutexes.patch"

Index: glibc-2.3.5/nptl/Makefile
===================================================================
--- glibc-2.3.5.orig/nptl/Makefile
+++ glibc-2.3.5/nptl/Makefile
@@ -1,6 +1,8 @@
 # Copyright (C) 2002, 2003, 2004 Free Software Foundation, Inc.
 # This file is part of the GNU C Library.
 
+# Robust mutex changes Copyright (C) 2005 Bull SA.
+
 # The GNU C Library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
@@ -56,6 +58,9 @@ libpthread-routines = init vars events v
 		      pthread_mutexattr_getpshared \
 		      pthread_mutexattr_setpshared \
 		      pthread_mutexattr_gettype pthread_mutexattr_settype \
+		      pthread_mutexattr_getrobust_np \
+		      pthread_mutexattr_setrobust_np \
+		      pthread_mutex_consistent_np \
 		      pthread_rwlock_init pthread_rwlock_destroy \
 		      pthread_rwlock_rdlock pthread_rwlock_timedrdlock \
 		      pthread_rwlock_wrlock pthread_rwlock_timedwrlock \
Index: glibc-2.3.5/nptl/pthread_mutexattr_getpshared.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutexattr_getpshared.c
+++ glibc-2.3.5/nptl/pthread_mutexattr_getpshared.c
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -31,7 +33,7 @@ pthread_mutexattr_getpshared (attr, psha
 
   /* We use bit 31 to signal whether the mutex is going to be
      process-shared or not.  */
-  *pshared = ((iattr->mutexkind & 0x80000000) != 0
+  *pshared = ((iattr->mutexkind & MUTEXATTR_KIND_SHARED) != 0
 	      ? PTHREAD_PROCESS_SHARED : PTHREAD_PROCESS_PRIVATE);
 
   return 0;
Index: glibc-2.3.5/nptl/pthread_mutexattr_getrobust_np.c
===================================================================
--- /dev/null
+++ glibc-2.3.5/nptl/pthread_mutexattr_getrobust_np.c
@@ -0,0 +1,39 @@
+/* Copyright (C) 2002 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   Robust mutex changes Copyright (C) 2005 Bull SA.
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
+#include <pthreadP.h>
+
+
+int
+pthread_mutexattr_getrobust_np (attr, robust)
+     const pthread_mutexattr_t *attr;
+     int *robust;
+{
+  const struct pthread_mutexattr *iattr;
+
+  iattr = (const struct pthread_mutexattr *) attr;
+
+  /* We use bit 30 to signal whether the mutex is going to be
+     robust or not.  */
+  *robust = ((iattr->mutexkind & MUTEXATTR_KIND_ROBUST) != 0
+	      ? PTHREAD_MUTEX_ROBUST_NP : PTHREAD_MUTEX_NOTROBUST_NP);
+
+  return 0;
+}
Index: glibc-2.3.5/nptl/pthread_mutexattr_gettype.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutexattr_gettype.c
+++ glibc-2.3.5/nptl/pthread_mutexattr_gettype.c
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -29,9 +31,8 @@ pthread_mutexattr_gettype (attr, kind)
 
   iattr = (const struct pthread_mutexattr *) attr;
 
-  /* We use bit 31 to signal whether the mutex is going to be
-     process-shared or not.  */
-  *kind = iattr->mutexkind & ~0x80000000;
+  /* Bits 30 and 31 indicate if the mutex is robust and/or process shared  */
+  *kind = iattr->mutexkind & MUTEXATTR_KIND_TYPEMASK;
 
   return 0;
 }
Index: glibc-2.3.5/nptl/pthread_mutexattr_setpshared.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutexattr_setpshared.c
+++ glibc-2.3.5/nptl/pthread_mutexattr_setpshared.c
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -37,9 +39,9 @@ pthread_mutexattr_setpshared (attr, psha
   /* We use bit 31 to signal whether the mutex is going to be
      process-shared or not.  */
   if (pshared == PTHREAD_PROCESS_PRIVATE)
-    iattr->mutexkind &= ~0x80000000;
+    iattr->mutexkind &= ~MUTEXATTR_KIND_SHARED;
   else
-    iattr->mutexkind |= 0x80000000;
+    iattr->mutexkind |= MUTEXATTR_KIND_SHARED;
 
   return 0;
 }
Index: glibc-2.3.5/nptl/pthread_mutexattr_setrobust_np.c
===================================================================
--- /dev/null
+++ glibc-2.3.5/nptl/pthread_mutexattr_setrobust_np.c
@@ -0,0 +1,46 @@
+/* Copyright (C) 2002 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   Robust mutex changes Copyright (C) 2005 Bull SA.
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
+#include <errno.h>
+#include <pthreadP.h>
+
+
+int
+pthread_mutexattr_setrobust_np (attr, robust)
+     pthread_mutexattr_t *attr;
+     int robust;
+{
+  struct pthread_mutexattr *iattr;
+
+  if (robust != PTHREAD_MUTEX_NOTROBUST_NP
+      && __builtin_expect (robust != PTHREAD_MUTEX_ROBUST_NP, 0))
+    return EINVAL;
+
+  iattr = (struct pthread_mutexattr *) attr;
+
+  /* We use bit 30 to signal whether the mutex is going to be
+     robust or not.  */
+  if (robust == PTHREAD_MUTEX_NOTROBUST_NP)
+    iattr->mutexkind &= ~MUTEXATTR_KIND_ROBUST;
+  else
+    iattr->mutexkind |= MUTEXATTR_KIND_ROBUST;
+
+  return 0;
+}
Index: glibc-2.3.5/nptl/pthread_mutexattr_settype.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutexattr_settype.c
+++ glibc-2.3.5/nptl/pthread_mutexattr_settype.c
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -33,9 +35,8 @@ __pthread_mutexattr_settype (attr, kind)
 
   iattr = (struct pthread_mutexattr *) attr;
 
-  /* We use bit 31 to signal whether the mutex is going to be
-     process-shared or not.  */
-  iattr->mutexkind = (iattr->mutexkind & 0x80000000) | kind;
+  /* Bits 30 and 31 indicate if the mutex is robust and/or process shared  */
+  iattr->mutexkind = (iattr->mutexkind & MUTEXATTR_KIND_FLAGMASK) | kind;
 
   return 0;
 }
Index: glibc-2.3.5/nptl/pthread_mutex_consistent_np.c
===================================================================
--- /dev/null
+++ glibc-2.3.5/nptl/pthread_mutex_consistent_np.c
@@ -0,0 +1,39 @@
+/* Copyright (C) 2002 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   Robust mutex changes Copyright (C) 2005 Bull SA.
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
+#include <errno.h>
+#include <pthreadP.h>
+#include <lowlevellock.h>
+
+int
+pthread_mutex_consistent_np (mutex)
+     pthread_mutex_t *mutex;
+{
+  if (!(mutex->__data.__kind & MUTEXATTR_KIND_ROBUST))
+    return EINVAL;
+
+  if (lll_mutex_not_recoverable(mutex->__data.__lock))
+    return ENOTRECOVERABLE;
+
+  if( lll_mutex_recover(mutex->__data.__lock) )
+		return errno;
+
+  return 0;
+}
Index: glibc-2.3.5/nptl/pthread_mutex_destroy.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_destroy.c
+++ glibc-2.3.5/nptl/pthread_mutex_destroy.c
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -19,6 +21,7 @@
 
 #include <errno.h>
 #include "pthreadP.h"
+#include <lowlevellock.h>
 
 
 int
@@ -28,6 +31,11 @@ __pthread_mutex_destroy (mutex)
   if (mutex->__data.__nusers != 0)
     return EBUSY;
 
+  /* deregister robust futex with the kernel */
+  if (mutex->__data.__kind & MUTEXATTR_KIND_ROBUST) {
+	if( lll_mutex_deregister(mutex->__data.__lock) )
+		return errno;
+  }
   return 0;
 }
 strong_alias (__pthread_mutex_destroy, pthread_mutex_destroy)
Index: glibc-2.3.5/nptl/pthread_mutex_init.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_init.c
+++ glibc-2.3.5/nptl/pthread_mutex_init.c
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -19,12 +21,15 @@
 
 #include <assert.h>
 #include <string.h>
+#include <errno.h>
 #include "pthreadP.h"
+#include <lowlevellock.h>
 
 
 static const struct pthread_mutexattr default_attr =
   {
-    /* Default is a normal mutex, not shared between processes.  */
+    /* Default is a normal mutex, not shared between processes,
+       and not robust.  */
     .mutexkind = PTHREAD_MUTEX_NORMAL
   };
 
@@ -40,11 +45,17 @@ __pthread_mutex_init (mutex, mutexattr)
 
   imutexattr = (const struct pthread_mutexattr *) mutexattr ?: &default_attr;
 
+  /* robust mutexes must be process shared */
+  if ( (imutexattr->mutexkind & MUTEXATTR_KIND_ROBUST)
+    && !(imutexattr->mutexkind & MUTEXATTR_KIND_SHARED) )
+    return EINVAL;
+
   /* Clear the whole variable.  */
   memset (mutex, '\0', __SIZEOF_PTHREAD_MUTEX_T);
 
-  /* Copy the values from the attribute.  */
-  mutex->__data.__kind = imutexattr->mutexkind & ~0x80000000;
+  /* Copy the values from the attribute, including the bits indicating
+     if the mutex is process shared or robust.  */
+  mutex->__data.__kind = imutexattr->mutexkind;
 
   /* Default values: mutex not used yet.  */
   // mutex->__count = 0;	already done by memset
@@ -52,6 +63,12 @@ __pthread_mutex_init (mutex, mutexattr)
   // mutex->__nusers = 0;	already done by memset
   // mutex->__spins = 0;	already done by memset
 
+  /* register robust futex with the kernel */
+  if (mutex->__data.__kind & MUTEXATTR_KIND_ROBUST) {
+	if( lll_mutex_register(mutex->__data.__lock) )
+		return errno;
+  }
+
   return 0;
 }
 strong_alias (__pthread_mutex_init, pthread_mutex_init)
Index: glibc-2.3.5/nptl/pthread_mutex_lock.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_lock.c
+++ glibc-2.3.5/nptl/pthread_mutex_lock.c
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -24,11 +26,12 @@
 
 
 #ifndef LLL_MUTEX_LOCK
-# define LLL_MUTEX_LOCK(mutex) lll_mutex_lock (mutex)
-# define LLL_MUTEX_TRYLOCK(mutex) lll_mutex_trylock (mutex)
+# define LLL_MUTEX_LOCK(mutex) \
+	(robust ? lll_mutex_lock_robust(mutex) : lll_mutex_lock (mutex))
+# define LLL_MUTEX_TRYLOCK(mutex) \
+	(robust ? lll_mutex_trylock_robust(mutex) : lll_mutex_trylock (mutex))
 #endif
 
-
 int
 __pthread_mutex_lock (mutex)
      pthread_mutex_t *mutex;
@@ -36,8 +39,14 @@ __pthread_mutex_lock (mutex)
   assert (sizeof (mutex->__size) >= sizeof (mutex->__data));
 
   pid_t id = THREAD_GETMEM (THREAD_SELF, tid);
+  int mutex_type = mutex->__data.__kind & MUTEXATTR_KIND_TYPEMASK;
+  int robust = mutex->__data.__kind & MUTEXATTR_KIND_ROBUST;
+  int result = 0;
+
+  if (robust && lll_mutex_not_recoverable(mutex->__data.__lock))
+    return ENOTRECOVERABLE;
 
-  switch (__builtin_expect (mutex->__data.__kind, PTHREAD_MUTEX_TIMED_NP))
+  switch (__builtin_expect (mutex_type, PTHREAD_MUTEX_TIMED_NP))
     {
       /* Recursive mutex.  */
     case PTHREAD_MUTEX_RECURSIVE_NP:
@@ -55,7 +64,7 @@ __pthread_mutex_lock (mutex)
 	}
 
       /* We have to get the mutex.  */
-      LLL_MUTEX_LOCK (mutex->__data.__lock);
+      result = LLL_MUTEX_LOCK (mutex->__data.__lock);
 
       mutex->__data.__count = 1;
       break;
@@ -73,14 +82,15 @@ __pthread_mutex_lock (mutex)
     case PTHREAD_MUTEX_TIMED_NP:
     simple:
       /* Normal mutex.  */
-      LLL_MUTEX_LOCK (mutex->__data.__lock);
+      result = LLL_MUTEX_LOCK (mutex->__data.__lock);
       break;
 
     case PTHREAD_MUTEX_ADAPTIVE_NP:
       if (! __is_smp)
 	goto simple;
 
-      if (LLL_MUTEX_TRYLOCK (mutex->__data.__lock) != 0)
+      result = LLL_MUTEX_TRYLOCK (mutex->__data.__lock);
+      if (result != 0 && result != EOWNERDEAD)
 	{
 	  int cnt = 0;
 	  int max_cnt = MIN (MAX_ADAPTIVE_COUNT,
@@ -89,29 +99,32 @@ __pthread_mutex_lock (mutex)
 	    {
 	      if (cnt++ >= max_cnt)
 		{
-		  LLL_MUTEX_LOCK (mutex->__data.__lock);
+		  result = LLL_MUTEX_LOCK (mutex->__data.__lock);
 		  break;
 		}
 
 #ifdef BUSY_WAIT_NOP
 	      BUSY_WAIT_NOP;
 #endif
+              result = LLL_MUTEX_TRYLOCK (mutex->__data.__lock);
 	    }
-	  while (LLL_MUTEX_TRYLOCK (mutex->__data.__lock) != 0);
+	  while (result != 0 && result != EOWNERDEAD);
 
 	  mutex->__data.__spins += (cnt - mutex->__data.__spins) / 8;
 	}
       break;
     }
 
-  /* Record the ownership.  */
-  assert (mutex->__data.__owner == 0);
-  mutex->__data.__owner = id;
+  if (result == 0 || result == EOWNERDEAD )
+    {
+      /* Record the ownership.  */
+      mutex->__data.__owner = id;
 #ifndef NO_INCR
-  ++mutex->__data.__nusers;
+      ++mutex->__data.__nusers;
 #endif
+    }
 
-  return 0;
+  return result;
 }
 #ifndef __pthread_mutex_lock
 strong_alias (__pthread_mutex_lock, pthread_mutex_lock)
Index: glibc-2.3.5/nptl/pthread_mutex_timedlock.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_timedlock.c
+++ glibc-2.3.5/nptl/pthread_mutex_timedlock.c
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -21,6 +23,12 @@
 #include "pthreadP.h"
 #include <lowlevellock.h>
 
+# define LLL_MUTEX_TIMEDLOCK(mutex,abstime) \
+	(robust ? lll_mutex_timedlock_robust(mutex,abstime) \
+		: lll_mutex_timedlock (mutex,abstime) )
+# define LLL_MUTEX_TRYLOCK(mutex) \
+	(robust ? lll_mutex_trylock_robust(mutex) : lll_mutex_trylock (mutex))
+
 
 int
 pthread_mutex_timedlock (mutex, abstime)
@@ -29,11 +37,16 @@ pthread_mutex_timedlock (mutex, abstime)
 {
   pid_t id = THREAD_GETMEM (THREAD_SELF, tid);
   int result = 0;
+  int mutex_type = mutex->__data.__kind & MUTEXATTR_KIND_TYPEMASK;
+  int robust = mutex->__data.__kind & MUTEXATTR_KIND_ROBUST;
 
   /* We must not check ABSTIME here.  If the thread does not block
      abstime must not be checked for a valid value.  */
 
-  switch (mutex->__data.__kind)
+  if (robust && lll_mutex_not_recoverable(mutex->__data.__lock))
+    return ENOTRECOVERABLE;
+
+  switch (mutex_type)
     {
       /* Recursive mutex.  */
     case PTHREAD_MUTEX_RECURSIVE_NP:
@@ -52,7 +65,7 @@ pthread_mutex_timedlock (mutex, abstime)
       else
 	{
 	  /* We have to get the mutex.  */
-	  result = lll_mutex_timedlock (mutex->__data.__lock, abstime);
+	  result = LLL_MUTEX_TIMEDLOCK (mutex->__data.__lock, abstime);
 
 	  if (result != 0)
 	    goto out;
@@ -75,14 +88,15 @@ pthread_mutex_timedlock (mutex, abstime)
     case PTHREAD_MUTEX_TIMED_NP:
     simple:
       /* Normal mutex.  */
-      result = lll_mutex_timedlock (mutex->__data.__lock, abstime);
+      result = LLL_MUTEX_TIMEDLOCK (mutex->__data.__lock, abstime);
       break;
 
     case PTHREAD_MUTEX_ADAPTIVE_NP:
       if (! __is_smp)
 	goto simple;
 
-      if (lll_mutex_trylock (mutex->__data.__lock) != 0)
+      result = LLL_MUTEX_TRYLOCK (mutex->__data.__lock);
+      if (result != 0 && result != EOWNERDEAD)
 	{
 	  int cnt = 0;
 	  int max_cnt = MIN (MAX_ADAPTIVE_COUNT,
@@ -91,22 +105,23 @@ pthread_mutex_timedlock (mutex, abstime)
 	    {
 	      if (cnt++ >= max_cnt)
 		{
-		  result = lll_mutex_timedlock (mutex->__data.__lock, abstime);
+		  result = LLL_MUTEX_TIMEDLOCK (mutex->__data.__lock, abstime);
 		  break;
 		}
 
 #ifdef BUSY_WAIT_NOP
 	      BUSY_WAIT_NOP;
 #endif
+              result = LLL_MUTEX_TRYLOCK (mutex->__data.__lock);
 	    }
-	  while (lll_mutex_trylock (mutex->__data.__lock) != 0);
+	  while (result != 0 && result != EOWNERDEAD);
 
 	  mutex->__data.__spins += (cnt - mutex->__data.__spins) / 8;
 	}
       break;
     }
 
-  if (result == 0)
+  if (result == 0 || result == EOWNERDEAD )
     {
       /* Record the ownership.  */
       mutex->__data.__owner = id;
Index: glibc-2.3.5/nptl/pthread_mutex_trylock.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_trylock.c
+++ glibc-2.3.5/nptl/pthread_mutex_trylock.c
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -21,14 +23,22 @@
 #include "pthreadP.h"
 #include <lowlevellock.h>
 
+# define LLL_MUTEX_TRYLOCK(mutex) \
+	(robust ? lll_mutex_trylock_robust(mutex) : lll_mutex_trylock (mutex))
 
 int
 __pthread_mutex_trylock (mutex)
      pthread_mutex_t *mutex;
 {
   pid_t id;
+  int mutex_type = mutex->__data.__kind & MUTEXATTR_KIND_TYPEMASK;
+  int robust = mutex->__data.__kind & MUTEXATTR_KIND_ROBUST;
+  int result;
+
+  if (robust && lll_mutex_not_recoverable(mutex->__data.__lock))
+    return ENOTRECOVERABLE;
 
-  switch (__builtin_expect (mutex->__data.__kind, PTHREAD_MUTEX_TIMED_NP))
+  switch (__builtin_expect (mutex_type, PTHREAD_MUTEX_TIMED_NP))
     {
       /* Recursive mutex.  */
     case PTHREAD_MUTEX_RECURSIVE_NP:
@@ -45,13 +55,14 @@ __pthread_mutex_trylock (mutex)
 	  return 0;
 	}
 
-      if (lll_mutex_trylock (mutex->__data.__lock) == 0)
+      result = LLL_MUTEX_TRYLOCK (mutex->__data.__lock);
+      if (result == 0 || result == EOWNERDEAD)
 	{
 	  /* Record the ownership.  */
 	  mutex->__data.__owner = id;
 	  mutex->__data.__count = 1;
 	  ++mutex->__data.__nusers;
-	  return 0;
+	  return result;
 	}
       break;
 
@@ -62,13 +73,14 @@ __pthread_mutex_trylock (mutex)
     case PTHREAD_MUTEX_TIMED_NP:
     case PTHREAD_MUTEX_ADAPTIVE_NP:
       /* Normal mutex.  */
-      if (lll_mutex_trylock (mutex->__data.__lock) == 0)
+      result = LLL_MUTEX_TRYLOCK (mutex->__data.__lock);
+      if (result == 0 || result == EOWNERDEAD)
 	{
 	  /* Record the ownership.  */
 	  mutex->__data.__owner = THREAD_GETMEM (THREAD_SELF, tid);
 	  ++mutex->__data.__nusers;
 
-	  return 0;
+	  return result;
 	}
     }
 
Index: glibc-2.3.5/nptl/pthread_mutex_unlock.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_unlock.c
+++ glibc-2.3.5/nptl/pthread_mutex_unlock.c
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -21,6 +23,8 @@
 #include "pthreadP.h"
 #include <lowlevellock.h>
 
+# define LLL_MUTEX_ISLOCKED(mutex) \
+	(robust ? lll_mutex_islocked_robust(mutex) : lll_mutex_islocked (mutex))
 
 int
 internal_function attribute_hidden
@@ -28,7 +32,13 @@ __pthread_mutex_unlock_usercnt (mutex, d
      pthread_mutex_t *mutex;
      int decr;
 {
-  switch (__builtin_expect (mutex->__data.__kind, PTHREAD_MUTEX_TIMED_NP))
+  int mutex_type = mutex->__data.__kind & MUTEXATTR_KIND_TYPEMASK;
+  int robust = mutex->__data.__kind & MUTEXATTR_KIND_ROBUST;
+
+  if (robust && lll_mutex_not_recoverable(mutex->__data.__lock))
+    return ENOTRECOVERABLE;
+
+  switch (__builtin_expect (mutex_type, PTHREAD_MUTEX_TIMED_NP))
     {
     case PTHREAD_MUTEX_RECURSIVE_NP:
       /* Recursive mutex.  */
@@ -43,7 +53,7 @@ __pthread_mutex_unlock_usercnt (mutex, d
     case PTHREAD_MUTEX_ERRORCHECK_NP:
       /* Error checking mutex.  */
       if (mutex->__data.__owner != THREAD_GETMEM (THREAD_SELF, tid)
-	  || ! lll_mutex_islocked (mutex->__data.__lock))
+	  || ! LLL_MUTEX_ISLOCKED (mutex->__data.__lock))
 	return EPERM;
       break;
 
@@ -62,7 +72,10 @@ __pthread_mutex_unlock_usercnt (mutex, d
     --mutex->__data.__nusers;
 
   /* Unlock.  */
-  lll_mutex_unlock (mutex->__data.__lock);
+  if (robust)
+    lll_mutex_unlock_robust (mutex->__data.__lock);
+  else
+    lll_mutex_unlock (mutex->__data.__lock);
 
   return 0;
 }
Index: glibc-2.3.5/nptl/sysdeps/pthread/pthread.h
===================================================================
--- glibc-2.3.5.orig/nptl/sysdeps/pthread/pthread.h
+++ glibc-2.3.5/nptl/sysdeps/pthread/pthread.h
@@ -1,6 +1,8 @@
 /* Copyright (C) 2002, 2003, 2004, 2005 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -138,6 +140,15 @@ enum
 };
 
 
+/* Mutex robustness flag.  */
+enum
+{
+  PTHREAD_MUTEX_NOTROBUST_NP,
+#define PTHREAD_MUTEX_NOTROBUST_NP PTHREAD_MUTEX_NOTROBUST_NP
+  PTHREAD_MUTEX_ROBUST_NP
+#define PTHREAD_MUTEX_ROBUST_NP  PTHREAD_MUTEX_ROBUST_NP
+};
+
 
 /* Conditional variable handling.  */
 #define PTHREAD_COND_INITIALIZER { }
Index: glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/ia64/lowlevellock.h
===================================================================
--- glibc-2.3.5.orig/nptl/sysdeps/unix/sysv/linux/ia64/lowlevellock.h
+++ glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/ia64/lowlevellock.h
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Jakub Jelinek <jakub@redhat.com>, 2003.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -32,6 +34,17 @@
 #define FUTEX_REQUEUE		3
 #define FUTEX_CMP_REQUEUE	4
 
+#define FUTEX_WAIT_ROBUST	5
+#define FUTEX_WAKE_ROBUST	6
+#define FUTEX_REGISTER		7
+#define FUTEX_DEREGISTER	8
+#define FUTEX_RECOVER		9
+
+#define FUTEX_WAITERS		0x80000000
+#define FUTEX_OWNER_DIED	0x40000000
+#define FUTEX_NOT_RECOVERABLE	0x20000000
+#define FUTEX_FLAGS (FUTEX_WAITERS | FUTEX_OWNER_DIED | FUTEX_NOT_RECOVERABLE)
+
 /* Delay in spinlock loop.  */
 #define BUSY_WAIT_NOP          asm ("hint @pause")
 
@@ -62,38 +75,177 @@
    _r10 == -1;								     \
 })
 
+#define lll_futex_wait_robust(futex) lll_futex_timed_wait_robust (futex, 0)
+
+#define lll_futex_timed_wait_robust(ftx, timespec)			\
+({									\
+   DO_INLINE_SYSCALL(futex, 4, (long) (ftx), FUTEX_WAIT_ROBUST, 0,	\
+		     (long) (timespec));				\
+   _r10 == -1 ? -_retval : _retval;					\
+})
+
+#define lll_futex_wake_robust(ftx)					\
+({									\
+   DO_INLINE_SYSCALL(futex, 2, (long) (ftx), FUTEX_WAKE_ROBUST);	\
+   _r10 == -1 ? -_retval : _retval;					\
+})
+
+#define lll_futex_register(ftx)						\
+({									\
+   DO_INLINE_SYSCALL(futex, 2, (long) (ftx), FUTEX_REGISTER);		\
+   _r10 == -1 ? -_retval : _retval;					\
+})
+
+#define lll_futex_deregister(ftx)					\
+({									\
+   DO_INLINE_SYSCALL(futex, 2, (long) (ftx), FUTEX_DEREGISTER);		\
+   _r10 == -1 ? -_retval : _retval;					\
+})
+
+#define lll_futex_recover(ftx)						\
+({									\
+   DO_INLINE_SYSCALL(futex, 2, (long) (ftx), FUTEX_RECOVER);		\
+   _r10 == -1 ? -_retval : _retval;					\
+})
+
+#define lll_futex_not_recoverable(ftx)					\
+   ((*ftx & FUTEX_NOT_RECOVERABLE) != 0)
 
 #define __lll_mutex_trylock(futex) \
   (atomic_compare_and_exchange_val_acq (futex, 1, 0) != 0)
 #define lll_mutex_trylock(futex) __lll_mutex_trylock (&(futex))
 
 
+#define __lll_mutex_trylock_robust(futex) \
+  ({									\
+    int *__futex = (futex);						\
+    int oldval, newval;							\
+    int pid, deadflag;							\
+    int __val;								\
+    									\
+    oldval = *__futex;							\
+    pid = oldval & 0x3fff;						\
+    deadflag = oldval & FUTEX_OWNER_DIED;				\
+    if (deadflag)							\
+      oldval = deadflag;						\
+    else								\
+      oldval = 0;							\
+    newval = THREAD_GETMEM (THREAD_SELF, tid) | deadflag;		\
+    __val = (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) != 0); \
+    if( __val != 0 && deadflag != 0 )						\
+    	__val = EOWNERDEAD;						\
+    __val;								\
+  })
+#define lll_mutex_trylock_robust(futex) __lll_mutex_trylock_robust (&(futex))
+
+
 #define __lll_mutex_cond_trylock(futex) \
   (atomic_compare_and_exchange_val_acq (futex, 2, 0) != 0)
 #define lll_mutex_cond_trylock(futex) __lll_mutex_cond_trylock (&(futex))
 
 
+#define __lll_mutex_cond_trylock_robust(futex) \
+  ({									\
+    int *__futex = (futex);						\
+    int oldval, newval;							\
+    int pid, deadflag;							\
+    int __val;								\
+    									\
+    oldval = *__futex;							\
+    pid = oldval & 0x3fff;						\
+    deadflag = oldval & FUTEX_OWNER_DIED;				\
+    if (deadflag)							\
+      oldval = deadflag;						\
+    else								\
+      oldval = 0;							\
+    newval = THREAD_GETMEM (THREAD_SELF, tid) | deadflag | FUTEX_WAITERS;\
+    __val = (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) != 0); \
+    if( __val != 0 && deadflag != 0 )						\
+    	__val = EOWNERDEAD;						\
+    __val;								\
+  })
+#define lll_mutex_cond_trylock_robust(futex) __lll_mutex_cond_trylock_robust (&(futex))
+
+
 extern void __lll_lock_wait (int *futex) attribute_hidden;
 
 
 #define __lll_mutex_lock(futex)						\
-  ((void) ({								\
+  ({								\
     int *__futex = (futex);						\
     if (atomic_compare_and_exchange_bool_acq (__futex, 1, 0) != 0)	\
       __lll_lock_wait (__futex);					\
-  }))
+    (0);								\
+  })
 #define lll_mutex_lock(futex) __lll_mutex_lock (&(futex))
 
 
+#define __lll_mutex_lock_robust(futex)					\
+  ({									\
+    int *__futex = (futex);						\
+    int __val;								\
+    int oldval, newval;							\
+    int pid, deadflag, waitflag;					\
+    									\
+    do {								\
+      do {								\
+        oldval = *__futex;						\
+        pid = oldval & 0x3fff;						\
+        deadflag = oldval & FUTEX_OWNER_DIED;				\
+        if (pid == 0) {							\
+          waitflag = 0;							\
+          pid = THREAD_GETMEM (THREAD_SELF, tid);			\
+        }								\
+        else								\
+          waitflag = FUTEX_WAITERS;					\
+        newval = pid | waitflag | deadflag;				\
+      } while (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) != 0); \
+      __val = 0;							\
+      if (waitflag != 0)						\
+        __val = lll_futex_wait_robust(futex);				\
+    } while (__val == -EAGAIN);						\
+    __val;								\
+  })
+#define lll_mutex_lock_robust(futex) __lll_mutex_lock_robust (&(futex))
+
+
 #define __lll_mutex_cond_lock(futex)					\
-  ((void) ({								\
+  ({									\
     int *__futex = (futex);						\
     if (atomic_compare_and_exchange_bool_acq (__futex, 2, 0) != 0)	\
       __lll_lock_wait (__futex);					\
-  }))
+    (0);								\
+  })
 #define lll_mutex_cond_lock(futex) __lll_mutex_cond_lock (&(futex))
 
 
+#define __lll_mutex_cond_lock_robust(futex)				\
+  ({									\
+    int *__futex = (futex);						\
+    int __val;								\
+    int oldval, newval;							\
+    int pid, deadflag, waitflag;					\
+    									\
+    do {								\
+      do {								\
+        oldval = *__futex;						\
+        pid = oldval & 0x3fff;						\
+        deadflag = oldval & FUTEX_OWNER_DIED;				\
+        waitflag = oldval & FUTEX_WAITERS;				\
+        if (pid == 0) {							\
+          pid = THREAD_GETMEM (THREAD_SELF, tid);			\
+        }								\
+        newval = pid | FUTEX_WAITERS | deadflag;			\
+      } while (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) != 0); \
+      __val = 0;							\
+      if (waitflag != 0)						\
+        __val = lll_futex_wait_robust(futex);				\
+    } while (__val == -EAGAIN);						\
+    __val;								\
+  })
+#define lll_mutex_cond_lock_robust(futex) __lll_mutex_cond_lock_robust (&(futex))
+
+
 extern int __lll_timedlock_wait (int *futex, const struct timespec *)
      attribute_hidden;
 
@@ -111,6 +263,38 @@ extern int __lll_timedlock_wait (int *fu
   __lll_mutex_timedlock (&(futex), abstime)
 
 
+extern int __lll_timedlock_wait_robust (int *futex, const struct timespec *)
+     attribute_hidden;
+
+#define __lll_mutex_timedlock_robust(futex,abstime)			\
+  ({									\
+    int *__futex = (futex);						\
+    int __val;								\
+    int oldval, newval;							\
+    int pid, deadflag, waitflag;					\
+    									\
+    do {								\
+      do {								\
+        oldval = *__futex;						\
+        pid = oldval & 0x3fff;						\
+        deadflag = oldval & FUTEX_OWNER_DIED;				\
+        waitflag = 0;							\
+        if (pid == 0)							\
+          pid = THREAD_GETMEM (THREAD_SELF, tid);			\
+        else								\
+          waitflag = FUTEX_WAITERS;					\
+        newval = pid | waitflag | deadflag;				\
+      } while (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) != 0); \
+      __val = 0;							\
+      if (waitflag != 0)						\
+        __val = __lll_timedlock_wait_robust(__futex,abstime);		\
+    } while (__val == EAGAIN);						\
+    __val;								\
+  })
+#define lll_mutex_timedlock_robust(futex,abstime) \
+  __lll_mutex_timedlock_robust (&(futex),(abstime))
+
+
 #define __lll_mutex_unlock(futex)			\
   ((void) ({						\
     int *__futex = (futex);				\
@@ -123,6 +307,32 @@ extern int __lll_timedlock_wait (int *fu
   __lll_mutex_unlock(&(futex))
 
 
+#define __lll_mutex_unlock_robust(futex)			\
+  ((void) ({							\
+    int *__futex = (futex);					\
+    int oldval, newval, deadflag, waitflag, done;		\
+    								\
+    do {							\
+      oldval = *__futex;					\
+      deadflag = oldval & FUTEX_OWNER_DIED;			\
+      waitflag = oldval & FUTEX_WAITERS;			\
+      								\
+      if (waitflag) {						\
+        lll_futex_wake_robust(__futex);				\
+        done = 1;						\
+      } else {							\
+        if (deadflag)						\
+          newval = FUTEX_OWNER_DIED | FUTEX_NOT_RECOVERABLE;	\
+        else							\
+          newval = 0;						\
+        done = (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) == 0);	\
+      }								\
+    } while (!done);						\
+  }))
+#define lll_mutex_unlock_robust(futex) \
+  __lll_mutex_unlock_robust(&(futex))
+
+
 #define __lll_mutex_unlock_force(futex)		\
   ((void) ({					\
     int *__futex = (futex);			\
@@ -136,6 +346,26 @@ extern int __lll_timedlock_wait (int *fu
 #define lll_mutex_islocked(futex) \
   (futex != 0)
 
+#define lll_mutex_islocked_robust(futex) \
+  ((futex & 0x3fff) != 0)
+
+#define lll_mutex_register(futex) \
+  lll_futex_register(&(futex))
+
+#define lll_mutex_deregister(futex) \
+  lll_futex_deregister(&(futex))
+
+#define __lll_mutex_recover(futex)				\
+  ({								\
+     int *__futex = (futex);					\
+     int __val = lll_futex_recover (__futex);			\
+     __val;							\
+  })
+#define lll_mutex_recover(futex) \
+  __lll_mutex_recover(&(futex))
+
+#define lll_mutex_not_recoverable(futex) \
+  lll_futex_not_recoverable(&(futex))
 
 /* We have a separate internal lock implementation which is not tied
    to binary compatibility.  We can use the lll_mutex_*.  */
Index: glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/internaltypes.h
===================================================================
--- glibc-2.3.5.orig/nptl/sysdeps/unix/sysv/linux/internaltypes.h
+++ glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/internaltypes.h
@@ -2,6 +2,8 @@
    This file is part of the GNU C Library.
    Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -55,12 +57,18 @@ struct pthread_mutexattr
   /* Identifier for the kind of mutex.
 
      Bit 31 is set if the mutex is to be shared between processes.
+     Bit 30 is set if the mutex is robust.
 
-     Bit 0 to 30 contain one of the PTHREAD_MUTEX_ values to identify
+     Bit 0 to 29 contain one of the PTHREAD_MUTEX_ values to identify
      the type of the mutex.  */
   int mutexkind;
 };
 
+#define MUTEXATTR_KIND_SHARED 0x80000000
+#define MUTEXATTR_KIND_ROBUST 0x40000000
+#define MUTEXATTR_KIND_FLAGMASK (MUTEXATTR_KIND_SHARED | MUTEXATTR_KIND_ROBUST)
+#define MUTEXATTR_KIND_TYPEMASK (~MUTEXATTR_KIND_FLAGMASK)
+
 
 /* Conditional variable attribute data structure.  */
 struct pthread_condattr
Index: glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/lowlevellock.c
===================================================================
--- glibc-2.3.5.orig/nptl/sysdeps/unix/sysv/linux/lowlevellock.c
+++ glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/lowlevellock.c
@@ -3,6 +3,8 @@
    This file is part of the GNU C Library.
    Contributed by Paul Mackerras <paulus@au.ibm.com>, 2003.
 
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+
    The GNU C Library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
@@ -76,6 +78,40 @@ __lll_timedlock_wait (int *futex, const 
 }
 
 
+int
+__lll_timedlock_wait_robust (int *futex, const struct timespec *abstime)
+{
+  struct timeval tv;
+  struct timespec rt;
+  int ret;
+
+  /* Reject invalid timeouts.  */
+  if (abstime->tv_nsec < 0 || abstime->tv_nsec >= 1000000000)
+    return EINVAL;
+
+  /* Get the current time.  */
+  (void) __gettimeofday (&tv, NULL);
+
+  /* Compute relative timeout.  */
+  rt.tv_sec = abstime->tv_sec - tv.tv_sec;
+  rt.tv_nsec = abstime->tv_nsec - tv.tv_usec * 1000;
+  if (rt.tv_nsec < 0)
+    {
+      rt.tv_nsec += 1000000000;
+      --rt.tv_sec;
+    }
+
+  /* Already timed out?  */
+  if (rt.tv_sec < 0)
+    return ETIMEDOUT;
+
+  /* Wait.  */
+  ret = lll_futex_timed_wait_robust (futex, &rt);
+
+  return (ret < 0) ? -ret : ret;
+}
+
+
 /* These don't get included in libc.so  */
 #ifdef IS_IN_libpthread
 int
Index: glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/pthread_mutex_cond_lock.c
===================================================================
--- glibc-2.3.5.orig/nptl/sysdeps/unix/sysv/linux/pthread_mutex_cond_lock.c
+++ glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/pthread_mutex_cond_lock.c
@@ -1,7 +1,13 @@
+/*
+   Robust mutex changes Copyright (C) 2005 Bull SA.
+ */
+
 #include <pthreadP.h>
 
-#define LLL_MUTEX_LOCK(mutex) lll_mutex_cond_lock(mutex)
-#define LLL_MUTEX_TRYLOCK(mutex) lll_mutex_cond_trylock(mutex)
+#define LLL_MUTEX_LOCK(mutex) \
+	(robust ? lll_mutex_cond_lock_robust(mutex) : lll_mutex_cond_lock (mutex))
+#define LLL_MUTEX_TRYLOCK(mutex) \
+	(robust ? lll_mutex_trylock_robust(mutex) : lll_mutex_cond_trylock (mutex))
 #define __pthread_mutex_lock __pthread_mutex_cond_lock
 #define NO_INCR
 
Index: glibc-2.3.5/nptl/Versions
===================================================================
--- glibc-2.3.5.orig/nptl/Versions
+++ glibc-2.3.5/nptl/Versions
@@ -222,6 +222,11 @@ libpthread {
     # affinity interfaces without size parameter
     pthread_getaffinity_np; pthread_setaffinity_np;
     pthread_attr_getaffinity_np; pthread_attr_setaffinity_np;
+
+    #
+    pthread_mutexattr_setrobust_np;
+    pthread_mutexattr_getrobust_np;
+    pthread_mutex_consistent_np;
   }
 
   GLIBC_2.3.4 {

--------------030107080100030604020908
Content-Type: text/x-patch;
 name="glibc-mvl-nptl-priority-inheritance.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="glibc-mvl-nptl-priority-inheritance.patch"

Index: glibc-2.3.5/nptl/Makefile
===================================================================
--- glibc-2.3.5.orig/nptl/Makefile
+++ glibc-2.3.5/nptl/Makefile
@@ -60,6 +60,8 @@ libpthread-routines = init vars events v
 		      pthread_mutexattr_gettype pthread_mutexattr_settype \
 		      pthread_mutexattr_getrobust_np \
 		      pthread_mutexattr_setrobust_np \
+		      pthread_mutexattr_getprotocol \
+		      pthread_mutexattr_setprotocol \
 		      pthread_mutex_consistent_np \
 		      pthread_rwlock_init pthread_rwlock_destroy \
 		      pthread_rwlock_rdlock pthread_rwlock_timedrdlock \
Index: glibc-2.3.5/nptl/pthread_mutexattr_getprotocol.c
===================================================================
--- /dev/null
+++ glibc-2.3.5/nptl/pthread_mutexattr_getprotocol.c
@@ -0,0 +1,39 @@
+/* Copyright (C) 2002 - 2005 Free Software Foundation, Inc.
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
+#include <pthreadP.h>
+#include <linux/futex.h>
+
+int
+pthread_mutexattr_getprotocol (attr, protocol)
+     const pthread_mutexattr_t *attr;
+     int *protocol;
+{
+  const struct pthread_mutexattr *iattr;
+  int flags;
+  iattr = (const struct pthread_mutexattr *) attr;
+  /* Use Bit 30, 29 to indicate the protocol of mutex :
+     -- PTHREAD_PRIO_NONE     (00)
+     -- PTHREAD_PRIO_INHERIT  (10)
+     -- PTHREAD_PRIO_PROTECT  (01)  */
+  flags = iattr->mutexkind;
+  *protocol = flags & FUTEX_ATTR_PRIORITY_INHERITANCE ? PTHREAD_PRIO_INHERIT
+    : PTHREAD_PRIO_NONE;
+
+  return 0;
+}
Index: glibc-2.3.5/nptl/pthread_mutexattr_setprotocol.c
===================================================================
--- /dev/null
+++ glibc-2.3.5/nptl/pthread_mutexattr_setprotocol.c
@@ -0,0 +1,48 @@
+/* Copyright (C) 2002 - 2005 Free Software Foundation, Inc.
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
+#include <errno.h>
+#include <pthreadP.h>
+#include <linux/futex.h>
+
+int
+pthread_mutexattr_setprotocol (attr, protocol)
+     const pthread_mutexattr_t *attr;
+     int protocol;
+{
+  struct pthread_mutexattr *iattr;
+  int flags = 0;
+
+  if (protocol < PTHREAD_PRIO_NONE || protocol > PTHREAD_PRIO_PROTECT)
+    return EINVAL;
+
+  iattr = (struct pthread_mutexattr *) attr;
+
+  /* Use Bit 30, 29 to indicate the protocol of mutex :
+     -- PTHREAD_PRIO_NONE     (00)
+     -- PTHREAD_PRIO_INHERIT  (10)
+     -- PTHREAD_PRIO_PROTECT  (01)  */
+
+  if (protocol == PTHREAD_PRIO_INHERIT)
+    flags |= FUTEX_ATTR_PRIORITY_INHERITANCE;
+
+  iattr->mutexkind &= ~(FUTEX_ATTR_PRIORITY_INHERITANCE);
+  iattr->mutexkind |= flags;
+
+  return 0;
+}
Index: glibc-2.3.5/nptl/pthread_mutex_init.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_init.c
+++ glibc-2.3.5/nptl/pthread_mutex_init.c
@@ -24,7 +24,7 @@
 #include <errno.h>
 #include "pthreadP.h"
 #include <lowlevellock.h>
-
+#include <linux/futex.h>
 
 static const struct pthread_mutexattr default_attr =
   {
@@ -46,8 +46,8 @@ __pthread_mutex_init (mutex, mutexattr)
   imutexattr = (const struct pthread_mutexattr *) mutexattr ?: &default_attr;
 
   /* robust mutexes must be process shared */
-  if ( (imutexattr->mutexkind & MUTEXATTR_KIND_ROBUST)
-    && !(imutexattr->mutexkind & MUTEXATTR_KIND_SHARED) )
+  if ( (imutexattr->mutexkind & FUTEX_ATTR_ROBUST)
+    && !(imutexattr->mutexkind & FUTEX_ATTR_SHARED) )
     return EINVAL;
 
   /* Clear the whole variable.  */
@@ -64,9 +64,10 @@ __pthread_mutex_init (mutex, mutexattr)
   // mutex->__spins = 0;	already done by memset
 
   /* register robust futex with the kernel */
-  if (mutex->__data.__kind & MUTEXATTR_KIND_ROBUST) {
-	if( lll_mutex_register(mutex->__data.__lock) )
-		return errno;
+  if (mutex->__data.__kind & (FUTEX_ATTR_ROBUST |
+                              FUTEX_ATTR_PRIORITY_INHERITANCE)) {
+    if( lll_mutex_register(mutex->__data.__lock, mutex->__data.__kind) )
+      return errno;
   }
 
   return 0;
Index: glibc-2.3.5/nptl/sysdeps/pthread/pthread.h
===================================================================
--- glibc-2.3.5.orig/nptl/sysdeps/pthread/pthread.h
+++ glibc-2.3.5/nptl/sysdeps/pthread/pthread.h
@@ -149,6 +149,15 @@ enum
 #define PTHREAD_MUTEX_ROBUST_NP  PTHREAD_MUTEX_ROBUST_NP
 };
 
+/* Mutex protocols. */
+enum
+  {
+    PTHREAD_PRIO_NONE=1,
+    PTHREAD_PRIO_INHERIT,
+#define PTHREAD_PRIO_INHERIT   PTHREAD_PRIO_INHERIT
+    PTHREAD_PRIO_PROTECT
+#define PTHREAD_PRIO_PROTECT   PTHREAD_PRIO_PROTECT
+  };
 
 /* Conditional variable handling.  */
 #define PTHREAD_COND_INITIALIZER { }
Index: glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/i386/i486/lowlevellock.S
===================================================================
--- glibc-2.3.5.orig/nptl/sysdeps/unix/sysv/linux/i386/i486/lowlevellock.S
+++ glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/i386/i486/lowlevellock.S
@@ -165,6 +165,87 @@ __lll_mutex_timedlock_wait:
 	.size	__lll_mutex_timedlock_wait,.-__lll_mutex_timedlock_wait
 #endif
 
+	.globl	__lll_timedlock_wait_robust
+	.type	__lll_timedlock_wait_robust,@function
+	.hidden	__lll_timedlock_wait_robust
+	.align	16
+__lll_timedlock_wait_robust:
+	/* Check for a valid timeout value.  */
+	cmpl	$1000000000, 4(%edx)
+	jae	3f
+
+	pushl	%edi
+	pushl	%esi
+	pushl	%ebx
+	pushl	%ebp
+
+	/* Stack frame for the timespec and timeval structs.  */
+	subl	$8, %esp
+
+	movl	%ecx, %ebp
+	movl	%edx, %edi
+
+	/* Get current time.  */
+	movl	%esp, %ebx
+	xorl	%ecx, %ecx
+	movl	$SYS_gettimeofday, %eax
+	ENTER_KERNEL
+
+	/* Compute relative timeout.  */
+	movl	4(%esp), %eax
+	movl	$1000, %edx
+	mul	%edx		/* Milli seconds to nano seconds.  */
+	movl	(%edi), %ecx
+	movl	4(%edi), %edx
+	subl	(%esp), %ecx
+	subl	%eax, %edx
+	jns	4f
+	addl	$1000000000, %edx
+	subl	$1, %ecx
+4:	testl	%ecx, %ecx
+	js	5f		/* Time is already up.  */
+
+	/* Futex call.  */
+	movl	%esp, %esi
+	xorl	%ecx, %ecx	/* movl $FUTEX_WAIT, %ecx */
+	movl	$SYS_futex, %eax
+	ENTER_KERNEL
+	movl	%eax, %ecx
+	cmpl	$-4096, %eax
+	ja	8f
+
+7:	movl	%ecx, %eax
+	sarl	$31, %eax
+	xorl	%eax, %ecx
+	subl	%eax, %ecx
+
+6:	addl	$8, %esp
+	popl	%ebp
+	popl	%ebx
+	popl	%esi
+	popl	%edi
+	ret
+
+	/* Make sure the current holder knows we are going to sleep.  */
+	movl	%edx, %eax
+	xchgl	%eax, (%ebx)
+	testl	%eax, %eax
+	jz	6b
+
+3:	movl	$EINVAL, %eax
+	ret
+
+5:	movl	$ETIMEDOUT, %eax
+	jmp	6b
+8:
+	movl	errno@INDNTPOFF, %eax
+	negl	%ecx
+	movl	%ecx, %gs:(%eax)
+	orl	$-1, %ecx
+	jmp	7b
+
+	.size	__lll_timedlock_wait_robust,.-__lll_timedlock_wait_robust
+
 
 #ifdef NOT_IN_libc
 	.globl	lll_unlock_wake_cb
Index: glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/i386/lowlevellock.h
===================================================================
--- glibc-2.3.5.orig/nptl/sysdeps/unix/sysv/linux/i386/lowlevellock.h
+++ glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/i386/lowlevellock.h
@@ -23,6 +23,7 @@
 #include <time.h>
 #include <sys/param.h>
 #include <bits/pthreadtypes.h>
+#include <linux/futex.h>
 
 #ifndef LOCK_INSTR
 # ifdef UP
@@ -33,9 +34,6 @@
 #endif
 
 #define SYS_futex		240
-#define FUTEX_WAIT		0
-#define FUTEX_WAKE		1
-
 
 /* Initializer for compatibility lock.  */
 #define LLL_MUTEX_LOCK_INITIALIZER		(0)
@@ -105,6 +103,36 @@ extern int __lll_mutex_timedlock_wait (i
 extern int __lll_mutex_unlock_wake (int *__futex)
      __attribute ((regparm (1))) attribute_hidden;
 
+#define lll_futex_wait_robust(futex) lll_futex_timed_wait_robust (futex, 0)
+
+#define lll_futex_timed_wait_robust(ftx, timespec)                     \
+({                                                                     \
+   INLINE_SYSCALL(futex, 4, (long) (ftx), FUTEX_WAIT_ROBUST, 0,        \
+                    (long) (timespec));                                \
+ })
+
+#define lll_futex_wake_robust(ftx)                                     \
+({                                                                     \
+   INLINE_SYSCALL(futex, 2, (long) (ftx), FUTEX_WAKE_ROBUST);          \
+})
+
+#define lll_futex_register(ftx, attr)                                  \
+({                                                                     \
+  INLINE_SYSCALL(futex, 3, (long) (ftx), FUTEX_REGISTER, (long) (attr));\
+})
+
+#define lll_futex_deregister(ftx)                                      \
+({                                                                     \
+   INLINE_SYSCALL(futex, 2, (long) (ftx), FUTEX_DEREGISTER);           \
+})
+#define lll_futex_recover(ftx)                                         \
+({                                                                     \
+   INLINE_SYSCALL(futex, 2, (long) (ftx), FUTEX_RECOVER);              \
+})
+
+#define lll_futex_not_recoverable(ftx)                                 \
+   ((*ftx & FUTEX_NOT_RECOVERABLE) != 0)
+
 
 /* NB: in the lll_mutex_trylock macro we simply return the value in %eax
    after the cmpxchg instruction.  In case the operation succeded this
@@ -120,6 +148,28 @@ extern int __lll_mutex_unlock_wake (int 
 		       : "memory");					      \
      ret; })
 
+#define __lll_mutex_trylock_robust(futex) \
+  ({                                                                   \
+    int *__futex = (futex);                                            \
+    int oldval, newval;                                                \
+    int pid, deadflag;                                                 \
+    int __val;                                                         \
+                                                                       \
+    oldval = *__futex;                                                 \
+    pid = oldval & 0x3fff;                                             \
+    deadflag = oldval & FUTEX_OWNER_DIED;                              \
+    if (deadflag)                                                      \
+      oldval = deadflag;                                               \
+    else                                                               \
+      oldval = 0;                                                      \
+    newval = THREAD_GETMEM (THREAD_SELF, tid) | deadflag;              \
+    __val = (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) != 0); \
+    if( __val != 0 && deadflag != 0 )                                  \
+       __val = EOWNERDEAD;                                             \
+    __val;                                                             \
+  })
+#define lll_mutex_trylock_robust(futex) __lll_mutex_trylock_robust (&(futex))
+
 
 #define lll_mutex_cond_trylock(futex) \
   ({ int ret;								      \
@@ -130,9 +180,36 @@ extern int __lll_mutex_unlock_wake (int 
 		       : "memory");					      \
      ret; })
 
+#define __lll_mutex_lock_robust(futex)                                 \
+  ({                                                                   \
+    int *__futex = (futex);                                            \
+    int __val;                                                         \
+    int oldval, newval;                                                \
+    int pid, deadflag, waitflag;                                       \
+                                                                       \
+    do {                                                               \
+      do {                                                             \
+        oldval = *__futex;                                             \
+        pid = oldval & 0x3fff;                                         \
+        deadflag = oldval & FUTEX_OWNER_DIED;                          \
+        if (pid == 0) {                                                \
+          waitflag = 0;                                                \
+          pid = THREAD_GETMEM (THREAD_SELF, tid);                      \
+        }                                                              \
+        else                                                           \
+          waitflag = FUTEX_WAITERS;                                    \
+        newval = pid | waitflag | deadflag;                            \
+      } while (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) != 0); \
+      __val = 0;                                                       \
+      if (waitflag != 0)                                               \
+        __val = lll_futex_wait_robust(futex);                          \
+    } while (__val == -EAGAIN);                                        \
+    __val;                                                             \
+  })
+#define lll_mutex_lock_robust(futex) __lll_mutex_lock_robust (&(futex))
 
 #define lll_mutex_lock(futex) \
-  (void) ({ int ignore1, ignore2;					      \
+  ({ int ignore1, result;     					              \
 	    __asm __volatile (LOCK_INSTR "cmpxchgl %1, %2\n\t"		      \
 			      "jnz _L_mutex_lock_%=\n\t"		      \
 			      ".subsection 1\n\t"			      \
@@ -144,15 +221,41 @@ extern int __lll_mutex_unlock_wake (int 
 			      ".size _L_mutex_lock_%=,.-_L_mutex_lock_%=\n"   \
 			      ".previous\n"				      \
 			      "1:"					      \
-			      : "=a" (ignore1), "=c" (ignore2), "=m" (futex)  \
+			      : "=a" (result), "=c" (ignore1), "=m" (futex)  \
 			      : "0" (0), "1" (1), "m" (futex)		      \
-			      : "memory"); })
+			      : "memory");                                    \
+                              result;})
 
+#define __lll_mutex_cond_lock_robust(futex)                            \
+  ({                                                                   \
+    int *__futex = (futex);                                            \
+    int __val;                                                         \
+    int oldval, newval;                                                \
+    int pid, deadflag, waitflag;                                       \
+                                                                       \
+    do {                                                               \
+      do {                                                             \
+        oldval = *__futex;                                             \
+        pid = oldval & 0x3fff;                                         \
+        deadflag = oldval & FUTEX_OWNER_DIED;                          \
+        waitflag = oldval & FUTEX_WAITERS;                             \
+        if (pid == 0) {                                                \
+          pid = THREAD_GETMEM (THREAD_SELF, tid);                      \
+        }                                                              \
+        newval = pid | FUTEX_WAITERS | deadflag;                       \
+      } while (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) != 0); \
+      __val = 0;                                                       \
+      if (waitflag != 0)                                               \
+        __val = lll_futex_wait_robust(futex);                          \
+    } while (__val == -EAGAIN);                                        \
+    __val;                                                             \
+  })
+#define lll_mutex_cond_lock_robust(futex) __lll_mutex_cond_lock_robust (&(futex ))
 
 /* Special version of lll_mutex_lock which causes the unlock function to
    always wakeup waiters.  */
 #define lll_mutex_cond_lock(futex) \
-  (void) ({ int ignore1, ignore2;					      \
+  ({ int ignore1, result;					              \
 	    __asm __volatile (LOCK_INSTR "cmpxchgl %1, %2\n\t"		      \
 			      "jnz _L_mutex_cond_lock_%=\n\t"		      \
 			      ".subsection 1\n\t"			      \
@@ -164,9 +267,10 @@ extern int __lll_mutex_unlock_wake (int 
 			      ".size _L_mutex_cond_lock_%=,.-_L_mutex_cond_lock_%=\n"   \
 			      ".previous\n"				      \
 			      "1:"					      \
-			      : "=a" (ignore1), "=c" (ignore2), "=m" (futex)  \
+			      : "=a" (result), "=c" (ignore1), "=m" (futex)   \
 			      : "0" (0), "1" (2), "m" (futex)		      \
-			      : "memory"); })
+			      : "memory"); 				      \
+			      result; })
 
 
 #define lll_mutex_timedlock(futex, timeout) \
@@ -189,9 +293,65 @@ extern int __lll_mutex_unlock_wake (int 
 		       : "memory");					      \
      result; })
 
+extern int __lll_timedlock_wait_robust (int *futex, const struct timespec *)
+     attribute_hidden;
+#define __lll_mutex_unlock_robust(futex)                       \
+  ((void) ({                                                   \
+    int *__futex = (futex);                                    \
+    int oldval, newval, deadflag, waitflag, done;              \
+                                                               \
+    do {                                                       \
+      oldval = *__futex;                                       \
+      deadflag = oldval & FUTEX_OWNER_DIED;                    \
+      waitflag = oldval & FUTEX_WAITERS;                       \
+                                                               \
+      if (waitflag) {                                          \
+        lll_futex_wake_robust(__futex);                        \
+        done = 1;                                              \
+      } else {                                                 \
+        if (deadflag)                                          \
+          newval = FUTEX_OWNER_DIED | FUTEX_NOT_RECOVERABLE;   \
+        else                                                   \
+          newval = 0;                                          \
+        done = (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) == 0);  \
+      }                                                                \
+    } while (!done);                                           \
+  }))
+#define lll_mutex_unlock_robust(futex) \
+  __lll_mutex_unlock_robust(&(futex))
+
+
+
+#define __lll_mutex_timedlock_robust(futex,abstime)                    \
+  ({                                                                   \
+    int *__futex = (futex);                                            \
+    int __val;                                                         \
+    int oldval, newval;                                                       \
+    int pid, deadflag, waitflag;                                       \
+                                                                       \
+    do {                                                               \
+      do {                                                             \
+        oldval = *__futex;                                             \
+        pid = oldval & 0x3fff;                                         \
+        deadflag = oldval & FUTEX_OWNER_DIED;                          \
+        waitflag = 0;                                                  \
+        if (pid == 0)                                                  \
+          pid = THREAD_GETMEM (THREAD_SELF, tid);                      \
+        else                                                           \
+          waitflag = FUTEX_WAITERS;                                    \
+        newval = pid | waitflag | deadflag;                            \
+      } while (atomic_compare_and_exchange_bool_acq (__futex, newval, oldval) != 0); \
+      __val = 0;                                                       \
+      if (waitflag != 0)                                               \
+        __val = __lll_timedlock_wait_robust(__futex,abstime);          \
+    } while (__val == EAGAIN);                                         \
+    __val;                                                             \
+  })
+#define lll_mutex_timedlock_robust(futex,abstime) \
+  __lll_mutex_timedlock_robust (&(futex),(abstime))
 
 #define lll_mutex_unlock(futex) \
-  (void) ({ int ignore;							      \
+  ({ int ignore, result;						      \
             __asm __volatile (LOCK_INSTR "subl $1,%0\n\t"		      \
 			      "jne _L_mutex_unlock_%=\n\t"		      \
 			      ".subsection 1\n\t"			      \
@@ -203,9 +363,10 @@ extern int __lll_mutex_unlock_wake (int 
 			      ".size _L_mutex_unlock_%=,.-_L_mutex_unlock_%=\n" \
 			      ".previous\n"				      \
 			      "1:"					      \
-			      : "=m" (futex), "=&a" (ignore)		      \
+			      : "=m" (futex), "=&a" (result)		      \
 			      : "m" (futex)				      \
-			      : "memory"); })
+			      : "memory");                                    \
+                              result; })
 
 
 #define lll_mutex_islocked(futex) \
@@ -262,7 +423,7 @@ extern int lll_unlock_wake_cb (int *__fu
 
 
 # define lll_lock(futex) \
-  (void) ({ int ignore1, ignore2;					      \
+  ({ int ignore1, result;					              \
 	    __asm __volatile ("cmpl $0, %%gs:%P6\n\t"			      \
 			      "je,pt 0f\n\t"				      \
 			      "lock\n"					      \
@@ -277,18 +438,19 @@ extern int lll_unlock_wake_cb (int *__fu
 			      ".size _L_mutex_lock_%=,.-_L_mutex_lock_%=\n"   \
 			      ".previous\n"				      \
 			      "1:"					      \
-			      : "=a" (ignore1), "=c" (ignore2), "=m" (futex)  \
+			      : "=a" (result), "=c" (ignore1), "=m" (futex)   \
 			      : "0" (0), "1" (1), "m" (futex),		      \
 		                "i" (offsetof (tcbhead_t, multiple_threads))  \
-			      : "memory"); })
+			      : "memory");                                    \
+                              result; })
 
 
 # define lll_unlock(futex) \
-  (void) ({ int ignore;							      \
+  ({ int result;							      \
             __asm __volatile ("cmpl $0, %%gs:%P3\n\t"			      \
 			      "je,pt 0f\n\t"				      \
 			      "lock\n"					      \
-			      "0:\tsubl $1,%0\n\t"		      \
+			      "0:\tsubl $1,%0\n\t"		              \
 			      "jne _L_mutex_unlock_%=\n\t"		      \
 			      ".subsection 1\n\t"			      \
 			      ".type _L_mutex_unlock_%=,@function\n"	      \
@@ -299,16 +461,38 @@ extern int lll_unlock_wake_cb (int *__fu
 			      ".size _L_mutex_unlock_%=,.-_L_mutex_unlock_%=\n" \
 			      ".previous\n"				      \
 			      "1:"					      \
-			      : "=m" (futex), "=&a" (ignore)		      \
+			      : "=m" (futex), "=&a" (result)		      \
 			      : "m" (futex),				      \
 				"i" (offsetof (tcbhead_t, multiple_threads))  \
-			      : "memory"); })
+			      : "memory");                                    \
+                              result; })
 #endif
 
 
 #define lll_islocked(futex) \
   (futex != LLL_LOCK_INITIALIZER)
 
+#define lll_mutex_islocked_robust(futex) \
+  ((futex & 0x3fff) != 0)
+
+#define lll_mutex_register(futex, attr) \
+  lll_futex_register(&(futex), attr)
+
+#define lll_mutex_deregister(futex) \
+  lll_futex_deregister(&(futex))
+
+#define __lll_mutex_recover(futex)                             \
+  ({                                                           \
+     int *__futex = (futex);                                   \
+     int __val = lll_futex_recover (__futex);                  \
+     __val;                                                    \
+  })
+#define lll_mutex_recover(futex) \
+  __lll_mutex_recover(&(futex))
+
+#define lll_mutex_not_recoverable(futex) \
+  lll_futex_not_recoverable(&(futex))
+
 
 /* The kernel notifies a process with uses CLONE_CLEARTID via futex
    wakeup when the clone terminates.  The memory location contains the
Index: glibc-2.3.5/nptl/Versions
===================================================================
--- glibc-2.3.5.orig/nptl/Versions
+++ glibc-2.3.5/nptl/Versions
@@ -227,6 +227,9 @@ libpthread {
     pthread_mutexattr_setrobust_np;
     pthread_mutexattr_getrobust_np;
     pthread_mutex_consistent_np;
+    pthread_mutexattr_getprotocol;
+    pthread_mutexattr_setprotocol;
+
   }
 
   GLIBC_2.3.4 {
Index: glibc-2.3.5/nptl/pthread_mutex_destroy.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_destroy.c
+++ glibc-2.3.5/nptl/pthread_mutex_destroy.c
@@ -22,7 +22,7 @@
 #include <errno.h>
 #include "pthreadP.h"
 #include <lowlevellock.h>
-
+#include <linux/futex.h>
 
 int
 __pthread_mutex_destroy (mutex)
@@ -32,7 +32,8 @@ __pthread_mutex_destroy (mutex)
     return EBUSY;
 
   /* deregister robust futex with the kernel */
-  if (mutex->__data.__kind & MUTEXATTR_KIND_ROBUST) {
+  if (mutex->__data.__kind &
+      (FUTEX_ATTR_ROBUST | FUTEX_ATTR_PRIORITY_INHERITANCE)) {
 	if( lll_mutex_deregister(mutex->__data.__lock) )
 		return errno;
   }
Index: glibc-2.3.5/nptl/pthread_mutex_lock.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_lock.c
+++ glibc-2.3.5/nptl/pthread_mutex_lock.c
@@ -23,7 +23,7 @@
 #include <errno.h>
 #include "pthreadP.h"
 #include <lowlevellock.h>
-
+#include <linux/futex.h>
 
 #ifndef LLL_MUTEX_LOCK
 # define LLL_MUTEX_LOCK(mutex) \
@@ -39,8 +39,8 @@ __pthread_mutex_lock (mutex)
   assert (sizeof (mutex->__size) >= sizeof (mutex->__data));
 
   pid_t id = THREAD_GETMEM (THREAD_SELF, tid);
-  int mutex_type = mutex->__data.__kind & MUTEXATTR_KIND_TYPEMASK;
-  int robust = mutex->__data.__kind & MUTEXATTR_KIND_ROBUST;
+  int mutex_type = mutex->__data.__kind & (~(FUTEX_ATTR_MASK));
+  int robust = mutex->__data.__kind & (FUTEX_ATTR_ROBUST | FUTEX_ATTR_PRIORITY_INHERITANCE);
   int result = 0;
 
   if (robust && lll_mutex_not_recoverable(mutex->__data.__lock))
Index: glibc-2.3.5/nptl/pthread_mutex_timedlock.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_timedlock.c
+++ glibc-2.3.5/nptl/pthread_mutex_timedlock.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 #include "pthreadP.h"
 #include <lowlevellock.h>
+#include <linux/futex.h>
 
 # define LLL_MUTEX_TIMEDLOCK(mutex,abstime) \
 	(robust ? lll_mutex_timedlock_robust(mutex,abstime) \
@@ -37,8 +38,8 @@ pthread_mutex_timedlock (mutex, abstime)
 {
   pid_t id = THREAD_GETMEM (THREAD_SELF, tid);
   int result = 0;
-  int mutex_type = mutex->__data.__kind & MUTEXATTR_KIND_TYPEMASK;
-  int robust = mutex->__data.__kind & MUTEXATTR_KIND_ROBUST;
+  int mutex_type = mutex->__data.__kind & (~FUTEX_ATTR_MASK);
+  int robust = mutex->__data.__kind & (FUTEX_ATTR_ROBUST | FUTEX_ATTR_PRIORITY_INHERITANCE);
 
   /* We must not check ABSTIME here.  If the thread does not block
      abstime must not be checked for a valid value.  */
Index: glibc-2.3.5/nptl/pthread_mutex_trylock.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_trylock.c
+++ glibc-2.3.5/nptl/pthread_mutex_trylock.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 #include "pthreadP.h"
 #include <lowlevellock.h>
+#include <linux/futex.h>
 
 # define LLL_MUTEX_TRYLOCK(mutex) \
 	(robust ? lll_mutex_trylock_robust(mutex) : lll_mutex_trylock (mutex))
@@ -31,8 +32,8 @@ __pthread_mutex_trylock (mutex)
      pthread_mutex_t *mutex;
 {
   pid_t id;
-  int mutex_type = mutex->__data.__kind & MUTEXATTR_KIND_TYPEMASK;
-  int robust = mutex->__data.__kind & MUTEXATTR_KIND_ROBUST;
+  int mutex_type = mutex->__data.__kind & (~FUTEX_ATTR_MASK);
+  int robust = mutex->__data.__kind & (FUTEX_ATTR_ROBUST | FUTEX_ATTR_PRIORITY_INHERITANCE);
   int result;
 
   if (robust && lll_mutex_not_recoverable(mutex->__data.__lock))
Index: glibc-2.3.5/nptl/pthread_mutex_unlock.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_unlock.c
+++ glibc-2.3.5/nptl/pthread_mutex_unlock.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 #include "pthreadP.h"
 #include <lowlevellock.h>
+#include <linux/futex.h>
 
 # define LLL_MUTEX_ISLOCKED(mutex) \
 	(robust ? lll_mutex_islocked_robust(mutex) : lll_mutex_islocked (mutex))
@@ -32,8 +33,8 @@ __pthread_mutex_unlock_usercnt (mutex, d
      pthread_mutex_t *mutex;
      int decr;
 {
-  int mutex_type = mutex->__data.__kind & MUTEXATTR_KIND_TYPEMASK;
-  int robust = mutex->__data.__kind & MUTEXATTR_KIND_ROBUST;
+  int mutex_type = mutex->__data.__kind & (~FUTEX_ATTR_MASK);
+  int robust = mutex->__data.__kind & (FUTEX_ATTR_ROBUST | FUTEX_ATTR_PRIORITY_INHERITANCE);
 
   if (robust && lll_mutex_not_recoverable(mutex->__data.__lock))
     return ENOTRECOVERABLE;
Index: glibc-2.3.5/nptl/pthread_mutexattr_gettype.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutexattr_gettype.c
+++ glibc-2.3.5/nptl/pthread_mutexattr_gettype.c
@@ -20,7 +20,7 @@
    02111-1307 USA.  */
 
 #include <pthreadP.h>
-
+#include <linux/futex.h>
 
 int
 pthread_mutexattr_gettype (attr, kind)
@@ -32,7 +32,7 @@ pthread_mutexattr_gettype (attr, kind)
   iattr = (const struct pthread_mutexattr *) attr;
 
   /* Bits 30 and 31 indicate if the mutex is robust and/or process shared  */
-  *kind = iattr->mutexkind & MUTEXATTR_KIND_TYPEMASK;
+  *kind = iattr->mutexkind & (~FUTEX_ATTR_MASK);
 
   return 0;
 }
Index: glibc-2.3.5/nptl/pthread_mutexattr_settype.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutexattr_settype.c
+++ glibc-2.3.5/nptl/pthread_mutexattr_settype.c
@@ -21,7 +21,7 @@
 
 #include <errno.h>
 #include <pthreadP.h>
-
+#include <linux/futex.h>
 
 int
 __pthread_mutexattr_settype (attr, kind)
@@ -36,7 +36,7 @@ __pthread_mutexattr_settype (attr, kind)
   iattr = (struct pthread_mutexattr *) attr;
 
   /* Bits 30 and 31 indicate if the mutex is robust and/or process shared  */
-  iattr->mutexkind = (iattr->mutexkind & MUTEXATTR_KIND_FLAGMASK) | kind;
+  iattr->mutexkind = (iattr->mutexkind & FUTEX_ATTR_MASK) | kind;
 
   return 0;
 }
Index: glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/internaltypes.h
===================================================================
--- glibc-2.3.5.orig/nptl/sysdeps/unix/sysv/linux/internaltypes.h
+++ glibc-2.3.5/nptl/sysdeps/unix/sysv/linux/internaltypes.h
@@ -56,20 +56,14 @@ struct pthread_mutexattr
 {
   /* Identifier for the kind of mutex.
 
-     Bit 31 is set if the mutex is to be shared between processes.
+     Bit 27 is set if the mutex is to be shared between processes.
      Bit 30 is set if the mutex is robust.
 
-     Bit 0 to 29 contain one of the PTHREAD_MUTEX_ values to identify
+     Bit 0 to 26 contain one of the PTHREAD_MUTEX_ values to identify
      the type of the mutex.  */
   int mutexkind;
 };
 
-#define MUTEXATTR_KIND_SHARED 0x80000000
-#define MUTEXATTR_KIND_ROBUST 0x40000000
-#define MUTEXATTR_KIND_FLAGMASK (MUTEXATTR_KIND_SHARED | MUTEXATTR_KIND_ROBUST)
-#define MUTEXATTR_KIND_TYPEMASK (~MUTEXATTR_KIND_FLAGMASK)
-
-
 /* Conditional variable attribute data structure.  */
 struct pthread_condattr
 {
Index: glibc-2.3.5/nptl/pthread_mutex_consistent_np.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutex_consistent_np.c
+++ glibc-2.3.5/nptl/pthread_mutex_consistent_np.c
@@ -21,12 +21,13 @@
 #include <errno.h>
 #include <pthreadP.h>
 #include <lowlevellock.h>
+#include <linux/futex.h>
 
 int
 pthread_mutex_consistent_np (mutex)
      pthread_mutex_t *mutex;
 {
-  if (!(mutex->__data.__kind & MUTEXATTR_KIND_ROBUST))
+  if (!(mutex->__data.__kind & FUTEX_ATTR_ROBUST))
     return EINVAL;
 
   if (lll_mutex_not_recoverable(mutex->__data.__lock))
Index: glibc-2.3.5/nptl/pthread_mutexattr_getpshared.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutexattr_getpshared.c
+++ glibc-2.3.5/nptl/pthread_mutexattr_getpshared.c
@@ -20,7 +20,7 @@
    02111-1307 USA.  */
 
 #include <pthreadP.h>
-
+#include <linux/futex.h>
 
 int
 pthread_mutexattr_getpshared (attr, pshared)
@@ -31,9 +31,9 @@ pthread_mutexattr_getpshared (attr, psha
 
   iattr = (const struct pthread_mutexattr *) attr;
 
-  /* We use bit 31 to signal whether the mutex is going to be
+  /* We use bit 27 to signal whether the mutex is going to be
      process-shared or not.  */
-  *pshared = ((iattr->mutexkind & MUTEXATTR_KIND_SHARED) != 0
+  *pshared = ((iattr->mutexkind & FUTEX_ATTR_SHARED) != 0
 	      ? PTHREAD_PROCESS_SHARED : PTHREAD_PROCESS_PRIVATE);
 
   return 0;
Index: glibc-2.3.5/nptl/pthread_mutexattr_getrobust_np.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutexattr_getrobust_np.c
+++ glibc-2.3.5/nptl/pthread_mutexattr_getrobust_np.c
@@ -19,7 +19,7 @@
    02111-1307 USA.  */
 
 #include <pthreadP.h>
-
+#include <linux/futex.h>
 
 int
 pthread_mutexattr_getrobust_np (attr, robust)
@@ -32,7 +32,7 @@ pthread_mutexattr_getrobust_np (attr, ro
 
   /* We use bit 30 to signal whether the mutex is going to be
      robust or not.  */
-  *robust = ((iattr->mutexkind & MUTEXATTR_KIND_ROBUST) != 0
+  *robust = ((iattr->mutexkind & FUTEX_ATTR_ROBUST) != 0
 	      ? PTHREAD_MUTEX_ROBUST_NP : PTHREAD_MUTEX_NOTROBUST_NP);
 
   return 0;
Index: glibc-2.3.5/nptl/pthread_mutexattr_setpshared.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutexattr_setpshared.c
+++ glibc-2.3.5/nptl/pthread_mutexattr_setpshared.c
@@ -21,7 +21,7 @@
 
 #include <errno.h>
 #include <pthreadP.h>
-
+#include <linux/futex.h>
 
 int
 pthread_mutexattr_setpshared (attr, pshared)
@@ -39,9 +39,9 @@ pthread_mutexattr_setpshared (attr, psha
   /* We use bit 31 to signal whether the mutex is going to be
      process-shared or not.  */
   if (pshared == PTHREAD_PROCESS_PRIVATE)
-    iattr->mutexkind &= ~MUTEXATTR_KIND_SHARED;
+    iattr->mutexkind &= ~FUTEX_ATTR_SHARED;
   else
-    iattr->mutexkind |= MUTEXATTR_KIND_SHARED;
+    iattr->mutexkind |= FUTEX_ATTR_SHARED;
 
   return 0;
 }
Index: glibc-2.3.5/nptl/pthread_mutexattr_setrobust_np.c
===================================================================
--- glibc-2.3.5.orig/nptl/pthread_mutexattr_setrobust_np.c
+++ glibc-2.3.5/nptl/pthread_mutexattr_setrobust_np.c
@@ -20,7 +20,7 @@
 
 #include <errno.h>
 #include <pthreadP.h>
-
+#include <linux/futex.h>
 
 int
 pthread_mutexattr_setrobust_np (attr, robust)
@@ -38,9 +38,9 @@ pthread_mutexattr_setrobust_np (attr, ro
   /* We use bit 30 to signal whether the mutex is going to be
      robust or not.  */
   if (robust == PTHREAD_MUTEX_NOTROBUST_NP)
-    iattr->mutexkind &= ~MUTEXATTR_KIND_ROBUST;
+    iattr->mutexkind &= ~FUTEX_ATTR_ROBUST;
   else
-    iattr->mutexkind |= MUTEXATTR_KIND_ROBUST;
+    iattr->mutexkind |= FUTEX_ATTR_ROBUST;
 
   return 0;
 }

--------------030107080100030604020908--
