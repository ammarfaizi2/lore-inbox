Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265034AbUETJCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbUETJCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 05:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUETJCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 05:02:16 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:7950 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265034AbUETJCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 05:02:13 -0400
Date: Thu, 20 May 2004 11:03:12 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Sensors <sensors@Stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Dynamic fan clock divider changes (long)
Message-Id: <20040520110312.101c5c11.khali@linux-fr.org>
In-Reply-To: <20040518021540.GB11012@earth.solarsys.private>
References: <20040516222809.2c3d1ea2.khali@linux-fr.org>
	<20040518021540.GB11012@earth.solarsys.private>
Reply-To: Sensors <sensors@Stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think I'll stick to #2 for now. The extra code is reasonable, and
> > I don't really see the low accuracy at high speed as a problem. What
> > matters much to me is that the user shouldn't have to worry about
> > selecting dividers himself, and #2 does this.
> > 
> > Part of the extra code may be moved to i2c_sensor if several drivers
> > use it. Also, remember that the new policy will remove some code
> > from the drivers (reading and setting dividers manually) so this
> > gives us some margin anyway.
> 
> The keyword in your conclusion is "policy", which reminds me of the
> phrase "mechanism, not policy".

I don't quite see how appropriate this phrase is in the context, and, to
say the truth, I'm not even sure I understand what you imply by saying
that. Could you please explain in great details why you seem to think
that my proposal is no good idea?

If the use of the word "policy" is incorrect, maybe I should have used
another. What I meant was that, if we start implementing that kind of
stuff in several drivers, we better discuss it together before, and
implement it the same, optimal way, so that we don't have to change it
afterwards, and it can be documented, and the user doesn't observe
different behaviors on different drivers. I'm trying to spare the user
some trouble, so let's not replace it with different trouble.

> The driver should behave exactly as commanded, nothing more.

Well, most hardware monitoring chip drivers do more than that, and I
don't think this should be changed. For example, drivers enable
monitoring on load and configure what needs to be. We have limited their
action to the least possible, and I think it was a clever move, but some
things definitely need to be done. Drivers may also need to reset alarm
flags after they read them. This belongs to the driver's job to do that!
Likewise, I believe that the fact that a clock divider has to be chosen
is a hardware implementation detail the user-space shouldn't even be
aware about.

> The solution to the fan divisor madness can and should be done in
> userspace.

I agree it could (the whole hardware monitoring chip drivers could).
However, the current interface doesn't allow that. The user-space would
need to know which dividers are available for each driver, and would
need to know the base clock frequency for each driver as well (or,
alternatively, we would have to export raw register readings for fan
tachometers). The amount of driver code required to do this would
probably be equal to, or even greater than, what I am proposing.

For information, my current implementation of the in-driver dynamic
clock adjustement is about 15 lines of code at update time, if you omit
comments and debugging, and 7 lines of code at low limit change time.
The current interface code to fan_div alone has about as much (about 22
lines)! If we are to export everything we need to do the same in
user-space, it will make the drivers even bigger, and add overhead at
the user-space/kernel-space interface. So why would we want to do that?

If you have a reason to believe that what I propose is not correct,
please explain why you do, with as much details as needed. I would also
want to read a concrete proposal of how we would do it your way. Simply
pretending that "it's not the correct way to do it" without additional
explanation nor proposal doesn't help me much, unfortunately.

I'm definitely surprised that you don't seem to like my proposal at all,
while I thought you were suggesting we could do something similar a few
months ago [1]. Quoting you back in January:

"(...) we'd auto-increment the fan_div until we got a non-zero reading
or we hit the max.  Then the first set to a fan_div turns the feature
off; that would allow sensors.conf/sensors -s to override."

Or do I misread you somehow?

Thanks.

[1] http://archives.andrew.net.au/lm-sensors/msg05815.html

-- 
Jean Delvare
http://khali.linux-fr.org/
