Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWEHQrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWEHQrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWEHQrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:47:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44048 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932423AbWEHQrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:47:18 -0400
Date: Mon, 8 May 2006 17:47:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Message-ID: <20060508164705.GC19040@flint.arm.linux.org.uk>
Mail-Followup-To: Erik Mouw <erik@harddisk-recovery.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Andrew Morton <akpm@osdl.org>,
	Jason Schoonover <jasons@pioneer-pra.com>,
	linux-kernel@vger.kernel.org
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org> <1147100149.2888.37.camel@laptopd505.fenrus.org> <20060508152255.GF1875@harddisk-recovery.com> <1147102290.2888.41.camel@laptopd505.fenrus.org> <20060508154217.GH1875@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508154217.GH1875@harddisk-recovery.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 05:42:18PM +0200, Erik Mouw wrote:
> On Mon, May 08, 2006 at 05:31:29PM +0200, Arjan van de Ven wrote:
> > On Mon, 2006-05-08 at 17:22 +0200, Erik Mouw wrote:
> > > ... except that any kernel < 2.6 didn't account tasks waiting for disk
> > > IO.
> > 
> > they did. It was "D" state, which counted into load average.
> 
> They did not or at least to a much lesser extent. That's the reason why
> ZenIV.linux.org.uk had a mail DoS during the last FC release and why we
> see load average questions on lkml.
> 
> I've seen it on our servers as well: when using 2.4 and doing 50 MB/s
> to disk (through NFS), the load just was slightly above 0. When we
> switched the servers to 2.6 it went to ~16 for the same disk usage.

It's actually rather interesting to look at 2.6 and load averages.

The load average appears to depend on the type of load, rather than
the real load.  Let's look at three different cases:

1. while (1) { } loop in a C program.

   Starting off with a load average of 0.00 with a "watch uptime" running
   (and leaving that running for several minutes), then starting such a
   program, and letting it run for one minute.

   Result: load average at the end: 0.60

2. a program which runs continuously for 6 seconds and then sleeps for
   54 seconds.

   Result: load average peaks at 0.12, drops to 0.05 just before it
   runs for a second 6 second.

   ps initially reports 100% CPU usage, drops to 10% after one minute,
   rises to 18% and drops back towards 10%, and gradually settles on
   10%.

3. a program which runs for 1 second and then sleeps for 9 seconds.

   Result: load average peaks at 0.22, drops to 0.15 just before it
   runs for the next second.

   ps reports 10% CPU usage.

Okay, so, two different CPU work loads without any other IO, using the
same total amount of CPU time every minute seem to produce two very
different load averages.  In addition, using 100% CPU for one minute
does not produce a load average of 1.

Seems to me that somethings wrong somewhere.  Either that or the first
load average number no longer represents the load over the past one
minute.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
