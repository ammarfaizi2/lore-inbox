Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWHNVWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWHNVWI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWHNVWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:22:08 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:30623 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964936AbWHNVWG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:22:06 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: 2.6.18-rc4-mm1: eth0: trigger_send() called with the transmitter busy
Date: Mon, 14 Aug 2006 23:25:59 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <44E0B72C.6010503@free.fr> <44E0D7C1.7040509@free.fr>
In-Reply-To: <44E0D7C1.7040509@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608142325.59054.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 22:06, Laurent Riffard wrote:
> Le 14.08.2006 19:47, Laurent Riffard a écrit :
> > Le 14.08.2006 18:50, Andrew Morton a écrit :
> >> On Mon, 14 Aug 2006 16:38:47 +0200
> >> Laurent Riffard <laurent.riffard@free.fr> wrote:
> >>
> >>> Le 13.08.2006 10:24, Andrew Morton a __crit :
> >>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> >>> Hello,
> >>>
> >>> This morning, while trying to suspend to disk, my box started to loop 
> >>> displaying the following message:
> >>> eth0: trigger_send() called with the transmitter busy.
> >>>
> >>> Here is the scenario. I booted 2.6.18-rc4-mm1 with this command line:
> >>> root=/dev/vglinux1/lvroot video=vesafb:ywrap,mtrr splash=silent resume=/dev/hdb7 netconsole=@192.163.0.3/,@192.168.0.1/00:0E:9B:91:ED:72 init 1
> >>>
> >>> Then I issued:
> >>> # echo 6 > /proc/sys/kernel/printk
> >>> # echo disk > /sys/power/state
> >> ne2k isn't <ahem> the most actively-maintained driver.
> >>
> >> But most (I think all) net drivers have problems during suspend when
> >> netconsole is active.  Does disabling netconsole help?
> > 
> > Yes it does. 
> >  
> >> Did this operation work OK in earlier kernels, with netconsole enabled?
> > 
> > It's the first time I see such a message. I can't speak for 2.6.18-rc3-mm2 
> > because it could not suspend at all (did hang right after 
> > "echo disk > /sys/power/state"), but it worked in earlier kernels.
> > 
> > I'll try with plain 2.6.18-rc4.
> 
> Same problem with 2.6.18-rc4.

I think something like this will help (untested):

 kernel/power/disk.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-2.6.18-rc4-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/kernel/power/disk.c
+++ linux-2.6.18-rc4-mm1/kernel/power/disk.c
@@ -119,8 +119,10 @@ int pm_suspend_disk(void)
 	if (error)
 		return error;
 
+	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
 	if (error) {
+		resume_console();
 		printk("Some devices failed to suspend\n");
 		unprepare_processes();
 		return error;
@@ -133,6 +135,7 @@ int pm_suspend_disk(void)
 
 	if (in_suspend) {
 		device_resume();
+		resume_console();
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write();
 		if (!error)
@@ -148,6 +151,7 @@ int pm_suspend_disk(void)
 	swsusp_free();
  Done:
 	device_resume();
+	resume_console();
 	unprepare_processes();
 	return error;
 }
@@ -212,7 +216,9 @@ static int software_resume(void)
 
 	pr_debug("PM: Preparing devices for restore.\n");
 
+	suspend_console();
 	if ((error = device_suspend(PMSG_PRETHAW))) {
+		resume_console();
 		printk("Some devices failed to suspend\n");
 		swsusp_free();
 		goto Thaw;
@@ -224,6 +230,7 @@ static int software_resume(void)
 	swsusp_resume();
 	pr_debug("PM: Restore failed, recovering.n");
 	device_resume();
+	resume_console();
  Thaw:
 	unprepare_processes();
  Done:
