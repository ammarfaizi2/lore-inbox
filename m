Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270118AbRHMMFP>; Mon, 13 Aug 2001 08:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270121AbRHMMFF>; Mon, 13 Aug 2001 08:05:05 -0400
Received: from web11808.mail.yahoo.com ([216.136.172.162]:28420 "HELO
	web11808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270120AbRHMMEx>; Mon, 13 Aug 2001 08:04:53 -0400
Message-ID: <20010813120505.97748.qmail@web11808.mail.yahoo.com>
Date: Mon, 13 Aug 2001 14:05:05 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is indeed a good structure, but this wide interface is a pain to
> keep stable, and having bootloaders call it directly is a genuinely
> bad idea.  It will lock us into an interface, or cause major breakage,
> when we have to do necessary revving of this interface.

 Note that this interface is so stable that the structure did not change
 for a long time. If someone wants to change it completely, he will
 have to rewrite tools which are accessing this structure (rdev) and
 also the bootloaders which are setting up fields into it already.
 This will involve re-coding real-mode i8086 assembly, and there is less
 and less people knowing how to do it.

> Instead, the proper time to deal with this is at kernel link time.
> The PC-BIOS stuff should go in, say arch/i386/pcbios, and you then can
> have other platforms (say, for example, arch/i386/linuxbios) which has
> its own setup code.  You then link a kernel image which has the
> appropriate code for the platform you're running on, and you're set.

 I can see your point about keeping functions which set up the structure
 and function which uses it in a single kernel release.
 In fact, all the functions setting this structure are in the same
 file in Gujin, vmlinuz.[ch]. This file could one day go into the Linux
 kernel, but we are no more speaking of compatibility.

 My main problem is the order the things are done: First load compressed
 files at defined addresses, then call a kernel function which callback the
 BIOS, then uncompress files.

 Once Gujin has started, I have a complete C environment so I can load
 files, treat errors, display messages. I can do this either from cold
 boot or from DOS (think of the first install of Linux on a system).

 A good solution would be to have the kernel being two (or three) GZIP
 files concatenated, the first would be the real-mode code to setup
 the structure only, the second would be the protected-mode code of the
 kernel (and the third the initrd). The first part would be a position
 independant function getting some parameters (address/max size of the
 structure to fill in) and returning information like microprocessor
 minimum requirement, video mode supported (number of BPP, or text only),
 address the kernel has been linked (to load a kernel at 16 Mb), ...

 Then I would call this setup function before doing invalid things like
 writing in the "DOS=HIGH" area. Note also that Gujin do not keep the
 compressed kernel/initrd files, it reads a block and uncompress it
 immediately because of the 64Kb limit on the data section.

 This interface would still not handle a distribution where there is
 few kernel files:
 /boot/Linux-2.4.8-SMP
 /boot/Linux-2.4.8-UP
 /boot/Linux-2.4.8-386
 /boot/Linux-2.4.8-Pentium
 And the bootloader should just select automagically the right kernel.

 I have to say that I simply do not have time to do such a thing,
 because I have a lot of other problems in Gujin: it is already
 a Linux-3.0 bootloader, not Linux-2.5 .
 Moreover, going from a simple solution (loading the binary image of
 an ELF file) to a complex one (as described) to solve problem which
 may appear in the future is not my way of thinking: it is already
 complex enought to do simple software.

  Etienne.

___________________________________________________________
Do You Yahoo!? -- Vos albums photos en ligne, 
Yahoo! Photos : http://fr.photos.yahoo.com
