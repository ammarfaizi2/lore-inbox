Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRJTJ2v>; Sat, 20 Oct 2001 05:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272280AbRJTJ2c>; Sat, 20 Oct 2001 05:28:32 -0400
Received: from smtp-rt-14.wanadoo.fr ([193.252.19.224]:61627 "EHLO
	adansonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S271800AbRJTJ2X>; Sat, 20 Oct 2001 05:28:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@osdl.org>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Sat, 20 Oct 2001 11:28:34 +0200
Message-Id: <20011020092834.24454@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0110191708220.2646-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110191708220.2646-100000@penguin.transmeta.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Why?
>
>If there is some ordering inherent in the bus, that has to be shown in the
>bus structure. Why would you EVER care about order between devices that
>are independent?

The power tree layout isn't necessarily identical to the bus tree layout.
On some macs, for example, we have some ASICs that can control some other
chip's clock and power lines, without having a direct parent relationchip.

So I like having the ability to reorder the power tree layout from
arch code. But I can work around if this ability is not provided by
the struct device. In fact, my main issue here is with Apple's big
"mac-io" ASIC (combo of several devices along with various IO lines
and clocks), and I beleive I will have to handle it as a special
case anyway for other reason (it must really be shut down last as
once down, I can't even talk to the power manager chip ;) I think
all other devices I have to deal with follow the physical bus
ordering.

The problem of suspend-to-disk, which requires, I beleive, that the
device used for the memory backup, to be state-saved last, is still
a problem I don't know how to solve. Maybe using flags in the device
structure indicating it's deferred. That would cause it's parents
to be deferred as well. The presence of the flag would prevent the
actual "suspend" state to be entered during step 3. Once all devices
are suspended, we then know that the bus path to the disk used for
suspend-to-disk is still powered and perform the actual suspend-to
disk operation.

However, I beleive that requires using non-generic IO functions (as
IO queues for the controller have already been blocked by step 2, and
the driver would have to deal with it's own saved state carefuly as
it can't obviously save state to RAM after it has been used to backup
the RAM itself). Maybe that could be a separate message (suspend_to_disk)
sent instead of step 3 (suspend) to this device.

That would give us the following scenario:

 - The device for suspend-to-disk is identified and a flag is set
   in it's device structure. This flag (or a different one to make
   things clear eventually) is "broadcast" all the way up the tree
   so it's parent brigdes/controllers are marked as well.
 - All devices get "suspend_prepare".
 - All devices get "suspend_save_state" and block normal IOs
 - All devices not marked above get "suspend"
 - Last housecleaning is done by the kernel.
 - The device marked above get a special "suspend_to_disk" message
   during which it can perform the actual memory backup and suspend
   itself.
 - The machine is put to sleep.

I currently don't implement suspend-to-disks on Mac, so I may have
overlooked something. Also, I'm not too sure about the requirements
of x86 laptops regarding those features. I'm lucky, Mac laptops
keep the RAM content during suspend ;)

Note also that if not doing suspend-to-disk, I think we should also
make sure to sync all buffers after suspend_prepare and before sending
the suspend_save_state messages. I noticed that recent 2.4 versions
are more sensible about power fail during suspend (that is battery
getting empty, or whatever causing lose of RAM content). I used to
call fsync_devs(0) between those 2 steps in the Mac PM scheme, but
it appears that with recent 2.4's, this doesn't prevent fsck from
finding inconsistencies.

Ben.



