Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTFUOJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTFUOJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:09:34 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:2734 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264372AbTFUOJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:09:27 -0400
Date: Sun, 22 Jun 2003 00:24:01 +1000
From: CaT <cat@zip.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: can't get linux to perform a bios suspend (was: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend)
Message-ID: <20030621142400.GB5388@zip.com.au>
References: <20030613033703.GA526@zip.com.au> <20030615183111.GD315@elf.ucw.cz> <20030616001141.GA364@zip.com.au> <20030616104710.GA12173@atrey.karlin.mff.cuni.cz> <20030618081600.GA484@zip.com.au> <20030618101728.GA203@elf.ucw.cz> <20030618102602.GA593@zip.com.au> <20030618103528.GB203@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618103528.GB203@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 12:35:28PM +0200, Pavel Machek wrote:
> > Ponderance: Why did it do a full s/w suspend when I asked for the bios
> > to handle it? I have s4bios showing up in /proc/acpi/sleep and the bios
> > is set to suspend to disk. I've even got an a0 partition fully formatted
> > and it still ignored it all.
> 
> I don't know, try looking at drivers/acpi/sleep/main.c, and if
> neccessary insert some printk()s to see what's going on.

I've had a wee look into it and if I remove software suspend from the
compile, I get no sleep states at all. period. /proc/acpi/sleep does
not exist and nothing is reported in dmesg.

Now I had a look in drivers/acpi/sleep and in the proc.c file I found
this bit of code:

...
        state = simple_strtoul(state_string, NULL, 0);

        if (state < 1 || state > 4)
                goto Done;

        if (!sleep_states[state])
                goto Done;

#ifdef CONFIG_SOFTWARE_SUSPEND
        if (state == 4) {
                software_suspend();
                goto Done;
        }
#endif  
        status = acpi_suspend(state);
...

To me this appears to indicate that it's treating a request for a
sleep state of 4 (s/w suspend) and 4b (bios suspend) as the same thing
as simple_strtoul will stop at the b and return 4 and there are no
further checks being done. In a small experiment I added a test of
state_string[1] == 'b', recompiled and tried it again. It did not go
into s/w suspend as expected but it failed to do a suspend alltogether.

At this point I'm slightly lost. To me it's obvious that there's
something whacky with acpi_suspend() or something it calls but I'm
not sure what. :/

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
