Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131153AbRALNmM>; Fri, 12 Jan 2001 08:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131500AbRALNmC>; Fri, 12 Jan 2001 08:42:02 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:44929 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131153AbRALNls>; Fri, 12 Jan 2001 08:41:48 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <31327.979300541@ocs3.ocs-net> 
In-Reply-To: <31327.979300541@ocs3.ocs-net> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        List Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Jan 2001 13:40:03 +0000
Message-ID: <18426.979306803@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  You just proved my point.  It is extremely difficult to deduce the
> required initialisation order by reading an undocumented Makefile
> where the init order is implemented as a side effect of selection
> order.  The existing method implies link order when none is required. 

I agree entirely. But you're confusing the debate on how to satisfy init 
order dependencies with my desire to avoid them altogether (for certain 
situations).



kaos@ocs.com.au said:
> I'm no filesystem expert but it appears that some of those core
> initialisation routines must be executed before most filesystems can
> start.  In particular, filelock_init() must be executed before any
> filesystem that supports locks is initialised.

No, before any filesystem that supports locks is _mounted_. Big difference. 
But I'm picking holes in your examples again. I accept that in some cases 
it is necessary, but I still think it's best to avoid it where possible.


kaos@ocs.com.au said:
> Firstly inter_module_xxx is only used by that very small subset of
> code where there are no constraints on whether the caller and callee
> can be in kernel, in modules or a mixture _and_ some of the objects
> are optional.  It is a special case because most code handles this
> problem through CONFIG options. If X needs (Y, Z) and X is built into the
> kernel then (Y, Z) must also be built into the kernel.  If Y or Z are
> optional then control the calls to those functions with CONFIG options.
> Almost all of the kernel handles it properly though CONFIG, so
> inter_module_xxx is already a process to handle a few special cases.

'properly through CONFIG'? I thought you agreed that doing it through
preprocessor options was ugly, and that it was preferable to get rid of such
things and deal with the presence or absence of such code cleanly through
some mechanism with similar semantics to inter_module_get(). The 'special 
case' code to which you refer is in fact the first set of such code to 
attempt to deal with this properly rather than just giving up and hacking 
it with preprocessor options.

Stepping back a moment and considering it, what we actually appear to be 
doing is trying to reinvent weak symbols, as far as I can tell. 


kaos@ocs.com.au said:
>  Secondly you want static inter_module_xxx tables for a small subset
> of these special cases, where the source has no other initialisation
> code. This is piling special cases on special cases.  Adding static
> inter_module_xxx tables requires 

I want the registration method not to impose init order restrictions where 
previously there were none. Where the previous code already had init order 
ugliness, it's not so much of a problem. But replacing the safe 
get_module_symbol() with the unsafe inter_module_get() just because the AGP 
author forgot to use EXPORT_SYMBOL_NOVERS to export the symbols doesn't 
really strike me as being useful. 

The only real difference between the two, other than the module symbol
mangling, appears to be that inter_module_get() looks stuff up in a dynamic
table which is made at runtime, where get_module_symbol() looks it up in a
static table which is made at compile (or module load) time. That was a
backward step, and wasn't necessary. 

If you object to having both the runtime inter_module_register() and the 
compile-time one, then ditch the dynamic one. Both current users of 
inter_module_xxx would be able to use the static version. 

But to be honest, I'd settle for ditching the whole blinkin' lot and 
getting weak symbols working right, if I could.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
