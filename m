Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTH0PSW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTH0PSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:18:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:11218 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263412AbTH0PST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:18:19 -0400
Date: Wed, 27 Aug 2003 08:13:12 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: LGW <large@lilymarleen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: porting driver to 2.6, still unknown relocs... :(
Message-Id: <20030827081312.7563d8f9.rddunlap@osdl.org>
In-Reply-To: <3F4CB452.2060207@lilymarleen.de>
References: <3F4CB452.2060207@lilymarleen.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 15:38:26 +0200 LGW <large@lilymarleen.de> wrote:

| Hi again.
| 
| As I described before, I try to port an audio driver from 2.4.x to 2.6.x.
| 
| It compiles, but on load I get "module snd_echoaudio: Unknown 
| relocation: 0" from dmesg.
| 
| I looked into arch/*/kernel/module.c, and this error appears if the 
| loaded module contains a relocation other than R_386_32 or R_386_PC32 
| (for intel).
| 
| Now I wonder, what would be an relocation type 0? The printk should also 
| print the type in clear text I think, but it just prints 0. 0 also does 
| not look very much like a valid value at all, or does it?

Maybe g++ generates something different?
Are parts of your driver in c++?

| These are the commands used to build the modules (taken from the .*.cmd 
| files):
| 
| // for the main module file:
| gcc -Wp,-MD,sound/pci/echoaudio/.echoaudio.o.d -Wall -Wstrict-prototypes 
| -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
| -mpreferred-stack-boundary=2 -march=athlon 
| -Iinclude/asm-i386/mach-default -D__KERNEL__ -Iinclude  -Wall 
| -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
| -pipe -mpreferred-stack-boundary=2 -march=athlon 
| -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE 
| -I/usr/include -Isound/pci/echoaudio/DSP -Isound/pci/echoaudio/ASIC 
| -DGINA_20 -DECHO_LINUX -DECHOGALS_FAMILY  -DKBUILD_BASENAME=echoaudio 
| -DKBUILD_MODNAME=snd_echoaudio -c
| -o sound/pci/echoaudio/echoaudio.o sound/pci/echoaudio/echoaudio.c
| 
| // for the c++ helper files:
| g++ -fno-rtti -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
| -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=athlon 
| -Iinclude/asm-i386/mach-default -D__KERNEL__ -Iinclude  -Wall 
| -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -nostdinc 
| -iwithprefix include -DMODULE -Isound/pci/echoaudio/DSP 
| -Isound/pci/echoaudio/ASIC -DGINA_20 -DECHO_LINUX -DECHOGALS_FAMILY  
| -DKBUILD_BASENAME=echoaudio -DKBUILD_MODNAME=snd_echoaudio 
| -I/usr/include -o $@.o $@.cpp
| 
| // linking echoaudio.o
| ld -m elf_i386  -r -o sound/pci/echoaudio/snd-echoaudio.o 
| sound/pci/echoaudio/echoaudio.o sound/pci/echoaudio/OsSupportLinux.o 
| sound/pci/echoaudio/CDaffyDuck.o sound/pci/echoaudio/CEchoGals_info.o
| sound/pci/echoaudio/CEchoGals_transport.o 
| sound/pci/echoaudio/CPipeOutCtrl.o sound/pci/echoaudio/CEchoGals_mixer.o 
| sound/pci/echoaudio/CMidiInQ.o sound/pci/echoaudio/CEchoGals_midi.o 
| sound/pci/echoaudio/CEchoGals_power.o sound/pci/echoaudio/CEchoGals.o 
| sound/pci/echoaudio/CLineLevel.o sound/pci/echoaudio/CMonitorCtrlL.o 
| sound/pci/echoaudio/CChannelMask.o 
| sound/pci/echoaudio/CGdDspCommObject.o 
| sound/pci/echoaudio/CDspCommObject.o 
| sound/pci/echoaudio/CGinaDspCommObject.o sound/pci/echoaudio/CGina.o
| 
| // linking snd-echoaudio.o
| ld -m elf_i386  -r -o sound/pci/echoaudio/snd-echoaudio.o 
| sound/pci/echoaudio/echoaudio.o sound/pci/echoaudio/OsSupportLinux.o 
| sound/pci/echoaudio/CDaffyDuck.o sound/pci/echoaudio/CEchoGals_info.o
| sound/pci/echoaudio/CEchoGals_transport.o 
| sound/pci/echoaudio/CPipeOutCtrl.o sound/pci/echoaudio/CEchoGals_mixer.o 
| sound/pci/echoaudio/CMidiInQ.o sound/pci/echoaudio/CEchoGals_midi.o 
| sound/pci/echoaudio/CEchoGals_power.o sound/pci/echoaudio/CEchoGals.o 
| sound/pci/echoaudio/CLineLevel.o sound/pci/echoaudio/CMonitorCtrlL.o 
| sound/pci/echoaudio/CChannelMask.o 
| sound/pci/echoaudio/CGdDspCommObject.o 
| sound/pci/echoaudio/CDspCommObject.o 
| sound/pci/echoaudio/CGinaDspCommObject.o sound/pci/echoaudio/CGina.o
| 
| // linking snd-echoaudio.ko
| ld -m elf_i386 -r -o sound/pci/echoaudio/snd-echoaudio.ko 
| sound/pci/echoaudio/snd-echoaudio.o sound/pci/echoaudio/snd-echoaudio.mod.o
| 
| I have no idea why those commands should lead to a file with broken 
| relocations. Please help me...


--
~Randy
