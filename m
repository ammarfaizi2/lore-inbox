Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTEPPUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 11:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTEPPUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 11:20:19 -0400
Received: from ida.rowland.org ([192.131.102.52]:20996 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264454AbTEPPUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 11:20:17 -0400
Date: Fri, 16 May 2003 11:33:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       <johannes@erdfelt.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
In-Reply-To: <1053026258.1548.7.camel@doobie>
Message-ID: <Pine.LNX.4.44L0.0305161045270.738-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul:

On 15 May 2003, Paul Fulghum wrote:

> I think I misread your message. Is there a per port resume
> indication? (I'm at home and don't have the specs in front
> of me) I was thinking of the global USBSTS_RD bit.

You can probably find this information in your copy of the specs.  Bit 6 
of the PORTSC register is Resume Detect.  When that bit gets set, the host 
controller signals a global resume and presumably sets bit 2 of the USBSTS 
register.

> If you can qualify the global USBSTS_RD bit with a per
> port resume indication on a non OC port, then it might
> make sense to do this on the wakeup side.
> 
> Pro: you could suspend the controller when appropriate
> without interference from the OC ports
> 
> Con: you would be generating a lot of spurious interrupts
> as the global USBSTS_RD is set (incorrectly) by the OC ports.
> Even though you would not actually do the wake, you still
> burn cycles servicing the false interrupts.

I'm not sure about that.  For ports in a permanent OC state, the RD bit 
would get set just once, so a single interrupt would be generated.  When 
the host clears the Resume Detect bit in the USBSTS register, it shouldn't 
get set again (not until a different port signals a resume).  Otherwise a 
properly working system would generate continuous interrupts during the 
global resume sequence.

That's just guesswork on my part; the spec isn't sufficiently precise to 
be certain one way or the other.  You can find out pretty easily by 
testing the driver on your machine.  Just don't do anything in the ISR 
when USBSTS_RD is set.  Come to think of it, I can try the same thing 
here.

> So my inclination is still to nab this on the suspend side.

By a nice coincidence, my system has a 8086:7112 controller -- wired up 
correctly and perfectly useable.  So I can easily test to make sure that 
the final proposed change works okay on a good system.

BTW, I'm not entirely pleased with the size of my test patch.  It's a bit 
lengthy for something intended mainly to move a delay loop outside an ISR.  
But I couldn't think of any simpler way to do it, and once the state 
transition code is there it's really no harder to add the 1-second "grace" 
periods.  So of the three ingredients we've got here (20ms delay outside 
of ISR, "grace" periods, checking for OC ports), I don't think we could 
make the patch much simpler by eliminating any.  What do you think?

Alan Stern

