Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWFHLSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWFHLSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 07:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWFHLSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 07:18:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:62882 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751281AbWFHLSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 07:18:03 -0400
Date: Thu, 8 Jun 2006 13:17:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
In-Reply-To: <1149726685.23790.8.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606081301320.17704@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org> 
 <1149652378.27572.109.camel@localhost.localdomain>  <20060606212930.364b43fa.akpm@osdl.org>
  <1149656647.27572.128.camel@localhost.localdomain>  <20060606222942.43ed6437.akpm@osdl.org>
  <1149662671.27572.158.camel@localhost.localdomain>  <20060607132155.GB14425@elte.hu>
 <1149726685.23790.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Jun 2006, Benjamin Herrenschmidt wrote:

> > a better solution would be to install boot-time IRQ vectors that just do
> > nothing but return. They dont mask, they dont ACK nor EOI - they just
> > return. The only thing that could break this is a screaming interrupt,
> > and even that one probably just slows things down a tiny bit until we
> > get so far in the init sequence to set up the PIC.
> 
> Changing vectors on the fly is hard on some platforms.... We could
> change our toplevel ppc_md.get_irq() on powerpc, but we still to do
> something about decrementer interrupts.

On ppc it should not be that difficult to even modify the exception entry 
code. Instead of calling do_IRQ use do_early_IRQ and only install the real 
handler later.

> A screaming level interrupt will lockup the machine at least on some
> platforms.

I guess that's even deadly on most platforms.

> The problem with all those approaches is that they require changes to
> all archs interrupt handling to make the situation safe vs. mutexes...

Only those archs that want to delay interrupt initialization and they at 
least have to provide minimal support to survive enabled interrupts.
init_IRQ() stays the same for all other archs and we add another hook to 
allow the delayed initializtion.


> I still don't think where is the suckage in just not hard-enabling in
> the mutex debug code...

If you want to have full services, then irqs are part of it. :)

bye, Roman
