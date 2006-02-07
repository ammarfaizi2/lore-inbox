Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWBGOuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWBGOuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWBGOuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:50:16 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:54451 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965108AbWBGOuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:50:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix build failure in recent pm_prepare_* changes.
Date: Tue, 7 Feb 2006 15:51:27 +0100
User-Agent: KMail/1.9.1
Cc: olh@suse.de, davej@redhat.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       benh@kernel.crashing.org
References: <200602032312.k13NCDAc012658@hera.kernel.org> <200602070057.26925.rjw@sisk.pl> <20060206164410.2c7d3f49.akpm@osdl.org>
In-Reply-To: <20060206164410.2c7d3f49.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602071551.29031.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 01:44, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > > > --- linux-2.6.16-rc1-mm5.orig/drivers/macintosh/via-pmu.c
> > > > +++ linux-2.6.16-rc1-mm5/drivers/macintosh/via-pmu.c
> > > > @@ -2070,6 +2070,14 @@ restore_via_state(void)
> > > >  	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
> > > >  }
> > > >  
> > > > +#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
> > > > +extern int pm_prepare_console(void);
> > > > +extern void pm_restore_console(void);
> > > > +#else
> > > > +static int pm_prepare_console(void) { return 0; }
> > > > +static void pm_restore_console(void) {}
> > > > +#endif
> > > > +
> > > 
> > > These should be in a header file.  Presumably one which
> > > kernel/power/power.h includes, too.
> > 
> > Then I think I should move all that to include/linux/suspend.h.
> 
> Sounds sane.  Or <linux/console.h>.

I chose include/linux/suspend.h (it was there before and the functions are
defined in kernel/power/console.c).

The appended patch (against -mm5) has been compile-tested on x86-64 and i386
with and withoud CONFIG_VT, CONFIG_VT_CONSOLE.  [I have no access to a Mac,
though.]

Greetings,
Rafael


Fix compilation problem in PM headers.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/suspend.h |   10 +++++++++-
 kernel/power/console.c  |    4 +++-
 kernel/power/power.h    |   16 ----------------
 3 files changed, 12 insertions(+), 18 deletions(-)

Index: linux-2.6.16-rc1-mm5/include/linux/suspend.h
===================================================================
--- linux-2.6.16-rc1-mm5.orig/include/linux/suspend.h
+++ linux-2.6.16-rc1-mm5/include/linux/suspend.h
@@ -42,13 +42,21 @@ extern void mark_free_pages(struct zone 
 #ifdef CONFIG_PM
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
+
+#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
+#else
+static inline int pm_prepare_console(void) { return 0; }
+static inline void pm_restore_console(void) {}
+#endif /* defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE) */
 #else
 static inline int software_suspend(void)
 {
 	printk("Warning: fake suspend called\n");
 	return -EPERM;
 }
-#endif
+#endif /* CONFIG_PM */
 
 #ifdef CONFIG_SUSPEND_SMP
 extern void disable_nonboot_cpus(void);
Index: linux-2.6.16-rc1-mm5/kernel/power/power.h
===================================================================
--- linux-2.6.16-rc1-mm5.orig/kernel/power/power.h
+++ linux-2.6.16-rc1-mm5/kernel/power/power.h
@@ -1,14 +1,6 @@
 #include <linux/suspend.h>
 #include <linux/utsname.h>
 
-/* With SUSPEND_CONSOLE defined suspend looks *really* cool, but
-   we probably do not take enough locks for switching consoles, etc,
-   so bad things might happen.
-*/
-#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
-#define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
-#endif
-
 struct swsusp_info {
 	struct new_utsname	uts;
 	u32			version_code;
@@ -43,14 +35,6 @@ static struct subsys_attribute _name##_a
 
 extern struct subsystem power_subsys;
 
-#ifdef SUSPEND_CONSOLE
-extern int pm_prepare_console(void);
-extern void pm_restore_console(void);
-#else
-static int pm_prepare_console(void) { return 0; }
-static void pm_restore_console(void) {}
-#endif
-
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
 
Index: linux-2.6.16-rc1-mm5/kernel/power/console.c
===================================================================
--- linux-2.6.16-rc1-mm5.orig/kernel/power/console.c
+++ linux-2.6.16-rc1-mm5/kernel/power/console.c
@@ -9,7 +9,9 @@
 #include <linux/console.h>
 #include "power.h"
 
-#ifdef SUSPEND_CONSOLE
+#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
+#define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
+
 static int orig_fgconsole, orig_kmsg;
 
 int pm_prepare_console(void)
