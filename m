Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSEKOvV>; Sat, 11 May 2002 10:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316226AbSEKOvU>; Sat, 11 May 2002 10:51:20 -0400
Received: from smtp1.wanadoo.nl ([194.134.35.136]:61376 "EHLO smtp1.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S314451AbSEKOvU>;
	Sat, 11 May 2002 10:51:20 -0400
Message-Id: <4.1.20020511114723.009c8270@pop.cablewanadoo.nl>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1
Date: Sat, 11 May 2002 16:46:09 +0200
To: Dave Jones <davej@suse.de>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: Linux 2.5.14-dj2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020508225147.GA11390@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:51 8-5-02 +0100, Dave Jones wrote:
>Some more pending items, including a large patch from Patrick
>which splits the x86 CPU initialisation code up a lot, cleaning
>up a lot of cruft in the process. Feedback on this welcomed from
>users of as many weird and wonderful x86 variants as can be found.

>2.5.14-dj2

Got these errors while compiling:

gcc -D__KERNEL__ -I/Upload/linux-2.5.14-dj2/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586
-nostdinc -I /usr/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/include
-DKBUILD_BASENAME=proc  -c -o proc.o proc.c
proc.c: In function `show_cpuinfo':
proc.c:69: warning: passing arg 2 of `constant_test_bit' from incompatible
pointer type
proc.c:69: warning: passing arg 2 of `variable_test_bit' from incompatible
pointer type
proc.c:99: warning: passing arg 2 of `constant_test_bit' from incompatible
pointer type
proc.c:99: warning: passing arg 2 of `variable_test_bit' from incompatible
pointer type

found a few other problems:
1) the pio fix posted last week is not included in your tree or Linus' and
I found this the hard way: severe filesystem damage and system lockup and a
kernel (2.4.19-pre8) panic because the root partition could not be mounted
(as reported before). 

The following patch fixes this, apllies with an offset of -2 lines:
-- begin patch --
--- linux-2.5.10/drivers/ide/ide-taskfile.c    Wed Apr 24 16:15:19 2002
+++ linux/drivers/ide/ide-taskfile.c  Fri Apr 26 15:44:42 2002
@@ -202,7 +202,7 @@
 			ata_write_slow(drive, buffer, wcount);
 		else
 #endif
- 			ata_write_16(drive, buffer, wcount<<1);
+ 			ata_write_16(drive, buffer, wcount);
 	}
 }
-- end patch --

2) After boot the system is not responsive to the keyboard, logging in via
ssh and doing a `insmod psmouse` followed by a `rmmod psmouse` results in a
working keyboard...
before and after insmod there is no interrupt 1 listed in /proc/interrupts,
but after doing the rmmod it is listed: "  1:         52          XT-PIC
i8042"
the mouse interrupt is listed as " 12:        154          XT-PIC  i8042"
the following message was issued after `rmmod psmouse`: "input: AT Set 2
keyboard on isa0060/serio0"


After applying the pio-fix I was able to run both 2.5.13-dj2 and 2.5.14-dj1
for three days on this system (p100, 48MB, 2x IDE-hd) without
ext2-filesystem corruption or lockups!!
2.5.14-dj2 is now running for 4 hours and I am going to stress-test it :-)

	Rudmer

