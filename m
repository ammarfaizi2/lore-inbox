Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274845AbRIUVlQ>; Fri, 21 Sep 2001 17:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274844AbRIUVlH>; Fri, 21 Sep 2001 17:41:07 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:3342 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S274842AbRIUVk7>; Fri, 21 Sep 2001 17:40:59 -0400
Date: Fri, 21 Sep 2001 17:41:23 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Linus <torvalds@transmeta.com>
Subject: [PATCH] Magic SysRq loglevel fix.
Message-ID: <20010921174123.K8188@mueller.datastacks.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Alan <alan@lxorguk.ukuu.org.uk>, Linus <torvalds@transmeta.com>
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org> <20010921170828.J8188@mueller.datastacks.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010921170828.J8188@mueller.datastacks.com>; from crutcher@datastacks.com on Fri, Sep 21, 2001 at 05:08:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a fix for this part of the sysrq code.

++ 21/09/01 17:08 -0400 - Crutcher Dunnavant:
> ++ 19/09/01 08:56 -0700 - Randy.Dunlap:
> > It always sets console_loglevel and then restores
> > console_loglevel from orig_log_level, so Alt+SysRq+#
> > handling is severely broken.
> > 
> > If someone (Crutcher ?) wants to patch it, that's fine.
> > If I patched it, I would just add a
> >   next_loglevel = -1;
> > at the beginning of __handle_sysrq_nolock() and then
> > let the loglevel handler(s) set next_loglevel.
> > If next_loglevel != -1 at the end of __handle_sysrq_nolock(),
> > set console_loglevel to next_loglevel.
> 
> I'm looking real close at this right now, and there are a couple of
> problems, and a simple, but ugly solution.
> 
> The entire reason that console_loglevel is touched _after_ the call to
> the second level handler is actually for the loglevel handler's
> printout. I was trying to minimize change in the display, but horked it.
> 
> Here is the problem.
> 
> SysRq events use action messages which get printed by the top level
> handler before calling the second level handler, the call line is:
> 
>         orig_log_level = console_loglevel;
>         console_loglevel = 7;
>         printk(KERN_INFO "SysRq : ");
> 
>         op_p = __sysrq_get_key_op(key);
> 	...
>         printk ("%s", op_p->action_msg);
>         op_p->handler(key, pt_regs, kbd, tty);
> 	...
>         console_loglevel = orig_log_level;
> 
> 
> The killer here is the fact that the action message format string does
> not carry a newline, allowing people to register strings which leave the
> printk state open. The loglevel handler then fills in the loglevel, and
> closes the printk state.
> 
> There was a time when I thought that was a good idea.
> 
> Go ahead, laugh.
> 
> Anyway, that sort of unresolved state is bad, and is the source of all
> of this song and dance. I think the right answer is to force handlers to
> open their own calls to printk, and to keep whats going on with the
> console_loglevel and printk buffer nice and clean.
> 
> The cost is that messages like this:
> 
> SysRq : Loglevel switched to X
> 
> will have to become more like this:
> 
> SysRq : Loglevel
> Loglevel switched to X
> 
> 
> Again, appologies, and a patch is forthcoming.

And here is the patch.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$

--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Description: patch-2.4.10-pre13-sysrq_log_level
Content-Disposition: attachment; filename="patch-2.4.10-pre13-sysrq_log_level"

--- linux-2.4.10-pre13/drivers/char/sysrq.c.sysrq_log_level	Fri Sep 21 17:25:45 2001
+++ linux-2.4.10-pre13/drivers/char/sysrq.c	Fri Sep 21 17:25:55 2001
@@ -47,13 +47,13 @@
 	int i;
 	i = key - '0';
 	console_loglevel = 7;
-	printk("%d\n", i);
+	printk("Loglevel set to %d\n", i);
 	console_loglevel = i;
 }	
 static struct sysrq_key_op sysrq_loglevel_op = {
 	handler:	sysrq_handle_loglevel,
 	help_msg:	"loglevel0-8",
-	action_msg:	"Loglevel set to ",
+	action_msg:	"Changing Loglevel",
 };
 
 
@@ -68,7 +68,7 @@
 static struct sysrq_key_op sysrq_SAK_op = {
 	handler:	sysrq_handle_SAK,
 	help_msg:	"saK",
-	action_msg:	"SAK\n",
+	action_msg:	"SAK",
 };
 #endif
 
@@ -82,7 +82,7 @@
 static struct sysrq_key_op sysrq_unraw_op = {
 	handler:	sysrq_handle_unraw,
 	help_msg:	"unRaw",
-	action_msg:	"Keyboard mode set to XLATE\n",
+	action_msg:	"Keyboard mode set to XLATE",
 };
 
 
@@ -94,7 +94,7 @@
 static struct sysrq_key_op sysrq_reboot_op = {
 	handler:	sysrq_handle_reboot,
 	help_msg:	"reBoot",
-	action_msg:	"Resetting\n",
+	action_msg:	"Resetting",
 };
 
 
@@ -225,7 +225,7 @@
 static struct sysrq_key_op sysrq_sync_op = {
 	handler:	sysrq_handle_sync,
 	help_msg:	"Sync",
-	action_msg:	"Emergency Sync\n",
+	action_msg:	"Emergency Sync",
 };
 
 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
@@ -236,7 +236,7 @@
 static struct sysrq_key_op sysrq_mountro_op = {
 	handler:	sysrq_handle_mountro,
 	help_msg:	"Unmount",
-	action_msg:	"Emergency Remount R/0\n",
+	action_msg:	"Emergency Remount R/0",
 };
 
 /* END SYNC SYSRQ HANDLERS BLOCK */
@@ -252,7 +252,7 @@
 static struct sysrq_key_op sysrq_showregs_op = {
 	handler:	sysrq_handle_showregs,
 	help_msg:	"showPc",
-	action_msg:	"Show Regs\n",
+	action_msg:	"Show Regs",
 };
 
 
@@ -263,7 +263,7 @@
 static struct sysrq_key_op sysrq_showstate_op = {
 	handler:	sysrq_handle_showstate,
 	help_msg:	"showTasks",
-	action_msg:	"Show State\n",
+	action_msg:	"Show State",
 };
 
 
@@ -274,7 +274,7 @@
 static struct sysrq_key_op sysrq_showmem_op = {
 	handler:	sysrq_handle_showmem,
 	help_msg:	"showMem",
-	action_msg:	"Show Memory\n",
+	action_msg:	"Show Memory",
 };
 
 /* SHOW SYSRQ HANDLERS BLOCK */
@@ -307,7 +307,7 @@
 static struct sysrq_key_op sysrq_term_op = {
 	handler:	sysrq_handle_term,
 	help_msg:	"tErm",
-	action_msg:	"Terminate All Tasks\n",
+	action_msg:	"Terminate All Tasks",
 };
 
 static void sysrq_handle_kill(int key, struct pt_regs *pt_regs,
@@ -318,7 +318,7 @@
 static struct sysrq_key_op sysrq_kill_op = {
 	handler:	sysrq_handle_kill,
 	help_msg:	"kIll",
-	action_msg:	"Kill All Tasks\n",
+	action_msg:	"Kill All Tasks",
 };
 
 static void sysrq_handle_killall(int key, struct pt_regs *pt_regs,
@@ -329,7 +329,7 @@
 static struct sysrq_key_op sysrq_killall_op = {
 	handler:	sysrq_handle_killall,
 	help_msg:	"killalL",
-	action_msg:	"Kill All Tasks (even init)\n",
+	action_msg:	"Kill All Tasks (even init)",
 };
 
 /* END SIGNAL SYSRQ HANDLERS BLOCK */
@@ -462,8 +462,9 @@
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
-                printk ("%s", op_p->action_msg);
-                op_p->handler(key, pt_regs, kbd, tty);
+		printk ("%s\n", op_p->action_msg);
+		console_loglevel = orig_log_level;
+		op_p->handler(key, pt_regs, kbd, tty);
 	} else {
 		printk("HELP : ");
 		/* Only print the help msg once per handler */
@@ -474,8 +475,8 @@
 				printk ("%s ", sysrq_key_table[i]->help_msg);
 		}
 		printk ("\n");
+		console_loglevel = orig_log_level;
 	}
-	console_loglevel = orig_log_level;
 }
 
 EXPORT_SYMBOL(handle_sysrq);

--0lnxQi9hkpPO77W3--
