Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTFIKCH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTFIKCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:02:07 -0400
Received: from h-64-105-35-62.SNVACAID.covad.net ([64.105.35.62]:27301 "EHLO
	adam.yggdrasil.com") by vger.kernel.org with ESMTP id S261182AbTFIKCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:02:05 -0400
Date: Mon, 9 Jun 2003 03:14:49 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200306091014.h59AEnU08591@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: 2.5.70-bk1[23]: load_module crashes when aborting module load
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

	I thought I should report this problem to you now, as I'm
about to have to explore some code that I'm not too familiar with
(vfree) as I continue debugging it.  Also note I am running a
modified kernel/module.c, so it is remotely possible that this problem
is self-inflicted, but I don't think so.

	In 2.5.70-bk1[23], I get a kernel bad memory reference
when trying load a module with an undefined symbol that is not found.
The bad memory reference occurs in load_module after the call
to module_free(mod,mod->module_core), the next time that "mod" is
dereferenced.   Here is a commented excerpt from load_module
in kernel/module.c:

 cleanup:
        module_unload_free(mod);
        module_free(mod, mod->module_init);
 free_core:
        module_free(mod, mod->module_core);
	/* The following "if" statement generates a kernel bad memory
	   reference.  --Adam */
 free_percpu:
        if (mod->percpu)
                percpu_modfree(mod->percpu);

	For whatever reason, module->module_core (ee820000) points to
an address slightly before mod (mod = ee828780, the bad dereference
is to ee8298a4).  On x86, module_free() is vfree().  I suspect that
somehow vfree() has gotten confused.

	By the way, there also seems to be a bug in the
2.5.70-bk12/kernel/module.c changes where mod->percpu is left unitialized
if a module has no per-cpu data.  I've verified that there really is a
junk non-zero value in mod->percpu in that case.  However, fixing that
bug does not eliminate this problem.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
