Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWC2BBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWC2BBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 20:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWC2BBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 20:01:22 -0500
Received: from science.horizon.com ([192.35.100.1]:37431 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750734AbWC2BBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 20:01:22 -0500
Date: 28 Mar 2006 20:01:11 -0500
Message-ID: <20060329010111.26121.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-os@analogic.com, s.organov@javad.com
Subject: Re: Lifetime of flash memory
Cc: dedekind@yandex.ru, kalin@thinrope.net, linux-kernel@vger.kernel.org,
       linux@horizon.com
In-Reply-To: <87acbb6vlj.fsf@javad.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Note that the actual block size is usually 64k, not the 512 bytes of a
>> 'sector'. Apparently, some of the data-space on each block is used for
>> relocation and logical-to-physical mapping.

> Wrong. AFAIK, first disks had FLASH with 512b blocks, then next
> generation had 16K blocks, and currently most of cards have 128K
> blocks. Besides, each page of a block (64 pages * 2K for 128K block) has
> additional "system" area of 64 bytes. One thing that is in the system
> area is bad block indicator (2 bytes) to mark some blocks as bad on
> factory, and the rest could be used by application[1] the same way the
> rest of the page is used. So physical block size is in fact 64 * (2048 +
> 64) = 135168 bytes.

Er, I think you know what you're talking about, but some people reading
this might be confused by the Flash-ROM-specific meaning of the word
"block" here.

In NAND Flash terminology, a PAGE is the unit of write.  Thus was
originaly 256+8 bytes, which quickly got bumped to 512+16 bytes.
This is called a "small page" device.

"large page" devices have 2048+64 byte pages.
E.g. the 2 Gbyte device at
http://www.samsung.com/Products/Semiconductor/NANDFlash/SLC_LargeBlock/16Gbit/K9WAG08U1M/K9WAG08U1M.htm

Now, in a flash device, "writing" is changing selected bits from 1 to 0.
"Erasing" is changing a large chunk of bits to 1.

In some NOR devices, you can perform an almost unlimited number of writes,
limited only by the fact that each one has to change at least one 1 bit
to a 0 or there's no point.

Due to the multiplexing scheme used in high-density NAND flash devices,
even the non-programmed cells are exposed to a fraction of the programming
voltage and there are very low limits on the number of write cycles to
a page before it has to be erased again.  Exceeding that can cause some
unwanted bits to change from 1 to 0.  Typically, however, it is enough
to write each 512-byte portion of a page independently.


Now, erasing is done in larger units called BLOCKs.  This is more
variable, but a power of two multiple of the page size.  32 to 64 pages
(16 k for small page/32-page blocks to 128K for large page with 64-page
blocks) is a typical quantity.  You can only erase a block at a time.

So you really only need to keep track of wear levaling at the erase
block level.

But any file system (or disk emulation layer) consists of having
a free block at all times, picking a block to re-use, copying the
still-needed data to the free block, and then erasing the new block.
This leaves you with one completely free block, and hopefully a bit
extra as the chosen block was not completely in use.

How you choose the blocks to re-use is the heart of wear leveling.
For best efficiency, you want to re-use blocks that have the last
still-needed (non-garbage) contents, but sometimes you have to copy a
completely full block that's been sitting there not bothering anyone
just because it has been sitting there and it's less worn out that the
"busy" blocks.

In fact, such data should be copied to the most-worn blocks, since
it will "give them a rest", while the least-worn blocks available
should be used for new data.  Since "most data dies young", it's
likely that the new data block will have to be copied for garbage
collection purposes.  It can get very complex.



Oh, and just for the curious, let me explain the terms NAND and NOR flash.


The classic N-channel MOS transistor has three terminals: a source,
a drain, and a gate.  When the gate is raised to a positive voltage,
it attracts electrons to the opposite side of the oxide insulator, and
forms a conductive channel connecting the source and drain.  Since they're
negatively charged electrons, it's an N channel.

A positive voltage relative to what?  Relative to the source and the drain,
of course, since that's where the electrons have to be attracted from!

In many discrete transistors, there's a difference between the source
and the drain, but the standard MOS IC process makes them completely
symmetrical.

So an N-channel MOS transistor is good for connecting things to low
voltages, but as the voltage gets closer to the gate voltage, the
resistance increases until it cuts off.  (Complementary MOS,
or CMOS, technology combines this with a P-channel transistor
with exactly the opposite properties to build devices that pass
high and low voltages well.)

But still, you can build a good inverter out of an N-channel transistor
by pulling the output up through a resistor or current source, and then,
if the input to the transistor's gate goes high, the transistor (with
its other end connected to ground) pulls the output low.

Now, if you connect multiple transistors to the same output line
in parallel, any one of them turning on can pull it low.  This is a
NOR gate.  NOR memory is built of rows and columns, and each
column is a thousand-input NOR gate.  Each input is a row, and
then you select the column to find the 

There are two ways to turn this into memory.

In dynamic RAM, each transistor is connected not to ground, but
to a capacitor.  When you turn it on, the capacitor might or
might not pull the output low.

In programmable "read-only" memory, each transistor is connected
to ground, but is made with a special "floating gate" that holds
a small charge.  This charge has the effect of altering the
threshold voltage for the transistor.  If the bit is programmed,
the floating gate has a positive sharge on it, and it "helps"
the main gate, so the voltage on the main gate needed to pull the
output low is reduced.  If the bit is erased, there's no charge,
and the voltage needed on the main gate to pull the output low is
higher.

To read a bit from the ROM, you feed a carefully chosen intermediate
voltage down the row line, and the column line is pulled low (or not)
depending on the programmed value.

Now, when you have an itty-bitty transistor trying to pull down a
great big long (high-capacitance) column line, the actual effect it has
is quite small.  It'll get there eventually, but like pushing a car,
it takes a quile to get started.  There's a special circuit known as a
"sense amplifier" that senses the very small effect it has and amplifies
it to get the data out in a reasonable number of nanoseconds.


Okay, so that's NOR memory.  Note that you have to connect three
wires to each transistor: a row line, a column line, and ground.
That takes a certain amount of space.


Now, go back to our original NMOS inverter circuit, with a pull-up
resistor and a pull-down transistor.  Suppose you added a second
transistor, not in parallel with the first, but in series.

Then you'd have to turn on (supply a high gate voltage to) BOTH
transistors to pull the output low.  This is a NAND gate.

You can put a long chain of transistors together, and they all have to
be on to pull the output low.  You can't quite put thousands together,
because a transistor isn't as good a conductor as a wire, but you can
hook 16 together easily enough.

Now, take those 16, add a 17th transistor to hook the group up to a
column line, and NOR together a pile of those groups.

You can read any transistor in a group by turning the other 15 (and
the 17th) on all the way, and giving the selected transistor the
halfway voltage to see how it's programmed.

Each group needs a single column line and a single ground, and each
transistor needs a row line to drive its gate, but the sources and drains
are simply connected to adjacent transistors.

This reduction of the wires per transistor from 3 to 1 + 3/16, and the
fact that the 1 is the gate, which is already a metal wire in a MOS
(metal-oxide-semiconductor) transistor allows a REALLY DENSE packing
of the transistors, which is how NAND flash can fir more storage
cells in than NOR flash.


BUT... even though you have to program the groups all together you
can't read them all at once.  Reading a group is a 16-step operation.
You have to assign them adjacent addresses or programming would make
no sense, but you can't read them all at the same time.

Thus, NAND flash is slower to read, but denser than NOR flash.
The fact that manufacturing defects are allowed in NAND flash
allows further density increases.


> Due to FLASH properties, it's a must to have ECC protection of the data
> on FLASH, and AFAIK 22-bits ECC is stored for every 256 bytes of data,
> so part of that extra memory on each page is apparently used for ECC
> storage taking about 24 bytes out of those 64. I have no idea how the
> rest of extra memory is used though.

The "classic" ECC design is a simple Hamming code over 256 bytes =
2^11 bits.  Assign each bit an 11-bit address, and for each of those
11 bits, compute two parity bits - one over the 1024 who have that
address bit zero, and one over the 1024 who have that address bit 1.

If you have a single-bit error, one of each pair of parity bits will
be wrong, with the combination giving the location of the erroneous bit.
A double-bit error will leave some parity bit pairs both right or both
wrong.

But more recent designs use 4-byte-correcting Reed-Solomon codes.
For an example, see the ST72681 data sheet at
http://www.st.com/stonline/books/ascii/docs/11352.htm
This computes 10 ECC bytes per 512 bytes of data and can correct up to 4
errors, or correct 3 and detect up to 5, or any other combination where
detect >= correct and correct + detect adds up to 8.
