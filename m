Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbQJ0RkE>; Fri, 27 Oct 2000 13:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbQJ0Rjy>; Fri, 27 Oct 2000 13:39:54 -0400
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:26637 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129561AbQJ0Rjh>; Fri, 27 Oct 2000 13:39:37 -0400
Message-ID: <39F9BE56.DD81A8A3@mvista.com>
Date: Fri, 27 Oct 2000 10:41:42 -0700
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
CC: Nigel Gamble <nigel@mvista.com>
Subject: Full preemption issues
Content-Type: multipart/mixed;
 boundary="------------D335139CCD430FF0C97E9C27"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D335139CCD430FF0C97E9C27
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dear Linus,

As you know we at MontaVista are working on a fully preemptable kernel. 
In this work we have come up with a couple of issues we would like your
comments on.

First, as you know, we have added code to the spinlock macros to count
up and down a preemption lock counter.  We would like to not do this if
the macro also turns off local interrupts.  The issue here is that in
some places in the code, spin_lock_irq() or spin_lock_irqsave() is
called but spin_unlock_irq() or spin_lock_irqrestore() is not.  This, of
course, confuses the preemption count.  Attached is a patch that
addresses this issue.  At this time we are not asking you to apply this
patch, but to indicate if we are moving in an acceptable direction.

The second issue resolves around the naming conventions used in the
kernel.  We want to extend this work to include the SMP kernel, but to
do this we need to have several levels of names for the spinlock
macros.  We note that the kernel uses "_" and "__" prefixes in some
macros, but can not, by inspection, figure out when to uses these
prefixes.  Could you explain this convention or is this wisdom written
somewhere?

To clarify the intent here is a bit of proto code:

#ifdef CONFIG_PREEMPT
#define preempt_lock() ... definition...
#define preempt_unlock() ...definition...
#else
#define preempt_lock()
#define preempt_unlock()
#endif

#ifdef CONFIG_SMP
#define _spin_lock(x) __spin_lock(x)  /* __spin_lock(x) to be todays SMP
definition */
#define _spin_unlock(x) __spin_unlock(x)  /* __spin_unlock(x) to be
todays SMP definition */
#else
#define _spin_lock()
#define _spin_unlock()
#endif

#define spin_lock(x) do{ preempt_lock(); _spin_lock(x);} while (0)
#define spin_unlock(x) do{ _spin_unlock(x); preempt_unlock();} while (0)

George
--------------D335139CCD430FF0C97E9C27
Content-Type: text/plain; charset=us-ascii;
 name="irq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq.patch"

diff -urP -X patch.exclude linux-2.4.0-test6-kb-p-r-i-6-1.4/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.4.0-test6-kb-p-r-i-6-1.4/drivers/ide/ide.c	Thu Jul 27 16:40:57 2000
+++ linux/drivers/ide/ide.c	Fri Oct 20 13:06:45 2000
@@ -1354,7 +1354,7 @@
 		 */
 		if (masked_irq && hwif->irq != masked_irq)
 			disable_irq_nosync(hwif->irq);
-		spin_unlock(&io_request_lock);
+		spin_unlock_noirqrestore(&io_request_lock);
 		ide__sti();	/* allow other IRQs while we start this request */
 		startstop = start_request(drive);
 		spin_lock_irq(&io_request_lock);
@@ -1438,7 +1438,7 @@
 			 * the handler() function, which means we need to globally
 			 * mask the specific IRQ:
 			 */
-			spin_unlock(&io_request_lock);
+			spin_unlock_noirqrestore(&io_request_lock);
 			hwif  = HWIF(drive);
 #if DISABLE_IRQ_NOSYNC
 			disable_irq_nosync(hwif->irq);
@@ -1599,7 +1599,7 @@
 	}
 	hwgroup->handler = NULL;
 	del_timer(&hwgroup->timer);
-	spin_unlock(&io_request_lock);
+	spin_unlock_noirqrestore(&io_request_lock);
 
 	if (drive->unmask)
 		ide__sti();	/* local CPU only */
--- linux-2.4.0-test6-org/include/linux/spinlock.h	Wed Aug  9 18:57:54 2000
+++ linux/include/linux/spinlock.h	Fri Oct 27 09:48:47 2000
@@ -7,29 +7,107 @@
  * These are the generic versions of the spinlocks and read-write
  * locks..
  */
-#define spin_lock_irqsave(lock, flags)		do { local_irq_save(flags);       spin_lock(lock); } while (0)
-#define spin_lock_irq(lock)			do { local_irq_disable();         spin_lock(lock); } while (0)
-#define spin_lock_bh(lock)			do { local_bh_disable();          spin_lock(lock); } while (0)
-
-#define read_lock_irqsave(lock, flags)		do { local_irq_save(flags);       read_lock(lock); } while (0)
-#define read_lock_irq(lock)			do { local_irq_disable();         read_lock(lock); } while (0)
-#define read_lock_bh(lock)			do { local_bh_disable();          read_lock(lock); } while (0)
-
-#define write_lock_irqsave(lock, flags)		do { local_irq_save(flags);      write_lock(lock); } while (0)
-#define write_lock_irq(lock)			do { local_irq_disable();        write_lock(lock); } while (0)
-#define write_lock_bh(lock)			do { local_bh_disable();         write_lock(lock); } while (0)
-
-#define spin_unlock_irqrestore(lock, flags)	do { spin_unlock(lock);  local_irq_restore(flags); } while (0)
-#define spin_unlock_irq(lock)			do { spin_unlock(lock);  local_irq_enable();       } while (0)
-#define spin_unlock_bh(lock)			do { spin_unlock(lock);  local_bh_enable();        } while (0)
-
-#define read_unlock_irqrestore(lock, flags)	do { read_unlock(lock);  local_irq_restore(flags); } while (0)
-#define read_unlock_irq(lock)			do { read_unlock(lock);  local_irq_enable();       } while (0)
-#define read_unlock_bh(lock)			do { read_unlock(lock);  local_bh_enable();        } while (0)
-
-#define write_unlock_irqrestore(lock, flags)	do { write_unlock(lock); local_irq_restore(flags); } while (0)
-#define write_unlock_irq(lock)			do { write_unlock(lock); local_irq_enable();       } while (0)
-#define write_unlock_bh(lock)			do { write_unlock(lock); local_bh_enable();        } while (0)
+#if defined(CONFIG_PREEMPT) & !defined(CONFIG_SMP)
+#define spin_lock_irqsave(lock, flags)	do { local_irq_save(flags); } while (0)
+#define read_lock_irqsave(lock, flags)	do { local_irq_save(flags); } while (0)
+#define write_lock_irqsave(lock, flags)	do { local_irq_save(flags); } while (0)
+
+#define spin_unlock_irqrestore(lock, flags)	do { local_irq_restore(flags);\
+                                                   } while (0)
+#define read_unlock_irqrestore(lock, flags)	do { local_irq_restore(flags);\
+                                                   } while (0)
+#define write_unlock_irqrestore(lock, flags)    do { local_irq_restore(flags); \
+                                                   } while (0)
+
+#define spin_lock_irq(lock)		do { local_irq_disable(); } while (0)
+#define read_lock_irq(lock)		do { local_irq_disable(); } while (0)
+#define write_lock_irq(lock)		do { local_irq_disable(); } while (0)
+
+#define spin_unlock_irq(lock)		do { local_irq_enable();} while (0)
+#define read_unlock_irq(lock)		do { local_irq_enable();} while (0)
+#define write_unlock_irq(lock)		do { local_irq_enable();} while (0)
+
+#ifdef BH_PREEMPT     /* Someday this might be possible, but they are too 
+                       * confused right now.
+                       */
+#define spin_lock_bh(lock)		do { local_bh_disable();} while (0)
+#define read_lock_bh(lock)		do { local_bh_disable();  } while (0)
+#define write_lock_bh(lock)		do { local_bh_disable();} while (0)
+
+#define spin_unlock_bh(lock)		do { local_bh_enable();} while (0)
+#define read_unlock_bh(lock)		do { local_bh_enable();} while (0)
+#define write_unlock_bh(lock)		do { local_bh_enable();} while (0)
+#endif
+
+/* For the case where we want to do the spin_unlock but leave the irq etc.
+ * alone we have these macros.  This is needed so we don't unlock what was
+ * never locked.
+ */
+#define spin_unlock_noirqrestore(lock)	do { } while (0)
+#define read_unlock_noirqrestore(lock)	do { } while (0)
+#define write_unlock_noirqrestore(lock) do { } while (0)
+
+#define spin_unlock_noirq(lock)		do { } while (0)
+#define read_unlock_noirq(lock)		do { } while (0)
+#define write_unlock_noirq(lock)	do { } while (0)
+
+#ifdef BH_PREEMPT
+#define spin_unlock_nobh(lock)		do { } while (0)
+#define read_unlock_nobh(lock)		do { } while (0)
+#define write_unlock_nobh(lock)		do { } while (0)
+#endif
+
+#else
+#define spin_lock_irqsave(lock, flags)	do { local_irq_save(flags); \
+                                             spin_lock(lock); } while (0)
+#define read_lock_irqsave(lock, flags)	do { local_irq_save(flags); \
+                                             read_lock(lock); } while (0)
+#define write_lock_irqsave(lock, flags)	do { local_irq_save(flags); \
+                                             write_lock(lock); } while (0)
+#define spin_unlock_irqrestore(lock, flags) do { spin_unlock(lock);   \
+                                             local_irq_restore(flags);}while (0)
+#define read_unlock_irqrestore(lock, flags) do { read_unlock(lock);   \
+                                             local_irq_restore(flags);}while (0)
+#define write_unlock_irqrestore(lock, flags)	do { write_unlock(lock);  \
+                                             local_irq_restore(flags);}while (0)
+#define spin_unlock_noirqrestore(lock)  do { spin_unlock(lock); } while (0)
+#define read_unlock_noirqrestore(lock)  do { read_unlock(lock); } while (0)
+#define write_unlock_noirqrestore(lock) do { write_unlock(lock); } while(0)
+
+#define spin_lock_irq(lock)	do { local_irq_disable(); \
+                                     spin_lock(lock); } while (0)
+#define read_lock_irq(lock)	do { local_irq_disable(); \
+                                     read_lock(lock); } while (0)
+#define write_lock_irq(lock)	do { local_irq_disable(); \
+                                     write_lock(lock); } while (0)
+#define spin_unlock_irq(lock)	do { spin_unlock(lock);   \
+                                     local_irq_enable();} while (0)
+#define read_unlock_irq(lock)	do { read_unlock(lock);   \
+                                     local_irq_enable();} while (0)
+#define write_unlock_irq(lock)	do { write_unlock(lock);    \
+                                     local_irq_enable();} while (0)
+#define spin_unlock_noirq(lock)	do { spin_unlock(lock); } while (0)
+#define read_unlock_noirq(lock)	do { read_unlock(lock); } while (0)
+#define write_unlock_noirq(lock) do { write_unlock(lock); } while (0)
+#endif
+
+#ifndef BH_PREEMPT
+#define spin_lock_bh(lock)	do { local_bh_disable();   \
+                                     spin_lock(lock); } while (0)
+#define read_lock_bh(lock)	do { local_bh_disable();   \
+                                     read_lock(lock); } while (0)
+#define write_lock_bh(lock)	do { local_bh_disable();   \
+                                     write_lock(lock); } while (0)
+#define spin_unlock_bh(lock)	do { spin_unlock(lock);   \
+                                     local_bh_enable();} while (0)
+#define read_unlock_bh(lock)	do { read_unlock(lock);   \
+                                     local_bh_enable();} while (0)
+#define write_unlock_bh(lock)	do { write_unlock(lock);   \
+                                     local_bh_enable();} while (0)
+#define spin_unlock_nobh(lock)	do { spin_unlock(lock); } while (0)
+#define read_unlock_nobh(lock)	do { read_unlock(lock); } while (0)
+#define write_unlock_nobh(lock)	do { write_unlock(lock); } while (0)
+#endif
 
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
diff -urP -X patch.exclude linux-2.4.0-test6-kb-p-r-i-6-1.4/include/linux/wait.h linux/include/linux/wait.h
--- linux-2.4.0-test6-kb-p-r-i-6-1.4/include/linux/wait.h	Wed Oct 25 13:28:46 2000
+++ linux/include/linux/wait.h	Mon Oct 23 14:22:02 2000
@@ -76,6 +76,9 @@
 # define wq_write_lock_irqsave write_lock_irqsave
 # define wq_write_unlock_irqrestore write_unlock_irqrestore
 # define wq_write_unlock write_unlock
+# define wq_read_unlock_noirqrestore read_unlock_noirqrestore
+# define wq_write_unlock_noirqrestore write_unlock_noirqrestore
+# define wq_write_unlock_noirq write_unlock_noirq
 #else
 # define wq_lock_t spinlock_t
 # define WAITQUEUE_RW_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
@@ -88,6 +91,9 @@
 # define wq_write_lock_irqsave spin_lock_irqsave
 # define wq_write_unlock_irqrestore spin_unlock_irqrestore
 # define wq_write_unlock spin_unlock
+# define wq_read_unlock_noirqrestore spin_unlock_noirqrestore
+# define wq_write_unlock_noirqrestore spin_unlock_noirqrestore
+# define wq_write_unlock_noirq spin_unlock_noirq
 #endif
 
 struct __wait_queue_head {
diff -urP -X patch.exclude linux-2.4.0-test6-kb-p-r-i-6-1.4/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.0-test6-kb-p-r-i-6-1.4/kernel/sched.c	Wed Oct 25 11:35:44 2000
+++ linux/kernel/sched.c	Fri Oct 27 09:37:15 2000
@@ -838,7 +838,7 @@
 #define	SLEEP_ON_HEAD					\
 	wq_write_lock_irqsave(&q->lock,flags);		\
 	__add_wait_queue(q, &wait);			\
-	wq_write_unlock(&q->lock);
+	wq_write_unlock_noirqrestore(&q->lock);
 
 #define	SLEEP_ON_TAIL						\
 	wq_write_lock_irq(&q->lock);				\

--------------D335139CCD430FF0C97E9C27--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
