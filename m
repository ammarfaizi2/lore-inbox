Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTJCQ0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 12:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbTJCQ0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 12:26:06 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:47042
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262297AbTJCQ0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 12:26:03 -0400
Date: Fri, 3 Oct 2003 18:26:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1: scsi/pcmcia qlogic does not build
Message-ID: <20031003162632.GD13360@velociraptor.random>
References: <20031002152648.GB1240@velociraptor.random> <3F7D8723.E1898A5@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7D8723.E1898A5@eyal.emu.id.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 12:26:43AM +1000, Eyal Lebedinsky wrote:
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
> -Wstrict-
> prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-poi
> nter -pipe -msoft-float -mpreferred-stack-boundary=2 -march=i686
> -malign-functio
> ns=4 -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre-aa/inclu
> de/linux/modversions.h  -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=qlogicf
> as -DPCMCIA -D__NO_VERSION__ -c -o qlogicfas.o ../qlogicfas.c
> ../qlogicfas.c: In function `qlogicfas_detect':
> ../qlogicfas.c:650: warning: passing arg 1 of
> `scsi_unregister_R2c5e5a25' from incompatible pointer type
> ld -m elf_i386 -r -o qlogic_cs.o qlogic_stub.o qlogicfas.o
> qlogicfas.o: In function `init_module':
> qlogicfas.o(.text+0xe40): multiple definition of `init_module'
> qlogic_stub.o(.text+0x770): first defined here
> ld: Warning: size of symbol `init_module' changed from 77 to 58 in
> qlogicfas.o
> qlogicfas.o: In function `cleanup_module':
> qlogicfas.o(.text+0xe80): multiple definition of `cleanup_module'
> qlogic_stub.o(.text+0x7c0): first defined here
> ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
> qlogicfas.o
> make[3]: *** [qlogic_cs.o] Error 1
> make[3]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre-aa/drivers/scsi/pcmcia'
> 
> A broken build?

it's a real compilation bug (not a mistake of your toolchain). The
init_module function is defined both in qlogic_stub.c and in qlogicfas.c
that imports scsi_module.c. One of the two has to go away or it can't
link due a name clash across two objects.

after a first look I'm unsure what's the right fix. I guess the init
module of the _cs has to get priority over the scsi_module.c. so
basically you could hack something to disable the include of
scsi_module.c from the other file. This assumes the _cs init_module will
eventually register the scsi device too from the pcmcia callback.

However this should be a generic problem not introduced by my changes.
Is there any scsi or pcmcia person interested in fixing it?

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
