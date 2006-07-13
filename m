Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWGMSUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWGMSUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWGMSUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:20:35 -0400
Received: from javad.com ([216.122.176.236]:3848 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1030269AbWGMSUf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:20:35 -0400
From: Sergei Organov <osv@javad.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<20060630001021.2b49d4bd.akpm@osdl.org> <87veq9cosq.fsf@javad.com>
	<1152302831.20883.63.camel@localhost.localdomain>
	<87d5cdg308.fsf@javad.com>
	<1152529855.27368.114.camel@localhost.localdomain>
	<873bd9fobb.fsf@javad.com>
	<1152552683.27368.185.camel@localhost.localdomain>
	<8764i1h9nd.fsf@javad.com> <1152805246.17919.2.camel@localhost>
Date: Thu, 13 Jul 2006 22:20:19 +0400
In-Reply-To: <1152805246.17919.2.camel@localhost> (Alan Cox's message of
 "Thu,
	13 Jul 2006 16:40:45 +0100")
Message-ID: <87veq1fjto.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> On Iau, 2006-07-13 at 18:17 +0400, Sergei Organov wrote:
>> This problem may occur with any tty driver that doesn't stop to insert
>> data into the tty buffers in throttled state. And yes, there are such
>> drivers in the tree. Before Paul's changes, the tty just dropped bytes
>> that aren't accepted by ldisc, so this problem had no chances to arise.
>
> You must honour throttle. 

I do, it's Greg who doesn't ;) BTW, isn't it OK to just check for
tty->throttled where appropriate if I don't have anything special to do
at unthrottled/throttled transition time?

> That has always been the case. At all times you should attempt to
> homour tty->receive_room and also ->throttle. If you don't it breaks.

Yes, but the difference is what "it" actually is. Loosing some
characters at some rare or "might never in fact happen conditions" is
one "it", and exhausting kernel memory at (even more) rare conditions is
a different "it", isn't it?

Besides, if the throttle() is that important and failure to handle it is
a big mistake, why is it optional then? I mean why struct tty_operations
with throttle field set to NULL is accepted in the first place? The same
question is applicable to the struct usb_serial_driver.

>> latter cases drivers that insert too much data without pushing to ldisc
>> may cause similar problem. Anyway, you definitely know better what to do
>> about it.
>
> Might be a good idea to put a limiter in before 2.6.18 proper just to
> trap any other drivers that have that bug. At least printk a warning and
> refuse the allocation once there is say 64K queued. That way the driver
> author gets a hint all is not well.

I'm afraid that the limit won't work well as a hint for driver
developers that didn't honour throttle, as real applications do usually
read from the files they open, and therefore the problem most probably
won't be noticed for a long time.

Provided the limiter is put, why not to make it a variable with 64K
default?  Driver writers that for whatever reason decide they need more
in buffers will be able to change that, but then it will be their
deliberate decision, not just underestimation of consequences of failure
to handle throttle() due to a lack of knowledge.

Actually I think that the first thing to decide is if memory usage by
tty should be bounded or not, and if yes, should it be per-tty limit, or
total memory usage by all the ttys limit, or both. Those decisions I'd
probably base on how other kernel subsystems behave (TCP stack is the
first that comes to mind, and AFAIK buffering for every socket is
limited). Due to lack of broad knowledge of the kernel, I won't try to
insist on any solution, even though my experience in embedded systems
programming cries for bounded model.

And at the end, I'm going to RTFM ;)

The comment to the throttle routine in the kernel tree says:

 * 	This routine notifies the tty driver that input buffers for
 * 	the line discipline are close to full, and it should somehow
 * 	signal that no more characters should be sent to the tty.

"Linux Device Drivers" 3-d edition says:

 The throttle function is called when the tty core’s input buffers are
 getting full. The tty driver should try to signal to the device that
 no more characters should be sent to it.

None of these two suggests there could be such a global consequences of
attempting to insert data to the throttled tty as exhausted kernel
memory. The kernel version reads more strict to me, but LDD one is
apparently how people indeed understand it.

BTW, I'm curious if Greg wasn't aware throttle must be handled, or just
decided that it's not worth to, as neither generic nor airprime
usb-serial drivers handle throttle. Besides, the example tiny_tty.c
driver from the LDD doesn't handle throttle either. If even most
experienced and involved kernel developers do ignore the throttle(),
what should be expected from random Joe driver writer?

-- 
Sergei.
