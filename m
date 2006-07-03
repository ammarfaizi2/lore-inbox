Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWGCXb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWGCXb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWGCXb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:31:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932085AbWGCXbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:31:25 -0400
Date: Mon, 3 Jul 2006 16:31:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060703163121.4ea22076.akpm@osdl.org>
In-Reply-To: <200607032250.02054.s0348365@sms.ed.ac.uk>
References: <20060703030355.420c7155.akpm@osdl.org>
	<200607032136.55259.s0348365@sms.ed.ac.uk>
	<20060703135419.7c58f318.akpm@osdl.org>
	<200607032250.02054.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 22:50:02 +0100
Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> On Monday 03 July 2006 21:54, Andrew Morton wrote:
> > On Mon, 3 Jul 2006 21:36:55 +0100
> > Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > On Monday 03 July 2006 21:17, Andrew Morton wrote:
> > > > On Mon, 3 Jul 2006 20:56:28 +0100
> > > > Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > > > On Monday 03 July 2006 20:39, Andrew Morton wrote:
> [snip]
> > > > > > Try adding `pause_on_oops=100000' to the kernel boot command line.
> > > > >
> > > > > (Trimmed Nathan)
> > > > >
> > > > > Helped somewhat, but I'm still missing a bit at the top.
> > > > >
> > > > > http://devzero.co.uk/~alistair/oops-20060703/
> > > >
> > > > That is irritating.  This should get us more info:
> > >
> > > Indeed, thanks.
> > >
> > > Try the same URL again, I've uploaded 3,4,5 from a couple of reboots. I
> > > still think I'm missing something at the top, but 3 is the earliest I
> > > could snap.
> >
> > Getting better.
> >
> > It would kinda help if pause_on_oops() was actually implemented on x86_64..
> 
> Doesn't help (work?).
> 
> [alistair] 22:47 [~] strings /boot/vmlinuz-2.6.17-mm6 | grep 2.6.17-mm6
> 2.6.17-mm6 (alistair@damocles) #3 SMP PREEMPT Mon Jul 3 22:39:54 BST 2006
> 
> [alistair] 22:48 [~] cat /boot/grub/menu.lst | grep -C1 mm6
> # testing
> title Linux 2.6.17-mm6
> root (hd0,0)
> kernel /boot/vmlinuz-2.6.17-mm6 vga=extended root=/dev/sda1 
> pause_on_oops=100000
> 
> I'm fairly sure I booted a kernel with your patch and that should be the right 
> cmdline flag.
> 

OK, x86_64 is significantly different from x86 in that area (better).  Have
a tested version...


diff -puN arch/x86_64/kernel/traps.c~x86_64-wire-up-oops_enter-oops_exit arch/x86_64/kernel/traps.c
--- a/arch/x86_64/kernel/traps.c~x86_64-wire-up-oops_enter-oops_exit
+++ a/arch/x86_64/kernel/traps.c
@@ -551,11 +551,14 @@ void __kprobes __die(const char * str, s
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
-	unsigned long flags = oops_begin();
+	unsigned long flags;
 
+	oops_enter();
+	flags = oops_begin();
 	handle_BUG(regs);
 	__die(str, regs, err);
 	oops_end(flags);
+	oops_exit();
 	do_exit(SIGSEGV); 
 }
 
diff -puN arch/x86_64/mm/fault.c~x86_64-wire-up-oops_enter-oops_exit arch/x86_64/mm/fault.c
--- a/arch/x86_64/mm/fault.c~x86_64-wire-up-oops_enter-oops_exit
+++ a/arch/x86_64/mm/fault.c
@@ -261,9 +261,11 @@ int unhandled_signal(struct task_struct 
 static noinline void pgtable_bad(unsigned long address, struct pt_regs *regs,
 				 unsigned long error_code)
 {
-	unsigned long flags = oops_begin();
+	unsigned long flags;
 	struct task_struct *tsk;
 
+	oops_enter();
+	flags = oops_begin();
 	printk(KERN_ALERT "%s: Corrupted page table at address %lx\n",
 	       current->comm, address);
 	dump_pagetable(address);
@@ -273,6 +275,7 @@ static noinline void pgtable_bad(unsigne
 	tsk->thread.error_code = error_code;
 	__die("Bad pagetable", regs, error_code);
 	oops_end(flags);
+	oops_exit();
 	do_exit(SIGKILL);
 }
 
@@ -562,6 +565,7 @@ no_context:
  * terminate things with extreme prejudice.
  */
 
+	oops_enter();
 	flags = oops_begin();
 
 	if (address < PAGE_SIZE)
@@ -578,6 +582,7 @@ no_context:
 	/* Executive summary in case the body of the oops scrolled away */
 	printk(KERN_EMERG "CR2: %016lx\n", address);
 	oops_end(flags);
+	oops_exit();
 	do_exit(SIGKILL);
 
 /*
_

