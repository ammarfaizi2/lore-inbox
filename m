Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289273AbSAVMB3>; Tue, 22 Jan 2002 07:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289280AbSAVMBU>; Tue, 22 Jan 2002 07:01:20 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:61956 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S289273AbSAVMBI>;
	Tue, 22 Jan 2002 07:01:08 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200201221200.g0MC0pd21058@oboe.it.uc3m.es>
Subject: Re: missing memset in divas and eicon in 2.2.20
In-Reply-To: <15377.1011696195@ocs3.intra.ocs.com.au> from "Keith Owens" at "Jan
 22, 2002 09:43:15 pm"
To: "Keith Owens" <kaos@ocs.com.au>
Date: Tue, 22 Jan 2002 13:00:51 +0100 (MET)
Cc: "Armin Schindler" <mac@melware.de>, "Peter T. Breuer" <ptb@it.uc3m.es>,
        kkeil@suse.de, "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Keith Owens wrote:"
> On Tue, 22 Jan 2002 10:19:15 +0100 (MET), 
> Armin Schindler <mac@melware.de> wrote:
> >Did you use plain 2.2.20 ?
> >I cannot reproduce this problem here, can you please send me your
> >kernel config.
> >
> >On Tue, 22 Jan 2002, Peter T. Breuer wrote:
> >>   betty:/usr/local/src/linux-2.2.20% sudo depmod -ae -F System.map 2.2.20-SMP
> >>   depmod: *** Unresolved symbols in
> >>   /lib/modules/2.2.20-SMP/misc/divas.o depmod:         memset
> >>   depmod: *** Unresolved symbols in
> >>   /lib/modules/2.2.20-SMP/misc/eicon.o depmod:         memset
> 
> This can be a gcc problem.  Some versions of gcc generate internal

Possibly. As I recall it self-selected gcc 2.7.2 to do the compilation
on my system, although egcs 2.91 is the installed compiler of choice.
I didn't pay too much attention as I was only compiling 2.2.20 in order
to win the arms race against stephen tweedies ext3 patch for the 2.2
series. So ... uh, ok, let's seee...


  /usr/bin/gcc272 -D__KERNEL__ -I/usr/local/src/linux-2.2.20/include
  -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -D__SMP__ -pipe
  -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2
  -malign-functions=2 -DCPU=686 -DUTS_MACHINE='"i386"' -c -o
  init/version.o init/version.c

Yep. Wonder how that got there.  This is a debian system. Oh, it's the
scripts/kwhich stuff. Clever lad.

   CC      =$(shell if [ -n "$(CROSS_COMPILE)" ]; then echo $(CROSS_COMPILE)gcc; else \
           $(CONFIG_SHELL) scripts/kwhich gcc272 2>/dev/null || $(CONFIG_SHELL) scripts/kwhich kgcc 2>/dev/null || echo cc; fi) \
           -D__KERNEL__ -I$(HPATH)


> calls to memset and memcpy when manipulating structures.  Because these
> internal calls are created after cpp they end up as phantom calls to
> functions instead of being converted by string.h.


In any case, don't worry about it. It's a question of adding an
#include <linux/strings.h> to every source file of divas.o and eicon.o
that mentions the word "memset". I did, and that cured the problem.

Something like   vim -o `grep -w memset *.c | cut -d: -f 1 | uniq`  
in the directory.


Now, obviously, all the other files in the kernel don't have this
problem with memset (I compile about 100 modules normally), so the
problem IS with the diva/eicon stuff, I am afraid. It's fixed by the
include I suggest above.

> If it is a gcc problem, you track it down by first identifying the object
> 
>   nm -A drivers/isdn/eicon/*.o | fgrep memset
> 
> then compile the xxx object with -S
> 
>   make CFLAGS_xxx.o=-S SUBDIRS=drivers/isdn/eicon modules
> 
> vi drivers/isdn/eicon/xxx.o looking for calls to memset.  Scroll up
> until you find the function that that is generating the call, then
> eyeball the code looking for structure assignments like s = *foo or s =
> 0.  Replace the assignments with explicit calls to memcpy or memset.

Well, I'd try that next, if I were desperate. It was just sufficiently
annoying that I fixed it in my own way.


Peter
