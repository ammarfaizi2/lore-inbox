Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTENVeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbTENVeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:34:20 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:44100 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262912AbTENVeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:34:17 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
In-Reply-To: <20030514213028.GA4200@kroah.com>
References: <Pine.LNX.4.44L0.0305131117240.3274-100000@ida.rowland.org>
	 <1052840106.2255.24.camel@diemos> <20030513173044.GB10284@kroah.com>
	 <1052830860.1992.2.camel@diemos> <20030513180913.GA10752@kroah.com>
	 <20030513181120.GA10790@kroah.com> <1052946393.2974.7.camel@diemos>
	 <20030514213028.GA4200@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052948705.1995.10.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 May 2003 16:45:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 16:30, Greg KH wrote:
> On Wed, May 14, 2003 at 04:06:33PM -0500, Paul Fulghum wrote:
> > On Tue, 2003-05-13 at 13:11, Greg KH wrote:
> > 
> > I was looking over the PIIX3 datasheet and noticed
> > that the USBSTS_RD bit is only valid when the
> > device is in the suspended state.
> > 
> > This bit is being acted on regardless of the
> > suspend state of the controller in the ISR.
> > Could this be why the driver is detecting
> > false 'resume' signals and calling wakeup_hc()
> > when it shouldn't?
> > 
> > Maybe the code should be something like:
> > 
> > if (uhci->is_suspended && (status & USBSTS_RD))
> > 	wakeup_hc(uhci);
> 
> That's basically what the code I sent you did :)

Yes, that's right.

In this case suspend_hc() is being called anyways, so
the controller *is* in the suspended state.
suspend_hc() and wakeup_hc() are spinning back
and forth forever.

For some reason I thought this was firing without
a call to suspend_hc(), but I verified it with printks.

I tried it both with is_suspended, and again testing
USBCMD_EGSM in the command register (Greg's patch)
with same results.

So it is a good check to add to qualify USBSTS_RD,
but in this case it looks like the mainboard implementation
is FUBAR and bogus resume messages are being
recognized by the controller.

Is there some transient period after setting USBCMD_EGSM
before which the controller is not officially in the
suspended state that might cause a spurious
USBSTS_RD indication? (seems unlikely)

> > in the ISR to qualify acting on that status bit.
> > Alternatively, USBCMD_EGSM (BIT3) of the USBCMD
> > register could be tested to qualify action on
> > the state of USBSTS_RD
> > 
> > I'm going to test this now, but I wanted to
> > know what you think.
> 
> I think it's correct, but I don't think it will solve your problem.  I
> would be very happy to be wrong though.

You are right (IMO) that it is correct and should be added,
and you are also right in that it does not solve this problem.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


