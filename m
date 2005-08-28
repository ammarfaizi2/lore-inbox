Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVH1U5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVH1U5T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 16:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVH1U5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 16:57:19 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:50568 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750799AbVH1U5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 16:57:19 -0400
Message-ID: <43122513.1000902@gmail.com>
Date: Sun, 28 Aug 2005 22:56:51 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Michael Marineau <marineam@engr.orst.edu>
CC: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Generic acpi vgapost
References: <43111298.80507@engr.orst.edu> <43111313.8000800@engr.orst.edu>
In-Reply-To: <43111313.8000800@engr.orst.edu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Marineau napsal(a):

>Generic function to post the video bios.
>
>Based directly on the original patch by Ole Rohne.
>
>Signed-off-by: Michael Marineau <marineam@engr.orst.edu>
>  
>
>------------------------------------------------------------------------
>
>Index: linux-2.6.13-rc7/arch/i386/kernel/acpi/sleep.c
>===================================================================
>--- linux-2.6.13-rc7.orig/arch/i386/kernel/acpi/sleep.c
>+++ linux-2.6.13-rc7/arch/i386/kernel/acpi/sleep.c
>@@ -5,6 +5,7 @@
>  *  Copyright (C) 2001-2003 Pavel Machek <pavel@suse.cz>
>  */
> 
>+#include <linux/module.h>
> #include <linux/acpi.h>
> #include <linux/bootmem.h>
> #include <linux/dmi.h>
>@@ -56,6 +57,34 @@ void acpi_restore_state_mem (void)
> 	zap_low_mappings();
> }
> 
>+/*
>+ * acpi_vgapost
>+ */
>+
>+extern void do_vgapost_lowlevel (unsigned long);
>+
>+void acpi_vgapost (unsigned long slot)
>+{
>+	unsigned long flags, saved_video_flags = acpi_video_flags;
>+
>+	acpi_video_flags = (slot & 0xffff) << 16 | 1;
>+
>+	/* Map low memory and copy information */
>+	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
>+	memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - &wakeup_start);
>  
>
80 chars on a line, again...

>+	acpi_copy_wakeup_routine(acpi_wakeup_address);
>+
>+	/* Tunnel thru real mode */
>+	local_irq_save(flags);
>+	do_vgapost_lowlevel(acpi_wakeup_address);
>+	local_irq_restore(flags);
>  
>

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

