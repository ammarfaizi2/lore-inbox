Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUCDWta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 17:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUCDWta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 17:49:30 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:31432 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261991AbUCDWtW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 17:49:22 -0500
Date: Thu, 4 Mar 2004 15:49:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040304224921.GI26065@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <20040302230018.GL20227@smtp.west.cox.net> <40451CCA.4070907@mvista.com> <200403031113.02822.amitkale@emsyssoft.com> <20040303151628.GQ20227@smtp.west.cox.net> <4046780D.7020700@mvista.com> <20040304151705.GB26065@smtp.west.cox.net> <4047AB20.1080703@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4047AB20.1080703@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 02:18:08PM -0800, George Anzinger wrote:
> Tom Rini wrote:
> >On Wed, Mar 03, 2004 at 04:27:57PM -0800, George Anzinger wrote:
> >
> >>Tom Rini wrote:
> >>
> >>>But that's not what you get with kgdb_serial.  You get the possibility
> >>>of serial from point A to B and you will have eth from point B onward,
> >>>if compiled in.  With an arch serial driver you get the possibility of
> >>>serial (or arch serial or whatever) from point A to B and eth from point
> >>>B onward, if compiled in.
> >>
> >>I don't think we want to switch.  Rather we want to say something like: 
> >>If no eth (or other input) options are on the command line then its is 
> >>serial. If eth (or other input) is there, that is what we use.
> >>
> >>This does leave open what happens when "eth" is given and we hit a 
> >>breakpoint prior to looking at the command line, but now this just fails 
> >>so we would be hard put to do worse.
> >
> >
> >This doesn't fail right now, or rather it shouldn't.  We would call
> >kgdb_arch_init() which would set it to 8250 (or arch serial) and go.  If
> >8250||arch serial is compiled in.
> 
> But, if I understand this right, now you can have either eth or serial.  If 
> you have eth and hit a breakpoint prior to its int, you are dead.

Ah yes, as a side effect of me being a bit too quick with my
kernel/Kconfig.kgdb changes, yes.  Good catch :)

> >>>I think you missed the point.  The problem isn't with providing weak
> >>>functions, the problem is trying to set the function pointer.  PPC
> >>>becomes quite clean since the next step is to kill off
> >>>PPC_SIMPLE_SERIAL and just have kgdb_read/write_debug_char in the
> >>>relevant serial drivers.
> >>
> >>No, you just set the default at configure time.  It is just done in such 
> >>away as to allow it to be overridden.
> >
> >
> >Which means you have to either c&p this into kgdb_arch_init for every
> >arch that provides it's own, or (and I've been thinking that this isn't
> >necessarily a bad idea) standardize on names for the arch serial driver,
> >and in kernel/kgdb.c::kgdb_entry() do:
> >#ifdef CONFIG_KGDB_8250
> >  extern ... kgdb8250_serial;
> >  kgdb_serial = &kgdb8250_serial;
> >#elif CONFIG_KGDB_ARCH_SERIAL
> >  extern ... kgdbarch_serial;
> >  kgdb_serial = &kgdbarch_serial;
> >#elif CONFIG_KGDB_ETH
> >  extern ... kgdboe_serial;
> >  kgdb_serial = &kgdboe_serial;
> >#endif
> 
> I would rather standardize on the name of the INIT block.  How about 
> something like:

I would rather not have to duplicate the above code (or, any code) for
every arch. :)

> #include <linux/kdgb_io.h>
> :
> :
> struc kgdb_io_table kgdb_io_table[]=KGDB_IO_FUNCTIONS;
> 
> then in linux/kgdb_io.h we have:
> 
> #include <asm/kgdb_io.h>
> 
> struc kgdb_io_table {
> 	char (*kgdb_read_char);
>     	void  (*kgdb_write_char);
>         :
> 	:
> }
> 
> And in asm/kgdb_io.h we define:
> extern char my_read_char(void);
> :
> #define KGDB_IO_FUNCTIONS {{my_read_char, my_write_char,...},\
>                             {eth_read_char,...}}

But eth_read_char, etc aren't, don't need to be, and shouldn't be global
functions.

> So it is completely up to the arch asm/kgdb_io.h to define the names and 
> even how many.  We then assume that the first one is the default.  An arch 
> that wants to mess with different things can do it all in this file, 
> including having several diffent serial drivers all with the same entry 
> points, different default as set at configure time and so on.

I think this is backwards.  Stop thinking in terms of 8250, eth and arch
serial, but instead io1, io2 and io3 (and io4, and io5, ...).  I don't
see what's wrong with what dwmw2 suggested that I passed along.

-- 
Tom Rini
http://gate.crashing.org/~trini/
