Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUGaWSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUGaWSX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 18:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUGaWSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 18:18:22 -0400
Received: from home.powernetonline.com ([66.84.210.20]:8168 "EHLO
	home.uspower.net") by vger.kernel.org with ESMTP id S264763AbUGaWRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 18:17:00 -0400
Date: Sat, 31 Jul 2004 17:17:36 -0500
From: John Lenz <jelenz@wisc.edu>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [2]
Message-ID: <20040731221736.GE5483@hydra.mshome.net>
References: <20040617223517.59a56c7e.zap@homelink.ru> <20040725215917.GA7279@hydra.mshome.net> <20040728221141.158d8f14.zap@homelink.ru> <20040729232547.GA4565@hydra.mshome.net> <20040730040645.169e4024.zap@homelink.ru> <20040730004950.GA11828@hydra.mshome.net> <20040731000205.4b0d8f01.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040731000205.4b0d8f01.zap@homelink.ru> (from zap@homelink.ru on Fri, Jul 30, 2004 at 15:02:05 -0500)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/04 15:02:05, Andrew Zabolotny wrote:
> On Thu, 29 Jul 2004 19:49:50 -0500
> John Lenz <jelenz@students.wisc.edu> wrote:
> 
> > The only problem is that what happens if the fb device is registered before
> > the lcd device?  So that means you still need to keep around a list of fb
> > devices that have been registered so that when a new lcd device is
> > registered it can check if it matches an old fb device.
> Right now it happens in a different way. The patch I've published earlier uses
> notifier objects (linux/notifier.h) so that if framebuffer can't find the
> matched lcd device, it registers to be notified when new lcd devices appear in
> the system; when it does it proceeds like usual (e.g. calls lcd_device_find).
> Until it finds the LCD device framebuffer device cannot even initialize
> (without powering on the LCD controller in some circumstances it's impossible
> to do anything useful).

I could see it going either way I guess.  The other thing the class_match could
do is create those symlinks from the two classes of devices.  What other way is
there from userspace to see which lcd device is associated with fb device?

> 
> > The only advantage is we let the core class code take care of managing the 2
> > lists of devices for us (which it is doing anyway).
> These lists are anyway maintained by the class.c core. You just need a pointer
> to the 'struct class' variable for classes you are interested in, and locking
> also comes for free - everything is already implemented. Look in class.c for
> list_for_each_entry macros - they all are traveling along these lists.

Yea I see that, but I was trying to keep all the class related code contained in
class.c  I feel kinda uncomfortable manipulating lists and locking locks in
struct class from outside code.

> 
> I personally don't like to make this device matching too generalized - if we
> need it for b/l, that's fine, we'll have to implement it for b/l.
> But it doesn't look too sane, so I'd rather leave it l/b specific.
> 

Why not?  I see it as a simple extension of the class_interface stuff... it
could even use the class_interface to implement class_match (or use
class_interface directly in the lcdbase.c code and forget the class_match stuff).

Now I could see both solutions as workable and either one or even a bunch more
could work for the lcd/fb matching.  Now the question is, which one to implement?
Or actually, the question is, which one is more likely to be accepted into the
kernel?

The way I see it, we really need a policy decision here, and neither you nor I 
are "authorized" to make that decision :)  We have two completly seperate devices,
both have a struct device and both have a struct device_driver.  They can sit on
completly seperate buses and be mixed together in lots of different combinations.
One of the devices "knows" if it matches with the other device.

What is the linux preferred way to dynamicly match the two devices together?  Should
each driver pair make its own decisions and its own constructs, or should we try and
extend the device/driver/class/bus/etc model to support matching two devices together?
Use waitqueues and probe functions?  notify.h?  match by a char *name? class_match?
class_interface? create a virtual bus and use the bus matching code (not a very good
solution, but one nonetheless)?  Secondly, what is the best way to represent this
matching to userspace (sysfs)?

We already tried matching together devices by their name, and that was shot down.
And yet the mtd code matches chips and maps together by their name...  We haven't
really gotten much feedback in which ways of matching devices together is acceptable
and which isn't.

John
