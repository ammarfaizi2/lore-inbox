Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWBFPCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWBFPCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 10:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWBFPCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 10:02:13 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:42667 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932135AbWBFPCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 10:02:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] Fix build failure in recent pm_prepare_* changes.
Date: Mon, 6 Feb 2006 16:03:29 +0100
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
References: <200602032312.k13NCDAc012658@hera.kernel.org> <20060206072845.GA21300@suse.de> <20060206142312.GA31509@suse.de>
In-Reply-To: <20060206142312.GA31509@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061603.29989.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 06 February 2006 15:23, Olaf Hering wrote:
>  On Mon, Feb 06, Olaf Hering wrote:
> 
> >  On Sun, Feb 05, Dave Jones wrote:
> > 
> > > On Sun, Feb 05, 2006 at 01:56:10PM +0100, Olaf Hering wrote:
> > >  >  On Fri, Feb 03, Linux Kernel Mailing List wrote:
> > >  > 
> > >  > > tree 8f70444139c8564c0f1e88e1f33adda036ae6a96
> > >  > > parent 278ff9537030bbb292b33504f5e1f6e0126793eb
> > >  > > author Dave Jones <davej@redhat.com> Fri, 03 Feb 2006 19:03:44 -0800
> > >  > > committer Linus Torvalds <torvalds@g5.osdl.org> Sat, 04 Feb 2006 00:32:00 -0800
> > >  > > 
> > >  > > [PATCH] Fix build failure in recent pm_prepare_* changes.
> > >  > > 
> > >  > > kernel/power/power.h:49: error: static declaration of 'pm_prepare_console' follows non-static declaration
> > >  > > include/linux/suspend.h:46: error: previous declaration of 'pm_prepare_console' was here
> > >  > > kernel/power/power.h:50: error: static declaration of 'pm_restore_console' follows non-static declaration
> > >  > > include/linux/suspend.h:47: error: previous declaration of 'pm_restore_console' was here

Sorry, my recent change has broken it, but pm_prepare_console() and
pm_restore_console() are only static if CONFIG_VT or CONFIG_VT_CONSOLE
is not set which Ben told me should not happen on Macs.

> > >  > > 
> > >  > > Signed-off-by: Dave Jones <davej@redhat.com>
> > >  > 
> > >  > this one is not correct, please have a closer look at
> > >  > f7b8988ff50d99c99746f65f420364e91362c065
> > >  > 
> > >  >   CC      drivers/macintosh/via-pmu.o
> > >  > drivers/macintosh/via-pmu.c: In function 'pmac_suspend_devices':
> > >  > drivers/macintosh/via-pmu.c:2078: error: implicit declaration of function 'pm_prepare_console'
> > >  > drivers/macintosh/via-pmu.c: In function 'pmac_wakeup_devices':
> > >  > drivers/macintosh/via-pmu.c:2194: error: implicit declaration of function 'pm_restore_console'
> > >  > make[2]: *** [drivers/macintosh/via-pmu.o] Error 1

> 
> 
> via-pmu needs to call console functions directly from the pmu_ioctl.
> 
>  drivers/macintosh/via-pmu.c |    4 ++++
>  1 files changed, 4 insertions(+)
> 
> Index: linux-2.6.16-rc2-olh/drivers/macintosh/via-pmu.c
> ===================================================================
> --- linux-2.6.16-rc2-olh.orig/drivers/macintosh/via-pmu.c
> +++ linux-2.6.16-rc2-olh/drivers/macintosh/via-pmu.c
> @@ -2070,6 +2070,10 @@ restore_via_state(void)
>  	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
>  }
>  
> +/* to avoid include mess */
> +extern int pm_prepare_console(void);
> +extern void pm_restore_console(void);

if CONFIG_VT or CONFIG_VT_CONSOLE is not set, these functions are not defined.

> +
>  static int
>  pmac_suspend_devices(void)
>  {
> 

I think the complete fix should look like that:

--- linux-2.6.16-rc1-mm5.orig/drivers/macintosh/via-pmu.c
+++ linux-2.6.16-rc1-mm5/drivers/macintosh/via-pmu.c
@@ -2070,6 +2070,14 @@ restore_via_state(void)
 	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
 }
 
+#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
+#else
+static int pm_prepare_console(void) { return 0; }
+static void pm_restore_console(void) {}
+#endif
+
 static int
 pmac_suspend_devices(void)
 {


Greetings,
Rafael
