Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbTHaV2d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTHaV2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:28:33 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:33425 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262682AbTHaV23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:28:29 -0400
Date: Sun, 31 Aug 2003 23:28:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Power Management Update
Message-ID: <20030831212813.GB122@elf.ucw.cz>
References: <Pine.LNX.4.33.0308301359570.944-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0308301359570.944-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> <mochel@osdl.org> (03/08/22 1.1276.19.8)
>    [power] swsusp Cleanups
>    
>    - do_magic()
>      - Rename to swsusp_arch_suspend().
>      - Move declaration to swsusp.c
>    
>    - arch_prepare_suspend()
>      - Return an int
>      - Fix x86 version to return -EFAULT if cpu does not have pse, instead of 
>        calling panic().
>      - Call from swsusp_save().
>    
>    - do_magic_suspend_1()
>      - Move body to pm_suspend_disk()
>      - Remove.
>    
>    - do_magic_suspend_2()
>      - Rename to swsusp_suspend()
>      - Move IRQ fiddling to suspend_save_image(), since that's the only call 
>        that needs it. 
>      - Return an int.
>    
>    - do_magic_resume_1()
>      - Move body to pm_resume().
>      - Remove
>    
>    - do_magic_resume_2()
>      - Rename to swsusp_resume(). 
>      - Return an int. 
>    
>    - swsusp general
>      - Remove unnecessary includes.
>      - Remove suspend_pagedir_lock, since it was only used to disable IRQs.
>      - Change swsusp_{suspend,resume} return an int, so pm_suspend_disk() knows
>        if anything failed. 

Gracious renames to make sure I can not orient in the code :-(.

-/* do_magic() is implemented in arch/?/kernel/suspend_asm.S, and
basically does:
+/* swsusp_arch_suspend() is implemented in arch/?/power/swsusp.S,
+   and basically does:

        if (!resume) {
-               do_magic_suspend_1();
                save_processor_state();
                SAVE_REGISTERS
-               do_magic_suspend_2();
+               swsusp_suspend();
                return;
        }
        GO_TO_SWAPPER_PAGE_TABLES
-       do_magic_resume_1();
        COPY_PAGES_BACK
        RESTORE_REGISTERS
        restore_processor_state();
-       do_magic_resume_2();
+       swsusp_resume();

  */


do_magic_suspend_1() did disable interrupts, where do you disable them
now?

Did you test it with CONFIG_PREEMPT to hunt for "scheduling in atomic"
bugs?

Your new naming is even worse than my original (and that's quite an
achievement).

swsusp_write() does
	swsusp_arch_suspend(), which in turn calls
		swsusp_suspend()
			^- and that does the writing.
			Ouch. do_magic_* was clearer than *that*.

I do not see why you had to change to BIOs just now. Perhaps you
should get it into stable state, first, and then adding more code to
make it look 2.6-like is good idea?

[Will add more comments after a test].
									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
