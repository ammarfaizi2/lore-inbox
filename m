Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUCDPRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 10:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbUCDPRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 10:17:10 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:57542 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261931AbUCDPRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 10:17:07 -0500
Date: Thu, 4 Mar 2004 08:17:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040304151705.GB26065@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <20040302230018.GL20227@smtp.west.cox.net> <40451CCA.4070907@mvista.com> <200403031113.02822.amitkale@emsyssoft.com> <20040303151628.GQ20227@smtp.west.cox.net> <4046780D.7020700@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4046780D.7020700@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 04:27:57PM -0800, George Anzinger wrote:
> Tom Rini wrote:
> >But that's not what you get with kgdb_serial.  You get the possibility
> >of serial from point A to B and you will have eth from point B onward,
> >if compiled in.  With an arch serial driver you get the possibility of
> >serial (or arch serial or whatever) from point A to B and eth from point
> >B onward, if compiled in.
> 
> I don't think we want to switch.  Rather we want to say something like: If 
> no eth (or other input) options are on the command line then its is serial. 
> If eth (or other input) is there, that is what we use.
> 
> This does leave open what happens when "eth" is given and we hit a 
> breakpoint prior to looking at the command line, but now this just fails so 
> we would be hard put to do worse.

This doesn't fail right now, or rather it shouldn't.  We would call
kgdb_arch_init() which would set it to 8250 (or arch serial) and go.  If
8250||arch serial is compiled in.

> >I think you missed the point.  The problem isn't with providing weak
> >functions, the problem is trying to set the function pointer.  PPC
> >becomes quite clean since the next step is to kill off
> >PPC_SIMPLE_SERIAL and just have kgdb_read/write_debug_char in the
> >relevant serial drivers.
> 
> No, you just set the default at configure time.  It is just done in such 
> away as to allow it to be overridden.

Which means you have to either c&p this into kgdb_arch_init for every
arch that provides it's own, or (and I've been thinking that this isn't
necessarily a bad idea) standardize on names for the arch serial driver,
and in kernel/kgdb.c::kgdb_entry() do:
#ifdef CONFIG_KGDB_8250
  extern ... kgdb8250_serial;
  kgdb_serial = &kgdb8250_serial;
#elif CONFIG_KGDB_ARCH_SERIAL
  extern ... kgdbarch_serial;
  kgdb_serial = &kgdbarch_serial;
#elif CONFIG_KGDB_ETH
  extern ... kgdboe_serial;
  kgdb_serial = &kgdboe_serial;
#endif

-- 
Tom Rini
http://gate.crashing.org/~trini/
