Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSBUXxi>; Thu, 21 Feb 2002 18:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSBUXx3>; Thu, 21 Feb 2002 18:53:29 -0500
Received: from suntan.tandem.com ([192.216.221.8]:25220 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S288012AbSBUXxJ>; Thu, 21 Feb 2002 18:53:09 -0500
Message-ID: <3C758230.4E21E5F7@compaq.com>
Date: Thu, 21 Feb 2002 15:26:40 -0800
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kendrick M. Smith" <kmsmith@umich.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18-pre9, trylock for read/write semaphores
In-Reply-To: <Pine.SOL.4.33.0202211759410.13345-100000@millipede.gpcc.itd.umich.edu>
Content-Type: multipart/mixed;
 boundary="------------62F43425C3C4FE77DFFE1FE0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------62F43425C3C4FE77DFFE1FE0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Kendrick M. Smith" wrote:
> I have the patch from your original post and will give it a try with
> 2.5.  In that post, you also mentioned having some sort of testsuite
> which would place the semaphore under heavy contention, while also
> testing basic semantics of the semaphore.  If you send this along, I
> will give it a try as well...

The testsuite patch is attached. Apply it after the rwsem trylock patch.
What it does is start ten kernel threads that randomly call down_read,
down_write, down_read_trylock, and down_write_trylock. Reboot with the
test kernel and let it run for awhile. It should give your hard drive a
good workout as the debug output is written to the log. After a few
thousand locking operations, reboot with an ordinary kernel and study
the log.

If you have questions about the debug output, let me know.

-- 
Brian Watson                | "Now I don't know, but I been told it's
Linux Kernel Developer      |  hard to run with the weight of gold,
Open SSI Clustering Project |  Other hand I heard it said, it's
Compaq Computer Corp        |  just as hard with the weight of lead."
Los Angeles, CA             |     -Robert Hunter, 1970

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
--------------62F43425C3C4FE77DFFE1FE0
Content-Type: text/plain; charset=us-ascii;
 name="patch-test-2.4.18-rc1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-test-2.4.18-rc1"

diff -Naur rwsem/include/asm-i386/rwsem.h rwsem-test/include/asm-i386/rwsem.h
--- rwsem/include/asm-i386/rwsem.h	Mon Feb 18 18:46:18 2002
+++ rwsem-test/include/asm-i386/rwsem.h	Mon Feb 18 18:18:02 2002
@@ -120,9 +120,30 @@
 		: "memory", "cc");
 }
 
+void rst_debug_print(signed long ctr);
+
 /*
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
+#if 0
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	signed long old, new, result;
+
+repeat:
+	old = (volatile signed long)sem->count;
+	if (old < RWSEM_UNLOCKED_VALUE)
+		return 0;
+	new = old + RWSEM_ACTIVE_READ_BIAS;
+	result = cmpxchg(&sem->count, old, new);
+	rst_debug_print(result);
+	if (result == old)
+		return 1;
+	else
+		goto repeat;
+}
+#endif
+
 static inline int __down_read_trylock(struct rw_semaphore *sem)
 {
 	__s32 result, tmp;
@@ -140,6 +161,7 @@
 		: "+m"(sem->count), "=&a"(result), "+&r"(tmp)
 		: "i"(RWSEM_ACTIVE_READ_BIAS)
 		: "memory", "cc");
+	rst_debug_print(result);
 	return result>=0 ? 1 : 0;
 }
 
@@ -181,6 +203,7 @@
 	signed long ret = cmpxchg(&sem->count,
 				  RWSEM_UNLOCKED_VALUE, 
 				  RWSEM_ACTIVE_WRITE_BIAS);
+	rst_debug_print(ret);
 	if (ret == RWSEM_UNLOCKED_VALUE)
 		return 1;
 	return 0;
diff -Naur rwsem/include/linux/rwsem.h rwsem-test/include/linux/rwsem.h
--- rwsem/include/linux/rwsem.h	Mon Feb 18 18:44:36 2002
+++ rwsem-test/include/linux/rwsem.h	Mon Feb 18 18:18:07 2002
@@ -9,7 +9,7 @@
 
 #include <linux/linkage.h>
 
-#define RWSEM_DEBUG 0
+#define RWSEM_DEBUG 1
 
 #ifdef __KERNEL__
 
diff -Naur rwsem/include/rwsem_test.h rwsem-test/include/rwsem_test.h
--- rwsem/include/rwsem_test.h	Wed Dec 31 16:00:00 1969
+++ rwsem-test/include/rwsem_test.h	Mon Feb 18 15:36:44 2002
@@ -0,0 +1,100 @@
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/random.h>
+#include <linux/rwsem.h>
+#include <linux/spinlock.h>
+
+DECLARE_RWSEM(rst_lock);
+
+spinlock_t rst_ctrlock = SPIN_LOCK_UNLOCKED;
+unsigned int rst_ctr = 1000;
+unsigned int getctr(void)
+{
+	unsigned long ret;
+	spin_lock(&rst_ctrlock);
+	ret = ++rst_ctr;
+	spin_unlock(&rst_ctrlock);
+	return ret;
+}
+
+void rst_debug_print(signed long ctr)
+{
+	printk("[rst %d:%d] rwsem counter: %x\n", current->pid, getctr(), (unsigned int)ctr);
+}
+
+int
+rst_daemon(void *ignore)
+{
+	while (1) {
+		unsigned char sleep, style, ctr = 0;
+
+		get_random_bytes(&sleep, 1);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout((signed long)sleep);
+
+		for (; ctr < 20; ++ctr) {
+			get_random_bytes(&style, 1);
+
+			if (style > 191) {
+				down_write(&rst_lock);
+				printk("[rst %d:%d] down_write\n", current->pid, getctr());
+			} else if (style > 127) {
+				if (!down_write_trylock(&rst_lock)) {
+					printk("[rst %d:%d] down_write_trylock "
+							"failed\n", 
+							current->pid, getctr());
+					break;
+				}
+				printk("[rst %d:%d] down_write_trylock "
+						"succeeded\n", current->pid, getctr());
+			} else if (style > 63) {
+				down_read(&rst_lock);
+				printk("[rst %d:%d] down_read\n", current->pid, getctr());
+			} else {
+				if (!down_read_trylock(&rst_lock)) {
+					printk("[rst %d:%d] down_read_trylock "
+							"failed\n", 
+							current->pid, getctr());
+					break;
+				}
+				printk("[rst %d:%d] down_read_trylock "
+						"succeeded\n", current->pid, getctr());
+			}
+
+			if (style > 127)
+				printk("[rst %d:%d] writing... [1]\n", 
+						current->pid, getctr());
+			else
+				printk("[rst %d:%d] reading... [1]\n", 
+						current->pid, getctr());
+
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(5);
+
+			if (style > 127)
+				printk("[rst %d:%d] writing... [2]\n", 
+						current->pid, getctr());
+			else
+				printk("[rst %d:%d] reading... [2]\n", 
+						current->pid, getctr());
+
+			if (style > 127) {
+				printk("[rst %d:%d] up_write\n", current->pid, getctr());
+				up_write(&rst_lock);
+			} else {
+				printk("[rst %d:%d] up_read\n", current->pid, getctr());
+				up_read(&rst_lock);
+			}
+		}
+	}
+	return 0;
+}
+
+void
+rst_init(void)
+{
+	int ctr = 0;
+	rst_lock.debug = 1;
+	for (; ctr < 10; ++ctr)
+		kernel_thread(rst_daemon, NULL, 0);
+}
diff -Naur rwsem/init/main.c rwsem-test/init/main.c
--- rwsem/init/main.c	Mon Feb 18 18:45:30 2002
+++ rwsem-test/init/main.c	Mon Feb 18 14:11:23 2002
@@ -31,6 +31,8 @@
 #include <asm/io.h>
 #include <asm/bugs.h>
 
+#include <rwsem_test.h>
+
 #if defined(CONFIG_ARCH_S390)
 #include <asm/s390mach.h>
 #include <asm/ccwcache.h>
@@ -829,6 +831,8 @@
 	 * The Bourne shell can be used instead of init if we are 
 	 * trying to recover a really broken machine.
 	 */
+
+	rst_init();
 
 	if (execute_command)
 		execve(execute_command,argv_init,envp_init);

--------------62F43425C3C4FE77DFFE1FE0--

