Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279732AbRJYJPt>; Thu, 25 Oct 2001 05:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279734AbRJYJPk>; Thu, 25 Oct 2001 05:15:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14164 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S279732AbRJYJPX>; Thu, 25 Oct 2001 05:15:23 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <E15wLfj-0001C8-00@the-village.bc.nu>
	<20011024130408.23754@smtp.adsl.oleane.com>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 25 Oct 2001 03:02:58 -0600
In-Reply-To: <20011024130408.23754@smtp.adsl.oleane.com>
Message-ID: <m1zo6gm6rh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> >> case, there's not much left to the controller, it isn't supposed to
> >> have any command in queue nor receive any new one once all it's child
> >> drivers have suspended.
> >
> >scsi devices are children of the scsi subststem (sd, sg, sr, st, osst) not
> >of the controller. That is how the state flows anyway. Only sr/sd etc know
> >what the state is for a given device on power off as they may issue 
> >multiple requests per action true transaction. sg would have to simply
> >refuse any suspend if open (think about cd-burning or even worse firmware
> >download)
> >
> >So the scsi devices hang off sd, sr etc which in turn hang off scsi and 
> >the controllers hang off scsi (and or the bus layers)
> >
> >This one at least I think I do understand
> 
> The problem with subsystems is that they don't fit well in the
> power tree. They aren't "devices" in that sense that they are
> not exposing a struct device, and they spawn over several controllers
> which means the dependency can quickly become unmanageable, especially
> when SCSI starts beeing layered on top of USB or FireWire.
> 
> Also, the dependency issue is made worst if you let RAID enter into
> the dance as I beleive ultimately, nothing would prevent a volume to
> spawn over several devices from different controllers or even different
> controller types. 

On the dependency case for x86 I have a fun common example.
To shut off the cpu, or the whole motherboard I need to talk to the
southbridge.  To talk to the southbridge, I need to talk to the northbridge.

So at least to some extent shutting down busses is a really different
case from shutting down devices.  And only in some cases can a tree
model it at all.

Equally fun are temperature monitors that appear on both the lpc/isa bus
and the i2c bus.

Or another fun common one.  To shut down the interrupt controller, I first
need to shut down every device that thinks it can generate interrupts.
But my interrupt controller is way out on my pci->isa bridge.  So I
can't shut that device down.

Sorry this whole device tree idea for shutdown ordering doesn't seem
to match my idea of reality.

Now I need to take a little time out and see what the code that is
being discussed will actually do about situations like the above.

> A tricky issue indeed...

Agreed.

Eric
