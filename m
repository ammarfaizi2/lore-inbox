Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVBITya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVBITya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 14:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVBITya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 14:54:30 -0500
Received: from [195.23.16.24] ([195.23.16.24]:38017 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261903AbVBITyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 14:54:19 -0500
Message-ID: <420A6A5C.8030106@grupopie.com>
Date: Wed, 09 Feb 2005 19:54:04 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209191817.GA1534@ucw.cz>
In-Reply-To: <20050209191817.GA1534@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Wed, Feb 09, 2005 at 06:08:10PM +0000, Paulo Marques wrote:
> [...]
> Touchscreens are one class of devices where the serial attachment is not
> dying.

Very true.

>[...]
>>We could parse a definition "string", like this:
>>
>>"SIZE:10,SYNC:0:8:85,SYNC:8:8:54,X:24:8:1,X:32:8:256,Y:40:8:1,Y:48:8:256,T:16:2:1"
>>
>>This string defines the touch driver for elotouch, 10 bytes packet (I 
>>didn't include the pressure reading, for simplification).
>>
>>I currently have 6 different "drivers" that would all fit into this 
>>model. The same goes for all 3 elotouch protocols that you implemented.
>>
>>Does this sound like a good idea?
> 
> I don't think so. I don't think the saving of code is worth the
> obfuscation, after all, 6 drivers is still not so much.
> 
> Also, direct code implementation can implement better synchronization
> methods and faster resynchronization in case of lost bytes.

Agreed.

A touch screen driver is pretty small already. The only advantage would 
actually be to support new touchscreens without actually changing the 
kernel, but if we write the code for the touchscreens we already know, 
we will probably not see that many "new" touchscreens with weird protocols.

> And then there are protocols like the Gunze one, which wouldn't be
> covered by this.

Actually the string for the gunze touchscreen would be something like 
(constructed from interpreting the gunze.c source code):

"SIZE:11, SYNC:0:5:80,SYNC:40:8:44,SYNC:80:8:13, 
X:12:4:1000,X:20:4:100,X:28:4:10,X:36:4:1, 
Y:52:4:3000,Y:60:4:300,Y:68:4:30,Y:76:4:3, T:2:1:1"

Yes, it doesn't look good ;)

And I agree that we would probably not be able to cover _all_ touchscreens.

>[...]
> 
> We could have a library that would do that and link applications against
> it. It could also handle things like tap-n-drag, etc, something we
> certainly don't want in the kernel.

I really like this idea :)

A libtouch library that handled calibration (this includes mirroring and 
swapping the coordinates) and other goodies (like filtering out short 
"touch release" events while dragging, etc.) would be a good standard 
interface for all applications.

Being in user space would also mean that the library could do things 
like keeping a /etc/touch.conf file where it would read default 
calibration data, etc.

>[...]
>>I would say that a tool to recover the touch screen into a "usable" 
>>state, by talking directly to the serial port, and "calibrating" it to 
>>max possible / min possible values would be the best way to deal with this.
> 
> 
> I agree with that. It could possibly even be put into the inputattach
> init routine for the specific touchscreen.

This certainly seems like a good place for it, yes.

>>Modern touchscreens just send the A/D data to the PC, and let the real 
>>processor do the math (it can even do more complex calculations, like 
>>compensate for rotation, etc.). IMHO calibration should be handled by 
>>software.
> 
> 
> And this is something the kernel certainly won't do. Floating point math
> is possible in the kernel with some jumping through hoops, but avoiding
> it is usually the better option.

We don't necessarily need floating point (even with 32 bits we have 
plenty of space for fixed point arithmetic), but I agree that this would 
be better handled in a library.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
