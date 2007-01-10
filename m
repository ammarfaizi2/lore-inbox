Return-Path: <linux-kernel-owner+w=401wt.eu-S932514AbXAJAjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbXAJAjd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 19:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbXAJAjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 19:39:33 -0500
Received: from tomts40.bellnexxia.net ([209.226.175.97]:52123 "EHLO
	tomts40-srv.bellnexxia.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932514AbXAJAjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 19:39:32 -0500
Date: Tue, 9 Jan 2007 19:39:26 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] local_t : Documentation - update
Message-ID: <20070110003926.GA27830@Krystal>
References: <20061221001545.GP28643@Krystal> <20061223093358.GF3960@ucw.cz> <20070109031446.GA29426@Krystal> <20070109224100.GB6555@elf.ucw.cz> <20070109232155.GA25387@Krystal> <20070109234511.GB7798@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20070109234511.GB7798@elf.ucw.cz>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:18:31 up 139 days, 21:25,  5 users,  load average: 0.82, 0.86, 0.73
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek (pavel@ucw.cz) wrote:
> > index dfeec94..bd854b3 100644
> > --- a/Documentation/local_ops.txt
> > +++ b/Documentation/local_ops.txt
> > @@ -22,6 +22,13 @@ require disabling interrupts to protect from interrupt handlers and it permits
> >  coherent counters in NMI handlers. It is especially useful for tracing purposes
> >  and for various performance monitoring counters.
> >  
> > +Local atomic operations only guarantee variable modification atomicity wrt the
> > +CPU which owns the data. Therefore, care must taken to make sure that only one
> > +CPU writes to the local_t data. This is done by using per cpu data and making
> > +sure that we modify it from within a preemption safe context. It is however
> > +permitted to read local_t data from any CPU : it will then appear to be written
> > +out of order wrt other memory writes on the owner CPU.
> 
> So it is "one cpu may write, other cpus may read", and as big as
> long. Are you sure obscure architectures (sparc?) can implement this
> in useful way? ... maybe yes, unless obscure architecture exists where
> second other cpu can see garbage data when first cpu writes into long
> ...?
> 
> 

Sparc64 uses a memory barrier around the atomic operations in the SMP case
(see arch/sparc64/lib/atomic.S). The same is true for sparc. As I am not a sparc
expert, I left the asm-generic default behavior, but I think it should be safe
to implement local.S code derived from atomic.S to optimize the speed of the
local_t operations on sparc and sparc64. Can anyone confirm this ?

I don't know any architecture where an aligned memory access (read or write)
to a pointer type is not atomic. Size of longs are either 32 or 64 bits, but
always smaller than the pointer size (LLP64 has 32 bits longs, LP64 has 64
bits longs, ILP64 has 64 bits longs).

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
