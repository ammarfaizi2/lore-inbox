Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbUBRAVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUBRATf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:19:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:21978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265908AbUBRAR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:17:29 -0500
Date: Tue, 17 Feb 2004 16:17:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Radeon issue on x86
In-Reply-To: <1077061068.1080.46.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402171553250.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org> 
 <20040217184543.GA18495@lsc.hu>  <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
  <20040217200545.GP1308@fs.tum.de>  <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
  <20040217225905.GQ1308@fs.tum.de>  <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
 <1077061068.1080.46.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> However, I got a few reports of that not working. Usually, on
> laptops, apparently, the PCI ROM doesn't exist and it can all
> be found in the low memory image (I suppose the video BIOS on
> these is hidden somewhere with the main BIOS and copied to RAM
> at aboot).

More commonly, the system BIOS is compressed. On laptops in particular, 
chip count actually matters, so there is often only _one_ flash ROM, and 
it contains both the regular system rom and the video ROM, and almost 
always in compressed format. It's then uncompressed into RAM, and the RAM 
is marked non-writable in the chipset.

>	 So I would need to reverse my algorithm and
> default to the RAM BIOS on laptops at least...

It's almost certainly worth doing it even on desktops too, since the above
is quite likely to be true at least for integrated chipsets (for cost 
reasons, if not for size reasons).

> The problem with the RAM image is that it's only there for the
> primary display chip that was initialized at boot. So I would
> need to "know" which PCI card is the primary display.

I can't help you on that one. You'd have to figure the "which chip is the 
primary" out on yourself, although you are likely to be able to figure it 
out by just following the trace of who has the legacy area mapped (ie who 
has the 0xA0000 - 0xCFFFF IO region enabled).

On PCI bridges, that _should_ be visible by checking which bridge has
"VGASnoop" on (and if none, default to the VGA device closest to the
root). But I don't know - I've never tried to do this myself. I assume 
XFree86 must have some strange code to do this.

>							 That's all
> x86 architecture black magic, so I'd like your advice on the best
> way to do that. Also, that low memory region at c0000, what is
> it's exact format ?

There is no exact format. It's allowed to look pretty much any way it
wants, although you're _supposed_ to have the marker 0x55, 0xAA in the
first two bytes. That's how the system BIOS historically figures out that 
there is an extension ROM there somewhere.

The rule is, I think, that the primary video ROM should be at address
0xC0000. There might be alternate ROM start points at 2kB boundaries (in
the whole 0xC0000 .. 0xFFFFF range).

Oh, and byte 2 should have the "length indicator", which is the size of 
the ROM in 512-byte blocks, while "byte 3" is actually the first 
instruction to be run at initialization. So if you want to verify more, 
you should be able to disassemble "start+3" into a valid instruction, and 
"start+2" should have a sensible value, but especially that "rom length" I 
don't know how accurate it is.

The reason I say "should be" is that I would not be totally surprised if a 
video ROM that is embedded with the system ROM might not skip that part, 
since the system ROM "knows" that it is there regardless of signature. 

I just checked my EVO rom, and I notice that it _does_ have the signature
0xAA55 at 0xC0000, and the byte 0x80 at byte offset 2 (implying 65536
bytes, which should be correct). So that's likely to be the right thing to
check.

> I currently copied a search routine from XFree but it does very little
> verifications in there, I'm a bit paranoid about picking the wrong
> thing...
> 
> What do you suggest ?

Does the above match what XFree86 does?

		Linus
