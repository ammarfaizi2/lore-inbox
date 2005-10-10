Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVJJObd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVJJObd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVJJObd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:31:33 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:36759 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750706AbVJJObc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:31:32 -0400
Message-ID: <3768.192.168.201.6.1128954688.squirrel@pc300>
In-Reply-To: <20051010131925.GA19256@atrey.karlin.mff.cuni.cz>
References: <2031.192.168.201.6.1128591983.squirrel@pc300>
    <20051007144631.GA1294@elf.ucw.cz>
    <2520.192.168.201.6.1128943428.squirrel@pc300>
    <20051010115641.GA2983@elf.ucw.cz>
    <3125.192.168.201.6.1128949772.squirrel@pc300>
    <20051010131925.GA19256@atrey.karlin.mff.cuni.cz>
Date: Mon, 10 Oct 2005 15:31:28 +0100 (BST)
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

>> > It seems to work okay here. Now, rewriting current boot system into C
>> > may be good goal...
>>
>>   At least that is a way which does not involve modifying assembler
>>  files. Slowly everybody switches to the C version which continue
>>  to evolve (i.e. removing old BIOS calls), then the tree under
>>  arch/i386/boot is removed and we can begin to rearrange the mapping
>>  of "struct linux_param".
>
> Will your C version work with lilo and grub?

  Tricky question. In short no, it cannot.

 It is in fact theoretically possible to boot the same way for LILO,
 Grub and SYSLINUX to still work, and then call this linux_set_params()
 function but involves a lot of assembler programming and linker setup.
 I have done this exact work once with Gujin, but then I was in full
 control of the bootloader, in a setup which was already in C, has the
 stack setup, where I can free the first 4 Kbytes of data (located at
 address 0) for use by this kernel function. It was far to be simple.

 One of the problem I can see is that you currently have two link
 being done by the linker, one in real mode and one in protected mode.
 You cannot have cross references in between those two links, and for
 instance with Gujin, you are filling the content of the LnxParam
 pointer, which is transparently copied at its right position before
 jumping to the Linux kernel code. You will need a seriously more
 complex linker file to forbid cross references, and duplicate Gujin
 treatment about memory setup (in this case that may involve HIMEM/EMM
 primitive calling if starting under DOS).

 Note that if this kernel function returns an error, Gujin will
 display an error message and you can select another kernel to boot,
 but you cannot return to LILO or Grub with an error...

 Modifying the bootloader may be possible, but lately I had another
 look at LILO source and I do not want to touch it.  If you run Grub,
 you loose the "BIOS information gathering before switching to
 protected mode" advantage, BIOS environment may still be broken.
 SYSLINUX is probably at lot more accessible, and Gujin still do
 not support network booting (It can be added, but my TODO list is
 long), but you will want to call a function which is curently at
 the end of a still compressed image.

 Sorry I cannot be compatible with them, please note that
 Gujin is also GPL.
 Etienne.

