Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269502AbUJLHx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269502AbUJLHx6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 03:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269505AbUJLHx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 03:53:58 -0400
Received: from mail.renesas.com ([202.234.163.13]:64915 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S269502AbUJLHxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 03:53:51 -0400
Date: Tue, 12 Oct 2004 16:53:41 +0900 (JST)
Message-Id: <20041012.165341.184807253.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc4] [m32r] Fix sys_tas system call for m32r
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch fixes a sys_tas system call for m32r.
Please apply.

- This patch fixes an Oops at sys_tas() in case CONFIG_SMP && CONFIG_PREEMPT.
  > Unable to handle kernel paging request at virtual address XXXXXXXX

  It is because a page fault happens at the spin_locked region in sys_tas()
  and in_atomic() checks preempt_count, but spin_lock() already counts up
  the preemt_count.

  arch/m32r/kernel/sys_m32r.c:
    32  /*
    33   * sys_tas() - test-and-set
    34   * linuxthreads testing version
    35   */
    36  #ifndef CONFIG_SMP
    37  asmlinkage int sys_tas(int *addr)
    38  {
    39          int oldval;
    40          unsigned long flags;
    41  
    42          if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
    43                  return -EFAULT;
    44          local_irq_save(flags);
    45          oldval = *addr;
    46          *addr = 1;
    47          local_irq_restore(flags);
    48          return oldval;
    49  }
    50  #else /* CONFIG_SMP */
    51  #include <linux/spinlock.h>
    52  
    53  static spinlock_t tas_lock = SPIN_LOCK_UNLOCKED;
    54  
    55  asmlinkage int sys_tas(int *addr)
    56  {
    57          int oldval;
    58  
    59          if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
    60                  return -EFAULT;
    61  
    62          spin_lock(&tas_lock);
    63          oldval = *addr;

	/* <<< ATTENTION >>>
	 * A page fault may happen here, because "addr" points an 
	 * user-space area.
	 */

    64          *addr = 1;
    65          spin_unlock(&tas_lock);
    66  
    67          return oldval;
    68  }
    69  #endif /* CONFIG_SMP */

  arch/mm/fault.c:
   137  /*
   138   * If we're in an interrupt or have no user context or are runni
ng in an
   139   * atomic region then we must not take the fault..
   140   */
   141  if (in_atomic() || !mm)
   142          goto bad_area_nosemaphore;

- sys_tas() is used for user-level mutual exclusion for the m32r,
  which is prepared to implement a linuxthreads library.
  The above problem may be happened in a program, which uses
  pthread_mutex_lock(), calls sys_tas().

  The current m32r instruction set has no user-level locking
  functions for mutual exclusion. 
  # I hope it will be fixed in the future...

- This patch fixes the problem by using _raw_spin_lock() instead of
  spin_lock().  spin_lock() increments up preemt_count, on the contrary, 
  _raw_sping_lock() does not.

  # I think this fix is just a temporary work around, and 
  # it is preferable to be rewrite to make it simpler by using 
  # asm() function or something...

Regards,

	* arch/m32r/kernel/sys_m32r.c:
	- Fix sys_tas() for CONFIG_SMP && CONFIG_PREEMPT.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/sys_m32r.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -ruNp a/arch/m32r/kernel/sys_m32r.c b/arch/m32r/kernel/sys_m32r.c
--- a/arch/m32r/kernel/sys_m32r.c	2004-10-12 09:34:39.000000000 +0900
+++ b/arch/m32r/kernel/sys_m32r.c	2004-10-12 11:00:55.000000000 +0900
@@ -59,10 +59,10 @@ asmlinkage int sys_tas(int *addr)
 	if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
 		return -EFAULT;
 
-	spin_lock(&tas_lock);
+	_raw_spin_lock(&tas_lock);
 	oldval = *addr;
 	*addr = 1;
-	spin_unlock(&tas_lock);
+	_raw_spin_unlock(&tas_lock);
 
 	return oldval;
 }


--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/


