Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTDCQ6u 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 11:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261369AbTDCQ6u 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 11:58:50 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.26]:53697 "EHLO
	mwinf0504.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261362AbTDCQ6s 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 11:58:48 -0500
Date: Thu, 3 Apr 2003 19:10:09 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sven Luther <luther@dpt-info.u-strasbg.fr>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Message-ID: <20030403171009.GC1092@iliana>
References: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk> <Pine.GSO.4.21.0304031831030.23642-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0304031831030.23642-100000@vervain.sonytel.be>
User-Agent: Mutt/1.5.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 06:33:17PM +0200, Geert Uytterhoeven wrote:
> On 3 Apr 2003, Alan Cox wrote:
> > On Iau, 2003-04-03 at 15:15, Sven Luther wrote:
> > > > Read is not enough. If you have connected one /dev/fbx to two monitors,
> > > > you must find highest common denominator for them, and use this one.
> > > 
> > > Err, i don't understand this ? Do you mean you are outputing to two
> > > monitors at the same time ?
> > 
> > I think you mean lowest common denominator.
> > 
> > > If that is so maybe you mean, speaking in graphic card terminology, and
> > > not in fbdev one, that you are sharing one common framebuffer between
> > > two outputs, right, possibly doing mirroring tricks or something such ?
> > 
> > Classic example is a SiS 6326 driving monitor and TV. You need to keep
> > the display to TV acceptable ranges.
> 
> I don't know whether that's a good example...

Ok, i will take the card i am currently working on for XFree86 as an
example, and you (Alan and Petr mostly) will tell me if this is a common
case, or if i miss something.

It has two outputs, where i can hook either a DVI or a VGA monitor. Each
of these video outputs correspond to a viewport, and there is hardware
which will let you set the output timings and the dot clock. You also
have to configure which part of the framebuffer you are reading, and
eventually setup a scaller to scale the pixels you read to the correct
output buffer. You also have for each head a DDC/I2C bus you can use to
speak with the monitor.

On the other side, you have the framebuffer area, which you can split in
two or not, and is fully independent from the above head issues.

So you could either have one fbdev and two viewports inside it, or have
two separate viewports each with only one viewport.

What i am trying to implement for the XFree86 driver is to have a common
framebuffer, so the graphic engine can be shared between them without
further changes, enabling dual head DRI suppport for example. Sure i
have a 8K coordinates range which makes this easy, but maybe other cards
have more strenous limits there. 

Now, the plan is to separate the setup stuff that is common to the
_chip_ from the setup stuff that is specific to each _head_ or output.

In this case, it becomes easy to have the DDC port being specific to
each head, and this would sole all problems, since you would read all
the monitors attached to all the DDC buses, store them somewhere (and
ask again at the user demand, like Benjamin suggested), and when the
user changes the head mapping, or at head mapping initialization, have
the mode being validated against the monitors we _know_ are attached to
each DDC bus.

Now, i know that some boards have more DDC buses than heads or maybe
ramdacs, and things can be a bit more complicated. What do you say Petr ?
Could you yell us more about the matrox internal design with regard to
this ?

Friendly,

Sven Luther
