Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264813AbUEPU1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264813AbUEPU1a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 16:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUEPU1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 16:27:30 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:8467 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264813AbUEPU1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 16:27:20 -0400
Date: Sun, 16 May 2004 22:28:09 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] Dynamic fan clock divider changes (long)
Message-Id: <20040516222809.2c3d1ea2.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a RFC about fan clock dividers in hardware monitoring chips.

### THE PROBLEM

Since the beginning of the lm78 project (now lm_sensors project, and
Linux 2.6 drivers), it has been assumed that users would be required to
manually set "fan divisors" of their hardware monitoring chipset in
order to have correct fan speed readings for their specific
configuration.

This has since become a FAQ, and is still one of the major source of
trouble and questions for fan speed measurements. This is why I am
suggesting that we could change our policy and have the proper clock
selection done by the drivers instead. I don't think I am the first one
to request that. I'm pretty sure I read a similar suggestion on this
list some times ago, but I can't remember who it came from.

The fact that various datasheets and documentation refer to it as "fan
divisors" has obviously added to the confusion. A more correct term
would be "fan clock divider", IMHO.

### ADDITIONAL POINTS TO CONSIDER

A second point to consider is that more and more people are willing to
change the speed of the fan depending of the temperature, most generally
using PWM (pulse width modulation), manual, software-driven or
hardware-driven. This means that a single divider may not be suitable
for the the full operating speed range. One particular point raised here
is that selecting the proper fan clock divider once and for all as the
driver loads is not sufficent. Also think of people plugging a new fan
afterwards, or changing fans. No way we want to force them to reload the
driver (which could be hard-built into the kernel anyway).

To add to complexity, remember that not only the measured fan speed has
to fit with the current clock divider, but the low fan speed limit has
to fit as well.

I have come to three possible implementations of various complexity,
depending on what we want to do, or not.

### WHAT YOU NEED TO KNOW

Here are a few reminders of how fan speed measurement work. It's
somewhat tricky, so even people with good knowledge are easily
mistaking. People with no knowledge wouldn't even have a chance to get
what I'm talking about without this summary ;) I'm voluntarily
simplifying a few things so as not to confuse newcomers.

Fan speeds are not measured directly. Instead, what is measured is how
much periods of clock have passed before the fan did a full revolution.
This value is stored in an 8-bit register. The actual speed (in RPM) is
given by (clock speed)*60/(register value). This means that you cannot
measure fans slower than (clock speed)*60/255. For this reason, it is
usually possible to divide the clock speed by 2, 4 or 8 (or even more)
so as to be able to measure slower fan speeds.

Usually, a low limit can be set by the user. If the fan spins under this
limit, an alarm is raised. This low limit is stored in an 8-bit
register, using a similar convention, so that the chipset can easily
compare the measured speed and the defined low limit. Note that a higher
value in the register means a slower fan, so there is an alarm condition
if the value in the measure register if *greater* than the value in the
low limit register. This may be confusing at first.

Example:
clock speed is 8kHz
the user sets the low limit to 2400 RPM
-> value in low limit register is 200 (8000*60/2400)
value read in the measure register is 150
-> real speed is 3200 RPM (8000*60/150)
-> no alarm is triggered
lower measurable speed is 1882 RPM (8000*60/255)

If we want to be able to measure a fan speed of, say, 1500RPM, we have
to set the clock divider to 2.

You may wonder why we don't directly use the greatest divider then. This
is *not* to be able to measure higher fan speeds. Even with a divider of
8, higher measurable fan speed is 60000 RPM (1000*60). This should be
sufficent for everyone ;) No, the reason is accuracy. It happens that
the measurement accuracy is proportional to the clock speed. More
precisely, the accuracy, defined as the lowest measurable RPM
difference, is computed as (speed*speed)/(clock*60). For a fan speed of
6000 RPM, the accuracy with a divider of 8 is no more than +/- 600 RPM.

This is why the choice of the best divider is important and non-trivial.
This is a lowest-measurable-speed vs accuracy-at-high-speed tradeoff.

Before I go on, please consider the following facts:

For a given fan speed, increasing the clock divider means decreasing the
value stored in the register.

It is always possible to increase the clock divider without losing low
limit value. We may have to round it but it'll fit.

If is not always possible to decrease the clock divider without losing
the low limit value. If the value in the register is >= 128, it won't
fit in an 8-bit register after we multiply it by 2 or more.

### PROPOSED IMPLEMENTATIONS

Implementation #1

Each time the user requests new data (which triggers an update of each
register value), the fan speed measurement register is analyzed. If the
value is too high (arbitrary limit to be defined), or if an overflow
flag has been set (for chipsets with such flags), the next higher clock
divider is selected (unless we already use the greatest available). The
fan min is preserved, possibly rounded. Else, if the value is too low
(arbitrary limit to be defined), the next lower clock divider is
selected (unless we already use the lowest available). The low limit is
preserved if possible, or lost and stored as 255.

This implementation solves all points mentioned above. The user doesn't
have to care, and the divider will change automatically if PWM is used,
or fan is changed. The drawback is that the selected low limit may be
lost is the process.

Concrete example (still using a 8kHz clock):

The user has a fan running at 1500 RPM with PWM, and has set low limit
to 1250 RPM. The driver will select a divider of 2 (neither 1250 nor
1500 RPM do fit with a divider of 1, lowest representable speed being
1882 RPM). Then the system goes hot and the fan goes full speed at 5000
RPM. The divider will be lowered to 1 to increase accuracy, which will
change the low limit to the lowest possible value (register == 255, i.e.
1882 RPM). Then, later, the temperature is low again and the fan returns
to low speed. The divider is back to 2, low limit is preserved to 1882,
and an alarm triggers as the measured speed is 1500 RPM.

An alternate possibility is to consider register == 255 as a special
case, which wouldn't be affected by increasing clock dividers.

In the example above, this would restore the low limit as 941 RPM
(lowest representable value with divider of 2) at the end. This won't
trigger an error, but still changed the value requested by the user.

This implementation is OK for the measured speed, but has side effects
on low limit.

Implementation #2

Same as #1, except that the low limit has to fit with the new clock
divider for a clock change to actually occur. Likewise, if the user
wants to set a new low limit which doesn't fit with the current divider,
the divider is changed.

Since the low limit is normally lower than the measured speed, this
means that the low limit is what will determine the divider. This means
that this implementation doesn't solve all the issues mentioned above.
The user still doesn't have to care, which is fine, but if the user has
a fan speed between 2000 and 5000 RPM, with low limit set to 1500 RPM,
he/she will have a "bad" accuracy at 5000 RPM (+/- 104 RPM). I see this
as the low limit "nailing" the divider ;)

The improvement here is that the clock is also changed if needed to
satisfy a requested low limit. Until now, the lowest representable speed
would have been set instead.

This is what I implemented in my new pc87360 driver (after trying #1). I
use 85 and 224 as the arbitrary limits for changing dividers.

Implementation #3

Same as #2, but we dissociate the requested low limit and the
register-stored low limit.

For example, say that the user requests a low limit of 1000 RPM but the
divider is currently 1 because it is the best tradeoff for measured
speed of 3000RPM. We will set the low limit register to 255, which
corresponds to the lowest measurable value with divider 1. But we
remember that the user wants 1000, and display this value too. If, at a
later time, the fan goes slower and the divider increases to 2, we will
remember that the user wants 1000, and store that value in the register
(now that we can). So the trick is fully invisible to the user.

The point here is that we start lying to the user. The low limit we
present isn't what is stored in the register anymore. He/she will
hopefully never notice it, but there are corner cases where it could
matter. For example, the BIOS could be messing with the chip at the same
time we are (we already saw this) and periodically force the low limit
to a given value. The user wouldn't notice (because we don't display the
speed from the actual register value) and alarms could trigger without a
visible reason. This may be because the BIOS is bad, but this would
still confuse the user. Another case is if fan speeds drops suddenly. By
the time the driver reacts and changes the clock divider, an alarm is
likely to trigger, while the user will not see any limit excess.

Each of the problems above are work-aroundable, but this will probably
significantly increase the amount of code in the driver, which is no
good.

Inplementation #4

Since implementation #2 looks rather good, and will practically result
in the clock divisor being set from the selected low limit, and never
change thereafter, choosing a constant (rather high) divider from the
very beginning may be reasonable after all. With a 8kHz clock, a divider
of 2 lets you measure speeds down to 941 RPM, which is most probably
fine for almost everyone. As far as I know, fans running below 1000 RPM
in normal conditions are quite rare. So we would simply choose an
arbitrary divider depending on the clock speed of each chipset. This is
by far the less code-expensive approach, of course, but may not be
correct in some critical cases (very slow or very fast fans).

### CONCLUSION

I think I'll stick to #2 for now. The extra code is reasonable, and I
don't really see the low accuracy at high speed as a problem. What
matters much to me is that the user shouldn't have to worry about
selecting dividers himself, and #2 does this.

Part of the extra code may be moved to i2c_sensor if several drivers use
it. Also, remember that the new policy will remove some code from the
drivers (reading and setting dividers manually) so this gives us some
margin anyway.

Comments welcome, of course.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
