Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279735AbRJYKC1>; Thu, 25 Oct 2001 06:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279739AbRJYKCS>; Thu, 25 Oct 2001 06:02:18 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:29713 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S279735AbRJYKCA>; Thu, 25 Oct 2001 06:02:00 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Turk <r.turk@chello.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 25 Oct 2001 12:01:24 +0200
Message-Id: <20011025100124.11238@smtp.adsl.oleane.com>
In-Reply-To: <9r8icv$ukh$1@ncc1701.cistron.net>
In-Reply-To: <9r8icv$ukh$1@ncc1701.cistron.net>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Doing so will create havoc on sequential devices, such as tape drives. If
>your system simply suspends, then all is well. Any data that isn't flushed
>yet is buffered inside the tapedrive. But when the system resumes and resets
>the SCSI bus, it will cause all data in the tape drive to be lost, and for
>most tape systems it will also re-position them at LBOT. Any running
>tar/dump/whatever tape process would not survive such a suspend-resume
>cycle.
>
>Another more subtle issue is state information that exists between the SCSI
>controller and the target devices. At some point they might have negotiated
>synchronous and/or wide transfer parameters. This information must be
>preserved, or you'll observe lockups, data corruption and the likes. Since
>these parameters are maintained at the lowest driver level, they should know
>about suspend. The low-level driver must know to re-negotiate these
>parameters when it comes back to life.

This can be handled by having st (or sd, or whatever "client driver" decide
to take over a SCSI device) register a struct device node that is a child
of the actual SCSI device.

In fact, I'm wondering if we need a struct device node at all for the
SCSI device on the bus. The SCSI controller (or USB/storage or
FireWire SBP2) will expose SCSI devices, that is "interface" to
which you can feed SCSI requests, but do those really need to have
a structure device associated ? One possibility would be to only do
so once attached to a "client" driver like st, sd, sg, ...
The "client" would then create that structure.

But...

If we still want "unclaimed" devices to have a representation in the
device tree (because, for example, userland wants to know about them,
eventually in order to "instanciate" an sg driver), then we could have
the SCSI subsystem create a simple skeletton struct device when the
devices are probed, and have the client driver just populate this with
more infos & PM hooks once attached to the device.
I don't think there's a need to have 2 struct device stacked.

But it's mostly a matter of taste ;)

Thinking more about it, I think I prefer the second solution. That is
to have SCSI create "standard" struct device for all devices probed
on the bus, thus ensuring they are visible from the userland
representation of the device-tree, and then eventually have drivers like
sd, st, etc... add entries & PM hooks to those devices if needed when
attached to them. But doing that, or just having them create a virtual
node as a child of the device is mostly a matter of taste, I beleive.

Ben.



