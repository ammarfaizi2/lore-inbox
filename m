Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTEHRqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 13:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTEHRqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 13:46:14 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:10893 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S261917AbTEHRqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 13:46:12 -0400
Date: Thu, 8 May 2003 12:56:48 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "David S. Miller" <davem@redhat.com>
cc: alan@lxorguk.ukuu.org.uk, <haveblue@us.ibm.com>, <akpm@digeo.com>,
       <rmk@arm.linux.org.uk>, <rddunlap@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The magical mystical changing ethernet interface order
In-Reply-To: <20030508.075438.52189319.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0305081240220.26857-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003, David S. Miller wrote:

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 08 May 2003 15:55:31 +0100
> 
>    Unfortunately for the ISA driver code we *have* to rely on link
>    order or rip out the __init stuff and use Space.c type hacks.
>    
> I do no argue that needing an invocation order is bogus.
> I merely disagree with the way we're trying to achieve it.

For one, the current way works, i.e. the linker doesn't reorder, and if it 
did, a whole lot of stuff would break. If the linker changed all of a 
sudden, there actually exists a section flag which tells it to not reorder 
things within that section. We're not currently setting this flag (and I 
don't even know how to do it), but if it becomes necessary, it'd be an 
option.

That said, the current way of doing things is surely not perfect. This 
discussion was on l-k before, IMO it's too late now for such big changes, 
but it should be kept in mind for 2.7.

There are different cases:

o Lots of init order dependencies are reflected in module load order (an 
  ISDN hardware driver like hisax.o calls register_isdn(), which is 
  exported from isdn.o. So when using modules, isdn.o must be loaded and
  thus initialized before any hardware driver. When these modules
  are built-in, no such restriction currently exists and things can
  go wrong - this is fixable, the dependency information just needs to be
  figured and used - there existed an initial patch for it.

o Lots of cases where we don't really call about the order but want it
  to remain constant, just so that network interfaces don't magically
  switch names etc. (Yes, other solutions like MAC exist, but it's still
  really inconvenient to have stuff change randomly). For this case,
  I think relying on link order as we currently do is totally fine.

o Some more complicated dependencies, as in "acpi needs pci which needs 
  arch_pci and the driver model to be initialized" or whatever.

> You don't need Space.c magic, the linker in binutils has mechanisms by
> which this can be accomplished and we already use this in 2.5.x
> 
> Have a peek at __define_initcall($NUM,fn), imagine it with one more
> argument $PRIO.  It might look like this:
> 
> #define __define_initcall(level,prio,fn) \
>         static initcall_t __initcall_##fn __attribute__
>         ((unused,__section__ ("\.initcall" level "." prio ".init"))) = fn
> 
> Use the 'prio' number to define the ordering.  The default for
> modules that don't care about relative ordering within a class
> use a value like "9999" or something like that.

Using a number to get the latter case right, be it a prio or a level, is 
just a hack, we want to explicitly know what we depend on being 
initialized first in this case.

Someone, rusty IIRC, had a patch which allowed to explicitly list init 
order dependencies, again this didn't get merged and I think it's too late 
now, but it should be kept in mind for 2.7. Adding another 
numerical priority level is IMO only yet another hack instead of doing it 
right.

--Kai



