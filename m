Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274908AbTGaVwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274909AbTGaVwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:52:54 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:4853 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S274908AbTGaVww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:52:52 -0400
Message-ID: <3F299069.1010905@pacbell.net>
Date: Thu, 31 Jul 2003 14:55:53 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>	 <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net>	 <20030726210123.GD266@elf.ucw.cz>  <3F288CAB.6020401@pacbell.net> <1059686596.7187.153.camel@gaston>
In-Reply-To: <1059686596.7187.153.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> 
> You should look at Patrick Mochel's stuff that shall be getting in
> the official tree this month hopefully. It does that (among others)

OK, thanks for the update.  It was puzzling to see this stuff
in such a state ... I've got a few patches for USB PM that are
worth putting back in advance of that, but it seems like real
testing will need to wait until "next month".  (Tomorrow!)


> The USB "device" drivers shall just rely on the Device Model
> infrastructure to have their suspend/resume callbacks be called at the
> appropriate time. 

Yes, that's no problem.  It looks like:

   static int my_suspend(struct device *_intf, u32 state, u32 level)
   {
       struct usb_interface   *intf;
       int                    retval = 0;

       intf = to_usb_interface(_intf);
       switch (level) {
       ... cases are yet to stabilize ...
       }
       return retval;
   }

   ... similar for resume()

   static struct usb_driver my_driver {
        .owner =      THIS_MODULE,
        .name =       "MyFirstDriver",
        .probe =      my_probe,
        .disconnect = my_disconnect,
        .id_table =   my_id_table,
        .driver = {
              .suspend =    my_suspend,
              .resume =     my_resume,
         },
    };

But until the suspend()/resume() callback API stabilizes, it's
mostly useful to know that it'll be exactly that simple, and
that usbcore doesn't get in the way.


I suspect that USB should do some non-global PM stuff too.
Hub ports can be suspended when the devices connected to them
are idle for long enough ... that's not something I'd expect
system-wide PM policies to address.

- Dave


