Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVJJLYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVJJLYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 07:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVJJLYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 07:24:01 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:62124 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750715AbVJJLYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 07:24:00 -0400
Message-ID: <2520.192.168.201.6.1128943428.squirrel@pc300>
In-Reply-To: <20051007144631.GA1294@elf.ucw.cz>
References: <2031.192.168.201.6.1128591983.squirrel@pc300>
    <20051007144631.GA1294@elf.ucw.cz>
Date: Mon, 10 Oct 2005 12:23:48 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: Re: [PATCH 1/3] Gujin linux.kgz boot format
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello, and thanks for reading my patch,

>>  It perfectly works for me, and even after reading those tens of times
>> I no more find anything to change or improve.
>>  Can someone propose a way forward, either in the direction of
>> linux-2.6.14/15 or in the -mm tree, and/or propose improvement or
>> point me to my bug(s) ?
>
> And advantages are? Having to maintain both C and assembly version
> does not seem like improvement to me.

  The problem is that you call the assembly version "maintained".
 When I started hacking that part, in 1998, I tried to rewrite it
 cleanly and fix obvious bugs - but assembler is not the right tool
 for this job and touching those assembler files would break some
 configuration - even if some other configuration would work better.

 I am not alone to not want to touch those assembler files: If you
 have a look at Linux/arch/x86_64/boot/video.S you will see that
 on an X86_64 architecture, people are doing I/O port and PCI
 peek/poke all over the place to detect video cards which have
 only been available on ISA bus, two bus generation ago!
 I seriously doubt you can even imagine an AMD 64 bits with an ISA
 trident 8900 video card inside, even for fun: you cannot plug it in.

 The problem of assembler is that when it has been put in, you cannot
 remove anything because at the time you want to remove old stuff,
 you no more understand the implications. You can not, like in C,
 stop calling a function and hope everything will be right. With my
 code, when you will want to get rid of the APM stuff, you just
 remove the function call vmlinuz_APM() and recompile.

 I am, with this set of patch, proposing a new way to boot. This
 way enable you to boot unlimited size kernel ("make allyesconfig"
 produces a bootable linux.kgz kernel) and the BIOS information
 collection is done in C while in real mode. This real mode function
 can be a lot bigger than it is currently, so that you can temporarily
 call some printf() equivalent while collecting data - instead of
 trying to get a clue of what has happen *after* the crash.

 There is no extended time spent in protected mode (unlike Grub)
 before collecting BIOS information, so that the BIOS environment
 has not been broken (for instance older BIOS APM power saving system
 would be active at startup on some PC, setting timer interrupt to
 slowly reduce power consumption in real mode. Grub switching to
 protected mode stop serving those interrupts, and may not work on
 this PC, or the BIOS information may be invalid).

>> +#define STR static const char
>
> Ouch.

  Well, you want to comment on the only file which is a standalone
 application and not released under GPL but BSD license, because it
 may be usefull elsewhere.

 I have written:
#define STR static const char
 then 50 strings, then
#undef STR

  The main advantage is that it saves screen space, when you want to
 group all the messages together because this standalone utility may
 be translated to other languages, unlike the kernel itself.
 The way to support other languages in C can be complex, and all
 those string can also be wchar_t, or an array of array of chars,
 and the "static" keyword may or may not be a good idea.
 The fact that it is released on a BSD license (if a collection
 of GZIP utilities is ever built) also changes the indentation
 rules if that matter.
  I am not sure we want to talk a lot about this file, it is just
 a simple executable to edit a string at a fixed position inside
 an otherwise binary file (as GZIP specifications), it can be
 written in a lot of other languages, or with shell commands
 like "cut" and file concatenation - it is just cleaner this way.


> 								Pavel
>  +const unsigned maskvesa = 0
>
>> +#ifndef CONFIG_FB_VESA
>> +	| (1 << 0)	/* Cannot boot in MASKVESA_1BPP */
>> +	| (1 << 1)	/* Cannot boot in MASKVESA_2BPP */
>> +	| (1 << 3)	/* Cannot boot in MASKVESA_4BPP */
>> +	| (1 << 7)	/* Cannot boot in MASKVESA_8BPP */
>> +	| (1 << 14)	/* Cannot boot in MASKVESA_15BPP */
>> +	| (1 << 15)	/* Cannot boot in MASKVESA_16BPP */
>> +	| (1 << 23)	/* Cannot boot in MASKVESA_24BPP */
>> +	| (1 << 31)	/* Cannot boot in MASKVESA_32BPP */
>> +#endif
>> +#if defined (CONFIG_VGA_CONSOLE) || defined (CONFIG_MDA_CONSOLE)
>> +	| (1 << 16)	/* able to boot in text mode */
>> +#endif
>> +	// | (1 << 17)	/* not able to boot in VESA1 mode */
>> +#ifdef CONFIG_FB_VESA
>> +	| (1 << 18)	/* able to boot in VESA2 linear mode */
>> +#endif
>> +	// | (1 << 19)	/* force VESA1 if in VESA2 */
>> +	| (1 << 20)	/* Cannot handle VGA graphic modes */
>> +	;

  No comment here. Well I know the use of ifdef's is deprecated, but
 there is simply no other way here - and lets face it: recompiling
 a 10 lines C function (with the host compiler and not the target one
 when cross compiling) at each kernel configuration change is not that
 long.
  Note that if you try to start with LILO a kernel in VESA graphic
 mode and the kernel is not compiled with CONFIG_FB_VESA, well, no
 error message is displayed because the kernel do not know how
 to display stuff... With Gujin you cannot start this kernel and
 you get a clear error message.
 You can also try to start a kernel in 320x200 4 colors modes...

--
> if you have sharp zaurus hardware you don't need... you know my address

  Sorry I do not... fun but not enough storage space.

  Cheers,
  Etienne.

