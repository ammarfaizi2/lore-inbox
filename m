Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262237AbSJFWVZ>; Sun, 6 Oct 2002 18:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbSJFWVZ>; Sun, 6 Oct 2002 18:21:25 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:35276 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262237AbSJFWVK>;
	Sun, 6 Oct 2002 18:21:10 -0400
Date: Mon, 7 Oct 2002 00:26:47 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210062226.AAA10733@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, tmolina@cox.net
Subject: Re: 2.5.40:  problem with configuration system
Cc: mec@shout.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002 16:28:09 -0500 (CDT), Thomas Molina wrote:
>I was configuring a kernel for a rescue disk, so lots of things were not 
>configured that normally would be.  At the end of the compile I get:
>
>arch/i386/kernel/built-in.o: In function `MP_processor_info':
>arch/i386/kernel/built-in.o(.text.init+0x31ab): undefined reference to 
>`Dprintk'
...
># CONFIG_DEBUG_KERNEL is not set
>CONFIG_X86_EXTRA_IRQS=y
>CONFIG_X86_FIND_SMP_CONFIG=y
>CONFIG_X86_MPPARSE=y
>
>The thing I don't understand is why they should be set to y.  My 
>understanding from reading the source is that they should only be y if 
>CONFIG_X86_LOCAL_APIC is y.  That should only happen if CONFIG_SMP is not 
>y and CONFIG_X86_UP_APIC is y.  The enclosed .config file shows this isn't 
>the case.  What am I missing?

This happened to me recently when I copied a .config which had
UP_APIC=y and used make config to disable UP_APIC. The problem in
my case was that the good ole' Configure script doesn't always
reach a fixpoint in one iteration: the fact that LOCAL_APIC=y at the
start is sufficient for it to emit MPPARSE=y at the end, even though
LOCAL_APIC got disabled. A 'make oldconfig' should fix the situation.

This is not the only case where Configure gets it wrong. There is
a bug involving dep_tristate, forward dependencies, and toggling
module support which I reported to LKML ages ago (with a fix), but
nobody cared so... FWIW, the fix to that bug is included below.

/Mikael

--- linux-2.5.40/scripts/Configure.~1~	Thu Oct  3 00:00:00 2002
+++ linux-2.5.40/scripts/Configure	Thu Oct  3 18:32:20 2002
@@ -316,7 +316,13 @@
 	      return
 	      ;;
 	    m)
-	      need_module=1
+	      # Note: "m" means "module" only when CONFIG_MODULES=y,
+	      # otherwise it really means "y". This matters when
+	      # a dep_tristate dependency is a forward reference
+	      # which we haven't yet "corrected" from "m" to "y".
+	      if [ "$CONFIG_MODULES" = "y" ]; then
+		need_module=1
+	      fi
 	      ;;
 	  esac
 	  shift
