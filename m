Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312320AbSC3ALn>; Fri, 29 Mar 2002 19:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312321AbSC3ALd>; Fri, 29 Mar 2002 19:11:33 -0500
Received: from CPE-203-51-25-11.nsw.bigpond.net.au ([203.51.25.11]:4081 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312320AbSC3ALU>; Fri, 29 Mar 2002 19:11:20 -0500
Message-ID: <3CA502A0.54547786@eyal.emu.id.au>
Date: Sat, 30 Mar 2002 11:11:12 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5: bad config
In-Reply-To: <Pine.LNX.4.21.0203291842530.6417-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------BFDC496D99796A8619B54904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BFDC496D99796A8619B54904
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes pre5. I've trimmed down the changelog because its just too big,
> and the ones who actually want to see all changelog can get it from
> linux.bkbits.net.

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-DKBUILD_BASENAME=sa1100_generic  -c -o sa1100_generic.o
sa1100_generic.c
sa1100_generic.c:40: linux/cpufreq.h: No such file or directory
sa1100_generic.c:50: linux/cpufreq.h: No such file or directory
sa1100_generic.c:58: asm/hardware.h: No such file or directory
sa1100_generic.c:62: asm/arch/assabet.h: No such file or directory
sa1100_generic.c: In function `sa1100_pcmcia_set_io_map':
sa1100_generic.c:595: warning: implicit declaration of function
`cpufreq_get'
sa1100_generic.c:597: `MECR' undeclared (first use in this function)
sa1100_generic.c:597: (Each undeclared identifier is reported only once
sa1100_generic.c:597: for each function it appears in.)
sa1100_generic.c: In function `sa1100_pcmcia_set_mem_map':
sa1100_generic.c:703: `MECR' undeclared (first use in this function)
sa1100_generic.c: In function `sa1100_pcmcia_proc_status':
sa1100_generic.c:751: `MECR' undeclared (first use in this function)
sa1100_generic.c: In function `sa1100_pcmcia_driver_init':
sa1100_generic.c:1079: warning: implicit declaration of function
`_PCMCIA'
sa1100_generic.c:1079: `PCMCIASp' undeclared (first use in this
function)
sa1100_generic.c:1095: warning: implicit declaration of function
`_PCMCIAAttr'
sa1100_generic.c:1096: warning: implicit declaration of function
`_PCMCIAMem'
sa1100_generic.c:1097: warning: implicit declaration of function
`_PCMCIAIO'
sa1100_generic.c:1110: `MECR' undeclared (first use in this function)
sa1100_generic.c: In function `sa1100_pcmcia_driver_shutdown':
sa1100_generic.c:1165: `PCMCIASp' undeclared (first use in this
function)
make[2]: *** [sa1100_generic.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/pcmcia'

The source of the problem seems to be a bad dependency in the pcmcia
config.
Since CONFIG_ARCH_SA1100 is undefined, it cannot be used on the shell
command
line for the dep_tristate.

I guess inside the ARM arch tree it is always defined and is safe on
command
lines as used in many places there.

In drivers/mtd/maps/Config.in CONFIG_ARM is used in the condition, so
maybe a better patch will be to do the same here? I leave this to the
experts.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------BFDC496D99796A8619B54904
Content-Type: text/plain; charset=us-ascii;
 name="2.4.19-pre5-sa1100.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.19-pre5-sa1100.patch"

--- linux/drivers/pcmcia/Config.in.orig	Sat Mar 30 10:48:11 2002
+++ linux/drivers/pcmcia/Config.in	Sat Mar 30 10:57:18 2002
@@ -24,6 +24,8 @@
       dep_tristate '  HD64465 host bridge support' CONFIG_HD64465_PCMCIA $CONFIG_PCMCIA
    fi
 fi
-dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_ARCH_SA1100 $CONFIG_PCMCIA
+if [ "$CONFIG_ARCH_SA1100" = "y" ]; then
+	dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_PCMCIA
+fi
 
 endmenu

--------------BFDC496D99796A8619B54904--

