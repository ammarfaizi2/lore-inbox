Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWQpO>; Thu, 23 Nov 2000 11:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKWQpE>; Thu, 23 Nov 2000 11:45:04 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:27145 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129091AbQKWQo5>; Thu, 23 Nov 2000 11:44:57 -0500
Date: Thu, 23 Nov 2000 10:14:31 -0600
To: Andries.Brouwer@cwi.nl, kaos@ocs.com.au
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        rmk@arm.linux.org.uk
Subject: [PATCH] silly [< >] and other excess
Message-ID: <20001123101431.T2918@wire.cadcamlab.org>
In-Reply-To: <UTC200011230224.DAA141466.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200011230224.DAA141466.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Nov 23, 2000 at 03:24:02AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Alan Cox]
> > Thats because too many things get put on a line then.
> > And because we do [<foo>] [<bar>]  not   [<foo>][<bar>] ?

[Andries Brouwer]
> In the good old times we had foo bar for a total of 8*(8+1) = 72
> positions. Now we have [<foo>] [<bar>] which takes 8*(8+1+4) = 104

I've got it!  Put multiple addresses within one set of [< >].  ksymoops
and klogd will require a small adjustment, of course.

The following show_stack() is 8 addrs per line, 79 columns.  Comments?

Peter

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
