Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUESV1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUESV1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 17:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUESV1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 17:27:31 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:35081 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S264503AbUESV11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 17:27:27 -0400
Date: Wed, 19 May 2004 23:28:22 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Rutger Nijlunsing <linux-kernel@tux.tmfweb.nl>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Dynamic fan clock divider changes (long)
Message-Id: <20040519232822.1f36b2d7.khali@linux-fr.org>
In-Reply-To: <20040516213645.GA18906@nospam.com>
References: <20040516222809.2c3d1ea2.khali@linux-fr.org>
	<20040516213645.GA18906@nospam.com>
Reply-To: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rutger,

> Implementation #5
> 
> Since the divider can be programmed, it is possible to take two
> measurements (all in the driver): first with the highest divider
> allowed by the chipset to get an indication of the current speed, and
> then a new measurement followed as close as possible to the first one
> with a divider fitting the first measured speed.

The idea is new to me, I have to admit it.

> Example: set divider to 64 (or highest possible divider); fan speed
> gives 2500 +- 500. Not set divider to 2 or 1 and re-measure.
> 
> Advantages:
>   - no 'low limit' has to be set magically

I'm not sure I get what you mean here.

>   - most accurate reading possible on the whole range

Correct. Same as #1 and #3 then.

>   - invisible to the user

Correct again, like all other proposed implementations.

> Disadvantages:
>   - no 'low limit' can be set in the hardware; low limit must be
>     processed in software.

Correct, same as #3. Except that with #3, the time will come when both
the fan speed measurement and the low limit fit in the same divider
value, so hardware limit can be restored. The fact that your
implementation completely disables the hardware limit is a problem.

>   - Update frequency of the fan speed will be halved.

This is another serious problem, methinks. And it doesn't quite match
your requirement of "as close as possible" above. If we simply alternate
two dividers, one per update, then there's no reason the fan speed won't
have changed inbetween. In a way, this is similar to my other proposals
in that matter, except that my implementations stick to the last "good"
value once they get it, so we don't have to change the divider often if
the fan is stable.

> Maybe-problem:
>   - The 'as close as possible' must be in a small range or otherwise
>     the fan speed may be dropping to fast to fall outside the
>     measurable range. I do not know with which frequency the fan speed
>     can be measured.

You're right here too, that's a problem. Some chips stop measuring
anything when accessed for register reads or writes. This is the reason
why all our hardware monitoring drivers cache the read values for some
time (typically 1 to 2 seconds). So reading the fan speed twice in the
same update, after changing the divider inbetween, is not an option. It
would add a very long delay to the update operation, it's just not worth
it.

> Processing the low limit in software will also solve the 'BIOS
> triggering false alarms'.

Not necessarily. If the BIOS restores an arbitrary low limit, it can
trigger. In any case, if the BIOS does this, it promises trouble, but if
we read the register value on each update and display it to the user (as
opposed to display a different one and process it in software), at least
the user will notice. This is a minor argument against your
implementation, and #3 as well.

Your proposal is very similar to #3, it seems. The idea is the same
(optimal accuracy all the time) and the problems are the same too. The
only advantage of yours is that you will get the "correct" divider value
at step 2, while it may take more than that in #3. But in the long run,
your method endlessly changes dividers while #3 stabilizes and doesn't.

> I agree with the stated 'I don't really see the low accuracy at high
> speed as a problem', but this would suggest a simple
> 3-or-so-line-patch to solve the problems: just use the highest fan
> divider by default. If a user really knows what he is doing, he can
> change the divider himself.

This is more or less implementation #4. Granted, this is by far the most
simple implementation. However, some chips have dividers up to 128. With
such a divider, readings at relatively high speed are *really* bad. At
5000 RPM you may have a resolution no better than +/- 2370 RPM, if I'm
not mistaking. We may not care about ultimate accuracy, but still... We
could decide that, for example, "32 should be enough for everyone" but
it may not be, some people have really slow fans, or fans emitting a
single tick per rotation. Deciding of one single divider will be fine
for most cases, but just not all, so this is probably not acceptable.
These people would be losing something from manual mode we have for now.

This is the reason why #2 has my preference. It does the best it can
with the user's hardware, while still being safe with regards to
hardware low limit and nasty BIOSes. The extra code required is
reasonable (IMHO), and the clock divider changes are limited to the
minimum required.

Thanks for your proposal, however.

-- 
Jean Delvare
http://khali.linux-fr.org/
