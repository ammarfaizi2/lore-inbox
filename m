Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318678AbSG0CL1>; Fri, 26 Jul 2002 22:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318679AbSG0CL1>; Fri, 26 Jul 2002 22:11:27 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:9622 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318678AbSG0CL0>;
	Fri, 26 Jul 2002 22:11:26 -0400
From: cort@fsmlabs.com
Date: Fri, 26 Jul 2002 20:15:10 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>, Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()]
Message-ID: <20020726201510.A6370@cort.fsmlabs.com>
References: <20020725150525.Q2276@host110.fsmlabs.com> <20020725220643.GT1180@dualathlon.random> <20020725160559.X2276@host110.fsmlabs.com> <20020725225613.GW1180@dualathlon.random> <20020725170113.F5326@host110.fsmlabs.com> <20020726223750.GA1151@dualathlon.random> <20020726165535.R13656@host110.fsmlabs.com> <20020726232834.GA1168@dualathlon.random> <20020726173127.S13656@host110.fsmlabs.com> <20020727001032.GA1177@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020727001032.GA1177@dualathlon.random>; from andrea@suse.de on Sat, Jul 27, 2002 at 02:10:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All I need is the nearest symbol name and that's it.  The patch was pretty
simple so it could be easily merged.  It added only a few 100's of bytes on
x86 and below 1k on PPC.  It would be handy to have this in a kernel rather
than require some user utility that requires I make it work in a
cross-build environment, copy the 'insmod -m' map output to my host
machine, run the user program on the system.map and the user utilities for
every boot, crash, debug cycle.

The patch is tiny and simple and I hoped to keep it that way.  If I want to
dig into the system and seriously debug rather than follow a known problem
I can use xmon on PPC, kgdb or more often than not a real JTAG debugger.

How about this - we print the module beginning _and_ the EIP symbol if we
can find one.  You get what you want and I get what I want (I won't even
add a line of output to get what I want).

To solve the ksyms mystery can you send me what versions of modutils, what
architecture, what distribution and anything else you think might be
useful?  I'd like to know what cases this fails in.

} You follow it. The reason I'm dropping functionality is that I want the
} functionality in userspace, not because your patch in-kernel was wasting
} any resources, but because from userspace the functionality will do the
} *right* thing always without me having to check if the symbol happened
} to be right because it was exported (and still no idea why you've more
} symbols than me in ksyms for modules). Also rarely I can get away with
} just the EIP.  So in short the symbol isn't going to help because I'd
} need to recheck with ksymoops anyways and I need the stack trace too
} potentially part of other modules, so I prefer to provide via the oops
} only the numeric information, but *all* of it :) to also reduce the oops
} size.  If your main object is to skip the ksymoops step, then I think
} even in such case you want to go to a full complete kksymoops instead of
} the halfway approch. I think ksymoops + module oops tracking patch is
} more than enough for the bugreports (modulo dprobes/lkcd etc...). For
} developement using a true debugger to get stack traces and inspect ram
} (i.e. uml or kgdb or kdb ) is probably superior to any other oops
} functionalty anyways (so if your object is to avoid the ksymoops step
} during developement I would suggest a real debugger that will save even
} more time).
} 
} I like the strict module oops tracking in particular for pre-compiled
} kernels where we don't even need to ask the user the system.map/vmlinux
} in order to debug it, and so where it would be a total loss of global
} ram resources to load in kernel ram of every machine all the symbols of
} the whole kernel and modules. Furthmore this adds a critical needed
} feature to have a chance to debug module oopses, so it's a must-have.
} 
} Nevertheless adding your ksym lookup for the EIP wouldn't hurt and it
} wouldn't waste lines (columns doesn't matter near the EIP), so we could
} merge the two things together, but as said above I don't feel the need
} of it as far as ksymoops learns about resolving the eip through the
} module information now included in the oops.
} 
} I updated the patch to reduce the number of lines of the oops, this is
} incremental with the previous patch.
} 
} --- 2.4.19rc3aa2/kernel/module.c.~1~	Sat Jul 27 00:48:38 2002
} +++ 2.4.19rc3aa2/kernel/module.c	Sat Jul 27 03:44:16 2002
} @@ -1271,26 +1271,29 @@ static void __module_oops_tracking_print
}  
}  	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
}  		if (!nr--)
} -			printk("	[(%s:<%p>:<%p>)]\n",
} +			printk(" [(%s:<%p>:<%p>)]",
}  			       mod->name,
}  			       (char *) mod + mod->size_of_struct,
}  			       (char *) mod + mod->size);
}  	}
} -	
}  }
}  
}  void module_oops_tracking_print(void)
}  {
}  	int nr;
} +	int i = 0;
}  
} -	printk("Module Oops Tracking:\n");
} +	printk("Modules:");
}  	nr = find_first_bit(module_oops_tracking, MODULE_OOPS_TRACKING_NR_BITS);
}  	for (;;) {
}  		if (nr == MODULE_OOPS_TRACKING_NR_BITS)
} -			return;
} +			break;
} +		if (i && !(i++ % 2))
} +			printk("\n        ");
}  		__module_oops_tracking_print(nr);
}  		nr = find_next_bit(module_oops_tracking, MODULE_OOPS_TRACKING_NR_BITS, nr+1);
}  	}
} +	printk("\n");
}  }
}  
}  #else		/* CONFIG_MODULES */
} 
} 
} Andrea
