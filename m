Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSGYUa7>; Thu, 25 Jul 2002 16:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSGYUa7>; Thu, 25 Jul 2002 16:30:59 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:16583 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316223AbSGYUa4>;
	Thu, 25 Jul 2002 16:30:56 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 25 Jul 2002 14:27:16 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725142716.N2276@host110.fsmlabs.com>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725190445.GO1180@dualathlon.random>; from andrea@suse.de on Thu, Jul 25, 2002 at 09:04:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

None of the changes look like a problem.  I'll absorb them and send another
patch.  One that fixes Ben's criticisms of spurious whitespace, even :)

Are you suggesting that it should print the start/end of the module in each
trace in addition to the symbol names or instead of them?

I've found it valuable to have the EIP resolved.  Even though the symbol
name may not be perfect (only resolves exported names) it is valuable to
see that the function crashed 0x1fe bytes after a given symbol name.

The version I use prints names for the stack trace but the formatting is
abysmal.  Making it clean and pretty on the screen would turn the "simple
and cheap" function into a parsing monster.  I'm happy to add it but it
wouldn't be the innocuous little patch it is now.

} It looks like it has a few issues, can you verify the below patch?
}
} I don't think it make sense to resolve the EIP unless it's a module,
} you'd liekly need the system.map/vmlinux anyways to get to the right
} function symbol name.
} 
} Furthmore it would be nice to print also for the stack trace, in case
} there are intra-modules, infact I guess I would prefer to keep trace of
} all the modules affected and to print the start address of each module
} affected instead of resolving to the nearest symbol, since as for the
} kernel .text, also the module .text isn't likely to be always exported.
} 
} In short I don't like very much your approch but for now the below will
} be ok, and it will work right most of the time (since from such symbol
} we'll be able to deduce the rest and it's likely all the modules
} addresses in the stack trace cames from the same module .o, but it's not
} guaranteed)
} 
} But as said above long term the right thing to do is to print the start
} address of each module affected in the trace (we just check for that
} during the oops to discard bogus values from the stack trace), not to
} try to resolve anything in the kernel. So I will reject the current
} patch as soon as the right way is implemented (then of course ksymoops
} will have to learn the right way too, instead of guessing from the
} current unreliable /proc/ksyms after reboot).
} 
} --- symb/kernel/module.c.~1~	Thu Jul 25 20:21:19 2002
} +++ symb/kernel/module.c	Thu Jul 25 20:48:20 2002
} @@ -246,10 +246,11 @@ void free_module(struct module *, int ta
}   * the need for user space tools.
}   *  -- Cort <cort@fsmlabs.com>
}   */
} +#define PRINT_ADDR_LENGTH 60
}  void module_print_addr(char *s1, unsigned long addr, char *s2)
}  {
}  	unsigned long best_match = 0; /* so far */
} -	char best_match_string[60] = {0, }; /* so far */
} +	char best_match_string[PRINT_ADDR_LENGTH];
}  	struct module *mod;
}  	struct module_symbol *sym;
}  	int j;
} @@ -265,24 +266,25 @@ void module_print_addr(char *s1, unsigne
}  		return;
}  	}
}  
} -	for (mod = module_list; mod; mod = mod->next)
} -	{
} +	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
} +		if (!mod_bound(addr, 0, mod))
} +			continue;
}  		for ( j = 0, sym = mod->syms; j < mod->nsyms; ++j, ++sym)
}  		{
}  			/* is this a better match than what we've
}  			 * found so far? -- Cort */
} -			if ( (sym->value < addr) &&
} -			     ((addr - sym->value) < (addr - best_match)) )
} +			if (sym->value <= addr &&
} +			    addr - sym->value < addr - best_match)
}  			{
}  				best_match = sym->value;
}  				/* kernelmodule.name is "" so we
}  				 * have a special case -- Cort */
}  				if ( mod->name[0] == 0 )
} -					sprintf(best_match_string, "%s",
} -						sym->name);
} +					snprintf(best_match_string, PRINT_ADDR_LENGTH, "%s",
} +						 sym->name);
}  				else
} -					sprintf(best_match_string, "%s:%s",
} -						sym->name, mod->name);
} +					snprintf(best_match_string, PRINT_ADDR_LENGTH, "%s:%s",
} +						 sym->name, mod->name);
}  			}
}  		}
}  	}
} 
} 
} 
} Andrea
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
