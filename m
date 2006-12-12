Return-Path: <linux-kernel-owner+w=401wt.eu-S932388AbWLLTWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWLLTWU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWLLTWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:22:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51654 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932388AbWLLTWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:22:19 -0500
Date: Tue, 12 Dec 2006 11:22:11 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: jacliburn@bellsouth.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] commit 3c517a61, slab: better fallback allocation behavior
In-Reply-To: <20061212105717.f539fb73.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0612121120390.12207@schroedinger.engr.sgi.com>
References: <457C64C5.9030108@bellsouth.net> <20061210124907.60c4a0aa.pj@sgi.com>
 <20061210141435.afac089d.akpm@osdl.org> <Pine.LNX.4.64.0612110855380.500@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0612110930180.500@schroedinger.engr.sgi.com>
 <20061212105717.f539fb73.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006, Paul Jackson wrote:

> Christoph wrote:
> > +		if (local_flags & __GFP_WAIT)
> > +			local_irq_enable();
> > +		kmem_flagcheck(cache, flags);
> >  		obj = kmem_getpages(cache, flags, -1);
> > +		if (local_flags & __GFP_WAIT)
> > +			local_irq_disable();
> 
> This seems strange to me.  I am surprised that it is ok for a routine
> that is called with irq's disabled, to enable them momentarilly.

The slab itself disables the irq. In this case the slab function is 
was called irqs enabled and we forgot to reenable interrupts before 
calling kmem_getpages().

> I'd have thought the caller of this routine, who called it with irq's
> disabled, would expect irq's to remain disabled across the entire call.

Irqs only stay disabled if GFP_ATOMIC is passed to the slab function.
