Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUBRAgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUBRAgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:36:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:4772 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266185AbUBRAe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:34:57 -0500
Subject: Re: Radeon issue on x86
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402171553250.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
	 <20040217184543.GA18495@lsc.hu>
	 <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
	 <20040217200545.GP1308@fs.tum.de>
	 <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
	 <20040217225905.GQ1308@fs.tum.de>
	 <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
	 <1077061068.1080.46.camel@gaston>
	 <Pine.LNX.4.58.0402171553250.2154@home.osdl.org>
Content-Type: text/plain
Message-Id: <1077064380.1076.76.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 11:33:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I can't help you on that one. You'd have to figure the "which chip is the 
> primary" out on yourself, although you are likely to be able to figure it 
> out by just following the trace of who has the legacy area mapped (ie who 
> has the 0xA0000 - 0xCFFFF IO region enabled).
> 
> On PCI bridges, that _should_ be visible by checking which bridge has
> "VGASnoop" on (and if none, default to the VGA device closest to the
> root). But I don't know - I've never tried to do this myself. I assume 
> XFree86 must have some strange code to do this.

Hrm... I'm not sure how all of this works. Somebody suggested just
picking the VGA card that has IO enabled at boot (so basically
adding a quirk to x86 that "remembers" the pci_dev of whatever
VGA card had IO enabled during first PCI probe).
 
> There is no exact format. It's allowed to look pretty much any way it
> wants, although you're _supposed_ to have the marker 0x55, 0xAA in the
> first two bytes. That's how the system BIOS historically figures out that 
> there is an extension ROM there somewhere.

Ok.

> The rule is, I think, that the primary video ROM should be at address
> 0xC0000. There might be alternate ROM start points at 2kB boundaries (in
> the whole 0xC0000 .. 0xFFFFF range).
> 
> Oh, and byte 2 should have the "length indicator", which is the size of 
> the ROM in 512-byte blocks, while "byte 3" is actually the first 
> instruction to be run at initialization. So if you want to verify more, 
> you should be able to disassemble "start+3" into a valid instruction, and 
> "start+2" should have a sensible value, but especially that "rom length" I 
> don't know how accurate it is.

I think I'll keep my current loop... so far it worked fine... (just
check for the signature). I may be able to check ATI specific signatures
in there, I don't know if it's worth the pain...

> The reason I say "should be" is that I would not be totally surprised if a 
> video ROM that is embedded with the system ROM might not skip that part, 
> since the system ROM "knows" that it is there regardless of signature. 
> 
> I just checked my EVO rom, and I notice that it _does_ have the signature
> 0xAA55 at 0xC0000, and the byte 0x80 at byte offset 2 (implying 65536
> bytes, which should be correct). So that's likely to be the right thing to
> check.

Maybe I should actually do more sanity checking on the values I read
from the BIOS, and based on that, try everything again the "other"
way... Hrm... it's all pretty nasty, I don't even have an x86 box
with a radeon to play with yet ;)

> > I currently copied a search routine from XFree but it does very little
> > verifications in there, I'm a bit paranoid about picking the wrong
> > thing...
> > 
> > What do you suggest ?
> 
> Does the above match what XFree86 does?

It just does a loop looking for the aa55 signature.

Ben.


