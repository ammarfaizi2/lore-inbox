Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUCAKF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUCAKF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:05:58 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:5339 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261161AbUCAKFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:05:34 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][3/7] SysRq-G
Date: Mon, 1 Mar 2004 15:35:17 +0530
User-Agent: KMail/1.5
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227213254.GE1052@smtp.west.cox.net> <403FC980.8040905@mvista.com>
In-Reply-To: <403FC980.8040905@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011535.17747.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 Feb 2004 4:19 am, George Anzinger wrote:
> There may be a need to change the keyboard driver for this.  I have had
> trouble with it in the past.  Seems it doesn't like to not get control back
> for a very long time.  I am not sure what the problem is but, be warned.

Let's put it in core instead of core-lite, then,

-Amit

>
> -g
>
> Tom Rini wrote:
> > Hello.  The following adds SysRq-G.  This is always configured in on
> > CONFIG_KGDB && CONFIG_SYSRQ.
> >
> > diff -zrupN linux-2.6.3+config+serial/drivers/char/sysrq.c
> > linux-2.6.3+config+serial+sysrq+arch_hooks/drivers/char/sysrq.c ---
> > linux-2.6.3+config+serial/drivers/char/sysrq.c	2004-02-27
> > 12:06:22.000000000 -0700 +++
> > linux-2.6.3+config+serial+sysrq+arch_hooks/drivers/char/sysrq.c	2004-02-2
> >7 12:16:14.000000000 -0700 @@ -31,6 +31,7 @@
> >  #include <linux/suspend.h>
> >  #include <linux/writeback.h>
> >  #include <linux/buffer_head.h>		/* for fsync_bdev() */
> > +#include <linux/kgdb.h>			/* for breakpoint() */
> >
> >  #include <linux/spinlock.h>
> >
> > @@ -44,6 +45,25 @@ int sysrq_enabled = 1;
> >  /* Machine specific power off function */
> >  void (*sysrq_power_off)(void);
> >
> > +/* Make a breakpoint() right now. */
> > +#ifdef CONFIG_KGDB
> > +#define  GDB_OP &kgdb_op
> > +static void kgdb_sysrq(int key, struct pt_regs *pt_regs, struct
> > tty_struct *tty) +{
> > +	printk("kgdb sysrq\n");
> > +	breakpoint();
> > +}
> > +
> > +static struct sysrq_key_op kgdb_op = {
> > +	.handler	= kgdb_sysrq,
> > +	.help_msg	= "kGdb|Fgdb",
> > +	.action_msg	= "Debug breakpoint\n",
> > +};
> > +
> > +#else
> > +#define  GDB_OP NULL
> > +#endif
> > +
> >  /* Loglevel sysrq handler */
> >  static void sysrq_handle_loglevel(int key, struct pt_regs *pt_regs,
> >  				  struct tty_struct *tty)
> > @@ -239,7 +259,7 @@ static struct sysrq_key_op *sysrq_key_ta
> >  /* d */	NULL,
> >  /* e */	&sysrq_term_op,
> >  /* f */	NULL,
> > -/* g */	NULL,
> > +/* g */	GDB_OP,
> >  /* h */	NULL,
> >  /* i */	&sysrq_kill_op,
> >  /* j */	NULL,

