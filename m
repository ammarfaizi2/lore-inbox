Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279557AbRJXNEs>; Wed, 24 Oct 2001 09:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279558AbRJXNEj>; Wed, 24 Oct 2001 09:04:39 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:60677 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S279557AbRJXNE1>; Wed, 24 Oct 2001 09:04:27 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Wed, 24 Oct 2001 15:04:08 +0200
Message-Id: <20011024130408.23754@smtp.adsl.oleane.com>
In-Reply-To: <E15wLfj-0001C8-00@the-village.bc.nu>
In-Reply-To: <E15wLfj-0001C8-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> case, there's not much left to the controller, it isn't supposed to
>> have any command in queue nor receive any new one once all it's child
>> drivers have suspended.
>
>scsi devices are children of the scsi subststem (sd, sg, sr, st, osst) not
>of the controller. That is how the state flows anyway. Only sr/sd etc know
>what the state is for a given device on power off as they may issue 
>multiple requests per action true transaction. sg would have to simply
>refuse any suspend if open (think about cd-burning or even worse firmware
>download)
>
>So the scsi devices hang off sd, sr etc which in turn hang off scsi and 
>the controllers hang off scsi (and or the bus layers)
>
>This one at least I think I do understand

The problem with subsystems is that they don't fit well in the
power tree. They aren't "devices" in that sense that they are
not exposing a struct device, and they spawn over several controllers
which means the dependency can quickly become unmanageable, especially
when SCSI starts beeing layered on top of USB or FireWire.

Also, the dependency issue is made worst if you let RAID enter into
the dance as I beleive ultimately, nothing would prevent a volume to
spawn over several devices from different controllers or even different
controller types. 

So let's see if I properly understand what is needed in the SCSI case:

The parent is the controller. We can't do much about this since we need
that relationchip for ordering. By controller, it can be a real SCSI host,
but it can also be a virtual host exposed by an USB storage device or
a firewire SBP2 device.

The child of this controller has to be a struct device for each physical
device on the bus. (just one in the case of an USB storage). The struct
device for this child is +/- generic, possibly created by the generic
SCSI probe code.

This device might (must ?) have childs instanciated by whatever "client"
attach to a given SCSI device. Clients like sg would effectively refuse
suspend, while clients like sd would do standard disk spindown commands.
That mean there is not "one" PM node for the SCSI subsystem, but one
per instance of a given subsystem module.

Now, I'm not sure what would happen with RAID. If we need to have logical
volumes be child of the sd "client", then we have to face the fact that
a given child may have multiple parents... welcome to the power graph !
But do we really need logical volumes to be part of the PM tree or
can blocking of requests at the sd layer be enough ? Remember we are
in pass2, we have already done memory allocation, we are supposed to
no longer swap nor do any disk/storage related activity.

A tricky issue indeed...


Ben.


