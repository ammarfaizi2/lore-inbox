Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbTL3XCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbTL3XB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:01:56 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:897 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S265907AbTL3XAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:00:13 -0500
Date: Wed, 31 Dec 2003 00:00:29 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
Message-ID: <20031230230028.GA778@ucw.cz>
References: <20031005171055.A21478@flint.arm.linux.org.uk> <20031228174622.A20278@flint.arm.linux.org.uk> <20031228182545.B20278@flint.arm.linux.org.uk> <Pine.LNX.4.58.0312281248190.11299@home.osdl.org> <20031230114324.A1632@flint.arm.linux.org.uk> <20031230165042.B13556@flint.arm.linux.org.uk> <20031230181741.D13556@flint.arm.linux.org.uk> <Pine.LNX.4.58.0312301045170.2065@home.osdl.org> <20031230194003.E13556@flint.arm.linux.org.uk> <20031230195303.F13556@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230195303.F13556@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 07:53:03PM +0000, Russell King wrote:
> On Tue, Dec 30, 2003 at 07:40:03PM +0000, Russell King wrote:
> > On Tue, Dec 30, 2003 at 10:47:10AM -0800, Linus Torvalds wrote:
> > > On Tue, 30 Dec 2003, Russell King wrote:
> > > > 
> > > > - i8042_noaux=1 - this doesn't seem to make any difference, although
> > > >   this does appear to leave the CTR set as 0x65, which appears to be
> > > >   the BIOS-set value.
> > > 
> > > Doesn't that leave the kbd mask the same? In particular, it still sets the 
> > > "disable" bit, aka I8042_CTR_KBDDIS later on..
> > 
> > Seems to.  With noaux unset, CTR is set to 0x47.
> > 
> > > What happens if you just define I8042_CTR_KBDDIS to zero?
> > 
> > That still causes suspend to fail.  I've separately tested I8042_CTR_KBDINT
> > set to zero as well, and that still causes failure.
> 
> I just tried this change to i8042.c, and suspend magically started
> working.
> 
> @@ -814,8 +815,8 @@
>         i8042_port_register(&i8042_kbd_values, &i8042_kbd_port);
>   
>         init_timer(&i8042_timer);
> -       i8042_timer.function = i8042_timer_func;
> -       mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
> +//     i8042_timer.function = i8042_timer_func;
> +//     mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
>   
>         register_reboot_notifier(&i8042_notifier);
>   
> So it looks like i8042 could do with hooking some power management
> to disable this timer before suspend and resume it afterwards.
> 
> Vojtech?

Agreed. There should already be some in -mm kernels, and I'll make sure
the timer is deleted before suspend. Thanks for finding this.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
