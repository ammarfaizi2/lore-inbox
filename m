Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbSJMAsV>; Sat, 12 Oct 2002 20:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSJMAsV>; Sat, 12 Oct 2002 20:48:21 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:8452 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261394AbSJMAsU>;
	Sat, 12 Oct 2002 20:48:20 -0400
Date: Sat, 12 Oct 2002 17:49:39 -0700
From: Greg KH <greg@kroah.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] pl2303 oops in 2.4.20-pre10 (and 2.5 too)
Message-ID: <20021013004938.GF12469@kroah.com>
References: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net> <20021009235332.GA19351@kroah.com> <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net> <20021011170623.GB4123@kroah.com> <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net> <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 01:56:04PM -0700, Barry K. Nathan wrote:
> The following patch (which reverts part of 2.4.20-pre2) seems to fix my
> pl2303 oopsing (and let me use the device properly again) in 2.4.20-pre2
> through -pre5. This patch doesn't work with -pre6 or up though (due to
> white space differences and, more importantly, the removal of all 6
> variables referenced in the if-statement).
> 
> Anyway, I'm posting this in case it provides another clue as to what's
> not working.

Ah, thanks for finding this.  Yes this does help, a bit.  Hm.  What /dev
device are you trying to write to, ttyUSB0 or ttyUSB1?  Yeah, I think we
need this kind of check back in to fix this problem, but I don't see off
the top of my head how to add it back...

And yes, the problem in 2.5 where you see the device register itself
twice is a known bug (to me at least), it goes away if you disable
CONFIG_USB_SERIAL_GENERIC.  It's on my TODO list, which seems to be
getting longer every day...

Any suggestions on how to fix this are appreciated.  Basically we don't
want to claim the interface that only has the interrupt endpoint on it
for this device, as we kinda already did in the section entitled END
HORRIBLE HACK FOR PL2303.  I guess we could just mark that interface as
claimed already, and then probe() would not get called again.  Want to
throw a call to usb_driver_claim_interface() into that section, grabbing
that interface, and see if that works?

thanks,

greg k-h
