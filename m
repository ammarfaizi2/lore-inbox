Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268704AbUHLUMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbUHLUMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268718AbUHLUMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:12:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:15232 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S268704AbUHLUMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:12:10 -0400
Date: Thu, 12 Aug 2004 22:13:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "David N. Welton" <davidw@eidetix.com>
Cc: Sascha Wilde <wilde@sha-bang.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040812201344.GA270@ucw.cz>
References: <20040811141408.17933.qmail@web81304.mail.yahoo.com> <20040811175613.GA829@kenny.sha-bang.local> <411BA214.2060306@eidetix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411BA214.2060306@eidetix.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 07:00:04PM +0200, David N. Welton wrote:

> Sascha Wilde wrote:
> 
> >>>Is PS/2 supposed to support hotpluging at all?  I guess it's not,
> >>> but I may be wrong...
> >>
> >>Yes it is, at least with newer (or rather not ancient) hardware...
> >
> >
> >well, so the patch obviously can't be a final solution...
> 
> Yes, it doesn't strike me as being ideal.
> 
> 
> I noticed something odd though... I reported this in another email:
> 
> *With keyboard* :
> 
> mice: PS/2 mouse device common for all mice
> drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
> drivers/input/serio/i8042.c: 65 <- i8042 (return) [0]
> 
> *Without keyboard* :
> 
> mice: PS/2 mouse device common for all mice
> drivers/input/serio/i8042.c: fa <- i8042 (flush, aux) [0]
> drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
> drivers/input/serio/i8042.c: 9a <- i8042 (return) [0]
> 
> I noticed that
> 0x9a is the 'inverse' of 0x65.  If I set it to 0x65 and write that out,
> it still reboots afterwards!  Hrm.  I don't know what that means
> exactly, but apparently it *is* possible to write something to the
> controller and have it keep going.

0x65:
	Reserved bit is zero (must be)
	Scancode translation enabled
	AUX interface disabled
	KBD interface enabled
	Keylock not ignored
	Selftest OK
	AUX interrupt disabled
	KBD interrupt enabled

All in all, 0x65 is what one would expect to be in the CTR register
after boot on a normal machine without a PS/2 mouse installed.

0x9a doesn't make sense _AT_ALL_, though!

And there comes a thought ... 

In i8042_command(), we do this:

      if (!retval)
                for (i = 0; i < ((command >> 8) & 0xf); i++) {
                        if ((retval = i8042_wait_read())) break;
                        if (i8042_read_status() & I8042_STR_AUXDATA)
                                param[i] = ~i8042_read_data();
                        else
                                param[i] = i8042_read_data();
                        dbg("%02x <- i8042 (return)", param[i]);
                }

to distinguish whether a response came from the AUX interface instead of
the KBD or controller itself. We _negate_ the value if the AUXDATA bit is
set in he status register.

So I think what happens is that the controller sets the AUXDATA bit for
some reason (or at least we read a status byte with the AUXDATA bit
set), which negates the value when we read the initial CTR. 

Then when we write that nonsensical CTR back to the controller on
reboot, we're screwed, since the i8042 is the more important CPU in the
system and can do many nasty things to it. ;)

Now, the question is, where does that AUXDATA bit come from?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
