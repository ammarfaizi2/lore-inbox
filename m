Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSGMKFu>; Sat, 13 Jul 2002 06:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318140AbSGMKFt>; Sat, 13 Jul 2002 06:05:49 -0400
Received: from pl312.nas911.n-yokohama.nttpc.ne.jp ([210.139.38.56]:43203 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S318139AbSGMKFr>;
	Sat, 13 Jul 2002 06:05:47 -0400
Message-ID: <3D2FFC22.49A057CD@yk.rim.or.jp>
Date: Sat, 13 Jul 2002 19:08:34 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Q: boot time memory region recognition and clearing.
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question concerning the kernel's memory detection at boot
time, and a proper way of clearing the recognized memory before
proceeding further.

Background:
I am toying with ECC (error checking and correction) module
for linux for some time.

    ECC module URL:
	http://www.anime.net/~goemon/linux-ecc/

I have found that the particular motherboard (and memory sticks)
that I use at home tends to generate bogus memory problem 
warning messages when I use ecc module.
Motherboard is Gigabyte 7XIE4 that uses AMD751.
(Yes, AMD has now provides AMD76x series chipset for
newer CPUs.)

I say "bogus" because I have tested the hardware
many times using memtest86 and found that it doesn't
detect any memory errors even 
if I let the test run over the night.
Also, from what I found, it seems this bogus message
may not appear if I somehow use/touch/write to
memory under win98 by running memory-hungry application
such as mozilla, internet explorer, etc. and THEN
reboot the PC into linux.

After following disucssion in ECC mailing list,
I now realize that the proper ECC support
would possibly require the BIOS's writing 0's, or
for that matter, any value, to
ALL the known memory locations before
the main kernel starts and we insert the ecc module.

My use of the said PC under win98 to possibly write
to all the available memory area using mozilla, etc.
may explain the disappearnce of bogus ecc messages under
linux afterward.

Now, as many are aware, not many BIOS's on
low-end motherboards seem to do the writing to
all the memory locations. 
[ I now know that
BIOSs on Tyan motherboard for dual AMD CPU operation
do this. But the writing seems to be very slow 
for some reason. There is a replacement BIOS project
going on. Please see the following URL, but I digress.

      http://www.acl.lanl.gov/linuxbios/
]

Please understand this writing is NOT the simple
writing of a byte or a few bytes per 1K/MB boundaries
to detect the presence of memory chips.
We need the clearing or writing of values to ALL
the bytes in the memory.

Instead of relying BIOS to do the clearing,
we can possibly do similar writing of 0's
at the kenerl boot time.
So my question now is whether we can
clear (or write a known value) to 
known memory locations before the main portion of
kernel starts up.

Let us focus the question to x86 linux kernel startup code
for now.

So the question boils down to the following, I think:

In the following file, the kernel
recognizes the BIOS-supplied, and/or user-supplied
memory regions and sets up internal data structure.

       /usr/src/linux/arch/i386/kernel/setup.c

>static void __init add_memory_region(unsigned long long start,

This routine takes the arguments of the form

	     start, length, type

and builds the list of triplets.

       >static void __init parse_mem_cmdline (char ** cmdline_p)

parse_mem_cmdline seems to handle the user-supplied
memory info.
       
There are other routines in the file
to handle the memory-related functins, especially
to read BIOS supplied memory info.

Specific questions:

So my guess is that
probably at the finish of one of the memory routines
in setup.c, I can add a loop to
clear (write zero's) to all the known locations.
But I am not sure about a few things.

 - Firstly, what routine would be the best to
   add such clearing code ?
  (That is, what function is the last one called among
   the functions in setup.c during boot time.)
 
 - Secondly, I don't want to overwrite the 
   kernel startup code, or other data/code entities
   already present in the memroy.

   Where (or what region, or what type in the
   triplet's third argument to add_memory_region) should
   I avoid clearing ?
 
   My first guess would be the lower 640K region where
   this setup.c code resides (correct?), but
   are there others?

 - Thirdly, can I use a simple direct addressing to
   access the memory at this stage of booting?

    That is, can I simply do a loop like the following.
    I am using char pointer since I am not even sure
    if I can write to the memory region(s) using
    long. (Oh well, I probably can on x86 architecture
    since if `start' is even an odd value, x86 won't
    see alignment error.)

    int i;
    for(i = 0 ; i <   e820.nr_map ; i++)
    {
	char *a;
	if ( dontwrite_foobar(i) ) /* necessary
			checking for regions that I should not clear */
	      next;

	/* now clear */
	a = e820.map[i].addr;
	for(l = 0; l < e820.map[i].size; l++)
	   *a++ = 0;
    }

    Obivious optimizations can wait until later.

 -    Is there a special macro that I can use
      to access high memory regions if simple direct
      addressing won't work at this stage?

      Or is there a place I can possibly add
      such clearing code beside setup.c?

      But then again, the clearing ought to be done
      as early as possible for ECC purposes.

   (I suspect that I may not be able to 
   access memory beyond certain upper limit 
   at this stage of booting. I wonder in what mode
   the CPU is. My plan of modifying setup.c
   requires more work if I need to wait until CPU
   changes mode to enable full 32-bit linear addressing, etc..)


TIA.
