Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVCYHgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVCYHgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVCYHgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:36:22 -0500
Received: from everest.2mbit.com ([24.123.221.2]:43691 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261502AbVCYHgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:36:12 -0500
Date: Fri, 25 Mar 2005 02:36:11 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, james4765@cwazy.co.uk
Subject: Re: [patch] oom-killer sysrq-f fix
Message-ID: <20050325073611.GA2510@everest.sosdg.org>
Reply-To: coywolf@gmail.com
References: <20050325003316.GA31352@everest.sosdg.org> <20050324164435.4286ac5f.akpm@osdl.org> <424363BB.80207@lovecn.org> <20050324172127.110e9dd4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324172127.110e9dd4.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 05:21:27PM -0800, Andrew Morton wrote:
> Coywolf Qi Hunt <coywolf@lovecn.org> wrote:
> >
> > >>--- 2.6.12-rc1-mm2/mm/oom_kill.c	2005-03-03 17:12:18.000000000 +0800
> > >>+++ 2.6.12-rc1-mm2-cy/mm/oom_kill.c	2005-03-25 08:07:19.000000000 +0800
> > >>@@ -20,6 +20,7 @@
> > >> #include <linux/swap.h>
> > >> #include <linux/timex.h>
> > >> #include <linux/jiffies.h>
> > >>+#include <linux/hardirq.h>
> > >> 
> > >> /* #define DEBUG */
> > >> 
> > >>@@ -283,6 +284,9 @@ retry:
> > >> 	if (mm)
> > >> 		mmput(mm);
> > >> 
> > >>+	if (in_interrupt())
> > >>+		return;
> > > 
> > > 
> > > That'll make the whole feature a no-op, won't it?
> > 
> > It won't be a no-op. I have tested it. It works well.
> > I pressed sysrq-f, loging bash got killed and I had to re-login.

s/loging bash/login bash/

> 
> (looks)
> 
> OK.  But the patch is still deadlocky because we do task_lock() from
> interrupt context.

Yes, it's deadlocky, but hardly observable in practice. SysRq is just
"taking the risk yourself" to users.

OK, the following patch put moom into workqueue.
Do you agree to put sysrq-e and sysrq-i into workqueue too?
send_sig_all() should do task_lock() too. 

Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
---

diff -pruN 2.6.12-rc1-mm2/drivers/char/sysrq.c 2.6.12-rc1-mm2-cy/drivers/char/sysrq.c
--- 2.6.12-rc1-mm2/drivers/char/sysrq.c	2005-03-25 05:21:39.000000000 +0800
+++ 2.6.12-rc1-mm2-cy/drivers/char/sysrq.c	2005-03-25 13:28:33.000000000 +0800
@@ -34,6 +34,7 @@
 #include <linux/swap.h>
 #include <linux/spinlock.h>
 #include <linux/vt_kern.h>
+#include <linux/workqueue.h>
 
 #include <asm/ptrace.h>
 #ifdef CONFIG_KGDB_SYSRQ
@@ -228,12 +229,19 @@ static struct sysrq_key_op sysrq_term_op
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
 
-static void sysrq_handle_moom(int key, struct pt_regs *pt_regs,
-			      struct tty_struct *tty)
+static void moom_callback(void *ignored)
 {
 	out_of_memory(GFP_KERNEL);
 //	console_loglevel = 8;
 }
+
+static DECLARE_WORK(moom_work, moom_callback, NULL);
+
+static void sysrq_handle_moom(int key, struct pt_regs *pt_regs,
+			      struct tty_struct *tty)
+{
+	schedule_work(&moom_work);
+}
 static struct sysrq_key_op sysrq_moom_op = {
 	.handler	= sysrq_handle_moom,
 	.help_msg	= "Full",
> 
> > > 
> > > The thing needs to be moved into process context via schedule_work().  I
> > > haven't got around to it yet.
> > > 
> > 
> > I don't think schedule_work() is a good option here.  Since sysrq-f is emergent,
> > we just let oom-killer send SIGKILL in interrupt context and return.
> > 
> > We needn't send SIGKILL in a process context. That'll be slow and [events] may got delayed.
> 
> There isn't much choice.  It should work OK - schedule_task doesn't
> allocate any memory.
> 
> keventd could be off allocating some memory somewhere, in which case it
> could take some time to respond, but it isn't worth running another kernel
> thread for sysrq-f.
