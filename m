Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265227AbUFWJgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUFWJgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 05:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUFWJgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 05:36:19 -0400
Received: from science.horizon.com ([192.35.100.1]:45618 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S265227AbUFWJgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 05:36:16 -0400
Date: 23 Jun 2004 09:36:15 -0000
Message-ID: <20040623093615.21801.qmail@science.horizon.com>
From: linux@horizon.com
To: dtor_core@ameritech.net
Subject: Re: [RFC/RFT] PS/2 mouse resync for KVM users
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - flag "suspect" packets - 1st bytes with overflow bits set and bytes that
>   indicate that Left + Middle or Right + Middle  buttons are pressed at the
>   same time which is unusial combination. Suspect packets, together with
>   timeouts, are treated as "soft" errors.

I'm a little unhappy with this.   They are *currently* unusual, but
I hate to preclude anyone from using them.

Just a reminder, the PS/2 mouse protocol is 3 bytes:

Byte 0, bit 7: Y overflow
Byte 0, bit 6: X overflow
Byte 0, bit 5: Y sign bit (Y delta bit 8)
Byte 0, bit 4: X sign bit (X delta bit 8)
Byte 0, bit 3: always 1 (apparently, internal/external)
Byte 0, bit 2: Middle button
Byte 0, bit 1: Right button
Byte 0, bit 0: left button

Byte 1: X movement (X delta bits 7..0)
Byte 2: Y movement (Y delta bits 7..0)

You can put the mouse in an extended mode where it adds a 4th byte, the
Z axis motion of the scroll wheel.  There's an extra-extended mode
which steals the high bots of that to encode the 4th and 5th button
presses.

Anyway, rather than a static button combination, I'd flag as "suspect"
any case where two buttons change state in opposite directions in
the same report.

I.e.

buttonsdown =  packet[0] & ~prevbyte0;
buttonsup   = ~packet[0] &  prevbyte0;
prevbyte0 = packet[0]

if (buttonsup != 0 && buttonsdown != 0)
	-> Suspect

You can press two buttons at the same time, but to switch buttons
that fast is virtually impossible.  But normal mouse motion will
produce exactly that effect in the lsbits of the movement bytes.

There's probably a neat bit-banging trick to compute that more simply...
changed = packet[0] ^ prevbyte0;
if ((changed & packet[0]) != 0 && (changed & prevbyte0) != 0)
	-> Suspect
... maybe someone can do better?


Also, although motions are 9-bit numbers and can encode values
up to -256/+255, you might consider motions outside -128/+127
(the sign bit does not match the msbit of the movement byte)
to be suspect as well.

You could also use the jiffies count to judge acceleration
as well and flag unrealisticly fast direction changes.

E.g. suppose we store prev_x, prev_y and prev_jiffies when we got
the last mouse packet.  The current movement values are x, y and
jiffies.

accel**2 = ((x - prev_x)**2 + (y - prev_y)**2) / (jiffies - prev_jiffies)**2

If accel**2 is too large, the packet is suspect.  (Perhaps even
have a degree of suspiscion based on how large it is.)

If jiffies - prev_jiffies is large, you can consider instead acceleration
from a stop (prev_x = prev_y = 0), with jiffies - prev_jiffies being
your reporting rate (the minimum commonly observed inter-packet interval.)


And finally, there's just looking for pauses in the data stream.
If you get <pause> nbytes <pause> and nbytes is divisible by 3 and
not 4, you can suspect the mouse got reset to 3-byte mode.
