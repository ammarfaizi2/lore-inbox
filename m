Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266706AbRGFOao>; Fri, 6 Jul 2001 10:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbRGFOaf>; Fri, 6 Jul 2001 10:30:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266706AbRGFOaa>; Fri, 6 Jul 2001 10:30:30 -0400
Date: Fri, 6 Jul 2001 10:30:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Gregory (Grisha) Trubetskoy" <grisha@ispol.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: reading/writing CMOS beyond 256 bytes?
In-Reply-To: <Pine.BSF.4.32.0107060829460.47924-100000@localhost>
Message-ID: <Pine.LNX.3.95.1010706094624.519A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Gregory (Grisha) Trubetskoy wrote:

> 
> sorry this may be OT:
> 
> I wrote a little brogram to read/write the CMOS settings to a file on an
> Intel L440GX motherboard using the outb() to ports 0x70 and 0x71. The idea
> is to save the BIOS settings I like and then be able to blast them from
> within Linux without having to tinker with BIOS setup.
> 
> Unfortunately, it seems that some settings are not in the 128 (or 256)
> bytes accessible this way, so they must be stored elsewhere.
> 
> Does anyone know where I should look for the remaining parts of CMOS
> (short of having to sign some NDA with Intel?)?
> 
> Any advice/pointers is highly appreciated,
> 
> Grisha

The CMOS in the timer-chip, whether or not it provides usable storage,
is accessed as an index byte at 0x70 which sets the offset to read/write
in 0x71. Therefore, no more than 256 bytes will ever be accessible
in this manner.

Motherboard manufacturers who have rewritable BIOS chips now leave
one page (typically 64k) for startup parameters. This is erased
and written using the magic provided by the chip vendors. This
is typically a sequence such as:

(The AMD Am29LV800B)

		OFFSET		DATA (short)
Erase sector:
		0x0555		0x00AA
		0x02AA		0x0055
		0x0555		0x0080
		0x0555		0x00AA
		0x02AA		0x0055
		0x0555		0x0010

Loop on the sector until all bits are set. This is the erased condition.
You need to erase before you write because writes can only reset bits to
zero, and not set them to one.

Program:

		0x0555		0x00AA
		0x02AA		0x0055
		0x0555		0x00A0
		OFFSET		WORD to WRITE

Loop on OFFSET until it is exactly what you wrote. This sequence
is repeated for every word.

You need to do this at the address where the ROM BIOS actually exists.
It does NOT exist at 0x000F0000 where it appears to be. This is RAM
by the time you see it. It will exist at the top of 32-bit address space,
usually like this:


	128k NVRAM
      -----------------------------------------
      | 64k of scratch and/or setup menu stuff |
      ------------------------------------------
      | The main ROM BIOS                      |
      |________________________________________|
                                             | | offset 0xffffffff
                                             |__ jump vector 0xfffffff0

This assumes a 128k chip (usually).

Since you have to erase a whole sector (64k), you copy the stuff from
the sector that you want to save to RAM. Erase the sector, modify your
copy, then write it back. Each ROM BIOS setup and parameter stuff is
different for each BIOS vendor. You can almost always find some unused
place in the chip to save/restore your parameters, even within the
BIOS portion of NVRAM. Since bits not programmed are set to 0xff, you
can readily find unused space:

000F5D00  00 01 17 02 00 00 46 4C-4F 50 50 59 00 46 4C 4F   ......FLOPPY.FLO
000F5D10  50 50 59 00 00 09 0C 17-00 01 06 05 04 04 0C 00   PPY.............
000F5D20  02 50 43 49 20 53 6C 6F-74 31 00 00 09 0C 18 00   .PCI Slot1......
000F5D30  01 06 05 04 04 0B 00 02-50 43 49 20 53 6C 6F 74   ........PCI Slot
000F5D40  32 00 00 09 0C 19 00 01-06 05 04 04 0A 00 02 50   2..............P
000F5D50  43 49 20 53 6C 6F 74 33-00 00 09 0C 1A 00 01 06   CI Slot3........
000F5D60  05 04 04 09 00 02 50 43-49 20 53 6C 6F 74 34 00   ......PCI Slot4.
000F5D70  00 09 0C 1B 00 01 03 04-02 04 00 00 0A 49 53 41   .............ISA
000F5D80  20 53 6C 6F 74 31 00 00-09 0C 1C 00 01 03 04 02    Slot1..........
000F5D90  04 00 00 02 49 53 41 20-53 6C 6F 74 32 00 00 0B   ....ISA Slot2...
000F5DA0  05 1D 00 01 4F 45 4D 20-53 74 72 69 6E 67 00 00   ....OEM String..
000F5DB0  0C 05 1E 00 01 53 79 73-74 65 6D 20 53 74 72 69   .....System Stri
000F5DC0  6E 67 00 00 0D 16 1F 00-01 00 00 00 00 00 00 00   ng..............
000F5DD0  00 00 00 00 00 00 00 00-00 01 45 4E 47 4C 49 53   ..........ENGLIS
000F5DE0  48 00 00 FF FF FF FF FF-FF FF FF FF FF FF FF FF   H...............
000F5DF0  FF FF FF FF FF FF FF FF-FF FF FF FF FF FF FF FF   ................
000F5E00  FF FF FF FF FF FF FF FF-FF FF FF FF FF FF FF FF   ................
000F5E10  FF FF FF FF FF FF FF FF-FF FF FF FF FF FF FF FF   ................
000F5E20  FF FF FF FF FF FF FF FF-FF FF FF FF FF FF FF FF   ................
000F5E30  FF FF FF FF FF FF FF FF-FF FF FF FF FF FF FF FF   ................


I would use 0x000F5DF0 on up for private parameters. (offset 0x5dF0 in
the ROM BIOS or offset 0x5dF0 + 0x10000 = 0x15df0 into the chip.

Copying/erasing/writing back 64k takes about 1 second. Mucking with
the NVRAM ROM BIOS can leave you with an unbootable system if you
screw up. If your BIOS is in a socket, no problem. Just copy it first.
If it's not, don't do this at home!!!

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


