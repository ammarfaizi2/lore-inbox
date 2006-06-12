Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWFLRGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWFLRGh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWFLRGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:06:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:14780 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751066AbWFLRGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:06:36 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: broken local_t on i386
Date: Mon, 12 Jun 2006 19:06:28 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606121848.05438.ak@suse.de> <Pine.LNX.4.64.0606120950280.19309@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606120950280.19309@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121906.28692.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 18:54, Christoph Lameter wrote:
> On Mon, 12 Jun 2006, Andi Kleen wrote:
> 
> > > #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
> > 
> > It is also affected by your race. The inc would only be atomic if the counter
> > was in the PDA, but standard per cpu data isn't. So it has to follow 
> > a pointer and then it could already have switched.
> 
> I thought the above would refer to a PDA memory area that is specially 
> mapped by each processor? That is the only thing that would get this 
> working right because we would map to a different PDA if the process 
> would be mapped to a different processor.

It does, but the per cpu data that everybody uses doesn't reside in the PDA
because it wasn't possible to make this work with binutils

It would require a relocation relative to another symbol which isn't
really supported.

At some point I considered using runtime patching to work around
this limitation, but it would be some work and relatively complex.

So the PDA just contains a pointer to the real per CPU area and it's
added. Unfortunately it's three instructions or so and not atomic 
(mov, add, reference) 

> 
> > Fix would be to disable preemption. I don't think it needs cli/sti
> > on non preemptible kernels.
> 
> Yuck. The advantage of local.t was that it does not need any of these 
> tricks. What is the point of local.t if one needs to disable preemption?

No atomic operations. Preemption just requires to increase a counter
in thread info.

Also on non preemptive kernels - which are the majority - it's a single
instruction on x86. I guess preempt users can live with a bit more
overhead ... 

-Andi

