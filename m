Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129436AbQK0Wdk>; Mon, 27 Nov 2000 17:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129523AbQK0Wda>; Mon, 27 Nov 2000 17:33:30 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:1028 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129436AbQK0WdW>; Mon, 27 Nov 2000 17:33:22 -0500
Date: Mon, 27 Nov 2000 16:02:13 -0600
To: Russell King <rmk@arm.linux.org.uk>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: silly [< >] and other excess
Message-ID: <20001127160213.F8881@wire.cadcamlab.org>
In-Reply-To: <200011251026.eAPAQKG210983@saturn.cs.uml.edu> <200011251211.eAPCBF019116@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011251211.eAPCBF019116@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Nov 25, 2000 at 12:11:15PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Albert D. Cahalan]
> > Somebody else posted a reasonable hack for the [<>] problem.  His
> > proposal involved letting multiple values share the same markers,
> > something like this:

[Russell King]
> Yep, now that is one idea I like!

Me too. (:  Keith posed two objections:

1. The >] could get word-wrapped so that it doesn't appear on the same
   line as the [<.  I *do not* see what makes this hard to parse
   reliably.

2. Someone (i.e. kernel debugger) could insert extra text.  Well, same
   culprits can mangle oopsen already -- see klogd.  These evil tools,
   whichever ones they may be, should learn to use /* */ or something.
   That way it is relatively easy to ignore their output.

Peter

PS. Should we be using KERN_* here?

--- arch/i386/kernel/traps.c.orig	Mon Nov 13 01:44:02 2000
+++ arch/i386/kernel/traps.c	Thu Nov 23 10:10:06 2000
@@ -126,7 +126,6 @@
 		printk("%08lx ", *stack++);
 	}
 
-	printk("\nCall Trace: ");
 	stack = esp;
 	i = 1;
 	module_start = VMALLOC_START;
@@ -144,12 +143,17 @@
 		if (((addr >= (unsigned long) &_stext) &&
 		     (addr <= (unsigned long) &_etext)) ||
 		    ((addr >= module_start) && (addr <= module_end))) {
-			if (i && ((i % 8) == 0))
-				printk("\n       ");
-			printk("[<%08lx>] ", addr);
+			if (i==1)
+				printk("\nCall Trace:  [<");
+			else if ((i % 8)==0)
+				printk(">]\n    [<");
+			else
+				printk(" ");
+			printk("%08lx", addr);
 			i++;
 		}
 	}
+	printk(">]\n");
 }
 
 static void show_registers(struct pt_regs *regs)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
