Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264852AbUEOAb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264852AbUEOAb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbUEOAQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:16:12 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:3968 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264653AbUENXtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:49:33 -0400
Date: Fri, 14 May 2004 05:26:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, rene.herman@keyaccess.nl,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-ID: <20040514032657.GB704@elf.ucw.cz>
References: <409F4944.4090501@keyaccess.nl> <200405102125.51947.bzolnier@elka.pw.edu.pl> <409FF068.30902@keyaccess.nl> <200405102352.24091.bzolnier@elka.pw.edu.pl> <20040510215626.6a5552f2.akpm@osdl.org> <20040510221729.3b8e93da.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510221729.3b8e93da.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > It's a bit grubby, but we could easily add a fourth state to
> >  `system_state': split SYSTEM_SHUTDOWN into SYSTEM_REBOOT and SYSTEM_HALT. 
> >  That would be a quite simple change.
> 
> Like this.  I checked all the SYSTEM_FOO users and none of them seem to
> care about the shutdown state at present.  Easy.

Perhaps this should be parameter to device_shutdown? This is quite
ugly.

								Pavel

> diff -puN include/linux/kernel.h~system-state-splitup include/linux/kernel.h
> --- 25/include/linux/kernel.h~system-state-splitup	2004-05-10 22:05:15.127191856 -0700
> +++ 25-akpm/include/linux/kernel.h	2004-05-10 22:05:15.133190944 -0700
> @@ -109,14 +109,17 @@ static inline void console_verbose(void)
>  extern void bust_spinlocks(int yes);
>  extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
>  extern int panic_on_oops;
> -extern int system_state;		/* See values below */
>  extern int tainted;
>  extern const char *print_tainted(void);
>  
>  /* Values used for system_state */
> -#define SYSTEM_BOOTING 0
> -#define SYSTEM_RUNNING 1
> -#define SYSTEM_SHUTDOWN 2
> +extern enum system_states {
> +	SYSTEM_BOOTING,
> +	SYSTEM_RUNNING,
> +	SYSTEM_HALT,
> +	SYSTEM_POWER_OFF,
> +	SYSTEM_RESTART,
> +} system_state;
>  
>  #define TAINT_PROPRIETARY_MODULE	(1<<0)
>  #define TAINT_FORCED_MODULE		(1<<1)
...
> diff -puN kernel/sys.c~system-state-splitup kernel/sys.c
> --- 25/kernel/sys.c~system-state-splitup	2004-05-10 22:05:15.130191400 -0700
> +++ 25-akpm/kernel/sys.c	2004-05-10 22:05:15.135190640 -0700
> @@ -451,7 +451,7 @@ asmlinkage long sys_reboot(int magic1, i
>  	switch (cmd) {
>  	case LINUX_REBOOT_CMD_RESTART:
>  		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
> -		system_state = SYSTEM_SHUTDOWN;
> +		system_state = SYSTEM_RESTART;
>  		device_shutdown();
>  		printk(KERN_EMERG "Restarting system.\n");
>  		machine_restart(NULL);

-- 
When do you have heart between your knees?
