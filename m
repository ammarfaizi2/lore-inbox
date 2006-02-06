Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWBFXz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWBFXz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWBFXz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:55:57 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:6319 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932417AbWBFXz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:55:57 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix build failure in recent pm_prepare_* changes.
Date: Tue, 7 Feb 2006 00:57:26 +0100
User-Agent: KMail/1.9.1
Cc: olh@suse.de, davej@redhat.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       benh@kernel.crashing.org
References: <200602032312.k13NCDAc012658@hera.kernel.org> <200602061603.29989.rjw@sisk.pl> <20060206113809.51c230ba.akpm@osdl.org>
In-Reply-To: <20060206113809.51c230ba.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602070057.26925.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 20:38, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Sorry, my recent change has broken it, but pm_prepare_console() and
> > pm_restore_console() are only static if CONFIG_VT or CONFIG_VT_CONSOLE
> > is not set which Ben told me should not happen on Macs.
> 
> But kernel/power/power.h has
> 
> #ifdef SUSPEND_CONSOLE

There is

#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
#define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
#endif

earlier in there.

> extern int pm_prepare_console(void);
> extern void pm_restore_console(void);
> #else
> static int pm_prepare_console(void) { return 0; }
> static void pm_restore_console(void) {}
> #endif
> 
> > --- linux-2.6.16-rc1-mm5.orig/drivers/macintosh/via-pmu.c
> > +++ linux-2.6.16-rc1-mm5/drivers/macintosh/via-pmu.c
> > @@ -2070,6 +2070,14 @@ restore_via_state(void)
> >  	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
> >  }
> >  
> > +#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
> > +extern int pm_prepare_console(void);
> > +extern void pm_restore_console(void);
> > +#else
> > +static int pm_prepare_console(void) { return 0; }
> > +static void pm_restore_console(void) {}
> > +#endif
> > +
> 
> These should be in a header file.  Presumably one which
> kernel/power/power.h includes, too.

Then I think I should move all that to include/linux/suspend.h.

Greetings,
Rafael
