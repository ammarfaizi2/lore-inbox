Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSL1BsJ>; Fri, 27 Dec 2002 20:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSL1BsJ>; Fri, 27 Dec 2002 20:48:09 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:43021 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265368AbSL1BsH>; Fri, 27 Dec 2002 20:48:07 -0500
Message-ID: <3E0CEE3D.F3282E22@linux-m68k.org>
Date: Sat, 28 Dec 2002 01:20:13 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Dave Jones <davej@codemonkey.org.uk>, Ed Tomlinson <tomlins@cam.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
References: <20021226042938.281142C04D@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rusty Russell wrote:

> > So where is the documentation describing module locking de jour ?
> 
> Here's the FAQ again.  Note that the init stuff is not currently true
> (you can enter a module doing init, with possibly bad results),
> because Linus patched my code.  It's on my TODO list to revisit this
> issue.

Rusty, you should do this rather soon. Could you please explain, how you
intend to solve the module init races? The "don't enter module until
init is finished" concept doesn't work, so what else do you want to do?

> Q: How does the code in try_module_get() work?
> A: It disables preemption for a moment, checks the live flag, and then
>    increments a per-cpu counter if the module is live.  This is even
>    lighter-weight (in icache and cycles) than using a brlock, but has
>    the same effect.

Q: But if I have a large number of modules (e.g. netfilter) and I have
to use try_module_get() for each of them, won't it still affect
performance?

> Q: Are these changes all so you could implement an in-kernel module
>    linker?
> A: No, they were to prevent load and unload races without altering
>    every module, nor introducing drastic new requirements.

Q: Wasn't it possible to do the rewrite in several steps? What made it
so urgent that everything had to be 2.6?

> Q: Doesn't putting linking code into the kernel just add bloat?
> A: The total linking code is about 200 generic lines, 100
>    x86-specific lines. [...]
> 
>    The previous code had to implement the two module loading
>    system calls, the module querying system call, and the /proc/ksyms
>    output, required a little more code than the current x86 linker.

2.4.20: wc kernel/module.c include/linux/module.h
   1283    3800   29616 kernel/module.c
    415    1609   13173 include/linux/module.h
   1698    5409   42789 total

2.5.52: wc kernel/module.c kernel/params.c arch/i386/kernel/module.c
include/linux/module*
   1414    4400   35284 kernel/module.c
    338    1093    8182 kernel/params.c
    124     412    3347 arch/i386/kernel/module.c
    368    1174    9954 include/linux/module.h
     61     244    1958 include/linux/moduleloader.h
    127     619    5199 include/linux/moduleparam.h
   2432    7942   63924 total

Q: Doesn't the querying system call provide the same information as
/proc/modules and /proc/ksyms? Is procfs now required to load modules?
Q: How can I debug modules with ksymoops?
Q: Why was it necessary to remove the system calls? Wasn't it possible
to emulate them?

> Q: Why not just fix the old code?
> A: Because having something so intimate with the kernel in userspace
>    greatly restricts what changes the kernel can make.  Moving into
>    the kernel means I have implemented modversions, typesafe
>    extensible module parameters and kallsyms without altering
>    userspace in any way.  Future extensions won't have to worry about
>    the version of modutils problem.

Q: Can I see the modversions implementation?
Q: Was there an analysis, which discussed the limitation of the old
code? Was it really impossible to design a more flexible interface,
which left as much as possible in userspace?

Rusty, could you _please_ start answering questions instead of ignoring
them or is there no discussion required anymore, now that your code is
in the kernel?

bye, Roman


