Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTFJELv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 00:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTFJELv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 00:11:51 -0400
Received: from dp.samba.org ([66.70.73.150]:31141 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262323AbTFJELu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 00:11:50 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk1[23]: load_module crashes when aborting module load 
In-reply-to: Your message of "Mon, 09 Jun 2003 03:14:49 MST."
             <200306091014.h59AEnU08591@adam.yggdrasil.com> 
Date: Tue, 10 Jun 2003 11:39:45 +1000
Message-Id: <20030610042531.4D63E2C13D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200306091014.h59AEnU08591@adam.yggdrasil.com> you write:
> Hi Rusty,
> 
> 	I thought I should report this problem to you now, as I'm
> about to have to explore some code that I'm not too familiar with
> (vfree) as I continue debugging it.  Also note I am running a
> modified kernel/module.c, so it is remotely possible that this problem
> is self-inflicted, but I don't think so.
> 
> 	In 2.5.70-bk1[23], I get a kernel bad memory reference
> when trying load a module with an undefined symbol that is not found.
> The bad memory reference occurs in load_module after the call
> to module_free(mod,mod->module_core), the next time that "mod" is
> dereferenced.   Here is a commented excerpt from load_module
> in kernel/module.c:
> 
>  cleanup:
>         module_unload_free(mod);
>         module_free(mod, mod->module_init);
>  free_core:
>         module_free(mod, mod->module_core);
> 	/* The following "if" statement generates a kernel bad memory
> 	   reference.  --Adam */
>  free_percpu:
>         if (mod->percpu)
>                 percpu_modfree(mod->percpu);
> 
> 	For whatever reason, module->module_core (ee820000) points to
> an address slightly before mod (mod = ee828780, the bad dereference
> is to ee8298a4).  On x86, module_free() is vfree().  I suspect that
> somehow vfree() has gotten confused.

Well, mod is inside module->module_core, so that makes sense: check
the section layout, but usually the .text section is first, then mod
will be near the .data section (turn on debugging in layout_sections
to get the details).

> 	By the way, there also seems to be a bug in the
> 2.5.70-bk12/kernel/module.c changes where mod->percpu is left unitialized
> if a module has no per-cpu data.  I've verified that there really is a
> junk non-zero value in mod->percpu in that case.  However, fixing that
> bug does not eliminate this problem.

Something is badly wrong: look in include/linux/module.h and you'll
see the initialization of __this_module (which becomes mod).  By
leaving the .percpu member uninitialized, it will be initialized to
NULL.

Random guess: did the build system not rebuild your modules properly
when module.h changed?

Puzzled,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
