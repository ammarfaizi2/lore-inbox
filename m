Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293071AbSCRVpg>; Mon, 18 Mar 2002 16:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293053AbSCRVpW>; Mon, 18 Mar 2002 16:45:22 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:26887 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293048AbSCRVpI>;
	Mon, 18 Mar 2002 16:45:08 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 18 Mar 2002 14:43:32 -0700
To: linux-kernel@vger.kernel.org
Subject: Print symbolic address of kernel and modules without extra data
Message-ID: <20020318144332.F4783@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just added this to the PPC debugger and the strongARM panic code when I
realized that I'm going to have to add this to MIPS, too.  Rather than
that, I'll send it here with the hope that someone finds it useful.

Consider this my contribution at the kernel-debugger and other dangerous
technologies altar.

Given an address, it prints out the symbolic name for it by digging
through the module symbol table rather than stuffing gobs of system.map
data into the kernel image.  It'll only pick up on EXPORT_SYMBOL() symbols
but it's a lot better than having to figure out what has happened in a
module that I've loaded on an embedded board with now r/w filesystem.

#if defined(CONFIG_MODULES)
#include <linux/module.h>

static void lookup_print_addr(unsigned long addr)
{
	extern unsigned long *_end;
	unsigned long best_match = 0; /* so far */
	char best_match_string[60] = {0, }; /* so far */
#if defined(CONFIG_MODULES)
	struct module *mod;
	struct module_symbol *sym;
	int j;
#endif

	/* user addresses - just print user and return -- Cort */
	if ( addr < PAGE_OFFSET )
	{
		printk("(user)");
		return;
	}

	for (mod = module_list; mod; mod = mod->next)
	{
		for ( j = 0, sym = mod->syms; j < mod->nsyms; ++j, ++sym)
		{
			/* is this a better match than what we've
			 * found so far? -- Cort */
			if ( (sym->value < addr) &&
			     ((addr - sym->value) < (addr - best_match)) )
			{
				best_match = sym->value;
				/* kernelmodule.name is "" so we
				 * have a special case -- Cort */
				if ( mod->name[0] == 0 )
					sprintf(best_match_string, "%s",
						sym->name);
				else
					sprintf(best_match_string, "%s:%s",
						sym->name, mod->name);
			}
		}
	}

	if ( best_match )
		printk("(%s + 0x%x)", best_match_string, addr - best_match);
	else
		printk("(???)");
}
#endif /* CONFIG_MODULES */
