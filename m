Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263315AbUJ2NhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbUJ2NhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbUJ2NhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:37:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19073 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263315AbUJ2Nf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:35:28 -0400
Date: Fri, 29 Oct 2004 15:35:27 +0200
From: Jan Kara <jack@suse.cz>
To: M?ns Rullg?rd <mru@inprovide.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-ID: <20041029133527.GA25172@atrey.karlin.mff.cuni.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041029024651.1ebadf82.akpm@osdl.org> <yw1xu0sdiwr2.fsf@inprovide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <yw1xu0sdiwr2.fsf@inprovide.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Andrew Morton <akpm@osdl.org> writes:
> 
> > Jan Kara <jack@suse.cz> wrote:
> >>
> >>    I know about a few people who would like to use some functionality of
> >>  the Magic Sysrq but don't want to enable all the functions it provides.
> >
> > That's a new one.  Can you tell us more about why people want to do such a
> > thing?
> >
> >>  So I wrote a patch which should allow them to do so. It allows to
> >>  configure available functions of Sysrq via /proc/sys/kernel/sysrq (the
> >>  interface is backward compatible). If you think it's useful then use it :)
> >>  Andrew, do you think it can go into mainline or it's just an overdesign?
> >
> > Patch looks reasonable - we just need to decide whether the requirement
> > warrants its inclusion.
> >
> > There have been a few changes in the sysrq code since 2.6.9 and there are
> > more changes queued up in -mm.  The patch applies OK, but it'll need
> > checking and redoing.  There's a new `sysrq-f' command in the pipeline
> > which causes a manual oom-killer call.
> 
> See also the patch I just posted to lkml.
  OK, Andrew, are you accepting the patch? The sysrq should probably go
into SYSRQ_ENABLE_SIGNAL group...

> I also thought of an improved way of selecting keys to enable.
> Instead of an arbitrary bitmask, would it be possible to simply list
> the keys you want to enable, such as "echo sku > /proc/sys/kernel/sysrq"?
  That would be possible of course but you'd have to do your own parsing
in kernel and you are not supposed to change the sysrq setting often - usually
just compute your favourite number, put it into boot scripts and you're
done. So I'm not convinced it's useful very much. The attached patch is
against 2.6.10-rc1-mm1 (I also added poweroff to SYSRQ_ENABLE_BOOT group
of functions).

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="enable-sysrq-2.6.10-rc1-mm1.diff"

Implement enabling of specific sysrq functions.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -ru linux-2.6.10-rc1-mm1/Documentation/sysrq.txt linux-2.6.10-rc1-mm1-sysrq/Documentation/sysrq.txt
--- linux-2.6.10-rc1-mm1/Documentation/sysrq.txt	2004-10-29 14:43:29.828759600 +0200
+++ linux-2.6.10-rc1-mm1-sysrq/Documentation/sysrq.txt	2004-10-29 15:05:41.415327672 +0200
@@ -10,13 +10,28 @@
 *  How do I enable the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 You need to say "yes" to 'Magic SysRq key (CONFIG_MAGIC_SYSRQ)' when
-configuring the kernel. When running on a kernel with SysRq compiled in, it
-may be DISABLED at run-time using following command:
+configuring the kernel. When running a kernel with SysRq compiled in,
+/proc/sys/kernel/sysrq controls the functions allowed to be invoked via
+the SysRq key. By default the file contains 1 which means that every
+possible SysRq request is allowed (in older versions SysRq was disabled
+by default, and you were required to specifically enable it at run-time
+but this is not the case any more). Here is the list of possible values
+in /proc/sys/kernel/sysrq:
+   0 - disable sysrq completely
+   1 - enable all functions of sysrq
+  >1 - bitmask of allowed sysrq functions (see below for detailed function
+       description):
+          2 - enable control of console logging level
+          4 - enable control of keyboard (SAK, unraw)
+          8 - enable debugging dumps of processes etc.
+         16 - enable sync command
+         32 - enable remount read-only
+         64 - enable signalling of processes (term, kill, oom-kill)
+        128 - allow reboot/poweroff
+        256 - allow entering KGDB via sysrq
 
-        echo "0" > /proc/sys/kernel/sysrq
-
-Note that previous versions disabled sysrq by default, and you were required
-to specifically enable it at run-time. That is not the case any longer.
+You can set the value in the file by the following command:
+    echo "number" >/proc/sys/kernel/sysrq
 
 *  How do I use the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff -ru linux-2.6.10-rc1-mm1/drivers/char/sysrq.c linux-2.6.10-rc1-mm1-sysrq/drivers/char/sysrq.c
--- linux-2.6.10-rc1-mm1/drivers/char/sysrq.c	2004-10-29 14:43:33.399216808 +0200
+++ linux-2.6.10-rc1-mm1-sysrq/drivers/char/sysrq.c	2004-10-29 14:59:08.513057896 +0200
@@ -35,6 +35,15 @@
 #include <linux/spinlock.h>
 
 #include <asm/ptrace.h>
+
+extern void reset_vc(unsigned int);
+
+/* Whether we react on sysrq keys or just ignore them */
+int sysrq_enabled = 1;
+
+/* Machine specific power off function */
+void (*sysrq_power_off)(void);
+
 #ifdef CONFIG_KGDB_SYSRQ
 
 #define  GDB_OP &kgdb_op
@@ -48,21 +57,13 @@
 	.handler	= kgdb_sysrq,
 	.help_msg	= "kGdb|Fgdb",
 	.action_msg	= "Debug breakpoint\n",
+	.enable_mask	= SYSRQ_ENABLE_BREAKPOINT,
 };
 
 #else
 #define  GDB_OP NULL
 #endif
 
-
-extern void reset_vc(unsigned int);
-
-/* Whether we react on sysrq keys or just ignore them */
-int sysrq_enabled = 1;
-
-/* Machine specific power off function */
-void (*sysrq_power_off)(void);
-
 /* Loglevel sysrq handler */
 static void sysrq_handle_loglevel(int key, struct pt_regs *pt_regs,
 				  struct tty_struct *tty) 
@@ -77,6 +78,7 @@
 	.handler	= sysrq_handle_loglevel,
 	.help_msg	= "loglevel0-8",
 	.action_msg	= "Changing Loglevel",
+	.enable_mask	= SYSRQ_ENABLE_LOG,
 };
 
 
@@ -93,6 +95,7 @@
 	.handler	= sysrq_handle_SAK,
 	.help_msg	= "saK",
 	.action_msg	= "SAK",
+	.enable_mask	= SYSRQ_ENABLE_KEYBOARD,
 };
 #endif
 
@@ -110,6 +113,7 @@
 	.handler	= sysrq_handle_unraw,
 	.help_msg	= "unRaw",
 	.action_msg	= "Keyboard mode set to XLATE",
+	.enable_mask	= SYSRQ_ENABLE_KEYBOARD,
 };
 #endif /* CONFIG_VT */
 
@@ -124,6 +128,7 @@
 	.handler	= sysrq_handle_reboot,
 	.help_msg	= "reBoot",
 	.action_msg	= "Resetting",
+	.enable_mask	= SYSRQ_ENABLE_BOOT,
 };
 
 static void sysrq_handle_sync(int key, struct pt_regs *pt_regs,
@@ -136,6 +141,7 @@
 	.handler	= sysrq_handle_sync,
 	.help_msg	= "Sync",
 	.action_msg	= "Emergency Sync",
+	.enable_mask	= SYSRQ_ENABLE_SYNC,
 };
 
 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
@@ -148,6 +154,7 @@
 	.handler	= sysrq_handle_mountro,
 	.help_msg	= "Unmount",
 	.action_msg	= "Emergency Remount R/O",
+	.enable_mask	= SYSRQ_ENABLE_REMOUNT,
 };
 
 /* END SYNC SYSRQ HANDLERS BLOCK */
@@ -165,6 +172,7 @@
 	.handler	= sysrq_handle_showregs,
 	.help_msg	= "showPc",
 	.action_msg	= "Show Regs",
+	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
 
 
@@ -177,6 +185,7 @@
 	.handler	= sysrq_handle_showstate,
 	.help_msg	= "showTasks",
 	.action_msg	= "Show State",
+	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
 
 
@@ -189,6 +198,7 @@
 	.handler	= sysrq_handle_showmem,
 	.help_msg	= "showMem",
 	.action_msg	= "Show Memory",
+	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
 
 /* SHOW SYSRQ HANDLERS BLOCK */
@@ -219,6 +229,7 @@
 	.handler	= sysrq_handle_term,
 	.help_msg	= "tErm",
 	.action_msg	= "Terminate All Tasks",
+	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
 
 static void sysrq_handle_moom(int key, struct pt_regs *pt_regs,
@@ -231,6 +242,7 @@
 	.handler	= sysrq_handle_moom,
 	.help_msg	= "Full",
 	.action_msg	= "Manual OOM execution",
+	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
 
 static void sysrq_handle_kill(int key, struct pt_regs *pt_regs,
@@ -243,6 +255,7 @@
 	.handler	= sysrq_handle_kill,
 	.help_msg	= "kIll",
 	.action_msg	= "Kill All Tasks",
+	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
 
 /* END SIGNAL SYSRQ HANDLERS BLOCK */
@@ -362,9 +375,13 @@
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
-		printk ("%s\n", op_p->action_msg);
-		console_loglevel = orig_log_level;
-		op_p->handler(key, pt_regs, tty);
+		if (sysrq_enabled == 1 || sysrq_enabled & op_p->enable_mask) {
+			printk ("%s\n", op_p->action_msg);
+			console_loglevel = orig_log_level;
+			op_p->handler(key, pt_regs, tty);
+		}
+		else
+			printk("This sysrq operation is disabled.\n");
 	} else {
 		printk("HELP : ");
 		/* Only print the help msg once per handler */
diff -ru linux-2.6.10-rc1-mm1/include/linux/sysrq.h linux-2.6.10-rc1-mm1-sysrq/include/linux/sysrq.h
--- linux-2.6.10-rc1-mm1/include/linux/sysrq.h	2004-10-18 23:53:06.000000000 +0200
+++ linux-2.6.10-rc1-mm1-sysrq/include/linux/sysrq.h	2004-10-29 15:00:57.528485032 +0200
@@ -16,10 +16,22 @@
 struct pt_regs;
 struct tty_struct;
 
+/* Possible values of bitmask for enabling sysrq functions */
+/* 0x0001 is reserved for enable everything */
+#define SYSRQ_ENABLE_LOG	0x0002
+#define SYSRQ_ENABLE_KEYBOARD	0x0004
+#define SYSRQ_ENABLE_DUMP	0x0008
+#define SYSRQ_ENABLE_SYNC	0x0010
+#define SYSRQ_ENABLE_REMOUNT	0x0020
+#define SYSRQ_ENABLE_SIGNAL	0x0040
+#define SYSRQ_ENABLE_BOOT	0x0080
+#define SYSRQ_ENABLE_BREAKPOINT	0x0100
+
 struct sysrq_key_op {
 	void (*handler)(int, struct pt_regs *, struct tty_struct *);
 	char *help_msg;
 	char *action_msg;
+	int enable_mask;
 };
 
 #ifdef CONFIG_MAGIC_SYSRQ
diff -ru linux-2.6.10-rc1-mm1/kernel/power/poweroff.c linux-2.6.10-rc1-mm1-sysrq/kernel/power/poweroff.c
--- linux-2.6.10-rc1-mm1/kernel/power/poweroff.c	2004-10-18 23:54:08.000000000 +0200
+++ linux-2.6.10-rc1-mm1-sysrq/kernel/power/poweroff.c	2004-10-29 15:03:01.228679744 +0200
@@ -32,7 +32,8 @@
 static struct sysrq_key_op	sysrq_poweroff_op = {
 	.handler        = handle_poweroff,
 	.help_msg       = "powerOff",
-	.action_msg     = "Power Off\n"
+	.action_msg     = "Power Off\n",
+	.enable_mask	= SYSRQ_ENABLE_BOOT,
 };
 
 static int pm_sysrq_init(void)

--BXVAT5kNtrzKuDFl--
