Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVKCIPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVKCIPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVKCIPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:15:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54031 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751134AbVKCIPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:15:37 -0500
Date: Thu, 3 Nov 2005 08:15:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Robert Schwebel <robert@schwebel.de>, Pavel Machek <pavel@suse.cz>,
       Robert Schwebel <r.schwebel@pengutronix.de>, vojtech@suse.cz,
       rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: best way to handle LEDs
Message-ID: <20051103081522.GA21663@flint.arm.linux.org.uk>
Mail-Followup-To: John Lenz <lenz@cs.wisc.edu>,
	Robert Schwebel <robert@schwebel.de>, Pavel Machek <pavel@suse.cz>,
	Robert Schwebel <r.schwebel@pengutronix.de>, vojtech@suse.cz,
	rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de> <20051102211334.GH23943@elf.ucw.cz> <20051102213354.GO23316@pengutronix.de> <38523.192.168.0.12.1130986361.squirrel@192.168.0.2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38523.192.168.0.12.1130986361.squirrel@192.168.0.2>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 08:52:41PM -0600, John Lenz wrote:
> On Wed, November 2, 2005 3:33 pm, Robert Schwebel said:
> > On Wed, Nov 02, 2005 at 10:13:34PM +0100, Pavel Machek wrote:
> >> We have some leds that are *not* on GPIO pins (like driven by
> >> ACPI). We'd like to support those, too.
> >
> > One more argument to have a LED framework which sits ontop of a lowlevel
> > one.
> >
> 
> Except the led code that is being proposed CAN sit on top of a generic
> GPIO layer.

I also have issues with a generic GPIO layer.  As I mentioned in the
past, there's serious locking issues with any generic abstraction of
GPIOs.

1. You want to be able to change GPIO state from interrupts.  This
   implies you can not sleep in GPIO state changing functions.

2. Some GPIOs are implemented on I2C devices.  This means that to
   change state, you must sleep.

(1) and (2) are incompatible requirements, so you can not offer a
generic interface for these GPIOs which has a consistent behaviour -
where users of the interface know whether the function may sleep or
may be used from interrupt context.

If you also consider that LEDs may be connected to these GPIOs, and
you may wish to change their state from interrupt context, you also
run into these same issues - you have an interface which has ill-
defined behaviour and ill-defined calling requirements.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
