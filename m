Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262070AbSIYTSK>; Wed, 25 Sep 2002 15:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262071AbSIYTSK>; Wed, 25 Sep 2002 15:18:10 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:39050 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262070AbSIYTSH>; Wed, 25 Sep 2002 15:18:07 -0400
Date: Wed, 25 Sep 2002 14:23:14 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.4.33.0209251113530.1817-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209251415500.28659-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Linus Torvalds wrote:

> On Wed, 25 Sep 2002, Ingo Molnar wrote:
> >
> > EIP is at sys_gettimeofday [kernel] 0x84
> > Call Trace: [<c0112a40>] do_page_fault [kernel] 0x0
> > [<c0107973>] syscall_call [kernel] 0x7
> 
> At a minimum, fix this to:
> 
>  - not print out that stupid "kernel" thing. Of _course_ it is the kernel. 
>    Modules can put their module name to clarify, but the core kernel 
>    certainly doesn't "clarify" anything by putting "kernel" there.
> 
>  - print out offset/length like the user-space ksymoops does. Without the 
>    offset the thing is useless, since you still need the real address to 
>    actually look up which instruction faulted.

Alright, I did these modifications (however, even the current version 
prints the offset, just not the length, which does not have too much 
meaning anyway)

So this patch converts the output to the more familiar

	sys_gettimeofday+0x84/0x108 [module-name]

format, where module-name is "" for the kernel. 

Ingo, could you test the modifications again, please? Also, I worked 
against my latest version, if you did additional changes after the last 
version I sent you, they need to be merged back in.

--Kai


Pull from http://linux-isdn.bkbits.net/linux-2.5.kallsyms

(Merging changesets omitted for clarity)

-----------------------------------------------------------------------------
ChangeSet@1.609, 2002-09-25 14:11:06-05:00, kai@tp1.ruhr-uni-bochum.de
  kksymoops: cosmetics
  
  Don't print "kernel" when a symbol is in the kernel.
  
  Change the output format to
  sys_gettimeofday+0x84/0x108 [module].

 ----------------------------------------------------------------------------
 module.c |   75 ++++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 44 insertions(+), 31 deletions(-)





=============================================================================
unified diffs follow for reference
=============================================================================


-----------------------------------------------------------------------------
ChangeSet@1.609, 2002-09-25 14:11:06-05:00, kai@tp1.ruhr-uni-bochum.de
  kksymoops: cosmetics
  
  Don't print "kernel" when a symbol is in the kernel.
  
  Change the output format to
  sys_gettimeofday+0x84/0x108 [module].

  ---------------------------------------------------------------------------

diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Wed Sep 25 14:18:41 2002
+++ b/kernel/module.c	Wed Sep 25 14:18:41 2002
@@ -52,7 +52,7 @@
 struct module kernel_module =
 {
 	.size_of_struct		= sizeof(struct module),
-	.name 			= "kernel",
+	.name 			= "",
 	.uc	 		= {ATOMIC_INIT(1)},
 	.flags			= MOD_RUNNING,
 	.syms			= __start___ksymtab,
@@ -1307,48 +1307,61 @@
 
 #define MAX_SYMBOL_SIZE 512
 
-int print_symbol(const char *fmt, unsigned long address)
+static void
+address_to_exported_symbol(unsigned long address, const char **mod_name, 
+			   const char **sym_name, unsigned long *sym_start,
+			   unsigned long *sym_end)
 {
 	struct module *this_mod;
-	unsigned long bestsofar;
+	int i;
+
+	for (this_mod = module_list; this_mod; this_mod = this_mod->next) {
+		/* walk the symbol list of this module. Only symbols
+		   who's address is smaller than the searched for address
+		   are relevant; and only if it's better than the best so far */
+		for (i = 0; i < this_mod->nsyms; i++)
+			if ((this_mod->syms[i].value <= address) &&
+			    (*sym_start < this_mod->syms[i].value)) {
+				*sym_start = this_mod->syms[i].value;
+				*sym_name  = this_mod->syms[i].name;
+				*mod_name  = this_mod->name;
+				if (i + 1 < this_mod->nsyms)
+					*sym_end = this_mod->syms[i+1].value;
+				else
+					*sym_end = (unsigned long) this_mod + this_mod->size;
+			}
+	}
+}
+
+int
+print_symbol(const char *fmt, unsigned long address)
+{
 	/* static to not take up stackspace; if we race here too bad */
 	static char buffer[MAX_SYMBOL_SIZE];
 
 	const char *mod_name = NULL, *sec_name = NULL, *sym_name = NULL;
 	unsigned long mod_start, mod_end, sec_start, sec_end,
-							sym_start, sym_end;
+		sym_start, sym_end;
+	char *tag = "";
 	
 	memset(buffer, 0, MAX_SYMBOL_SIZE);
 
-	if (!kallsyms_address_to_symbol(address,&mod_name,&mod_start,&mod_end,&sec_name, &sec_start, &sec_end, &sym_name, &sym_start, &sym_end)) {
-		/* kallsyms doesn't have a clue; lets try our list 
-		 * of exported symbols */
-		bestsofar = 0;
-		sprintf(buffer, "[unresolved]");
-		
-		for (this_mod = module_list; this_mod; this_mod = this_mod->next) {
-			int i;
-			/* walk the symbol list of this module. Only symbols
-			   who's address is smaller than the searched for address
-			   are relevant; and only if it's better than the best so far */
-			for (i = 0; i < this_mod->nsyms; i++)
-				if ((this_mod->syms[i].value <= address) &&
-				    (bestsofar < this_mod->syms[i].value)) {
-					snprintf(buffer, MAX_SYMBOL_SIZE - 1,
-						 "%s [%s] 0x%x",
-						this_mod->syms[i].name,
-						this_mod->name,
-						(unsigned int)(address - this_mod->syms[i].value));
-					bestsofar = this_mod->syms[i].value;
-				}
-		}
+	sym_start = 0;
+	if (!kallsyms_address_to_symbol(address, &mod_name, &mod_start, &mod_end, &sec_name, &sec_start, &sec_end, &sym_name, &sym_start, &sym_end)) {
+		tag = "E ";
+		address_to_exported_symbol(address, &mod_name, &sym_name, &sym_start, &sym_end);
+	}
 
-	} else { /* kallsyms success */
-		snprintf(buffer,MAX_SYMBOL_SIZE - 1, "%s [%s] 0x%x",
-			 sym_name, mod_name,
-			 (unsigned int)(address - sym_start));
+	if (sym_start) {
+		snprintf(buffer, MAX_SYMBOL_SIZE - 1, "%s%s+%#x/%#x [%s]",
+			 tag, sym_name,
+			 (unsigned int)(address - sym_start),
+			 (unsigned int)(sym_end - sym_start),
+			 mod_name);
+		printk(fmt, buffer);
+	} else {
+		printk(fmt, "[unresolved]");
 	}
-	printk(fmt, buffer);
 	return 0;
 }
 




