Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318690AbSHAKQN>; Thu, 1 Aug 2002 06:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318691AbSHAKQN>; Thu, 1 Aug 2002 06:16:13 -0400
Received: from [195.63.194.11] ([195.63.194.11]:42756 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318690AbSHAKQN>; Thu, 1 Aug 2002 06:16:13 -0400
Message-ID: <3D490A06.6070008@evision.ag>
Date: Thu, 01 Aug 2002 12:14:30 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org, gerald@io.com, martin@dalecki.de
Subject: Re: 2.5.29: bug in ide and hd kernel option handling
References: <200208010101.DAA00248@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Tue, 30 Jul 2002, I wrote:
> 
>>On my 486 test box (ISA/VLB only, CONFIG_PCI=n), passing any
>>any ide or hd kernel option (like idebus=33) to 2.5.29 results
>>in a kernel hang at boot: I get the initial "Uncompressing ..
>>booting .." and then nothing.
> 
> 
> Problem partially identified.
> 
> With CONFIG_PCI=n, include/asm-i386/ide.h:ide_init_default_hwifs()
> is defined to ide_register_hw() the PC's standard IDE ports, but
> with CONFIG_PCI=y, it's empty.
> 
> When drivers/ide/main.c:ide_setup() is called for some "ide..."
> kernel option, it starts by calling init_global_data(), which
> in turn calls ide_init_default_hwifs(). When CONFIG_PCI=n so
> ide_init_default_hwifs() isn't empty, the kernel either hangs
> or reboots at that point.
> 
> init_global_data() and ide_init_default_hwifs() can also be called
> much later from 'module_init(init_ata)'. In that case there is no
> hang or reboot -- so my guess is that the initialisation does something
> which normally works but is illegal and causes a fault when done
> at __setup()-time.
> 
> I tested every kernel from 2.5.29 and back, and the problem started
> with 2.5.5.
> 
> As a workaround I applied the patch below to unconditionally
> make ide_init_default_hwifs() do nothing. This solved my problem
> and doesn't seem to have had any bad side-effects: the kernel still
> finds all standard IDE ports on my 486.

Ahh. Thats actually insightfull. OK some other archs even default to the
same if PCI bus support is enabled at all. I will have to test the
effects of this approach in bochs to see how it lives with "legacy"
host chips. Maybe this whole ide_init_default_hwifs can go completely
away then... (If anything it should be fallback only.)

