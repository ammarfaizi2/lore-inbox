Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUJOSb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUJOSb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUJOSbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:31:55 -0400
Received: from fmr03.intel.com ([143.183.121.5]:20690 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S268293AbUJOSbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:31:15 -0400
Date: Fri, 15 Oct 2004 11:29:02 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041015112902.A12631@unix-os.sc.intel.com>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org> <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>; from geert@linux-m68k.org on Fri, Oct 15, 2004 at 02:38:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 02:38:01PM +0200, Geert Uytterhoeven wrote:
> On Fri, 15 Oct 2004, Gerd Knorr wrote:
> > Have you talked to the powermanagement guys btw.?  One of the major
> > issues with suspend-to-ram is to get the graphics card back online,
> > and SNAPBoot might help to fix this too.  I'm not sure a userspace
> > solution would work for *that* through.
> 
> Why not? Of course you won't get any output before the graphics card has been
> re-initialized to a sane and usable state...
> 

True. I do it on my Dell 600m (Radeon 9000M) using usermodehelper and it works just fine. It works both with VGA and X. I need to split up the thaw_processes into two stages though. It may not work with fb as fb driver resumes earlier. I use the patch below for the kernel and a userlevel x86 emulator.

I have to say though, it will help if we have a such an emulator in the kernel.

Thanks,
Venki


--- linux-2.6.9-rc2/kernel/power/main.c.org	2004-09-12 18:23:00.671546520 -0700
+++ linux-2.6.9-rc2/kernel/power/main.c	2004-09-12 18:22:27.548581976 -0700
@@ -106,12 +106,28 @@ static int suspend_enter(u32 state)
  *	console that we've allocated.
  */
 
+int vgapost_usermode(void)
+{
+	char	*argv[3] = {NULL, NULL, NULL};
+	char	*envp[3] = {NULL, NULL, NULL};
+
+	argv[0] = "/root/emu/video_post";
+
+	/* minimal command environment */
+	envp[0] = "HOME=/";
+	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+        
+	return call_usermodehelper(argv[0], argv, envp, 1);
+}
+
 static void suspend_finish(u32 state)
 {
 	int retval;
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
+	thaw_processes_kernel();
+	retval = vgapost_usermode();
 	thaw_processes();
 
 	pm_restore_console();
--- linux-2.6.9-rc2/kernel/power/process.c.org	2004-09-12 18:21:48.266553752 -0700
+++ linux-2.6.9-rc2/kernel/power/process.c	2004-09-12 18:22:06.851728376 -0700
@@ -97,6 +97,29 @@ int freeze_processes(void)
 	return 0;
 }
 
+void thaw_processes_kernel(void)
+{
+	struct task_struct *g, *p;
+
+	printk( "Restarting kernel tasks..." );
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (!freezeable(p))
+			continue;
+		if (p->parent->pid != 1)
+			continue;
+		if (p->flags & PF_FROZEN) {
+			p->flags &= ~PF_FROZEN;
+			wake_up_process(p);
+		} else
+			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+	} while_each_thread(g, p);
+
+	read_unlock(&tasklist_lock);
+	schedule();
+	printk( " done\n" );
+}
+
 void thaw_processes(void)
 {
 	struct task_struct *g, *p;
@@ -106,6 +129,8 @@ void thaw_processes(void)
 	do_each_thread(g, p) {
 		if (!freezeable(p))
 			continue;
+		if (p->parent->pid == 1)
+			continue;
 		if (p->flags & PF_FROZEN) {
 			p->flags &= ~PF_FROZEN;
 			wake_up_process(p);
