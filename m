Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVCaHa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVCaHa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVCaH3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:29:09 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:43136 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262539AbVCaH0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:26:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Date: Thu, 31 Mar 2005 02:26:02 -0500
User-Agent: KMail/1.8
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Isaacson <adi@hexapodia.org>
References: <20050329181831.GB8125@elf.ucw.cz> <1112135477.29392.16.camel@desktop.cunningham.myip.net.au> <20050329223519.GI8125@elf.ucw.cz>
In-Reply-To: <20050329223519.GI8125@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503310226.03495.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 March 2005 17:35, Pavel Machek wrote:
> Hi!
> 
> > > We currently freeze processes for suspend-to-ram, too. I guess that
> > > disable_usermodehelper is probably better and that in_suspend() should
> > > only be used for sanity checks... go with disable_usermodehelper and
> > > sorry for the noise.
> > 
> > Here's another possibility: Freeze the workqueue that
> > call_usermodehelper uses (remember that code I didn't push hard enough
> > to Andrew?), and let invocations of call_usermodehelper block in
> > TASK_UNINTERRUPTIBLE. In refrigerating processes, don't choke on
> 
> There may be many devices in the system, and you are going to need
> quite a lot of RAM for all that... That's why they do not queue it
> during boot, IIRC. Disabling usermode helper seems right.

Ok, what do you think about this one?

===================================================================

swsusp: disable usermodehelper after generating memory snapshot and
        before resuming devices, so when device fails to resume we
        won't try to call hotplug - userspace stopped anyway.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 include/linux/kmod.h  |    3 +++
 kernel/kmod.c         |   14 +++++++++++++-
 kernel/power/disk.c   |    2 ++
 kernel/power/swsusp.c |    1 -
 4 files changed, 18 insertions(+), 2 deletions(-)

Index: dtor/kernel/power/disk.c
===================================================================
--- dtor.orig/kernel/power/disk.c
+++ dtor/kernel/power/disk.c
@@ -205,6 +205,8 @@ int pm_suspend_disk(void)
 
 	if (in_suspend) {
 		pr_debug("PM: writing image.\n");
+		usermodehelper_disable();
+		device_resume();
 		error = swsusp_write();
 		if (!error)
 			power_down(pm_disk_mode);
Index: dtor/kernel/power/swsusp.c
===================================================================
--- dtor.orig/kernel/power/swsusp.c
+++ dtor/kernel/power/swsusp.c
@@ -853,7 +853,6 @@ static int suspend_prepare_image(void)
 int swsusp_write(void)
 {
 	int error;
-	device_resume();
 	lock_swapdevices();
 	error = write_suspend_image();
 	/* This will unlock ignored swap devices since writing is finished */
Index: dtor/kernel/kmod.c
===================================================================
--- dtor.orig/kernel/kmod.c
+++ dtor/kernel/kmod.c
@@ -124,6 +124,8 @@ struct subprocess_info {
 	int retval;
 };
 
+static int usermodehelper_disabled;
+
 /*
  * This is the task which runs the usermode application
  */
@@ -240,7 +242,7 @@ int call_usermodehelper(char *path, char
 	if (!khelper_wq)
 		return -EBUSY;
 
-	if (path[0] == '\0')
+	if (usermodehelper_disabled || path[0] == '\0')
 		return 0;
 
 	queue_work(khelper_wq, &work);
@@ -249,6 +251,16 @@ int call_usermodehelper(char *path, char
 }
 EXPORT_SYMBOL(call_usermodehelper);
 
+void usermodehelper_enable(void)
+{
+	usermodehelper_disabled = 0;
+}
+
+void usermodehelper_disable(void)
+{
+	usermodehelper_disabled = 1;
+}
+
 void __init usermodehelper_init(void)
 {
 	khelper_wq = create_singlethread_workqueue("khelper");
Index: dtor/include/linux/kmod.h
===================================================================
--- dtor.orig/include/linux/kmod.h
+++ dtor/include/linux/kmod.h
@@ -34,7 +34,10 @@ static inline int request_module(const c
 #endif
 
 #define try_then_request_module(x, mod...) ((x) ?: (request_module(mod), (x)))
+
 extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
 extern void usermodehelper_init(void);
+extern void usermodehelper_enable(void);
+extern void usermodehelper_disable(void);
 
 #endif /* __LINUX_KMOD_H__ */
