Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUCDXR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbUCDXR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:17:56 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:28134 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261969AbUCDXRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:17:40 -0500
Date: Thu, 4 Mar 2004 16:17:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040304231737.GJ26065@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <200403031113.02822.amitkale@emsyssoft.com> <20040303151628.GQ20227@smtp.west.cox.net> <200403041011.39467.amitkale@emsyssoft.com> <20040304152729.GC26065@smtp.west.cox.net> <4047B67A.4050609@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4047B67A.4050609@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 03:06:34PM -0800, George Anzinger wrote:
> Tom Rini wrote:
> >On Thu, Mar 04, 2004 at 10:11:39AM +0530, Amit S. Kale wrote:
> >
> >>On Wednesday 03 Mar 2004 8:46 pm, Tom Rini wrote:
> >>
> >>>On Wed, Mar 03, 2004 at 11:13:02AM +0530, Amit S. Kale wrote:
> >
> >[snip]
> >
> >>>>kgdb_serial isn't ugly. It's just a function switch, similar to several
> >>>>of them in the kernel. ppc is ugly, but that's anyway the case because 
> >>>>of
> >>>>so many varieties of ppc. If we are trying to make ppc code clean, it
> >>>>makes more sense to move this weak function thing into ppc specific 
> >>>>files
> >>>>IMHO.
> >>>
> >>>I think you missed the point.  The problem isn't with providing weak
> >>>functions, the problem is trying to set the function pointer.  PPC
> >>>becomes quite clean since the next step is to kill off
> >>>PPC_SIMPLE_SERIAL and just have kgdb_read/write_debug_char in the
> >>>relevant serial drivers.
> >>
> >>We can still have one single hardcoded function pointer for ppc and manage
> >>the rest in ppc specific files.
> >
> >
> >I think you're still missing the point.
> >
> >Regardless, the solution to this is what dwmw2 suggested on IRC I
> >believe, as this should remove all of the #ifdef mess.
> 
> I am afraid I don't quite understand what he was saying other than early 
> init stuff.  On of the problems with trying early init stuff, by the way, 
> is that a lot of things depend on having alloc up and that happens rather 
> late in the game.

I assume you aren't talking about kgdb stuff here (or what would be the
point of going so early) but I believe he was talking about allowing for
stuff that could be done early, to be done early.

> But back to the method.  Is he/are you suggesting that the init code plug 
> the array of functions into the kgdb table?  This could be done by 
> providing a register function in kgdb to register an i/o method.  Pass it a 
> pointer to a struc of entry points, keep the pointers in an array, etc.  
> All that is left is to define the default in some simple and clean way, a 
> way that might be overridden at command line parse time and so on.

What I'm suggesting is that we don't need this table stuff at all.
Roughly:
- Call kgdb_entry(), minus the kgdb_serial->hook(), as early as
  possible.
- We do early parsing of some cmd opts (this I believe is __early_setup)
  - This means that to use kgdboe you _must_ pass kgdboe=whatever, same
    for 8250, etc.  This would also do kgdb_serial = kgdboe_serial, or
    whatever.
  - 8250, kgdboe, etc, must be able to init themselves.
- If ('gdb' || 'kgdbwait') && kgdb_serial != NULL -> breakpoint();

-- 
Tom Rini
http://gate.crashing.org/~trini/
