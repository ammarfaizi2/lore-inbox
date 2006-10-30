Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWJ3NXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWJ3NXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWJ3NXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:23:03 -0500
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:32464 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030195AbWJ3NXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:23:01 -0500
Message-ID: <4545FCB1.8030900@grupopie.com>
Date: Mon, 30 Oct 2006 13:22:57 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Franck <vagabon.xyz@gmail.com>
CC: Miguel Ojeda <maxextreme@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>	 <453CE85B.2080702@innova-card.com>	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com> <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com> <4545C52A.5010105@innova-card.com>
In-Reply-To: <4545C52A.5010105@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franck Bui-Huu wrote:
> Miguel Ojeda wrote:
>> [...]
>> Anyway, an animation of 10 Hz wouldn't be fine at this
>> kind of LCDs, so it is pointless which the refresh rate of the driver
>> is, as it is not useful to display images as fast as the driver
>> refresh the LCD.
> 
> An application might want to display quickly a set of images, not for
> doing animations but rather displaying 'fake' greyscale images.

To do "fake" greyscale you would need to synchronize with the actual 
refresh of the controller or you will have very ugly aliasing artifacts.

Since there is no hardware interface to know when the controller is 
refreshing, I don't think this is one viable usage scenario.

>> Well, mmaping is the best option, as it is the easiest and the
>> fastest. Any use will be better using mmaping than doing synchrone
>> write(). Yes, many uses just need a write() call, but other uses would
>> need mmap.
> 
> That's true for devices which have a frame buffer. But it's not your
> case. You _emulate_ this behaviour and I can see big drawbacks to
> this design:
> 
>   - You need to keep synchrone your buffer and the display every
>     100ms. It makes your CPU busy even if nothing has been written in
>     LCD for a while. Futhermore this kind of display is likely to run
>     on embedded system where CPU speed can be less than 100MHz.

It is not *that* bad. If nothing has changed, the driver only pays the 
cost of a 1024 bytes memcmp. Even more, there are no current users for 
anything other than a PC, so I think we shouldn't overdesign at this point.

>   - All accesses to the device depend on the previous behaviour whereas
>     write(), read() syscall could be synchrone and easier to use for
>     fast writing of image sets. Actually the refresh stuff is really
>     needed only if you mmap the device. And it seems not really used
>     for now since it was broken on your last patch.

That is not entirely true. If a user-space application misbehaves and 
starts writing faster than what can actually be seen, not having a fixed 
refresh rate means that your CPU will be *very* busy writing garbage 
that the user won't be able to see.

A fixed refresh rate is a maximum CPU usage tunable that prevents 
applications (that are not aware that this is an external slow device) 
to write more than what they should.

This can be improved, however.

We could have the concept of a "dirty" buffer. Any write or nopage call 
would set the dirty flag and set a timer to refresh the display in one 
refresh period from now.

When doing the actual refresh, the "dirty" flag would be cleared and the 
buffer unmapped.

In this case, if nothing was ever written to the display, the CPU usage 
would be _zero_ (as it should), and it would work nicely with dynticks 
and such.

Anyway, I think that the driver is useful as is and fulfills its 
original goals: drive an LCD connected to a parelel port on a PC.

Since the actual userspace interface supports the suggested 
improvements, we can just merge now and improve it later to support 
different usage scenarios as they appear (or even before they appear).

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
