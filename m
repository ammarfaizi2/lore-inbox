Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135645AbRDXRIA>; Tue, 24 Apr 2001 13:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135549AbRDXRHk>; Tue, 24 Apr 2001 13:07:40 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:50486 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S135540AbRDXRHd>; Tue, 24 Apr 2001 13:07:33 -0400
Message-Id: <4.3.2.7.2.20010424095651.00c477c0@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 24 Apr 2001 10:06:54 -0700
To: <imel96@trustix.co.id>
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: [PATCH] Single user linux
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0104241830020.11899-100000@tessy.trustix.co.
 id>
In-Reply-To: <992trn$lk1$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thinking out of the box," you don't need to modify the kernel or the 
userland utilities to make Linux automatically launch a dedicated terminal 
for embedded applications.  All you need to do is look at the file 
/etc/inittab and read the man pages for this file.  For console access, you 
merely make a shell the first program launched, and you specify RESPAWN as 
the restart type so that if the shell crashes you get your shell back.  The 
invocation may need to be put in a wrapper so that standard input, standard 
output, and standard error are set properly, as are the environment variables.

The security model of Unix need not be sacrificed.  The wrapper can set the 
user ID to a default non-zero user so that there is more security than the 
all-root solution that others have suggested.  For administrative duties, 
the user would use su (and appropriate password) to acquire the appropriate 
permissions.
Back when Unix was first given out by Bell Labs in the '70s, several Bell 
people wrote papers describing exactly how to do this sort of thing in 
Version 7.  In the thirty years since the technique was described, the 
underlying structure -- init/getty/login -- hasn't changed.  I suspect that 
many people here haven't explored the power of inittab, especially given 
the discussion about dying daemons a few months back and how the problem 
was solved in the beginning and the solution ignored today.  (For those of 
you interested, you might want to check the archives for the tangent in the 
OOMkiller discussion.)

(Sorry, I've not found those papers on-line, and my copies were lost about 
seven moves ago.)

Satch


At 06:44 PM 4/24/01 +0700, imel96@trustix.co.id wrote:

>hi,
>
>a friend of my asked me on how to make linux easier to use
>for personal/casual win user.
>
>i found out that one of the big problem with linux and most
>other operating system is the multi-user thing.
>
>i think, no personal computer user should know about what's
>an operating system idea of a user. they just want to use
>the computer, that's it.
>
>by a personal computer i mean home pc, notebook, tablet,
>pda, and communicator. only one user will use those devices,
>or maybe his/her friend/family. do you think that user want
>to know about user account?
>
>from that, i also found out that it is very awkward to type
>username and password every time i use my computer.
>so here's a patch. i also have removed the user_struct from
>my kernel, but i don't think you'd like #ifdef's.
>may be it'll be good for midori too.
>
>
>         imel
>
>
>
>--- sched.h     Mon Apr  2 18:57:06 2001
>+++ sched.h~    Tue Apr 24 17:32:33 2001
>@@ -655,6 +655,12 @@
>                        unsigned long, const char *, void *);
>  extern void free_irq(unsigned int, void *);
>
>+#ifdef CONFIG_NOUSER
>+#define capable(x)     1
>+#define suser()                1
>+#define fsuser()       1
>+#else
>+
>  /*
>   * This has now become a routine instead of a macro, it sets a flag if
>   * it returns true (to do BSD-style accounting where the process is flagged
>@@ -706,6 +712,8 @@
>         }
>         return 0;
>  }
>+
>+#endif /* CONFIG_NOUSER */
>
>  /*
>   * Routines for handling mm_structs
>
>diff -ur linux/Documentation/Configure.help 
>nouser/Documentation/Configure.help
>--- linux/Documentation/Configure.help  Mon Apr  2 18:53:29 2001
>+++ nouser/Documentation/Configure.help Tue Apr 24 18:08:49 2001
>@@ -13626,6 +13626,14 @@
>    a work-around for a number of buggy BIOSes. Switch this option on if
>    your computer crashes instead of powering off properly.
>
>+Disable Multi-user (DANGEROUS)
>+CONFIG_NOUSER
>+  Disable kernel multi-user support. Normally, we treat each user
>+  differently, depending on his/her permissions. If you _really_
>+  think that you're not going to use your computer in a hostile
>+  environment and would like to cut a few bytes, say Y.
>+  Most people should say N.
>+
>  Watchdog Timer Support
>  CONFIG_WATCHDOG
>    If you say Y here (and to one of the following options) and create a
>diff -ur linux/arch/i386/config.in nouser/arch/i386/config.in
>--- linux/arch/i386/config.in   Mon Feb  5 18:50:27 2001
>+++ nouser/arch/i386/config.in  Tue Apr 24 17:53:42 2001
>@@ -244,6 +244,8 @@
>     bool '    Use real mode APM BIOS call to power off' 
> CONFIG_APM_REAL_MODE_POWER_OFF
>  fi
>
>+bool 'Disable Multi-user (DANGEROUS)' CONFIG_NOUSER
>+
>  endmenu
>
>  source drivers/mtd/Config.in
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

