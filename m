Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265968AbTFWJgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 05:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbTFWJgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 05:36:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38414 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265968AbTFWJgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 05:36:53 -0400
Date: Mon, 23 Jun 2003 11:50:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: CaT <cat@zip.com.au>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: can't get linux to perform a bios suspend (was: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend)
Message-ID: <20030623095058.GB6158@atrey.karlin.mff.cuni.cz>
References: <20030615183111.GD315@elf.ucw.cz> <20030616001141.GA364@zip.com.au> <20030616104710.GA12173@atrey.karlin.mff.cuni.cz> <20030618081600.GA484@zip.com.au> <20030618101728.GA203@elf.ucw.cz> <20030618102602.GA593@zip.com.au> <20030618103528.GB203@elf.ucw.cz> <20030621142400.GB5388@zip.com.au> <20030622151549.GD199@elf.ucw.cz> <20030623005814.GA583@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623005814.GA583@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > To me this appears to indicate that it's treating a request for a
> > > sleep state of 4 (s/w suspend) and 4b (bios suspend) as the same thing
> > > as simple_strtoul will stop at the b and return 4 and there are no
> > > further checks being done. In a small experiment I added a test of
> > > state_string[1] == 'b', recompiled and tried it again. It did not go
> > > into s/w suspend as expected but it failed to do a suspend alltogether.
> > 
> > If you have 2.4.X, get 2.5.72. That should have
> > do_suspend_lowlevel_s4bios in wakeup.S. Look around and fix it so that
> > it is called when user does echo 4b. It may well be broken.
> 
> Been using 2.5.x all this time. Just did the following mod on 2.5.72-bk3:
> 
> #ifdef CONFIG_SOFTWARE_SUSPEND
>         if (state == 4) {
>                 if (state_string[1] == 'b') {
>                         do_suspend_lowlevel_s4bios(0);
>                 } else {
>                         software_suspend();
>                 }
>                 goto Done;
>         }
> #endif  
> 
> And it activated bios suspend just fine. It didn't resume properly though.
> The bios resume screen was left behind and the whole setup hung. I've
> been using the suspend2disk functionality of this laptop under apm and 2.4.x
> just fine (for months really - I rarely 'rebooted' my laptop) so I don't
> think it's the bios that's b0rked.

And did you use S4bios with 2.4.X? apm and acpi are really different.

Modification you did is wrong; I'd try

#ifdef CONFIG_SOFTWARE_SUSPEND
        if ((state == 4) && (state_string[1] != 'b')) {
	        software_suspend();
                goto Done;
        }
#endif  

Does s3 work for you? s3 and s4bios should be really similar.

									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
