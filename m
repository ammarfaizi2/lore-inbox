Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTFVPB7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 11:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTFVPB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 11:01:59 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:27011 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264094AbTFVPB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 11:01:58 -0400
Date: Sun, 22 Jun 2003 17:15:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: CaT <cat@zip.com.au>
Cc: Pavel Machek <pavel@suse.cz>, swsusp@lister.fornax.hu,
       linux-kernel@vger.kernel.org
Subject: Re: can't get linux to perform a bios suspend (was: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend)
Message-ID: <20030622151549.GD199@elf.ucw.cz>
References: <20030613033703.GA526@zip.com.au> <20030615183111.GD315@elf.ucw.cz> <20030616001141.GA364@zip.com.au> <20030616104710.GA12173@atrey.karlin.mff.cuni.cz> <20030618081600.GA484@zip.com.au> <20030618101728.GA203@elf.ucw.cz> <20030618102602.GA593@zip.com.au> <20030618103528.GB203@elf.ucw.cz> <20030621142400.GB5388@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030621142400.GB5388@zip.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ponderance: Why did it do a full s/w suspend when I asked for the bios
> > > to handle it? I have s4bios showing up in /proc/acpi/sleep and the bios
> > > is set to suspend to disk. I've even got an a0 partition fully formatted
> > > and it still ignored it all.
> > 
> > I don't know, try looking at drivers/acpi/sleep/main.c, and if
> > neccessary insert some printk()s to see what's going on.
> 
> I've had a wee look into it and if I remove software suspend from the
> compile, I get no sleep states at all. period. /proc/acpi/sleep does
> not exist and nothing is reported in dmesg.
> 
> Now I had a look in drivers/acpi/sleep and in the proc.c file I found
> this bit of code:
> 
> ...
>         state = simple_strtoul(state_string, NULL, 0);
> 
>         if (state < 1 || state > 4)
>                 goto Done;
> 
>         if (!sleep_states[state])
>                 goto Done;
> 
> #ifdef CONFIG_SOFTWARE_SUSPEND
>         if (state == 4) {
>                 software_suspend();
>                 goto Done;
>         }
> #endif  
>         status = acpi_suspend(state);
> ...
> 
> To me this appears to indicate that it's treating a request for a
> sleep state of 4 (s/w suspend) and 4b (bios suspend) as the same thing
> as simple_strtoul will stop at the b and return 4 and there are no
> further checks being done. In a small experiment I added a test of
> state_string[1] == 'b', recompiled and tried it again. It did not go
> into s/w suspend as expected but it failed to do a suspend alltogether.
> 
> At this point I'm slightly lost. To me it's obvious that there's
> something whacky with acpi_suspend() or something it calls but I'm
> not sure what. :/

If you have 2.4.X, get 2.5.72. That should have
do_suspend_lowlevel_s4bios in wakeup.S. Look around and fix it so that
it is called when user does echo 4b. It may well be broken.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
