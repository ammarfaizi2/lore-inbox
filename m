Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbTDFWlq (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbTDFWlp (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:41:45 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:3590
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263143AbTDFWlo (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 18:41:44 -0400
Date: Sun, 6 Apr 2003 18:48:21 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: LKML <linux-kernel@vger.kernel.org>, Andy Grover <andrew.grover@intel.com>
Subject: Re: 2.5.66-bk12: acpi_power_off: sleeping function called from
 illegal context
In-Reply-To: <1049668212.725.13.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.50.0304061847220.2268-100000@montezuma.mastecende.com>
References: <1049668212.725.13.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2003, Felipe Alfaro Solana wrote:

> Power down.
> acpi_power_off called
> Debug: sleeping function called from illegal context at
> include/asm/semaphore.h: 119
> Call  Trace:
>  [<c012088a>] __might_sleep+0x5f/0x75
>  [<c01ffb10>] acpi_os_wait_semaphore+0xc5/0xea
>  [<c021440c>] acpi_ut_acquire_mutex+0x51/0x73
>  [<c020ab4f>] acpi_set_register+0x34/0x15d
>  [<c020b1f6>] acpi_enter_sleep_state+0x77/0x1ab
>  [<c0215d7d>] acpi_power_off+0x21/0x23
>  [<c011a3e5>] machine_power_off+0x10/0x13
>  [<c0135f7b>] sys_reboot+0x332/0x741
>  [<c011e010>] schedule+0x210/0x6d7
>  [<c0130daf>] group_send_sig_info+0x2af/0x6b6
>  [<c011e50d>] preempt_schedule+0x36/0x50
>  [<c0131384>] kill_proc_info+0x60/0x62
>  [<c0134346>] sys_kill+0x4d/0x51
>  [<c016e76b>] __fput+0xaf/0xfb
>  [<c016cabc>] filp_close+0x160/0x226
>  [<c01850cb>] sys_ioctl+0x197/0x3e8
>  [<c010af29>] sysenter_past_esp+0x52/0x71

You probably need this;

Index: linux-2.5.66/drivers/acpi/osl.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/drivers/acpi/osl.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 osl.c
--- linux-2.5.66/drivers/acpi/osl.c	24 Mar 2003 23:39:26 -0000	1.1.1.1
+++ linux-2.5.66/drivers/acpi/osl.c	6 Apr 2003 22:46:04 -0000
@@ -750,7 +750,7 @@ acpi_os_wait_semaphore(
 
 	ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n", handle, units, timeout));
 
-	if (in_atomic())
+	if (in_atomic() || irqs_disabled())
 		timeout = 0;
 
 	switch (timeout)
-- 
function.linuxpower.ca
