Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRCLI1e>; Mon, 12 Mar 2001 03:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRCLI1Z>; Mon, 12 Mar 2001 03:27:25 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10686 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129583AbRCLI1V>;
	Mon, 12 Mar 2001 03:27:21 -0500
Message-ID: <3AAC881E.D420957A@mandrakesoft.com>
Date: Mon, 12 Mar 2001 03:26:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        rth@twiddle.net
Subject: Re: 2.4.2-ac18 fix for Alpha machines
In-Reply-To: <20010312100155.P23336@mea-ext.zmailer.org>
Content-Type: multipart/mixed;
 boundary="------------0383ECD505A67008ABB84EA1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0383ECD505A67008ABB84EA1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Matti Aarnio wrote:
> 
> The linkage of vmlinux fails with lacking code for  bust_spinlocks(),
> thus I cloned the i386 one as is -- which apparently is not really
> processor specific...
> 
> --- arch/alpha/mm/fault.c~      Sun Mar 11 11:49:23 2001
> +++ arch/alpha/mm/fault.c       Sun Mar 11 14:46:39 2001
> @@ -231,3 +231,39 @@
>         }
>  #endif
>  }
> +
> +extern spinlock_t timerlist_lock;
> +
> +/*
> + * Unlock any spinlocks which will prevent us from getting the
> + * message out (timerlist_lock is acquired through the
> + * console unblank code)
> + */
> +void bust_spinlocks(int yes)
> +{
> +       spin_lock_init(&timerlist_lock);
> +       if (yes) {
> +               oops_in_progress = 1;
> +#ifdef CONFIG_SMP
> +               global_irq_lock = 0;    /* Many serial drivers do __global_cli() */

can you say untested-on-smp :)
global_irq_lock is a spinlock.

> +#endif
> +       } else {
> +               int loglevel_save = console_loglevel;
> +               unblank_screen();

need to include vt_kern.h for unblank_screen proto

> +void do_BUG(const char *file, int line)
> +{
> +       bust_spinlocks(1);
> +       printk("kernel BUG at %s:%d!\n", file, line);
> +}

hmm, is this necessary?  The patch I sent to Alan is missing this.

Don't forget to CC Richard Henderson, the Alpha maintainer, on
patches... Attached are the two patches I sent to Alan and Richard
earlier today.  The first is my version of the bust_spinlock fix.  The
second is an unrelated fix which was needed for our build, and may be
helpful to some seeing "get_wchan_stack" warnings or errors.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
--------------0383ECD505A67008ABB84EA1
Content-Type: text/plain; charset=us-ascii;
 name="fault.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fault.patch"

--- linux/arch/alpha/mm/fault.c.orig	Sun Mar 11 22:44:41 2001
+++ linux/arch/alpha/mm/fault.c	Sun Mar 11 22:51:04 2001
@@ -24,9 +24,36 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
+#include <linux/vt_kern.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
+
+extern spinlock_t timerlist_lock;
+void bust_spinlocks(int yes)
+{
+        spin_lock_init(&timerlist_lock);
+        if (yes) {
+                oops_in_progress = 1;
+#ifdef CONFIG_SMP
+		spin_lock_init(&global_irq_lock);    /* Many serial drivers do __global_cli() */
+#endif
+        } else {
+                int loglevel_save = console_loglevel;
+                unblank_screen();
+                oops_in_progress = 0;
+                /*
+                 * OK, the message is on the console.  Now we call printk()
+                 * without oops_in_progress set so that printk will give klogd
+                 * a poke.  Hold onto your hats...
+                 */
+                console_loglevel = 15;          /* NMI oopser may have shut the console up */
+                printk(" ");
+                console_loglevel = loglevel_save;
+        }
+}
+
+
 
 extern void die_if_kernel(char *,struct pt_regs *,long, unsigned long *);
 

--------------0383ECD505A67008ABB84EA1
Content-Type: text/plain; charset=us-ascii;
 name="array.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="array.patch"

--- linux/fs/proc/array.c.orig	Sun Mar 11 22:42:37 2001
+++ linux/fs/proc/array.c	Sun Mar 11 22:43:26 2001
@@ -271,6 +271,7 @@
 extern int get_wchan_stack(struct task_struct *p, unsigned long *stack, int max);
 inline char *task_stack(struct task_struct *p, char *buffer)
 {
+#ifdef CONFIG_X86
 	unsigned long stack[64];
 	int i;
 	int cnt = get_wchan_stack(p, stack, 64);
@@ -278,6 +279,7 @@
 		buffer += sprintf(buffer, "Stack[%d]: %lx\n",
 				  i, stack[i]);
 	}
+#endif
 	return buffer;
 }
 

--------------0383ECD505A67008ABB84EA1--

