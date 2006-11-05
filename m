Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965834AbWKEERT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965834AbWKEERT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 23:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965835AbWKEERT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 23:17:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965834AbWKEERS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 23:17:18 -0500
Date: Sat, 4 Nov 2006 20:16:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
In-Reply-To: <1162699255.28571.150.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611042013400.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain> 
 <20061104140559.GC19760@flint.arm.linux.org.uk>  <1162678639.28571.63.camel@localhost.localdomain>
  <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org> 
 <1162689005.28571.118.camel@localhost.localdomain> 
 <1162697533.28571.131.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org> <1162699255.28571.150.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Benjamin Herrenschmidt wrote:
> > 
> > Just rip the _be versions out, methinks.
> 
> At least one user:
> 
> ./drivers/scsi/53c700.h:        __u32 value = bEBus ? ioread32be(hostdata->base + reg) :
> ./drivers/scsi/53c700.h:        bEBus ? iowrite32be(value, hostdata->base + reg):
> 
> Should I make it use explicit swab32 instead ?

Well, I actually really dislike your version with the explicit swab.

The _only_ reason to use "ioread32be()" would be because the machine is 
actually natively BE, and you want to avoid swab. That's kind of the point 
of using "be32_to_cpu(__raw_readl(addr)))" like we do now - it will do the 
byte swap only if it's necessary.

In contrast, your "swab(readl())" does _two_ byteswaps - once to turn it 
into LE, then to turn it back into BE.

So if we can't just rip it out, then we sure as hell shouldn't replace it 
with something that is obviously worse either.

In other words - I don't see the reasoning here again. You seem to want to 
make the code just worse. 

		Linus
