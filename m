Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbTIDLEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 07:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTIDLEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 07:04:05 -0400
Received: from ozlabs.org ([203.10.76.45]:53395 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264917AbTIDLDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 07:03:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16215.7181.755868.593534@nanango.paulus.ozlabs.org>
Date: Thu, 4 Sep 2003 21:03:41 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <20030904092834.A27774@infradead.org>
References: <20030904010940.5fa0e560.davem@redhat.com>
	<Pine.LNX.4.44.0309040111290.20151-100000@home.osdl.org>
	<20030904011010.21857a1c.davem@redhat.com>
	<20030904092834.A27774@infradead.org>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> ioremap_resource() looks like a fine idea.  It's cleaner, easily
> emulateable on <= 2.4 and solves the problem this hack wanted to
> work around properly.

I agree.

> This still doesn't make the phys_addr_t a good interims solution,
> though.  Just use ioremap_resource from the beginning for those
> drivers that care for the bigger address space on ppc44x.
> 
> Paul, what does actually use this higher addresses?

We have drivers for on-chip peripherals that work from a struct
ocp_device and call ioremap on the ocp_dev->paddr value, which is a
phys_addr_t (although some of them use __ioremap instead).  These
drivers are used on 405-based systems (with 32-bit phys_addr_t) as
well as on 440-based systems.

These drivers are in the linuxppc-2.{4,5} trees but most of them
haven't made it into the official trees yet.  They could all be
audited and converted to use __ioremap, although it seems a bit
arbitrary to say that you can't use ioremap in a an ocp driver if
you're going to use it on a 440.  I wouldn't expect it to be
immediately obvious to a driver author just why you have to use
__ioremap rather than ioremap in an ocp driver.  The ioremap_resource
idea would solve that problem of course, we would put a resource in
the struct ocp_device instead of the physical address.

Paul.

