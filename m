Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268250AbUIKRtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268250AbUIKRtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUIKRty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:49:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:51692 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268254AbUIKRtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:49:24 -0400
Date: Sat, 11 Sep 2004 10:49:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jon Smirl <jonsmirl@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1094919501.21088.111.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0409111041550.2341@ppc970.osdl.org>
References: <9e47339104090919015b5b5a4d@mail.gmail.com> 
 <9e47339104091008115b821912@mail.gmail.com>  <1094829278.17801.18.camel@localhost.localdomain>
  <9e4733910409100937126dc0e7@mail.gmail.com>  <1094832031.17883.1.camel@localhost.localdomain>
  <9e47339104091010221f03ec06@mail.gmail.com>  <1094835846.17932.11.camel@localhost.localdomain>
  <9e47339104091011402e8341d0@mail.gmail.com>  <Pine.LNX.4.58.0409102254250.13921@skynet>
  <20040911132727.A1783@infradead.org>  <9e47339104091109111c46db54@mail.gmail.com>
  <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
 <1094919501.21088.111.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Sep 2004, Alan Cox wrote:

> On Sad, 2004-09-11 at 18:02, Linus Torvalds wrote:
> > My personal preference for this whole mess has always been the "silly 
> > driver" that isn't even hardware-specific, and really does _nothing_ on 
> > its own. This one would be the only thing that actually reserves the IO 
> > regions and "owns" the card from the respect of the resources. EVERYBODY 
> > else would be a "stealth" driver. Not just DRM.
> 
> How do you plan to deal with hot plug. At the point the "silly driver"
> (in my case this is the vga class driver) claims the PCI device and
> propogates things onwards hotplug seems to work.

Since the users would have to use the locking methods, they'd all be
dependent on it, so it would either be compiled in, or "modprobe" would 
just automagically load it.

And yes, it would just attach directly to any VGA class device on PCI (and 
have some other way to detect any other kind of graphics devices).

If we make it small, simple and generic enough (serialization isn't really
a gfx-only thing), we could frigging attach it to _every_ device in the
system, at which point it doesn't even need to "attach" any more. It would 
just be there. That obviously requires that it really only do a _very_ 
generic set of minimal locks.

> The second fun bit is that Jon is right that in some cases the fb driver
> for a card may want to use the DRI layer if loaded - but only some and
> only in a controlled manner. Sometimes the drivers want to co-operate
> sometimes they just want to avoid beating each other senseless.

They can put whatever data they want in the shared data area (called
"gfx_data" in my previous pseudo-code-posting). They'd need to know about
each other if they want to cooperate, of course. The "silly driver" never 
uses the data area itself, really. It just contains a few predefined 
things, like the lock pointers, but the silly driver doesn't really even 
access them, it's up to the low-level drivers to pass in the proper lock 
to the silly driver.

> >    Now, the reason why these things are _pointers_ to locks rather than 
> >    locks themselves is that maybe some hardware ends up sharing resources 
> >    between these things (maybe "modeswitch" needs the accelerator to 
> 
> How do you deal with making sure the lock doesn't get freed and knowing
> who needs it still ? I ended up with locks in the shared area itself
> because I couldn't figure that one out ?

That's exactly what I would do. See the example I sent out.

> Linus let me run what I have now past you for comment (the code isnt
> working yet since I've been having a fight with the class code)

Please realize that I have not a _frigging_ clue what I'm talking about. 
I'm just listening in to the flame war, and throwing out suggestions in 
the middle to try to get the discussion going _forward_. I hate seeing 
hundreds of emails in my mailbox that don't seem to actually make any 
_progress_.

So my comments are likely worthless.

		Linus
