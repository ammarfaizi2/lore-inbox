Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTFJIef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 04:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTFJIef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 04:34:35 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:38158 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S262464AbTFJIee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 04:34:34 -0400
Date: Tue, 10 Jun 2003 03:48:02 -0500 (CDT)
Message-Id: <200306100848.h5A8m2E1034824@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Rusty Russell <rusty@rustcorp.com.au>,
       "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk1[23]: load_module crashes when aborting module load
In-Reply-To: <20030610042531.4D63E2C13D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon Jun 09 2003 - 20:39:45 EST, Rusty Russell (rusty@rustcorp.com.au) wrote:
> In message <200306091014.h59AEnU08591@adam.yggdrasil.com> you write: 
> > cleanup:
> > module_unload_free(mod);
> > module_free(mod, mod->module_init);
> > free_core:
> > module_free(mod, mod->module_core);
> > /* The following "if" statement generates a kernel bad memory
> > reference. --Adam */
> > free_percpu:
> > if (mod->percpu)
> > percpu_modfree(mod->percpu);
> >
..
> 
> Well, mod is inside module->module_core, so that makes sense: check
> the section layout, but usually the .text section is first, then mod
> will be near the .data section (turn on debugging in layout_sections
> to get the details). 

Umm, isn't that the problem?  Once we get past the point where mod points
inside the module core (ie where we would goto cleanup), we can't 
reference mod->percpu after freeing mod->mod_core, since that frees mod
(and hence a the use-after-free bug).

milton
