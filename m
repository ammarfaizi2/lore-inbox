Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVJJNJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVJJNJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJJNJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:09:36 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:50333 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750776AbVJJNJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:09:35 -0400
Message-ID: <3125.192.168.201.6.1128949772.squirrel@pc300>
In-Reply-To: <20051010115641.GA2983@elf.ucw.cz>
References: <2031.192.168.201.6.1128591983.squirrel@pc300>
    <20051007144631.GA1294@elf.ucw.cz>
    <2520.192.168.201.6.1128943428.squirrel@pc300>
    <20051010115641.GA2983@elf.ucw.cz>
Date: Mon, 10 Oct 2005 14:09:32 +0100 (BST)
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

> It seems to work okay here. Now, rewriting current boot system into C
> may be good goal...

  At least that is a way which does not involve modifying assembler
 files. Slowly everybody switches to the C version which continue
 to evolve (i.e. removing old BIOS calls), then the tree under
 arch/i386/boot is removed and we can begin to rearrange the mapping
 of "struct linux_param".

>>  I seriously doubt you can even imagine an AMD 64 bits with an ISA
>>  trident 8900 video card inside, even for fun: you cannot plug it
>>  in.
>
> Feel free to fix that. [I think I could get PCI-to-ISA bridge and plug
> it into my x86-64 box...]

  Well, I can help to plug it in, but it involves a set of tool not
 usually used in computer software, that is hammer and axes :-)
 For the software support of VESA 1 bank switching to display graphic
 modes in 64 Kbytes memory window, well, Gujin support it but not Linux.
 For my future investment in a x86-64, well I will one day, it is on
 my TODO list. I wonder about PCI-E -> ISA converter, they should be
 faster than PCI -> ISA, no?...

>>   Well, you want to comment on the only file which is a standalone
>>  application and not released under GPL but BSD license, because it
>>  may be usefull elsewhere.
>
> Well, if you want to distribute the file with kernel, it should
> folllow kernel coding style. If not, sorry for the noise.

  I hope I can still put a BSD license "helper" in kernel tree, it
 is BSD because GZIP is itself BSD licensed - and its indentation
 looks like GZIP source.

>> >> +#ifndef CONFIG_FB_VESA
>> >> +	| (1 << 0)	/* Cannot boot in MASKVESA_1BPP */
>> >> +	| (1 << 1)	/* Cannot boot in MASKVESA_2BPP */
>> >> +	| (1 << 3)	/* Cannot boot in MASKVESA_4BPP */
>> >> +	| (1 << 7)	/* Cannot boot in MASKVESA_8BPP */
>> >> +	| (1 << 14)	/* Cannot boot in MASKVESA_15BPP */
>> >> +	| (1 << 15)	/* Cannot boot in MASKVESA_16BPP */
>> >> +	| (1 << 23)	/* Cannot boot in MASKVESA_24BPP */
>> >> +	| (1 << 31)	/* Cannot boot in MASKVESA_32BPP */
>> >> +#endif
>> >> +#if defined (CONFIG_VGA_CONSOLE) || defined (CONFIG_MDA_CONSOLE)
>> >> +	| (1 << 16)	/* able to boot in text mode */
>> >> +#endif
>> >> +	// | (1 << 17)	/* not able to boot in VESA1 mode */
>> >> +#ifdef CONFIG_FB_VESA
>> >> +	| (1 << 18)	/* able to boot in VESA2 linear mode */
>> >> +#endif
>> >> +	// | (1 << 19)	/* force VESA1 if in VESA2 */
>> >> +	| (1 << 20)	/* Cannot handle VGA graphic modes */
>> >> +	;
>>
>>   No comment here. Well I know the use of ifdef's is deprecated, but
>>  there is simply no other way here - and lets face it: recompiling
>>  a 10 lines C function (with the host compiler and not the target one
>>  when cross compiling) at each kernel configuration change is not that
>>  long.
>
> // comments are deprecated, too, and you probably should use symbolic
> constant, no?

  For the "//" comment I have to check those patches; I am used to put
 them when the user may think of changing it for configuration.

  I do not want to use symbolic constant, as in:
static const unsigned MASKVESA_1BPP = 1 << 0;
  because the assembler generated is bad (a real area of memory is
 reserved - it is constant in C but may be modified in assembler).
 I do not put my constant as enum because I am still not a real
 C++ software writer (don't tell my boss!).

  I could do:
#define MASKVESA_1BPP	(1 << 0)
  as in Gujin vmlinuz.h, but because it is used once and only once,
 I did put MASKVESA_1BPP as comment (use one source line instead
 of two). I can change it, I have enough spare "linefeed" -:)

  My bigger problem was for the CPUID detection, I did not know if
 I should use Gujin library.h structure:
struct cpuid_flags_str {
    unsigned	fpu	: 1;
    unsigned	vme	: 1;
    unsigned	de	: 1;
    unsigned	pse	: 1;
    unsigned	tsc	: 1;
    unsigned	msr	: 1;
    unsigned	pae	: 1;
    unsigned	mce	: 1;
    unsigned	cx8	: 1;
    unsigned	apic	: 1;
    unsigned	unused3	: 1;
    unsigned	sep	: 1;
    unsigned	mtrr	: 1;
    unsigned	pge	: 1;
    unsigned	mca	: 1;
    unsigned	cmov	: 1;
    unsigned	pat	: 1;
    unsigned	pse36	: 1;
    unsigned	psn	: 1;
    unsigned	clfl	: 1;
    unsigned	unused2	: 1;
    unsigned	dtes	: 1;
    unsigned	acpi	: 1;
    unsigned	mmx	: 1;
    unsigned	fxsr	: 1;
    unsigned	sse	: 1;
    unsigned	sse2	: 1;
    unsigned	ss	: 1;
    unsigned	htt	: 1;
    unsigned	tm	: 1;
    unsigned	ia64	: 1;
    unsigned	unused1	: 1;

    unsigned	mapping_to_define;
    } __attribute__ ((packed));

  and:
struct cpuid_amd_flags_str {
    unsigned	fpu	: 1;
    unsigned	vme	: 1;
    unsigned	de	: 1;
    unsigned	pse	: 1;
    unsigned	tsc	: 1;
    unsigned	msr	: 1;
    unsigned	pae	: 1;
    unsigned	mce	: 1;
    unsigned	cx8	: 1;
    unsigned	apic	: 1;
    unsigned	unused3	: 1;
    unsigned	sep	: 1;
    unsigned	mtrr	: 1;
    unsigned	pge	: 1;
    unsigned	mca	: 1;
    unsigned	cmov	: 1;
    unsigned	pat	: 1; /* or FCMOV */
    unsigned	pse36	: 1;
    unsigned	unused2	: 4;
    unsigned	mmxplus	: 1;
    unsigned	mmx	: 1;
    unsigned	fxsr	: 1; /* or emmx, Cyrix */
    unsigned	unused1	: 4;
    unsigned	lm	: 1;
    unsigned	E3Dnow	: 1; /* Extended 3DNow!+ */
    unsigned	S3Dnow	: 1; /* Standard 3DNow! */
    } __attribute__ ((packed));

  and because of the complexity decided to build the constant
 manually, which led to manual building of the video constant.

  Somebody else would like some other modifications?

  Cheers,
  Etienne.

