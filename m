Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbRGKC1u>; Tue, 10 Jul 2001 22:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbRGKC1k>; Tue, 10 Jul 2001 22:27:40 -0400
Received: from smtp.awc.net ([216.205.112.6]:63240 "EHLO mx-a.awc.net")
	by vger.kernel.org with ESMTP id <S267187AbRGKC1Z>;
	Tue, 10 Jul 2001 22:27:25 -0400
For: <linux-kernel@vger.kernel.org>
Message-ID: <000b01c109af$97451ba0$2b00000a@briandesk>
From: "Brian K. White" <brian@aljex.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: compile error about do_softirq in 2.4.5-ac21
Date: Tue, 10 Jul 2001 22:17:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sun, 1 Jul 2001, Byeong-ryeol Kim wrote:
>
>>On Sat, 30 Jun 2001, Keith Owens wrote:
>>
>>>On Sat, 30 Jun 2001 10:07:20 +0900 (KST),
>>>Byeong-ryeol Kim <jinbo21@hananet.net> wrote:
>>>>>>background.c:57: `do_softirq_Rf0a529b7' undeclared (first use in \
>>>>>> this function)
>>>
>>>Missing include in fs/jffs2/background.c. spin_unlock_bh() needs the
>>>definition of do_softirq(). Against 2.4.5-ac21, will fit -ac22 as well.
>>>
>>>Index: 5.52/fs/jffs2/background.c
>>>--- 5.52/fs/jffs2/background.c Sun, 22 Apr 2001 07:25:55 +1000 kaos
(linux->2.4/Z/d/7_background 1.1 644)
>>>+++ 5.52(w)/fs/jffs2/background.c Sat, 30 Jun 2001 14:13:12 +1000 kaos
(linux->2.4/Z/d/7_background 1.1 644)
>>>@@ -43,6 +43,7 @@
>>> #include <linux/jffs2.h>
>>> #include <linux/mtd/mtd.h>
>>>+#include <linux/interrupt.h>
>>> #include <linux/smp_lock.h>
>>> #include "nodelist.h"
>>...
>>
>>Thank you.
>>But, it is proved to be that jffs2/background.c includes
'linux/smp_lock.h',
>>'linux/smp_lock.h' includes 'asm/smplock.h' and 'asm/smplock.h' includes
>>'linux/interrupt.h'.
>>Is it correct to put 'linux/interrupt.h' into jffs2/background.c in this
>>situation?
>...
>
>Please, ignore my previous mail about 'linux/interrupt.h'.
>I bypassed the '#ifndef CONFIG_SMP ... #endif' wrapper in linux/smp_lock.h.
>
>...
>#ifndef CONFIG_SMP
>
>#define lock_kernel() do { } while(0)
>#define unlock_kernel() do { } while(0)
>#define release_kernel_lock(task, cpu) do { } while(0)
>#define reacquire_kernel_lock(task) do { } while(0)
>#define kernel_locked() 1
>
>#else
>#include <asm/smplock.h>
>#endif /* CONFIG_SMP */
>...
>
>Thanks,


I get this same error when trying to compile modules for stock 2.4.6. I have
no problems with 2.4.5 or any version previous.

>>>>>>background.c:57: `do_softirq_Rf0a529b7' undeclared (first use in \
>>>>>> this function)

except I get it in a different place...

--- snip ---
gcc -D__KERNEL__ -I/usr/src/linux-2.4.6/include -Wall -Wstrict-prototypes -W
no-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred
-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.6/include/linux/modversions.h   -c -o cfi_probe.o
cfi_probe.c
In file included from cfi_probe.c:17:
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h: In function `cfi_spin_unlock':
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: `do_softirq_Rf0a529b7'
undeclared (first use in this function)
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: (Each undeclared
identifier is reported only once
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: for each function it
appears in.)
make[3]: *** [cfi_probe.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.6/drivers/mtd/chips'
make[2]: *** [_modsubdir_chips] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.6/drivers/mtd'
make[1]: *** [_modsubdir_mtd] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.6/drivers'
make: *** [_mod_drivers] Error 2
--- snip ---

It's not clear to me from the earlier posts... do I insert an include for
interrupt.h into cfi_probe.c or not?

I'm trying to compile mtd/cfi support on my laptop because I'm guessing I
want this in order to write ext2 filesystems onto CF type-1 flash cards via
a pcmcia-cf adapter.

though I'm only guessing about that, I really have no idea how to proceed on
that...

The purpose is to install precompiled / cross-compiled binaries for the sh3
processor and hopefully eventually run linux on an HP Jornada 548

maybe it would be easier to use the jornada to write to the cf card, if
there was only a "rawrite" or "dd" for WinCE out there somewhere...

Brian K. White  --  brian@aljex.com  --  http://www.aljex.com/bkw/
+++++[>+++[>+++++>+++++++<<-]<-]>>+.>.+++++.+++++++.-.[>+<---]>++.
filePro BBx  Linux SCO  Prosper/FACTS AutoCAD  #callahans Satriani


