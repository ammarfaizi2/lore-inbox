Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWCRU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWCRU25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWCRU25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:28:57 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:21724 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750944AbWCRU24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:28:56 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: -mm: PM=y, VT=n doesn't compile
Date: Sat, 18 Mar 2006 21:28:02 +0100
User-Agent: KMail/1.9.1
Cc: bunk@stusta.de, pavel@suse.cz, linux-kernel@vger.kernel.org
References: <20060317171814.GO3914@stusta.de> <20060318114825.75dba55a.akpm@osdl.org> <200603182058.58389.rjw@sisk.pl>
In-Reply-To: <200603182058.58389.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182128.02955.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 20:58, Rafael J. Wysocki wrote:
> On Saturday 18 March 2006 20:48, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > --- linux-2.6.16-rc6-mm2.orig/drivers/base/power/suspend.c
> > >  +++ linux-2.6.16-rc6-mm2/drivers/base/power/suspend.c
> > >  @@ -8,6 +8,9 @@
> > >    *
> > >    */
> > >   
> > >  +#include <linux/vt_kern.h>
> > >  +#include <linux/kbd_kern.h>
> > >  +#include <linux/console.h>
> > >   #include <linux/device.h>
> > >   #include <linux/kallsyms.h>
> > >   #include <linux/pm.h>
> > >  @@ -65,6 +68,17 @@ int suspend_device(struct device * dev, 
> > >   	return error;
> > >   }
> > >   
> > >  +#ifdef CONFIG_VT
> > >  +static inline int is_suspend_console_safe(void)
> > >  +{
> > >  +	/* It is unsafe to suspend devices while X has control of the
> > >  +	 * hardware. Make sure we are running on a kernel-controlled console.
> > >  +	 */
> > >  +	return vc_cons[fg_console].d->vc_mode == KD_TEXT;
> > >  +}
> > 
> > Please implement this inside the vt subsystem, not the pm subsystem.  That way
> > 
> > a) It gets to be called "console_is_in_text_mode()", or
> >    "vt_not_running_X()" or something, which is something someone else might
> >    want to know.  
> > 
> > b) People who work on vt code don't need to keep an eye on a hunk of pm
> >    code at the same time.
> > 
> > c) You won't need all those includes.
> 
> I'm working on this now.  [For some obscure reason I received your reply to
> Adrian only a couple of minutes ago.]
> 
> Still I'd like to separate it from the console-related changes in
> kernel/power/user.c that are needed for the userland suspend, so I'd like
> to split the dropped patch in two.
> 
> I've already sent the kernel/power/user.c changes in a separate patch,
> and I'll send the drivers/base/power/suspend.c changes when I test them
> (in a while).

OK, here they go.

---
From: "Rafael J. Wysocki" <rjw@sisk.pl>

It is unsafe to suspend devices if the hardware is controlled by X. 
Add an extra check to prevent this from happening.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/suspend.c |    5 ++++-
 drivers/char/vt.c            |    8 ++++++++
 include/linux/vt_kern.h      |    5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

Index: linux-2.6.16-rc6-mm2/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/drivers/base/power/suspend.c
+++ linux-2.6.16-rc6-mm2/drivers/base/power/suspend.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/vt_kern.h>
 #include <linux/device.h>
 #include <linux/kallsyms.h>
 #include <linux/pm.h>
@@ -65,7 +66,6 @@ int suspend_device(struct device * dev, 
 	return error;
 }
 
-
 /**
  *	device_suspend - Save state and stop all devices in system.
  *	@state:		Power state to put each device in.
@@ -85,6 +85,9 @@ int device_suspend(pm_message_t state)
 {
 	int error = 0;
 
+	if (!is_console_suspend_safe())
+		return -EINVAL;
+
 	down(&dpm_sem);
 	down(&dpm_list_sem);
 	while (!list_empty(&dpm_active) && error == 0) {
Index: linux-2.6.16-rc6-mm2/drivers/char/vt.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/drivers/char/vt.c
+++ linux-2.6.16-rc6-mm2/drivers/char/vt.c
@@ -3234,6 +3234,14 @@ void vcs_scr_writew(struct vc_data *vc, 
 	}
 }
 
+int is_console_suspend_safe(void)
+{
+	/* It is unsafe to suspend devices while X has control of the
+	 * hardware. Make sure we are running on a kernel-controlled console.
+	 */
+	return vc_cons[fg_console].d->vc_mode == KD_TEXT;
+}
+
 /*
  *	Visible symbols for modules
  */
Index: linux-2.6.16-rc6-mm2/include/linux/vt_kern.h
===================================================================
--- linux-2.6.16-rc6-mm2.orig/include/linux/vt_kern.h
+++ linux-2.6.16-rc6-mm2/include/linux/vt_kern.h
@@ -73,6 +73,11 @@ int con_copy_unimap(struct vc_data *dst_
 int vt_waitactive(int vt);
 void change_console(struct vc_data *new_vc);
 void reset_vc(struct vc_data *vc);
+#ifdef CONFIG_VT
+int is_console_suspend_safe(void);
+#else
+static inline int is_console_suspend_safe(void) { return 1; }
+#endif
 
 /*
  * vc_screen.c shares this temporary buffer with the console write code so that
