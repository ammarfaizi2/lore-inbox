Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSKSLrq>; Tue, 19 Nov 2002 06:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSKSLrq>; Tue, 19 Nov 2002 06:47:46 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:3200 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S264867AbSKSLrp>;
	Tue, 19 Nov 2002 06:47:45 -0500
Date: Tue, 19 Nov 2002 12:54:44 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mbm@tinc.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5.48: BUG() at kernel/module.c:1000
Message-ID: <20021119115444.GA2011@vana>
References: <200211182239.gAIMdBL04074@mort.demon.co.uk> <20021118235221.4B9A92C237@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118235221.4B9A92C237@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 10:50:42AM +1100, Rusty Russell wrote:
> In message <200211182239.gAIMdBL04074@mort.demon.co.uk> you write:
> > The code (get_sizes) that calculates the amount of space required
> > by the sections assumes that the first one is loaded at address
> > zero (or large alignment) when performing subsequent alignments.
> 
> Please test this patch (Petr, contains fix for you too).

Hi Rusty,
  I was getting oopses with your patch (due to uninitialized common_length).
With this one (against clean 2.5.48) it works fine (both parport
and vmmon can be insmodded/rmmoded (parport only until it is used by lp,
but that's another story)).

  I also modified copy_sections code to verify that we are not
overrunning allocated regions. So now you should get -ENOEXEC instead
of BUG() + corrupted kernel.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


--- linux/kernel/module.c	2002-11-18 14:50:48.000000000 +0100
+++ linux/kernel/module.c	2002-11-19 12:49:37.000000000 +0100
@@ -607,14 +607,17 @@
 {
 	void *dest;
 	unsigned long *use;
+	unsigned long max;
 
 	/* Only copy to init section if there is one */
 	if (strstr(name, ".init") && mod->module_init) {
 		dest = mod->module_init;
 		use = &used->init_size;
+		max = mod->init_size;
 	} else {
 		dest = mod->module_core;
 		use = &used->core_size;
+		max = mod->core_size;
 	}
 
 	/* Align up */
@@ -622,6 +625,9 @@
 	dest += *use;
 	*use += sechdr->sh_size;
 
+	if (*use > max)
+		return ERR_PTR(-ENOEXEC);
+
 	/* May not actually be in the file (eg. bss). */
 	if (sechdr->sh_type != SHT_NOBITS)
 		memcpy(dest, base + sechdr->sh_offset, sechdr->sh_size);
@@ -788,9 +794,10 @@
 /* Get the total allocation size of the init and non-init sections */
 static struct sizes get_sizes(const Elf_Ehdr *hdr,
 			      const Elf_Shdr *sechdrs,
-			      const char *secstrings)
+			      const char *secstrings,
+			      unsigned long common_length)
 {
-	struct sizes ret = { 0, 0 };
+	struct sizes ret = { 0, common_length };
 	unsigned i;
 
 	/* Everything marked ALLOC (this includes the exported
@@ -943,10 +950,9 @@
 	mod->live = 0;
 	module_unload_init(mod);
 
-	/* How much space will we need?  (Common area in core) */
-	sizes = get_sizes(hdr, sechdrs, secstrings);
-	common_length = read_commons(hdr, &sechdrs[symindex]);
-	sizes.core_size += common_length;
+	/* How much space will we need?  (Common area in first) */
+	sizes = get_sizes(hdr, sechdrs, secstrings,
+			  common_length = read_commons(hdr, &sechdrs[symindex]));
 
 	/* Set these up, and allow archs to manipulate them. */
 	mod->core_size = sizes.core_size;
@@ -973,7 +979,7 @@
 	mod->module_core = ptr;
 
 	ptr = module_alloc(mod->init_size);
-	if (!ptr) {
+	if (!ptr && mod->init_size) {
 		err = -ENOMEM;
 		goto free_core;
 	}
