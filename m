Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751882AbWFUAsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbWFUAsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWFUAsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:48:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:46030 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751882AbWFUAsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:48:07 -0400
Subject: Re: [patch 0/3] 2.6.17 radix-tree: updates and lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, npiggin@suse.de, Paul.McKenney@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.64.0606201732580.14331@schroedinger.engr.sgi.com>
References: <20060408134635.22479.79269.sendpatchset@linux.site>
	 <20060620153555.0bd61e7b.akpm@osdl.org>
	 <1150844989.1901.52.camel@localhost.localdomain>
	 <20060620163037.6ff2c8e7.akpm@osdl.org>
	 <1150847428.1901.60.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201732580.14331@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 10:47:29 +1000
Message-Id: <1150850849.12507.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 17:34 -0700, Christoph Lameter wrote:
> On Wed, 21 Jun 2006, Benjamin Herrenschmidt wrote:
> 
> > Anyway, I can drop a spinlock in (in fact I have) the ppc64 irq code for
> > now but that sucks, thus we should really seriously consider having the
> > lockless tree in 2.6.18 or I might have to look into doing an alternate
> > implementation specifically in arch code... or find some other way of
> > doing the inverse mapping there...
> 
> How many interrupts do you have to ? I would expect a simple table 
> lookup would be fine to get from the virtual to the real interrupt.

No, our hardware interrupt numbers are an encoded form containing the
geographical location of the device :) so they are 24 bits at least (and
we have a platform coming where they can be 64 bits).

The current code has a radix tree locally into the xics interrupt
controller used on IBM pSeries machines.

My rewritten powerpc irq core & remapper allows for different
reverse-map implementation based on the controller, you can ask for no
inverse map (in case you can fit your virtual irq directly in your hw
controller, some can, or give it to your hypervisor and get it back when
an interrupt happens), legacy (0..15 only, they are reserved unless you
are a i8259 to avoid problems with stupid drivers), linear map (a table)
or tree map (a radix tree).

Ben.


