Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318658AbSG0AG1>; Fri, 26 Jul 2002 20:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318659AbSG0AG1>; Fri, 26 Jul 2002 20:06:27 -0400
Received: from [195.223.140.120] ([195.223.140.120]:11115 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318658AbSG0AG0>; Fri, 26 Jul 2002 20:06:26 -0400
Date: Sat, 27 Jul 2002 02:10:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>, Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()]
Message-ID: <20020727001032.GA1177@dualathlon.random>
References: <20020725205910.GR1180@dualathlon.random> <20020725150525.Q2276@host110.fsmlabs.com> <20020725220643.GT1180@dualathlon.random> <20020725160559.X2276@host110.fsmlabs.com> <20020725225613.GW1180@dualathlon.random> <20020725170113.F5326@host110.fsmlabs.com> <20020726223750.GA1151@dualathlon.random> <20020726165535.R13656@host110.fsmlabs.com> <20020726232834.GA1168@dualathlon.random> <20020726173127.S13656@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726173127.S13656@host110.fsmlabs.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 05:31:27PM -0600, Cort Dougan wrote:
> I haven't found those cases, nope.  Even with them, it is nice to resolve
> to the nearest symbol when we can.  Printing the beginning and end of the
> module that you put in there is useful, though.
> 
> Any names for the stack trace are a mess, since formatting that is hard
> without scrolling off the screen and making the oops useless.  My patch was
> just a first cut to get a symbol name and module name for the EIP.  I think
> that's a good start and it seems your version actually removes some of the
> very simple functionality that I wanted to be able to use.
> 
> Do I follow what you're doing correctly or do I have it confused?

You follow it. The reason I'm dropping functionality is that I want the
functionality in userspace, not because your patch in-kernel was wasting
any resources, but because from userspace the functionality will do the
*right* thing always without me having to check if the symbol happened
to be right because it was exported (and still no idea why you've more
symbols than me in ksyms for modules). Also rarely I can get away with
just the EIP.  So in short the symbol isn't going to help because I'd
need to recheck with ksymoops anyways and I need the stack trace too
potentially part of other modules, so I prefer to provide via the oops
only the numeric information, but *all* of it :) to also reduce the oops
size.  If your main object is to skip the ksymoops step, then I think
even in such case you want to go to a full complete kksymoops instead of
the halfway approch. I think ksymoops + module oops tracking patch is
more than enough for the bugreports (modulo dprobes/lkcd etc...). For
developement using a true debugger to get stack traces and inspect ram
(i.e. uml or kgdb or kdb ) is probably superior to any other oops
functionalty anyways (so if your object is to avoid the ksymoops step
during developement I would suggest a real debugger that will save even
more time).

I like the strict module oops tracking in particular for pre-compiled
kernels where we don't even need to ask the user the system.map/vmlinux
in order to debug it, and so where it would be a total loss of global
ram resources to load in kernel ram of every machine all the symbols of
the whole kernel and modules. Furthmore this adds a critical needed
feature to have a chance to debug module oopses, so it's a must-have.

Nevertheless adding your ksym lookup for the EIP wouldn't hurt and it
wouldn't waste lines (columns doesn't matter near the EIP), so we could
merge the two things together, but as said above I don't feel the need
of it as far as ksymoops learns about resolving the eip through the
module information now included in the oops.

I updated the patch to reduce the number of lines of the oops, this is
incremental with the previous patch.

--- 2.4.19rc3aa2/kernel/module.c.~1~	Sat Jul 27 00:48:38 2002
+++ 2.4.19rc3aa2/kernel/module.c	Sat Jul 27 03:44:16 2002
@@ -1271,26 +1271,29 @@ static void __module_oops_tracking_print
 
 	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
 		if (!nr--)
-			printk("	[(%s:<%p>:<%p>)]\n",
+			printk(" [(%s:<%p>:<%p>)]",
 			       mod->name,
 			       (char *) mod + mod->size_of_struct,
 			       (char *) mod + mod->size);
 	}
-	
 }
 
 void module_oops_tracking_print(void)
 {
 	int nr;
+	int i = 0;
 
-	printk("Module Oops Tracking:\n");
+	printk("Modules:");
 	nr = find_first_bit(module_oops_tracking, MODULE_OOPS_TRACKING_NR_BITS);
 	for (;;) {
 		if (nr == MODULE_OOPS_TRACKING_NR_BITS)
-			return;
+			break;
+		if (i && !(i++ % 2))
+			printk("\n        ");
 		__module_oops_tracking_print(nr);
 		nr = find_next_bit(module_oops_tracking, MODULE_OOPS_TRACKING_NR_BITS, nr+1);
 	}
+	printk("\n");
 }
 
 #else		/* CONFIG_MODULES */


Andrea
