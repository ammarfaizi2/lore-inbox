Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270724AbUJUQ4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270724AbUJUQ4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270721AbUJUP7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:59:37 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:10246 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270661AbUJUP5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:57:10 -0400
Message-ID: <4177DF15.8010007@techsource.com>
Date: Thu, 21 Oct 2004 12:08:53 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Stephen Wille Padnos <spadnos@sover.net>
CC: Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com>	 <9e4733910410201808c0796c8@mail.gmail.com> <9e473391041020181150638b4@mail.gmail.com> <4177185A.9080708@sover.net>
In-Reply-To: <4177185A.9080708@sover.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Wille Padnos wrote:
> Jon Smirl wrote:
> 
>> Another thought, TV out is important in the embedded market. Think
>> about Tivo/MythTV/set top boxes.
>>
> OK - so the answer seems to be "if it does the right things, then it may 
> sell"  It's hard to sell a card that doesn't do good 3D these days (re: 
> Matrox Parhelia).  Speaking of the parhelia, I would look at that 
> feature set as a starting point.  10-bit color, multiscreen accelerated 
> 3D, dual DVI, gamma corrected glyph antialiasing, etc.

I was thinking of pointing at the Permedia 2 or 3 as an example of the 
basic 3D feature set.

> 
> So, let's try to figure out the right feature set.  (that is what was 
> originally asked for, after all)
> 
> Looking at 2D, I would definitely want to see: (some taken from other 
> emails on the subject)

> alpha blending

Easy enough.

> antialiasing (related to alpha blending)

Antialiasing implies oversampling or supersampling, unless you're 
thinking about something else.  Sometimes, "antialiasing" is nothing 
more than a fuzzy texture.  For instance, the way the X11 font server 
handles antialiased text... it just spits out a grayscale bitmap which 
can be used as texture.

> bitblt
> fast primitive drawing

No problem.

> accelerated offscreen operations

It's funny that people mention that.  Every DDX module I have ever 
produced has had sophistocated off-screen memory management so that 
pixmaps could be accelerated.  I never even considered NOT supporting 
accelerated off-screen surfaces.

There was one chip I had to support a number of years ago which didn't 
have separate registers for the base pointers to source and destination 
surfaces.  That meant that you couldn't use "bitblt" to copy an image 
from off-screen to on-screen.  What I ended up having to do was 
implement bitblt as a texture-mapping operation.  (It wound up being 
slightly faster than the regular bitblt, even if the source and dest 
were the same surface.)

Anyhow, in my world, accelerated off-screen surfaces are a given.

> more than 8 bits/color channel

For rendering or for display?  A DVI transmitter won't do more than 8 
bits per channel, but it can be helpful to have more than 8 bits per 
channel for greater mathematical precision when compositing images.

> video output - preferably with independent scale / refresh (ie, clone 
> the 100Hz 1600x1200 monitor on a 648x480 60 Hz NTSC monitor)
 > video decoding acceleration (possibly some encoding functions as well)

While I have considered that for other products, I'm not sure I want to 
do through that trouble for a "low-end" card, unless you're happy with 
integer scaling, which isn't so bad.

Most LCD monitors I encounter will scale, but I don't know what's the 
best thing to do about your example.  I can see why you'd want to be 
able to squeeze your game display onto a TV, but I also wasn't thinking 
about supporting TV.  Consider how much that would increase the parts cost.

> bitmap scaling (think of font sizing and the like)
> 2D rotation
> possibly 2.5D rotation - ie, the perspective "twist" of a plane image 
> into 3D space (like Sun's Looking Glass environment)

Those are all subsets of texture-mapping.

> 
> I would think that a chip that has a lot of simple functions, but 
> requires the OS to put them together to actually do something, would be 
> great.  This would be the UNIX mentality brought to hardware: lots of 
> small components that get strung together in ways their creator(s) never 
> imagined.  If there can be a programmable side as well (other than 
> re-burning the FPGA), that would be great.

You're right, and you're not.  There are two reasons why modern 3D GPUs 
put the world mesh into the card framebuffer and do all the T&L in the 
GPU.  One reason is that it's faster to do it in dedicated hardware. 
The other more pressing reason is that the host interface (PCI or AGP) 
puts a very low upper-bound on your triangle rendering rate.

The number of parameters necessary to specify a single texture-mapped 
triangle are literally in the dozens.  If you did only 32-bit fixed 
point (16.16) for coordinates, that's still a huge amount of information 
to move across the bus to instruct the chip to render a single triangle. 
  And what if that triangle ends up amounting to a single pixel?  Think 
about the waste!

Instead, the un-transformed geometry is loaded into the card memory only 
once, and the GPU is instructed to render the scene based on the camera 
perspective and lighting information.  Aside from the need to cache 
textures on-card, this is another reason for the need to have LOTS of 
graphics memory.

> 
> I guess I would look at this as an opportunity to make a "visual 
> coprocessor", that also has the hardware necessary to output to a 
> monitor (preferably multiple monitors).

I don't think that's realistic.  We could do that, but it would have 
terrible performance.

