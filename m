Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbUAPXPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 18:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbUAPXPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 18:15:25 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:26328 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265869AbUAPXPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 18:15:17 -0500
Message-ID: <4008709E.6030207@pacbell.net>
Date: Fri, 16 Jan 2004 15:15:42 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] improce USB Gadget Kconfig
References: <20031123172356.GB16828@fs.tum.de> <3FF0F6F5.10409@pacbell.net> <Pine.LNX.4.58.0401152200330.2530@serv> <400749F3.6070203@pacbell.net> <Pine.LNX.4.58.0401162118320.2530@serv>
In-Reply-To: <Pine.LNX.4.58.0401162118320.2530@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 15 Jan 2004, David Brownell wrote:
> 
>> > choice values can also be tristate symbols, so you wouldn't need the
>> > separate defines, unless you really always want to compile only a 
>> > single controller (even as module).
>>
>> That's it precisely.  USB devices have only one (upstream) link;
>> they're not like hosts.  And its link to the controller isn't
>> re-wired on the fly any more than, say, the MMU.  Kconfig just
>> needed some persuasion before it'd dance that way.
> 
> 
> It's still weird. Where is the problem to compile all controllers as
> module? At runtime you still have the possibility that only one of them
> can be loaded and the next one would fail to load.

The problem is something I accidently neglected to respond to in your
previous note.  Those controllers aren't drop-in substitutes for one
another, and you seemed to be assuming they were.


>> > The dependency "USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_SA1100
>> > || USB_GOKU" can be basically reduced to "USB_GADGET".

That's where I accidentally trimmed out a response.  It's wrong; those
controllers are not equivalent in general.  Gadget drivers that work with
one controller will not automagically work with another.  Two quick examples
should illustrate the point:

  (i) A "video" gadget driver would requires isochronous transfer support.
      But only two of those controllers support that (net2280, pxa2xx_udc).

      So a video (or audio) class gadget driver would depend on configuring
      an appropriate controller ... and even then, it'd probably compile in
      more code if it's talking to a controller that supports high bandwidth
      transfer modes (up to 24 MByte/sec) than one maxing ouat a 1 Mbyte/sec.

(ii) Essentially every controller has endpoints that differ from the others
      in capabilities like addressing, direction, supported packet sizes
      transfer modes, or throughput.  All of those are things that MUST be
      reported to the USB host in device descriptors.

      The differences are currently all handled by conditional compilation.
      Until a gadget driver has that support for a particular controller,
      it shouldn't be possible to configure that combination.

There's some work afoot to do more autoconfiguration, but it won't be able
to handle all the issues for all drivers.  I have hopes that at least some
simple configurations -- two endpoints for bulk data (IN/OUT) and one
for status (interrupt IN), for example -- will be able to autoconfigure
at some point.


>> Reproduced it again here today, with a reasonably current 2.6.1
>> tree on top of RH9 (plus some updated RPMs from RH).  It's there
>> in gconfig too.  The workaround is "vi .config" and delete the
>> sticky DUMMY_HCD entry, then re-configure.
> 
> 
> It really works fine here, are you sure you don't have any additional
> changes under scripts/kconfig? Did you try this on a different machine?

Absolutely certain.  Yes, tried on multiple machines.  Did you try
it on RH9?  Since it's working for you, I wonder if that's the source
of the difference.  Same bug in xconfig, gconfig, and menuconfig;
doesn't make a lot of sense to me but then I've not looked at that
code in any case.

- Dave


