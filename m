Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271645AbRISSWW>; Wed, 19 Sep 2001 14:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272677AbRISSWD>; Wed, 19 Sep 2001 14:22:03 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:24842 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S272528AbRISSVz>; Wed, 19 Sep 2001 14:21:55 -0400
Message-ID: <3BA8E1F3.3A32ECF7@osdlab.org>
Date: Wed, 19 Sep 2001 11:20:35 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>, Linus <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
Content-Type: multipart/mixed;
 boundary="------------690ABC80A822894259391443"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------690ABC80A822894259391443
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Same patch as previous, just adding "[PATCH]"
in Subject: line and adding info that Keith Owens's
sysrq.c patch also needs to be applied with this one.

Keith's patch will cause some small offsets and fuzz also.

~Randy

-------- Original Message --------
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
Date: Wed, 19 Sep 2001 11:02:33 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: crutcher+kernel@datastacks.com, lkml
<linux-kernel@vger.kernel.org>
In-Reply-To: <E15jkR4-0003Fg-00@the-village.bc.nu>

Alan Cox wrote:
> 
> > Anyway, in looking at SysRq loglevel handling in
> > 2.4.9-ac (and 2.4.10-pre12), I see that it has been modified
> > quite a bit.  Looks extensible, which can be good.
> > However, looking over it gave me several nagging questions
> > and problems.
> >
> > If someone (Crutcher ?) wants to patch it, that's fine.
> > If I patched it, I would just add a
> >   next_loglevel = -1;
> > at the beginning of __handle_sysrq_nolock() and then
> > let the loglevel handler(s) set next_loglevel.
> > If next_loglevel != -1 at the end of __handle_sysrq_nolock(),
> > set console_loglevel to next_loglevel.
> 
> Send me a patch and cc Linus/Crutcher

Here's a patch to fix SysRq handling of console_loglevel.

Please apply to 2.4.10-pre12 and to 2.4.9-ac12.

Thanks,
~Randy
--------------690ABC80A822894259391443
Content-Type: text/plain; charset=us-ascii;
 name="sysrq-ll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrq-ll.patch"

--- linux/drivers/char/sysrq.c.org	Mon Sep 17 10:15:48 2001
+++ linux/drivers/char/sysrq.c	Wed Sep 19 10:15:12 2001
@@ -39,6 +39,8 @@
 /* Whether we react on sysrq keys or just ignore them */
 int sysrq_enabled = 1;
 
+static int entry_loglevel, next_loglevel;
+
 /* Machine specific power off function */
 void (*sysrq_power_off)(void);
 
@@ -47,13 +49,13 @@
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	int i;
 	i = key - '0';
-	console_loglevel = 7;
 	printk("%d\n", i);
-	console_loglevel = i;
-}	
+	next_loglevel = i;
+}
+
 static struct sysrq_key_op sysrq_loglevel_op = {
 	handler:	sysrq_handle_loglevel,
-	help_msg:	"loglevel0-8",
+	help_msg:	"loglevel0-9",
 	action_msg:	"Loglevel set to ",
 };
 
@@ -66,6 +68,7 @@
 		do_SAK(tty);
 	reset_vc(fg_console);
 }
+
 static struct sysrq_key_op sysrq_SAK_op = {
 	handler:	sysrq_handle_SAK,
 	help_msg:	"saK",
@@ -137,9 +140,6 @@
 /* do_emergency_sync helper function */
 static void go_sync(struct super_block *sb, int remount_flag)
 {
-	int orig_loglevel;
-	orig_loglevel = console_loglevel;
-	console_loglevel = 7;
 	printk(KERN_INFO "%sing device %s ... ",
 	       remount_flag ? "Remount" : "Sync",
 	       kdevname(sb->s_dev));
@@ -178,7 +178,6 @@
 		fsync_dev(sb->s_dev);
 		printk("OK\n");
 	}
-	console_loglevel = orig_loglevel;
 }
 /*
  * Emergency Sync or Unmount. We cannot do it directly, so we set a special
@@ -192,7 +191,6 @@
 void do_emergency_sync(void) {
 	struct super_block *sb;
 	int remount_flag;
-	int orig_loglevel;
 
 	lock_kernel();
 	remount_flag = (emergency_sync_scheduled == EMERG_REMOUNT);
@@ -211,11 +209,7 @@
 			go_sync(sb, remount_flag);
 
 	unlock_kernel();
-
-	orig_loglevel = console_loglevel;
-	console_loglevel = 7;
 	printk(KERN_INFO "Done.\n");
-	console_loglevel = orig_loglevel;
 }
 
 static void sysrq_handle_sync(int key, struct pt_regs *pt_regs,
@@ -223,6 +217,7 @@
 	emergency_sync_scheduled = EMERG_SYNC;
 	wakeup_bdflush(0);
 }
+
 static struct sysrq_key_op sysrq_sync_op = {
 	handler:	sysrq_handle_sync,
 	help_msg:	"Sync",
@@ -250,6 +245,7 @@
 	if (pt_regs)
 		show_regs(pt_regs);
 }
+
 static struct sysrq_key_op sysrq_showregs_op = {
 	handler:	sysrq_handle_showregs,
 	help_msg:	"showPc",
@@ -261,6 +257,7 @@
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	show_state();
 }
+
 static struct sysrq_key_op sysrq_showstate_op = {
 	handler:	sysrq_handle_showstate,
 	help_msg:	"showTasks",
@@ -272,6 +269,7 @@
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	show_mem();
 }
+
 static struct sysrq_key_op sysrq_showmem_op = {
 	handler:	sysrq_handle_showmem,
 	help_msg:	"showMem",
@@ -303,8 +301,9 @@
 static void sysrq_handle_term(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	send_sig_all(SIGTERM, 0);
-	console_loglevel = 8;
+	next_loglevel = 8;
 }
+
 static struct sysrq_key_op sysrq_term_op = {
 	handler:	sysrq_handle_term,
 	help_msg:	"tErm",
@@ -314,8 +313,9 @@
 static void sysrq_handle_kill(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	send_sig_all(SIGKILL, 0);
-	console_loglevel = 8;
+	next_loglevel = 8;
 }
+
 static struct sysrq_key_op sysrq_kill_op = {
 	handler:	sysrq_handle_kill,
 	help_msg:	"kIll",
@@ -325,8 +325,9 @@
 static void sysrq_handle_killall(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	send_sig_all(SIGKILL, 1);
-	console_loglevel = 8;
+	next_loglevel = 8;
 }
+
 static struct sysrq_key_op sysrq_killall_op = {
 	handler:	sysrq_handle_killall,
 	help_msg:	"killalL",
@@ -381,7 +382,7 @@
 /* v */	NULL,
 /* w */	NULL,
 /* x */	NULL,
-/* w */	NULL,
+/* y */	NULL,
 /* z */	NULL
 };
 
@@ -434,6 +435,7 @@
 
 void handle_sysrq(int key, struct pt_regs *pt_regs,
 		  struct kbd_struct *kbd, struct tty_struct *tty) {
+
 	if (!sysrq_enabled)
 		return;
 
@@ -451,13 +453,13 @@
 void __handle_sysrq_nolock(int key, struct pt_regs *pt_regs,
 		  struct kbd_struct *kbd, struct tty_struct *tty) {
 	struct sysrq_key_op *op_p;
-	int orig_log_level;
 	int i, j;
 	
 	if (!sysrq_enabled)
 		return;
 
-	orig_log_level = console_loglevel;
+	entry_loglevel = console_loglevel;
+	next_loglevel = -1;
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq : ");
 
@@ -476,7 +478,7 @@
 		}
 		printk ("\n");
 	}
-	console_loglevel = orig_log_level;
+	console_loglevel = (next_loglevel == -1) ? entry_loglevel : next_loglevel;
 }
 
 EXPORT_SYMBOL(handle_sysrq);

--------------690ABC80A822894259391443--

