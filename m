Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTEPPpg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 11:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbTEPPpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 11:45:36 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:53553 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264463AbTEPPpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 11:45:34 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305161045270.738-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305161045270.738-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053100440.1948.17.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 May 2003 10:58:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 10:33, Alan Stern wrote:

> You can probably find this information in your copy of the specs.  Bit 6 
> of the PORTSC register is Resume Detect.  When that bit gets set, the host 
> controller signals a global resume and presumably sets bit 2 of the USBSTS 
> register.

Yes, I see that now.

> > Con: you would be generating a lot of spurious interrupts
> > as the global USBSTS_RD is set (incorrectly) by the OC ports.
> > Even though you would not actually do the wake, you still
> > burn cycles servicing the false interrupts.
> 
> I'm not sure about that.  For ports in a permanent OC state, the RD bit 
> would get set just once, so a single interrupt would be generated.  When 
> the host clears the Resume Detect bit in the USBSTS register, it shouldn't 
> get set again (not until a different port signals a resume).  Otherwise a 
> properly working system would generate continuous interrupts during the 
> global resume sequence.

Good point. The continuous interrupts I was seeing is because
the wakeup was actually being carried out, followed by the
thrashing between suspend and wakeup.

If your interpretation is true (which I suspect it is)
then global suspend could still be supported with only
a couple of extra interrupts after each suspend.

> That's just guesswork on my part; the spec isn't sufficiently precise to 
> be certain one way or the other.  You can find out pretty easily by 
> testing the driver on your machine.  Just don't do anything in the ISR 
> when USBSTS_RD is set.  Come to think of it, I can try the same thing 
> here.

I'll test this.

> By a nice coincidence, my system has a 8086:7112 controller -- wired up 
> correctly and perfectly useable.  So I can easily test to make sure that 
> the final proposed change works okay on a good system.

Good

> BTW, I'm not entirely pleased with the size of my test patch.  It's a bit 
> lengthy for something intended mainly to move a delay loop outside an ISR.  
> But I couldn't think of any simpler way to do it, and once the state 
> transition code is there it's really no harder to add the 1-second "grace" 
> periods.  So of the three ingredients we've got here (20ms delay outside 
> of ISR, "grace" periods, checking for OC ports), I don't think we could 
> make the patch much simpler by eliminating any.  What do you think?

Moving the wait out of the ISR and doing the wakeup
only for RD on non-OC ports are winners.

I can't comment on the 1 second grace period. Was that
in response to this investigation, or have you actually
seen false RD indications due to noise?

There is also the more trivial matter of removing the
unnecessary setting of the FGR bit on wakeup.

I'll check that the global RD interrupt does not
keep repeating after a false RD by an OC port.

So I suggest you build a patch that does all of
the above (with the grace period at your discretion).
Then we can both test it, and you can submit it
for actual inclusion.

Thanks,
Paul



