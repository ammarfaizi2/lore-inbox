Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbREOIwu>; Tue, 15 May 2001 04:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbREOIwk>; Tue, 15 May 2001 04:52:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22798 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262684AbREOIwg>; Tue, 15 May 2001 04:52:36 -0400
Subject: Re: LANANA: Getting out of hand?
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 15 May 2001 09:48:05 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0105142114310.23663-100000@penguin.transmeta.com> from "Linus Torvalds" at May 14, 2001 09:30:33 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zaUv-0002Cj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How hard is it to generate a new "disk driver framework", and let people
> register themselves, kind of like the "misc" drivers do. Except we'd only
> allow DISKS. You could add something like
> 
> 	register_disk_driver("compaq-ciss", nr_disks, &my_queue);

Why bother. Devfs does that already. Thats the enumeration problem 

> and then the disk driver framework will select a range of minor numbers
> for the disks, and forward all requests that come to those minor numbers
> to "my_queue". No major numbers. No fixed minors. And the user sees _one_
> disk major, and doesn't care _what_ the hell is behind it.

The user running devfs sees /dev/disc or /devices/disc and doesnt care
whats behind it already. They also see what is scsi and the like providing
they care to ask. The latter is essential to make ioctl work.

Doing a grep across about a large amount of source code I found several very
definite uses the device type:

1	Is file A the same as file B	

	This continues to work fine

2	Is file A on mountpoint B

	This continues to work fine

3	Are you running this on a sane device

	Joystick, hdparm, ...

4	Which ioctl set can I use of device A

	This breaks. Examples of this include tools like mt-st which has to
	use different ioctls according to the tape class. Our ioctls overlap
	so it isnt safe to issue them and pray

5	Deep nasty lowlevel grungy knowledge

	Things like lilo that knows and to an extent has to know more about
	the universe than is nice.

3 and 4 are variants of the same thing really. The lack of any way other than
the major number to say 'What ioctl classes does this device support'. IMHO
thats a thing you have to fix first - a way to query the device and get back
{"disk", "scsi-disk", "scsi-lowlevel"} or {"disk", "cpqarray"}

The underlying name/number thing is a red herring. You don't need that to
do /dev/disc nicely. devfs rather proved it. 

Alan

