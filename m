Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTDGJSN (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 05:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbTDGJSN (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 05:18:13 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:36056 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263357AbTDGJSM (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 05:18:12 -0400
Subject: Re: 2.5.66-bk12: acpi_power_off: sleeping function called from
	illegal context
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Grover <andrew.grover@intel.com>
In-Reply-To: <Pine.LNX.4.50.0304061847220.2268-100000@montezuma.mastecende.com>
References: <1049668212.725.13.camel@teapot.felipe-alfaro.com>
	 <Pine.LNX.4.50.0304061847220.2268-100000@montezuma.mastecende.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049707778.592.22.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 07 Apr 2003 11:29:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 00:48, Zwane Mwaikambo wrote:
> On Sun, 7 Apr 2003, Felipe Alfaro Solana wrote:
> 
> > Power down.
> > acpi_power_off called
> > Debug: sleeping function called from illegal context at
> > include/asm/semaphore.h: 119
> > Call  Trace:
> >  [<c012088a>] __might_sleep+0x5f/0x75
> >  [<c01ffb10>] acpi_os_wait_semaphore+0xc5/0xea
> >  [<c021440c>] acpi_ut_acquire_mutex+0x51/0x73
> >  [<c020ab4f>] acpi_set_register+0x34/0x15d
> >  [<c020b1f6>] acpi_enter_sleep_state+0x77/0x1ab
> >  [<c0215d7d>] acpi_power_off+0x21/0x23
> >  [<c011a3e5>] machine_power_off+0x10/0x13
> >  [<c0135f7b>] sys_reboot+0x332/0x741
> >  [<c011e010>] schedule+0x210/0x6d7
> >  [<c0130daf>] group_send_sig_info+0x2af/0x6b6
> >  [<c011e50d>] preempt_schedule+0x36/0x50
> >  [<c0131384>] kill_proc_info+0x60/0x62
> >  [<c0134346>] sys_kill+0x4d/0x51
> >  [<c016e76b>] __fput+0xaf/0xfb
> >  [<c016cabc>] filp_close+0x160/0x226
> >  [<c01850cb>] sys_ioctl+0x197/0x3e8
> >  [<c010af29>] sysenter_past_esp+0x52/0x71
> 
> You probably need this;
> 
> Index: linux-2.5.66/drivers/acpi/osl.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.66/drivers/acpi/osl.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 osl.c
> --- linux-2.5.66/drivers/acpi/osl.c	24 Mar 2003 23:39:26 -0000	1.1.1.1
> +++ linux-2.5.66/drivers/acpi/osl.c	6 Apr 2003 22:46:04 -0000
> @@ -750,7 +750,7 @@ acpi_os_wait_semaphore(
>  
>  	ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n", handle, units, timeout));
>  
> -	if (in_atomic())
> +	if (in_atomic() || irqs_disabled())
>  		timeout = 0;
>  
>  	switch (timeout)

OK, now it doesn't cause an oops, but the machine doesn't power off: it
stays powered on showing:

acpi_power_off

and I must manually cycle the power.
This 2.5 ACPI stuff is causing me great deal of pain... I can never get
it to work realiably.

________________________________________________________________________
Linux Registered User #287198

