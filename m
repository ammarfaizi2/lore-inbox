Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWCHSd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWCHSd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 13:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWCHSd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 13:33:26 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:21900 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932186AbWCHSd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 13:33:26 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Fw: Re: oops in choose_configuration()
Date: Wed, 8 Mar 2006 10:33:21 -0800
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0603080947270.5220-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0603080947270.5220-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081033.21584.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if that SCSI fix (restoring a wrongly deleted mem clear) helps
get rid of this oops too?


On Wednesday 08 March 2006 7:30 am, Alan Stern wrote:
> > > a) How come we're only considering the zeroth slot in that array in here?
> > 
> > We start out with the first interface setting, as we always know we have
> > one of them as per the USB spec (I think, anyone from linux-usb-devel
> > want to verify this?)
> 
> In this case it wouldn't make any difference, since all the altsettings
> for a particular interface are supposed to have the same bInterfaceClass,
> bInterfaceSubClass, and bInterfaceProtocol.  Although I don't think the
> USB spec actually says this anywhere..

I'd have stopped at "wouldn't make any difference"; the kernel must make
some initial choice, but userspace is free to revise it.  Agreed it would
be odd if altsettings had different class/subclass/protocol, but I don't
see any good reason to make that illegal.


> The bMaxPower value could be different for different altsettings. 

Erm, no; that's a per-configuration thing, not a per-altsetting thing.
It's checking the config descriptor, not the interface descriptor,
for that particular concern.


> > > b) How do we know that there's actually anything _there_?  The length of
> > >    that variable-sized array doesn't seem to have been stored anywhere
> > >    obvious by usb_parse_configuration() and choose_configuration() doesn't
> > >    check.  What happens if the length was zero?
> > 
> > I don't think it is allowed to be, as all USB devices have to have at
> > least 1 interface.

I think that's not true, and it would be worth verifying that it's not
a no-interfaces device even if the USB spec required it.  It's trivial
to create device firmware that advertises no-interfaces, and those should
never be able to make Linux hiccup (much less oops).


> The code in usb_parse_configuration() guarantees that the number of
> entries in the altsettings array is at least 1, because it sets nalts[n]
> to 1 initially and never decreases it.  The whole idea of an interface
> without altsettings makes no sense...

Right; there's always at least one setting.  Calling them "alt" settings
can be confusing; any one of them could be the "main" setting.

- Dave

