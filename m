Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291666AbSBHRel>; Fri, 8 Feb 2002 12:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291672AbSBHReV>; Fri, 8 Feb 2002 12:34:21 -0500
Received: from adsl-64-168-153-221.dsl.snfc21.pacbell.net ([64.168.153.221]:64904
	"EHLO unifiedcomputing.com") by vger.kernel.org with ESMTP
	id <S291666AbSBHReH>; Fri, 8 Feb 2002 12:34:07 -0500
Message-Id: <4.2.2.20020208092102.00aa5eb8@10.10.10.29>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.2.2 
Date: Fri, 08 Feb 2002 09:30:13 -0800
To: linux-kernel@vger.kernel.org
From: "S. Parker" <linux@sparker.net>
Subject: Sysrq enhancement: process kill facility
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's something that myself and others at Cobalt Networks have found useful.
It extends sysrq to support a way to manually kill a process.  In debugging
situations, we have found times where the system gets wedged, and we'ld like
to avoid a reboot.  Show tasks provides the pid information.

You enter <alt>-<sysrq>-n ("nuke"), and then prompts for the pid.  It supports
backspace and control-U.  On serial ports, it retains the same semantics:
a break activates this as a sysrq sequence, but if more than 5-seconds pass
without any input, it drops out of processing input as a sysrq.

Feedback welcome, please cc: me directly.

Cheers,

         ~sparker


diff -ur generic-2.4.17/drivers/char/keyboard.c 
sysrq-generic-2.4.17/drivers/char/keyboard.c
--- generic-2.4.17/drivers/char/keyboard.c      Tue Sep 18 13:39:51 2001
+++ sysrq-generic-2.4.17/drivers/char/keyboard.c        Thu Feb  7 17:59:18 
2002
@@ -252,7 +252,7 @@
                 goto out;
         } else if (sysrq_pressed) {
                 if (!up_flag) {
-                       handle_sysrq(kbd_sysrq_xlate[keycode], kbd_pt_regs, 
kbd, tty);
+                       (void) handle_sysrq(kbd_sysrq_xlate[keycode], 
kbd_pt_regs, kbd, tty);
                         goto out;
                 }
         }
Only in sysrq-generic-2.4.17/drivers/char: keyboard.c.orig
diff -ur generic-2.4.17/drivers/char/serial.c 
sysrq-generic-2.4.17/drivers/char/serial.c
--- generic-2.4.17/drivers/char/serial.c        Fri Dec 21 09:41:54 2001
+++ sysrq-generic-2.4.17/drivers/char/serial.c  Thu Feb  7 17:59:18 2002
@@ -645,8 +645,12 @@
                 if (break_pressed && info->line == sercons.index) {
                         if (ch != 0 &&
                             time_before(jiffies, break_pressed + HZ*5)) {
-                               handle_sysrq(ch, regs, NULL, NULL);
-                               break_pressed = 0;
+                               if (!handle_sysrq(ch, regs, NULL, NULL)) {
+                                       break_pressed = 0;
+                               } else {
+                                       /* reset time-out! more data needed */
+                                       break_pressed = jiffies;
+                               }
                                 goto ignore_char;
                         }
                         break_pressed = 0;
Only in sysrq-generic-2.4.17/drivers/char: serial.c.orig
diff -ur generic-2.4.17/drivers/char/serial_amba.c 
sysrq-generic-2.4.17/drivers/char/serial_amba.c
--- generic-2.4.17/drivers/char/serial_amba.c   Sun Sep 16 21:23:14 2001
+++ sysrq-generic-2.4.17/drivers/char/serial_amba.c     Thu Feb  7 17:59:18 
2002
@@ -356,8 +356,11 @@
  #ifdef SUPPORT_SYSRQ
                 if (info->sysrq) {
                         if (ch && time_before(jiffies, info->sysrq)) {
-                               handle_sysrq(ch, regs, NULL, NULL);
-                               info->sysrq = 0;
+                               if (!handle_sysrq(ch, regs, NULL, NULL)) {
+                                       info->sysrq = 0;
+                               } else {
+                                       info->sysrq = jiffies;
+                               }
                                 goto ignore_char;
                         }
                         info->sysrq = 0;
diff -ur generic-2.4.17/drivers/char/sysrq.c 
sysrq-generic-2.4.17/drivers/char/sysrq.c
--- generic-2.4.17/drivers/char/sysrq.c Fri Dec 21 09:41:54 2001
+++ sysrq-generic-2.4.17/drivers/char/sysrq.c   Thu Feb  7 17:59:18 2002
@@ -42,13 +42,14 @@
  void (*sysrq_power_off)(void);

  /* Loglevel sysrq handler */
-static void sysrq_handle_loglevel(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_loglevel(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         int i;
         i = key - '0';
         console_loglevel = 7;
         printk("Loglevel set to %d\n", i);
         console_loglevel = i;
+       return 0;
  }
  static struct sysrq_key_op sysrq_loglevel_op = {
         handler:        sysrq_handle_loglevel,
@@ -59,11 +60,12 @@

  /* SAK sysrq handler */
  #ifdef CONFIG_VT
-static void sysrq_handle_SAK(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_SAK(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         if (tty)
                 do_SAK(tty);
         reset_vc(fg_console);
+       return 0;
  }
  static struct sysrq_key_op sysrq_SAK_op = {
         handler:        sysrq_handle_SAK,
@@ -74,10 +76,11 @@


  /* unraw sysrq handler */
-static void sysrq_handle_unraw(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_unraw(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         if (kbd)
                 kbd->kbdmode = VC_XLATE;
+       return 0;
  }
  static struct sysrq_key_op sysrq_unraw_op = {
         handler:        sysrq_handle_unraw,
@@ -87,9 +90,10 @@


  /* reboot sysrq handler */
-static void sysrq_handle_reboot(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_reboot(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         machine_restart(NULL);
+       return 0;
  }
  static struct sysrq_key_op sysrq_reboot_op = {
         handler:        sysrq_handle_reboot,
@@ -217,10 +221,11 @@
         console_loglevel = orig_loglevel;
  }

-static void sysrq_handle_sync(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_sync(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         emergency_sync_scheduled = EMERG_SYNC;
         wakeup_bdflush();
+       return 0;
  }
  static struct sysrq_key_op sysrq_sync_op = {
         handler:        sysrq_handle_sync,
@@ -228,10 +233,11 @@
         action_msg:     "Emergency Sync",
  };

-static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         emergency_sync_scheduled = EMERG_REMOUNT;
         wakeup_bdflush();
+       return 0;
  }
  static struct sysrq_key_op sysrq_mountro_op = {
         handler:        sysrq_handle_mountro,
@@ -244,10 +250,11 @@

  /* SHOW SYSRQ HANDLERS BLOCK */

-static void sysrq_handle_showregs(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_showregs(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         if (pt_regs)
                 show_regs(pt_regs);
+       return 0;
  }
  static struct sysrq_key_op sysrq_showregs_op = {
         handler:        sysrq_handle_showregs,
@@ -256,9 +263,10 @@
  };


-static void sysrq_handle_showstate(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_showstate(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         show_state();
+       return 0;
  }
  static struct sysrq_key_op sysrq_showstate_op = {
         handler:        sysrq_handle_showstate,
@@ -267,9 +275,10 @@
  };


-static void sysrq_handle_showmem(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_showmem(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         show_mem();
+       return 0;
  }
  static struct sysrq_key_op sysrq_showmem_op = {
         handler:        sysrq_handle_showmem,
@@ -277,6 +286,73 @@
         action_msg:     "Show Memory",
  };

+void
+ask_to_kill(buf)
+{
+       char *p;
+       pid_t pid;
+       int errors;
+
+       for (p = buf; *p; p++) {
+               if (*p < '0' || *p > '9') {
+                       printk("Bad pid: %s\n", buf);
+                       return;
+               }
+       }
+       /* Okay, got a numeric string... */
+       for (p = buf, pid =0; *p; p++) {
+               pid *= 10;
+               pid += *p - '0';
+       }
+       errors = kill_proc(pid, SIGKILL, 1);
+       printk("kill: %d - returns %d\n", pid, errors);
+}
+int in_accumulate;
+char buf[128];
+
+static int
+accumulate_buf(char c)
+{
+       static int i = 0;
+
+       if (c == '\n' || c == '\r') {
+               buf[i] = '\0';
+               printk("\n");
+               ask_to_kill(buf);
+               in_accumulate = 0;
+               i = 0;
+               return 0;
+       }
+       if (c == '\b' || c == '\0177') { /* backspace or delete? */
+               if (i > 0) {
+                       i--;
+                       printk("\b \b");
+               }
+               return 1;
+       }
+       if (c == '\025') { /* ^U?  kill the whole entry */
+               i = 0;
+               printk("XXX\nenter pid to kill: ");
+               return 1;
+       }
+       buf[i++] = c;
+       printk("%c", c);
+       return 1;
+}
+
+
+static int sysrq_handle_nuke(int key, struct pt_regs *pt_regs,
+               struct kbd_struct *kbd, struct tty_struct *tty) {
+       printk("enter pid to kill: ");
+       in_accumulate = 1;
+       return 1;
+}
+static struct sysrq_key_op sysrq_nuke_op = {
+       handler:        sysrq_handle_nuke,
+       help_msg:       "Nuke",
+       action_msg:     "Nuke process",
+};
+
  /* SHOW SYSRQ HANDLERS BLOCK */


@@ -299,10 +375,11 @@
         }
  }

-static void sysrq_handle_term(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_term(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         send_sig_all(SIGTERM, 0);
         console_loglevel = 8;
+       return 0;
  }
  static struct sysrq_key_op sysrq_term_op = {
         handler:        sysrq_handle_term,
@@ -310,10 +387,11 @@
         action_msg:     "Terminate All Tasks",
  };

-static void sysrq_handle_kill(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_kill(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         send_sig_all(SIGKILL, 0);
         console_loglevel = 8;
+       return 0;
  }
  static struct sysrq_key_op sysrq_kill_op = {
         handler:        sysrq_handle_kill,
@@ -321,10 +399,11 @@
         action_msg:     "Kill All Tasks",
  };

-static void sysrq_handle_killall(int key, struct pt_regs *pt_regs,
+static int sysrq_handle_killall(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty) {
         send_sig_all(SIGKILL, 1);
         console_loglevel = 8;
+       return 0;
  }
  static struct sysrq_key_op sysrq_killall_op = {
         handler:        sysrq_handle_killall,
@@ -368,7 +447,7 @@
  #endif
  /* l */        &sysrq_killall_op,
  /* m */        &sysrq_showmem_op,
-/* n */        NULL,
+/* n */        &sysrq_nuke_op,
  /* o */        NULL, /* This will often be registered
                  as 'Off' at init time */
  /* p */        &sysrq_showregs_op,
@@ -431,14 +510,18 @@
   * and any other keycode arrives.
   */

-void handle_sysrq(int key, struct pt_regs *pt_regs,
-                 struct kbd_struct *kbd, struct tty_struct *tty) {
+int handle_sysrq(int key, struct pt_regs *pt_regs,
+                 struct kbd_struct *kbd, struct tty_struct *tty)
+{
+       int ret_val;
+
         if (!sysrq_enabled)
-               return;
+               return 0;

         __sysrq_lock_table();
-       __handle_sysrq_nolock(key, pt_regs, kbd, tty);
+       ret_val = __handle_sysrq_nolock(key, pt_regs, kbd, tty);
         __sysrq_unlock_table();
+       return ret_val;
  }

  /*
@@ -447,14 +530,20 @@
   * as they are inside of the lock
   */

-void __handle_sysrq_nolock(int key, struct pt_regs *pt_regs,
+int __handle_sysrq_nolock(int key, struct pt_regs *pt_regs,
                   struct kbd_struct *kbd, struct tty_struct *tty) {
         struct sysrq_key_op *op_p;
         int orig_log_level;
         int i, j;
+       int ret_val;

         if (!sysrq_enabled)
-               return;
+               return 0;
+
+       if (in_accumulate) {
+               ret_val = accumulate_buf(key);
+               return ret_val;
+       }

         orig_log_level = console_loglevel;
         console_loglevel = 7;
@@ -464,7 +553,7 @@
          if (op_p) {
                 printk ("%s\n", op_p->action_msg);
                 console_loglevel = orig_log_level;
-               op_p->handler(key, pt_regs, kbd, tty);
+               ret_val = op_p->handler(key, pt_regs, kbd, tty);
         } else {
                 printk("HELP : ");
                 /* Only print the help msg once per handler */
@@ -476,7 +565,9 @@
                 }
                 printk ("\n");
                 console_loglevel = orig_log_level;
+               ret_val = 0;
         }
+       return ret_val;
  }

  EXPORT_SYMBOL(handle_sysrq);
diff -ur generic-2.4.17/drivers/s390/char/ctrlchar.c 
sysrq-generic-2.4.17/drivers/s390/char/ctrlchar.c
--- generic-2.4.17/drivers/s390/char/ctrlchar.c Sun Sep 30 12:26:07 2001
+++ sysrq-generic-2.4.17/drivers/s390/char/ctrlchar.c   Thu Feb  7 17:59:18 
2002
@@ -26,7 +26,7 @@

  static void
  ctrlchar_handle_sysrq(struct tty_struct *tty) {
-       handle_sysrq(ctrlchar_sysrq_key, NULL, NULL, tty);
+       (void) handle_sysrq(ctrlchar_sysrq_key, NULL, NULL, tty);
  }
  #endif

diff -ur generic-2.4.17/drivers/tc/zs.c sysrq-generic-2.4.17/drivers/tc/zs.c
--- generic-2.4.17/drivers/tc/zs.c      Mon Aug 27 08:56:31 2001
+++ sysrq-generic-2.4.17/drivers/tc/zs.c        Thu Feb  7 17:59:18 2002
@@ -444,8 +444,12 @@
                 if (break_pressed && info->line == sercons.index) {
                         if (ch != 0 &&
                             time_before(jiffies, break_pressed + HZ*5)) {
-                               handle_sysrq(ch, regs, NULL, NULL);
-                               break_pressed = 0;
+                               if (!handle_sysrq(ch, regs, NULL, NULL)) {
+                                       break_pressed = 0;
+                               } else {
+                                       /* reset time-out! more data needed */
+                                       break_pressed = jiffies;
+                               }
                                 goto ignore_char;
                         }
                         break_pressed = 0;
diff -ur generic-2.4.17/include/linux/sysrq.h 
sysrq-generic-2.4.17/include/linux/sysrq.h
--- generic-2.4.17/include/linux/sysrq.h        Wed Jan 30 16:47:01 2002
+++ sysrq-generic-2.4.17/include/linux/sysrq.h  Thu Feb  7 17:59:18 2002
@@ -18,7 +18,7 @@
  struct tty_struct;

  struct sysrq_key_op {
-       void (*handler)(int, struct pt_regs *,
+       int (*handler)(int, struct pt_regs *,
                         struct kbd_struct *, struct tty_struct *);
         char *help_msg;
         char *action_msg;
@@ -29,9 +29,14 @@
  /* Generic SysRq interface -- you may call it from any device driver, 
supplying
   * ASCII code of the key, pointer to registers and kbd/tty structs (if they
   * are available -- else NULL's).
+ *
+ * Most sysrq's are single character commands, but to allow for multiple
+ * key-stroke input, handle_sysrq() returns true if the current command
+ * is collecting more input.  This matters to serial-based consoles which
+ * base the interpretation of the character on the proximity of the break.
   */

-void handle_sysrq(int, struct pt_regs *,
+int handle_sysrq(int, struct pt_regs *,
                 struct kbd_struct *, struct tty_struct *);


@@ -40,7 +45,7 @@
   * call sysrq handlers
   */

-void __handle_sysrq_nolock(int, struct pt_regs *,
+int __handle_sysrq_nolock(int, struct pt_regs *,
                  struct kbd_struct *, struct tty_struct *);




