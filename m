Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUA0Bfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 20:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUA0Bfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 20:35:46 -0500
Received: from hera.cwi.nl ([192.16.191.8]:5782 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261735AbUA0Bfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 20:35:43 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 27 Jan 2004 02:35:34 +0100 (MET)
Message-Id: <UTC200401270135.i0R1ZYs03187.aeb@smtp.cwi.nl>
To: patearl@patearl.net, usb-storage@one-eyed-alien.net
Subject: Re: Writing CIS... ioctl?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi.  As a fun little project I'm considering adding userland support 
    for reading and writing the CIS block via the SDDR-09.  Based on my 
    previous driver experience, I'd do it using an ioctl on the scsi 
    device it maps to.  However, I'm unsure of how the SCSI/USB layering 
    occurs and if an ioctl would be the best way to allow access to the 
    CIS.  Note that the CIS info itself is roughly 100 bytes, and that 
    information is duplicated in another location on the smartmedia card.

    Any thoughts?  Is an ioctl the way to do it?

    Are there other ways that low level control data is written to storage 
    devices?

For any single project ioctl() is one of the easy ways of doing it.
There are other communication channels, like module parameters
or proc files.

But there are lots of such projects, and after doing a few hundred of them
we have interface mess. For the dev_t change last year I did an audit of
all ioctls, more than a thousand, with lots of different interfaces,
sometimes varying between architectures, not exactly a pleasure.

So, something else is needed, and we do not have it. Lots of ideas have been
suggested. Whatever one does the situation is messy, just because the type
of control needed varies a lot.

If for every device there also is a control device, then the control device
can be opened and ordinary read and write calls can be used. That is good.
But still there will be parsing on both sides, so the mess has only been
hidden a little, it is still there.

Sysfs tries to avoid the parsing problem by having a large number of files,
each with a simple ASCII value. Now one has to walk and parse messy trees.
People who like that will want a control filesystem instead of a control device
for each device.

But you do not want a long discussion, but a utility.

Give the driver a reading and a writing mode.
(Read normal 512-byte blocks, or 512+64-bytes blocks plus control,
or just the 64-byte control, possibly with a choice between 16-byte and
64-byte control, and similarly for write, where write also has the
writeCIS possibility.)

The getting and setting of reading and writing mode is separate from the
rest. While testing, it is probably easiest to use a module parameter.
If everything works, and you want to submit the result for inclusion in the
kernel, see whether Linus has requirements on the shape things should be in.

In case you learn things about the sddr09 hardware not yet documented,
I would like to hear about them.

Andries


[Non-sddr09 examples of control things one wants to do: setmax on a disk;
set a password on a disk; set a disk read-only or read-write (on the
media level or on the drive level or on the software level); eject;
reread partition table; set a ZIP drive to disk vs large floppy mode;
load a keymap; set unicode mode; load a compose table; assign keycodes
to scancode sequences; set keyboard repeat rate; set magic SysRq key.]

