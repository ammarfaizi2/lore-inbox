Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSGYTAr>; Thu, 25 Jul 2002 15:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSGYTAr>; Thu, 25 Jul 2002 15:00:47 -0400
Received: from [195.223.140.120] ([195.223.140.120]:49445 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315942AbSGYTAq>; Thu, 25 Jul 2002 15:00:46 -0400
Date: Thu, 25 Jul 2002 21:04:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725190445.GO1180@dualathlon.random>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725112142.I2276@host110.fsmlabs.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 11:21:42AM -0600, Cort Dougan wrote:
> I'm glad you found it useful.
> 
> I'm sorry, Aunt Tillie has a mind of her own about indentation.  Patch
> below with spaces turned to tabs.

It looks like it has a few issues, can you verify the below patch?

I don't think it make sense to resolve the EIP unless it's a module,
you'd liekly need the system.map/vmlinux anyways to get to the right
function symbol name.

Furthmore it would be nice to print also for the stack trace, in case
there are intra-modules, infact I guess I would prefer to keep trace of
all the modules affected and to print the start address of each module
affected instead of resolving to the nearest symbol, since as for the
kernel .text, also the module .text isn't likely to be always exported.

In short I don't like very much your approch but for now the below will
be ok, and it will work right most of the time (since from such symbol
we'll be able to deduce the rest and it's likely all the modules
addresses in the stack trace cames from the same module .o, but it's not
guaranteed)

But as said above long term the right thing to do is to print the start
address of each module affected in the trace (we just check for that
during the oops to discard bogus values from the stack trace), not to
try to resolve anything in the kernel. So I will reject the current
patch as soon as the right way is implemented (then of course ksymoops
will have to learn the right way too, instead of guessing from the
current unreliable /proc/ksyms after reboot).

--- symb/kernel/module.c.~1~	Thu Jul 25 20:21:19 2002
+++ symb/kernel/module.c	Thu Jul 25 20:48:20 2002
@@ -246,10 +246,11 @@ void free_module(struct module *, int ta
  * the need for user space tools.
  *  -- Cort <cort@fsmlabs.com>
  */
+#define PRINT_ADDR_LENGTH 60
 void module_print_addr(char *s1, unsigned long addr, char *s2)
 {
 	unsigned long best_match = 0; /* so far */
-	char best_match_string[60] = {0, }; /* so far */
+	char best_match_string[PRINT_ADDR_LENGTH];
 	struct module *mod;
 	struct module_symbol *sym;
 	int j;
@@ -265,24 +266,25 @@ void module_print_addr(char *s1, unsigne
 		return;
 	}
 
-	for (mod = module_list; mod; mod = mod->next)
-	{
+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+		if (!mod_bound(addr, 0, mod))
+			continue;
 		for ( j = 0, sym = mod->syms; j < mod->nsyms; ++j, ++sym)
 		{
 			/* is this a better match than what we've
 			 * found so far? -- Cort */
-			if ( (sym->value < addr) &&
-			     ((addr - sym->value) < (addr - best_match)) )
+			if (sym->value <= addr &&
+			    addr - sym->value < addr - best_match)
 			{
 				best_match = sym->value;
 				/* kernelmodule.name is "" so we
 				 * have a special case -- Cort */
 				if ( mod->name[0] == 0 )
-					sprintf(best_match_string, "%s",
-						sym->name);
+					snprintf(best_match_string, PRINT_ADDR_LENGTH, "%s",
+						 sym->name);
 				else
-					sprintf(best_match_string, "%s:%s",
-						sym->name, mod->name);
+					snprintf(best_match_string, PRINT_ADDR_LENGTH, "%s:%s",
+						 sym->name, mod->name);
 			}
 		}
 	}



Andrea
