Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUCRLFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbUCRLFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:05:41 -0500
Received: from mail9.messagelabs.com ([194.205.110.133]:59840 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S261748AbUCRLFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:05:16 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-31.tower-9.messagelabs.com!1079608012!6473002
X-StarScan-Version: 5.1.15; banners=arcom.com,-,-
Subject: Re: [PATCH] PXA255 LCD Driver
From: Ian Campbell <icampbell@arcom.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0403171723330.15898-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0403171723330.15898-100000@phoenix.infradead.org>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1079607908.2175.67.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 11:05:09 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James (and everyone),

> The way to handle different types of displays, LCD, CRT etc has 
> improved greatly in the latest 2.6.X kernels. You don't need to lock yourself 
> into the standard modedb database. Also  modedb is used only for selecting a 
> particular resolution. The structure used to define the display panels 
> behavior is struct fb_monspecs. Take a look at it in fb.h. I'm interested 
> if I got all the needed data from the EDID about a display panel.

I understand what you are saying (I think...), but I'm not sure how it
applies to my situation -- my embedded LCD controller has no analogue
for much of the stuff in fb_monspecs and has some extra stuff which are
not present there.

If I explain what the situation is with the PXA LCD controller perhaps
you can give me some advice onto how I can massage this into the current
system, or extend the system to my needs.

Essentially the LCD controller<->panel interface has 16 data pins, an
output enable, a pixel clock and (HV)sync. There is nothing
'intelligent' in the controller, it needs to be told explicitly how it
should manage these pins. The settings depend on the panel you have
attached and there is no way to automatically derive them, the panel is
not like a monitor really, it just shifts in pixel data on each clock
pulse and puts it on the display.

The settings which are of interest on a PXA255 are that aren't present
in fb_monspecs, they specify the physical interface between the
processor and the panel:

        active(==TFT) or passive(==STN), 
                These are two fundamentally different types of panel. It
                impacts when the pixclock ticks (all the time or just
                when data is present), and some other timing stuff.
        output enable polarity
                panel is enabled on low or high
        pixel clock polarity
                should the panel shift in data on a rising or a falling
                edge
	dual or single panel
                some STN panels are physically two panels stacked on top
                of each other, this impacts the way pixel data is packed
                onto the data lines
        4pix or 8pix STN mono
                Monochrome STN panels take either 4 or 8 pixels at a
                time.

All of these differ from panel to panel, pretty much at the whim of the
manufacturer...

The other settings I think are already accounted for in the mode db:
        resolution, bit depth, color/mono/grayscale, pixel clock, h and
        vsync length, Left-Right-Upper-Lower margins.
However -- all these are fixed in hardware for any given panel (although
you could emulate different resolutions in s/w I guess).

Because the driver is often used in an embedded environment the settings
are often hardcoded at compile time.

My problem is that I need to support Arcom's development kits, which a
customer might plug just about any TFT or STN panel into, so I need to
be able to control all of the above settings from the command line or
module parameters, or to pass in something like the LCD part # and have
the settings looked up from a DB. However I would like to keep the
overhead for others who just want a single static panel to be as small
as possible.

I also don't know how applicable all this is to other embedded LCD
controllers --- the StrongArm hardware is very close to the PXA
hardware, and I think all controllers which are as low level as them
will share the same settings (since they are down to the hardware
interface). I don't know for sure though.

My thinking prior to this discussion was to go for a database which maps
LCD part # to all the settings above, where each LCD is selectable from
Kconfig and a default can be specified (sort of like NLS now). People
with a static panel would only build in the one database entry, people
like me could build in a selection and choose from the command line etc
(with overrides for all the above). 

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been checked for all viruses by MessageLabs Virus Control Centre.
