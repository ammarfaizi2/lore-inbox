Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUIVT5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUIVT5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUIVTxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:53:40 -0400
Received: from hagen.doit.wisc.edu ([144.92.197.163]:29682 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S266838AbUIVTxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:53:11 -0400
Date: Wed, 22 Sep 2004 19:53:07 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [PATCH] new class for led devices
In-reply-to: <20040922072727.GA4553@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <1095882787l.4629l.0l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CD 0, __CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-1, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.22.2, SenderIP=146.151.41.63
References: <1095829641l.11731l.0l@hydra> <20040922072727.GA4553@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/04 02:27:27, Vojtech Pavlik wrote:
> 
> Well, we already have an interface for setting LEDs through the input
> layer, it'd be trivial to create an input device driver with just  
> LEDs
> and no buttons/keys ...
>

It's not really a nice fit with what we are trying to do.  In the input  
layer, there is a whole list of led types, none of which make sense...  
For example, on the Sharp Zaurus, we have two leds, one green, one  
amber.  Which one is LED_NUML?  We don't enforce anything on the policy  
userspace has for the leds, sometimes it might use the amber led to let  
the user know they have new mail, and sometimes to show the power is  
plugged in, sometimes for something else (maybe even that caps lock or  
numlock is on).

Secondly, there is no good way through the input layer to query which  
leds and what colors are present.  I guess you can look at /proc/bus/ 
input/devices and if we agreed on a common name format or something.   
If you look around in arch/arm/mach-sa1100 and arch/arm/mach-pxa you  
can see we already have around 15 led devices, each one of them  
different.  Some support a green and a red led, some only a red led,  
some an amber and green, some control a single led that can be multiple  
colors, etc.  Userspace needs a way to ask which leds are available and  
which color will be turned on by which codes.

We could solve these problems in the input layer by adding some more  
information into /sys/class/input/.  If we could add an attribute  
saying, this is a led (or better yet, returning the info found in / 
proc/bus/input/devices for this device), and moreover an attribute  
specifying the mapping between led code numbers and a description (be  
it a color or numlock or whatever), then userspace would not need to  
use the LED_NUML symbols from input.h and we wouldn't need to add  
entries into that enumeration for every possible led type in the  
future.

Userspace would look in /sys/class/input/event2/mapping or whatever and  
realize there are two entries, 0 = green, 1 = amber or something.  Then  
when writing to /dev/input/event2 userspace fills in 0 in  
input_event.code to change the green and 1 to change the amber.

It's still not as intuitive as going /sys/class/leds and having two  
directories, one for each led, a color attribute to see color and a  
light attribute to toggle the led, but in the interest of using already  
available interfaces I could scrap it and use the input layer.

John

