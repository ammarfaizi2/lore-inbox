Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754123AbWKGIus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbWKGIus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 03:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbWKGIus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 03:50:48 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:1558 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1754123AbWKGIur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 03:50:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=HxNiwGMHtnwkSxbqZ6tM112tvaN5fXbBukMk3DhZm1rE51mtVUCbuz12CxkDNk2SorCgONTnrYvp9KVZjupseVEhEm//H76sYIgUeG/cXeo02PeFtdtDjSWOrM+1S2p01uTgn2M/CPu6UxpIG1hqju7cR3r35CsZCZ7/JPOBL/Q=
Date: Tue, 7 Nov 2006 17:50:40 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] export die_counter as /proc/sys/kernel/oops-counter
Message-ID: <20061107085040.GA9150@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture specific function die() stores the value of
how many times oops happened into its local static variable
die_counter.

This patch exports the die_counter as /proc/sys/kernel/oops-counter.

Example usage: Display oops-counter in Tray Icon

#! /usr/bin/python
import pygtk
pygtk.require("2.0")
import gtk
import egg.trayicon
import gobject

def oops_count():
	return int(open("/proc/sys/kernel/oops-counter", "r").readline())

def update_oops_count(t):
	t.get_children()[0].set_text("Oops: " + str(oops_count()))
	gobject.timeout_add(1000, update_oops_count, t)

t = egg.trayicon.TrayIcon("OopsCounter")
t.add(gtk.Label("Oops: " + str(oops_count())))
gobject.timeout_add(1000, update_oops_count, t)
t.show_all()
gtk.main()


Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 Documentation/sysctl/kernel.txt |    7 +++++++
 arch/i386/kernel/traps.c        |    3 +--
 arch/x86_64/kernel/traps.c      |    3 +--
 include/linux/kernel.h          |    1 +
 include/linux/sysctl.h          |    1 +
 kernel/panic.c                  |    2 ++
 kernel/sysctl.c                 |    8 ++++++++
 7 files changed, 21 insertions(+), 4 deletions(-)

Index: 2.6-git/include/linux/kernel.h
===================================================================
--- 2.6-git.orig/include/linux/kernel.h
+++ 2.6-git/include/linux/kernel.h
@@ -193,6 +193,7 @@ extern int panic_on_unrecovered_nmi;
 extern int tainted;
 extern const char *print_tainted(void);
 extern void add_taint(unsigned);
+extern int oops_counter;
 
 /* Values used for system_state */
 extern enum system_states {
Index: 2.6-git/kernel/panic.c
===================================================================
--- 2.6-git.orig/kernel/panic.c
+++ 2.6-git/kernel/panic.c
@@ -22,6 +22,7 @@
 
 int panic_on_oops;
 int tainted;
+int oops_counter;
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -258,6 +259,7 @@ int oops_may_print(void)
  */
 void oops_enter(void)
 {
+	++oops_counter;
 	debug_locks_off(); /* can't trust the integrity of the kernel anymore */
 	do_oops_enter_exit();
 }
Index: 2.6-git/arch/i386/kernel/traps.c
===================================================================
--- 2.6-git.orig/arch/i386/kernel/traps.c
+++ 2.6-git/arch/i386/kernel/traps.c
@@ -452,7 +452,6 @@ void die(const char * str, struct pt_reg
 		.lock_owner =		-1,
 		.lock_owner_depth =	0
 	};
-	static int die_counter;
 	unsigned long flags;
 
 	oops_enter();
@@ -473,7 +472,7 @@ void die(const char * str, struct pt_reg
 		unsigned short ss;
 
 		handle_BUG(regs);
-		printk(KERN_EMERG "%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
+		printk(KERN_EMERG "%s: %04lx [#%d]\n", str, err & 0xffff, oops_counter);
 #ifdef CONFIG_PREEMPT
 		printk(KERN_EMERG "PREEMPT ");
 		nl = 1;
Index: 2.6-git/arch/x86_64/kernel/traps.c
===================================================================
--- 2.6-git.orig/arch/x86_64/kernel/traps.c
+++ 2.6-git/arch/x86_64/kernel/traps.c
@@ -579,8 +579,7 @@ void __kprobes oops_end(unsigned long fl
 
 void __kprobes __die(const char * str, struct pt_regs * regs, long err)
 {
-	static int die_counter;
-	printk(KERN_EMERG "%s: %04lx [%u] ", str, err & 0xffff,++die_counter);
+	printk(KERN_EMERG "%s: %04lx [%u] ", str, err & 0xffff, oops_counter);
 #ifdef CONFIG_PREEMPT
 	printk("PREEMPT ");
 #endif
Index: 2.6-git/include/linux/sysctl.h
===================================================================
--- 2.6-git.orig/include/linux/sysctl.h
+++ 2.6-git/include/linux/sysctl.h
@@ -160,6 +160,7 @@ enum
 	KERN_MAX_LOCK_DEPTH=74,
 	KERN_NMI_WATCHDOG=75, /* int: enable/disable nmi watchdog */
 	KERN_PANIC_ON_NMI=76, /* int: whether we will panic on an unrecovered */
+	KERN_OOPS_COUNTER=77, /* int: oops counter */
 };
 
 
Index: 2.6-git/kernel/sysctl.c
===================================================================
--- 2.6-git.orig/kernel/sysctl.c
+++ 2.6-git/kernel/sysctl.c
@@ -768,6 +768,14 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_OOPS_COUNTER,
+		.procname	= "oops-counter",
+		.data		= &oops_counter,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
 
 	{ .ctl_name = 0 }
 };
Index: 2.6-git/Documentation/sysctl/kernel.txt
===================================================================
--- 2.6-git.orig/Documentation/sysctl/kernel.txt
+++ 2.6-git/Documentation/sysctl/kernel.txt
@@ -32,6 +32,7 @@ show up in /proc/sys/kernel:
 - msgmax
 - msgmnb
 - msgmni
+- oops-counter
 - osrelease
 - ostype
 - overflowgid
@@ -170,6 +171,12 @@ This flag controls the L2 cache of G3 pr
 
 ==============================================================
 
+oops-counter: 
+
+The number of oops-counter shows how many times oops happened.
+
+==============================================================
+
 osrelease, ostype & version:
 
 # cat osrelease
