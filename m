Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWBFTjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWBFTjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWBFTjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:39:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932320AbWBFTjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:39:14 -0500
Date: Mon, 6 Feb 2006 11:38:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: olh@suse.de, davej@redhat.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       benh@kernel.crashing.org
Subject: Re: [PATCH] Fix build failure in recent pm_prepare_* changes.
Message-Id: <20060206113809.51c230ba.akpm@osdl.org>
In-Reply-To: <200602061603.29989.rjw@sisk.pl>
References: <200602032312.k13NCDAc012658@hera.kernel.org>
	<20060206072845.GA21300@suse.de>
	<20060206142312.GA31509@suse.de>
	<200602061603.29989.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Sorry, my recent change has broken it, but pm_prepare_console() and
> pm_restore_console() are only static if CONFIG_VT or CONFIG_VT_CONSOLE
> is not set which Ben told me should not happen on Macs.

But kernel/power/power.h has

#ifdef SUSPEND_CONSOLE
extern int pm_prepare_console(void);
extern void pm_restore_console(void);
#else
static int pm_prepare_console(void) { return 0; }
static void pm_restore_console(void) {}
#endif

> --- linux-2.6.16-rc1-mm5.orig/drivers/macintosh/via-pmu.c
> +++ linux-2.6.16-rc1-mm5/drivers/macintosh/via-pmu.c
> @@ -2070,6 +2070,14 @@ restore_via_state(void)
>  	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
>  }
>  
> +#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
> +extern int pm_prepare_console(void);
> +extern void pm_restore_console(void);
> +#else
> +static int pm_prepare_console(void) { return 0; }
> +static void pm_restore_console(void) {}
> +#endif
> +

These should be in a header file.  Presumably one which
kernel/power/power.h includes, too.

