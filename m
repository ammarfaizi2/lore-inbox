Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279518AbRJXKfl>; Wed, 24 Oct 2001 06:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279521AbRJXKfc>; Wed, 24 Oct 2001 06:35:32 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:37895 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S279518AbRJXKfZ>; Wed, 24 Oct 2001 06:35:25 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Wed, 24 Oct 2001 12:34:51 +0200
Message-Id: <20011024103451.8099@smtp.adsl.oleane.com>
In-Reply-To: <E15wKn8-00013C-00@the-village.bc.nu>
In-Reply-To: <E15wKn8-00013C-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The two trees are certainly closely related - USB devices before USB hub,
>USB hub before PCI etc. The scanner example works fine there, providing that
>we are careful about memory issues - remember the USB layer allocates memory
>to do any transaction, so the scanner has to complete its state save before 
>we do any interrupt disabling/memory alloc freezing.

That's why we have that first step that is run before any device is blocked
and with interrupts still flowing. Devices that need memory for either state
save or for requests used during power down are supposed to allocate them
at this point.

>Thats still just ordering and maybe two passes

Well, 3 passes actually ;) I'd suggest you re-read Patrick's mochel latest
document, which describes the 3 step process. One first pass give a chance
to device to "prepare" for sleep, that is allocate anything they will need
without actually blocking or suspending anything. On the second pass, devices
are asked to suspend IOs, complete pending ones, and save state. This is
done with interrupts still enabled. The 3rd pass is called with interrupt
disabled and is where the actual shutdown of the device is supposed to happen.

In practice, a lot of drivers will only need to implement 1 or 2 of these
3 passes. But the flexibility has to be there for a device that need both\
to allocate memory and to suspend with interrupts disabled.

An additional idea we had was to make pass 2 somewhat asyncrhonous by
allowing some kind of "call my later" result code (basically, a device
would block it's queue, and return "call me later" while it still has
pending IOs). This is an optional "feature".

>> the HW or not when getting a new request). In cases where a mid-layer
>> enters the scene, like SCSI, that wants to do timeouts, then well...
>> we can let it timeout (just stop processing requests), or we can
>> have the midlayer go to sleep as well :) That later solution
>> may cause some interesting ordering issues however...
>
>For scsi you have to complete the pending commands, you don't know what the
>transaction granularity is in some cases and half completing the sequence
>won't help you. In addition the upper layers have to queue additional scsi
>commands to do stuff like cd drawer locking and to ask the drive firmware
>to enter powerdown modes

Yes. SCSI is a problem as the current SCSI layer is tricky enough to
make this difficult. I beleive that if the SCSI devices are childs of
the SCSI controller, then they can take care of suspending the device
(that is sending whatever command to lock the drawer or stop the disk
spinning) before the controller is actually going to sleep. In that
case, there's not much left to the controller, it isn't supposed to
have any command in queue nor receive any new one once all it's child
drivers have suspended.

>> For USB, for example, we can consider that when a device driver
>> (not a controller driver) suspend has been done, any URB it submits
>> can just be dropped (returned immediately with an error). We don't
>> need blocking here neither. Of course, that means we have the
>> framework to call devices' suspend/resume callbacks when the
>> controller is about to go to sleep.
>
>That will scramble large numbers of devices. Randomly erroring pending block
>writes is -not- civilised.

The drivers will have to be adapted for PM, whatever scheme we use. The
USB case is very similar to SCSI. The controller is a parent of all
devices. Devices will get the suspend before the controller, they will
have a chance to suspend requests and wait for pending ones to complete
(for example, the USB storage will have a chance to block new incoming
requests in the queue and wait for pending ones to complete) before
the USB controller is put to suspend.
That way, once we are reaching real USB controller suspend, we can safely
discard urbs as we are not supposed to get any until devices have been
resumed.

I currently don't do that on pmac (I just let URBs be handled by OHCI
and let OHCI fill the TD queues in memory, I only prevent the controller
from actually handling those queues). It's not good as some drivers will
get error messages due to their underlying device beeing suspended,
and won't understand why the URBs are going away.

In the case of USB devices that don't support suspend state, it's slightly
more tricky as on some HW, I may have to actually turn them off. That mean
the driver must deal with re-doing configuration & set-interface on
wakeup. That is again a driver matter, and a bit like the PCI case we
mentioned previously, we need some way to know if driver for a given
device can handle the requested power state or not. If not, we should
probably abort the suspend sequence, and find a clean interface to tell
userland about which device caused the failure so the user can deal with
it (rmmod the driver for example).


Ben.


