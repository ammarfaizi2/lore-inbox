Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbTCZJWu>; Wed, 26 Mar 2003 04:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbTCZJWu>; Wed, 26 Mar 2003 04:22:50 -0500
Received: from evrtwa1-ar9-4-65-245-203.evrtwa1.dsl-verizon.net ([4.65.245.203]:9186
	"EHLO omgwallhack.org") by vger.kernel.org with ESMTP
	id <S261517AbTCZJWs>; Wed, 26 Mar 2003 04:22:48 -0500
From: bung@omgwallhack.org (Joe Rayhawk)
Date: Tue, 25 Mar 2003 07:30:05 -0800
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-kernel@vger.kernel.org, shaheed <srhaque@iee.org>
Subject: Re: [PROBLEM] SB16 fails to compile: ISA PNP issues
Message-ID: <20030325153005.GA831@cobain.omgwallhack.org>
References: <200303091038.00948.srhaque@iee.org> <200303252221.59910.srhaque@iee.org> <20030325191251.GA1083@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325191251.GA1083@neo.rr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With everything compiled into the kernel, ISAPNP initializes -after- ALSA initializes, so ALSA fails to find the card. Good news is that ISAPNP does indeed find the card. Is there some way to re-init ALSA or get it to do a rescan?

Syslog stuff:

isapnp: Scanning for PnP cards...
pnp: Calling quirk for 01:01.00
pnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative SB16 PnP'
isapnp: 1 Plug & Play card detected total
[...]
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA sound/drivers/mpu401/mpu401.c:76: specify port
pnp: the driver 'sb16' has been registered
ALSA sound/pci/intel8x0.c:2560: joystick(s) found
ALSA device list:
  No soundcards found.
[...]
Board 1 has Identity 59 10 08 23 bc 24 00 8c 1e:  GTL0024 Serial No 268968892 [checksum 59]
GTL0024/268968892[0]{Audio               }: Ports 0x220 0x330 0x388; IRQ5 DMA1 DMA3 --- Enabled OK
GTL0024/268968892[3]{Game                }: --- Enabled OK  

cat /proc/asound/cards
--- no soundcards ---

cat /etc/isapnp.conf | grep -v \#
(READPORT 0x0273)
(ISOLATE PRESERVE)
(IDENTIFY *)
(VERBOSITY 2)
(CONFIGURE GTL0024/268968892 (LD 0
(INT 0 (IRQ 5 (MODE +E)))
(DMA 0 (CHANNEL 1))
(DMA 1 (CHANNEL 3))
(IO 0 (SIZE 16) (BASE 0x0220))
(IO 1 (SIZE 2) (BASE 0x0330))
(IO 2 (SIZE 4) (BASE 0x0388))
 (NAME "GTL0024/268968892[0]{Audio               }")
(ACT Y)
))
(CONFIGURE GTL0024/268968892 (LD 1
 (NAME "GTL0024/268968892[3]{Game                }")
 (ACT Y)
))
(WAITFORKEY)
# Note: This config works fine for OSS in 2.4


Next I compiled ALSA as a module so I could get it to rescan after ISAPNP goes to work. SB16 is modularized as a result of this, but upon attempting to compile, I get this:

make -f scripts/Makefile.build obj=sound/isa/sb
   rm -f sound/isa/sb/built-in.o; ar rcs sound/isa/sb/built-in.o
  gcc -Wp,-MD,sound/isa/sb/.emu8000_synth.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=emu8000_synth -DKBUILD_MODNAME=snd_emu8000_synth -c -o sound/isa/sb/emu8000_synth.o sound/isa/sb/emu8000_synth.c
  gcc -Wp,-MD,sound/isa/sb/.emu8000_callback.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=emu8000_callback -DKBUILD_MODNAME=snd_emu8000_synth -c -o sound/isa/sb/emu8000_callback.o sound/isa/sb/emu8000_callback.c
  gcc -Wp,-MD,sound/isa/sb/.emu8000_patch.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=emu8000_patch -DKBUILD_MODNAME=snd_emu8000_synth -c -o sound/isa/sb/emu8000_patch.o sound/isa/sb/emu8000_patch.c
  gcc -Wp,-MD,sound/isa/sb/.emu8000_pcm.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=emu8000_pcm -DKBUILD_MODNAME=snd_emu8000_synth -c -o sound/isa/sb/emu8000_pcm.o sound/isa/sb/emu8000_pcm.c
  gcc -Wp,-MD,sound/isa/sb/.sb_common.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=sb_common -DKBUILD_MODNAME=snd_sb_common -c -o sound/isa/sb/sb_common.o sound/isa/sb/sb_common.c
  gcc -Wp,-MD,sound/isa/sb/.sb_mixer.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=sb_mixer -DKBUILD_MODNAME=snd_sb_common -c -o sound/isa/sb/sb_mixer.o sound/isa/sb/sb_mixer.c
  gcc -Wp,-MD,sound/isa/sb/.sb16_csp.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=sb16_csp -DKBUILD_MODNAME=snd_sb16_csp -c -o sound/isa/sb/sb16_csp.o sound/isa/sb/sb16_csp.c
  gcc -Wp,-MD,sound/isa/sb/.sb16_main.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=sb16_main -DKBUILD_MODNAME=snd_sb16_dsp -c -o sound/isa/sb/sb16_main.o sound/isa/sb/sb16_main.c
  gcc -Wp,-MD,sound/isa/sb/.sb16.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=sb16 -DKBUILD_MODNAME=snd_sb16 -c -o sound/isa/sb/sb16.o sound/isa/sb/sb16.c
sound/isa/sb/sb16.c:251: storage size of `__mod_pnp_card_device_table' isn't known
make[3]: *** [sound/isa/sb/sb16.o] Error 1
make[2]: *** [sound/isa/sb] Error 2
make[1]: *** [sound/isa] Error 2
make: *** [sound] Error 2
