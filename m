Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031166AbWI0Whd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031166AbWI0Whd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031164AbWI0Whd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:37:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:19883 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1031166AbWI0Wha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:37:30 -0400
Subject: Re: [PATCH 0/5] Message signaled irq handling cleanups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Michael Ellerman <michaele@au.ibm.com>
In-Reply-To: <m164f9m6dy.fsf@ebiederm.dsl.xmission.com>
References: <m164f9m6dy.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 08:36:45 +1000
Message-Id: <1159396605.18293.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So hopefully we are finally close enough that other architectures
> will be able implement msi support, without too much trouble.
> 
> msi: Simplify msi sanity checks by adding with generic irq code.
> msi: Only use a single irq_chip for msi interrupts
> msi: Refactor and move the msi irq_chip into the arch code.
> msi: Move the ia64 code into arch/ia64
> htirq: Tidy up the htirq code

Heh ! And Michael was just coming up with a rewritten MSI core for
PowerPC :) Oh well... I'll dig through your patches.

My main problem is that you have thus dynamic_irq stuff in the generic
code. I just can't see any way that code can apply to me in any shape or
form. PowerPC has a virtual IRQ layer that remaps linux IRQs to
controller/line pairs to handle multiple controllers etc... thus we have
some primitives for allocating virtual irqs and binding them to a
controller etc... 

I have the feeling that this dynamic_irq_* thing you introduced will not
only not work properly for us but can't be made to work in our context,
not with the current API and not with any "generic" non platform
specific API.

Also we need to have different low level callbacks for different busses
in the system for the various bits, ranging from allocating & providing
up the irq_chip, to setting up the MSI. Unfortunately, even your
reworked code just don't fit our needs at the moment in that area. Also,
you hijack irq data which we can't do as it can/will be used by our PIC
code that actually gets the MSIs on some machines (they are just routed
to it as normal irqs) etc....

At this point, best is that we finish a working implementation based on
Michael reworked core for PowerPC (which is currently located in
arch/powerpc and doesn't exclude whatever sits in drivers/pci/ except
that we don't build the later on PowerPC) so you can see more what our
approach looks like and why we need to go that way.

Ben.




