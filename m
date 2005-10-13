Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVJMAAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVJMAAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVJMAAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:00:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27127 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964829AbVJMAAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:00:03 -0400
Message-ID: <434DA382.1050100@mvista.com>
Date: Wed, 12 Oct 2005 17:00:02 -0700
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: robustmutexes@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Robust Futex update
Content-Type: multipart/mixed;
 boundary="------------000207050404070601020300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000207050404070601020300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo,
    here 's a patch for 2.6.14-rc4-rt1 that fixes two things:

1) Deregister futex returns -EBUSY instead of -EINVAL if a thread tries 
to deregister a pthread_mutex that another thread has locked.

2)  Make the fast path robust.  If a pthread_mutex is only locked in 
user space we need to clear the owner when
the thread dies.  This makes both the 'rt_mutex is locked in the kernel' 
and the 'pthread_mutex is only locked in user space'
paths robust.

David

--------------000207050404070601020300
Content-Type: text/plain;
 name="patch-2.6.14-rc4-rt1-rf1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.14-rc4-rt1-rf1"

Index: linux-2.6.13/kernel/futex.c
===================================================================
--- linux-2.6.13.orig/kernel/futex.c
+++ linux-2.6.13/kernel/futex.c
@@ -1354,18 +1354,25 @@ static void find_owned_futex(struct vm_a
 		if (uaddr == 0)
 			continue;
 
+		up(&mapping->robust_sem);
+		up_read(&current->mm->mmap_sem);
+		value = futex_get_user(uaddr);
+		if (this->futex_mutex.mutex_attr & FUTEX_ATTR_ROBUST)
+			value |= FUTEX_OWNER_DIED;
 		if (rt_mutex_owned_by(&this->futex_mutex, ti)) {
-			up(&mapping->robust_sem);
-			up_read(&current->mm->mmap_sem);
-			if (this->futex_mutex.mutex_attr & FUTEX_ATTR_ROBUST) {
-	 			value = futex_get_user(uaddr);
-				value |= FUTEX_OWNER_DIED;
- 				futex_put_user(value, uaddr);
-			}
+			futex_put_user(value, uaddr);
 			up_futex(&this->futex_mutex);
-			down(&mapping->robust_sem);
-			down_read(&current->mm->mmap_sem);
+		} else if ((value & FUTEX_PID) == current->pid) {
+			/*
+			 * this bit is for the fast path.  If the lock is only
+			 * locked in user space wee need to unlock it
+			 * for the exiting thread.
+			 */
+			value &= ~FUTEX_PID;
+			futex_put_user(value, uaddr);
 		}
+		down(&mapping->robust_sem);
+		down_read(&current->mm->mmap_sem);
 	}
 
 	up(&mapping->robust_sem);
@@ -1524,7 +1531,7 @@ static int futex_deregister(unsigned lon
 			if (rt_mutex_owned_by(&this->futex_mutex, ti)) {
 				up_futex(&this->futex_mutex);
 			} else if (rt_mutex_owner(&this->futex_mutex) != NULL) {
-				ret = -EINVAL;
+				ret = -EBUSY;
 				break;
 			}
 			list_del(&this->list);
Index: linux-2.6.13/include/linux/futex.h
===================================================================
--- linux-2.6.13.orig/include/linux/futex.h
+++ linux-2.6.13/include/linux/futex.h
@@ -1,8 +1,6 @@
 #ifndef _LINUX_FUTEX_H
 #define _LINUX_FUTEX_H
 
-#include <linux/fs.h>
-
 /* Second argument to futex syscall */
 
 
Index: linux-2.6.13/kernel/rt.c
===================================================================
--- linux-2.6.13.orig/kernel/rt.c
+++ linux-2.6.13/kernel/rt.c
@@ -47,6 +47,7 @@
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
 #include <linux/plist.h>
+#include <linux/fs.h>
 #include <linux/futex.h>
 
 #define CAPTURE_LOCK

--------------000207050404070601020300--
