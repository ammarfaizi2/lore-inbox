Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265924AbUBKRIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 12:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265927AbUBKRIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 12:08:46 -0500
Received: from ns.suse.de ([195.135.220.2]:61631 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265924AbUBKRIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 12:08:42 -0500
Date: Sat, 14 Feb 2004 19:59:49 +0100
From: Andi Kleen <ak@suse.de>
To: Alex Pankratov <ap@swapped.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] [2/2] hlist: remove IFs from hlist functions
Message-Id: <20040214195949.2ad9aa4f.ak@suse.de>
In-Reply-To: <402A5CEC.2030603@swapped.cc>
References: <4029CB7E.4030003@swapped.cc.suse.lists.linux.kernel>
	<4029CF24.1070307@osdl.org.suse.lists.linux.kernel>
	<4029D2D5.7070504@swapped.cc.suse.lists.linux.kernel>
	<p73y8ra5721.fsf@nielsen.suse.de>
	<402A5CEC.2030603@swapped.cc>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 08:48:44 -0800
Alex Pankratov <ap@swapped.cc> wrote:

> 
> Andi Kleen wrote:
> 
> > Alex Pankratov <ap@swapped.cc> writes:
> > 
> >>
> >>No, because its 'pprev' field *is* getting modified.
> > 
> > I didn't notice this before, sorry. But this could end up 
> > being a scalability problem on big SMP systems. Even though
> > the cache line of this is never read it will bounce all the
> > time between all CPUs using hlists and add considerably 
> > latency and cross node traffic. Remember Linux is supposed
> > to run well on 128 CPU machines now.
> 
> That's a bit above my head. How does this potential latency
> compare to the speed up due to not having CMPs ? My cycle
> counting skills are a bit dusty :)

A full cache miss is extremly costly on a modern Gigahertz+ CPU because
memory and busses are far slower than the CPU core. As a rule of 
thumb 1000+ cycles. An CMP is extremly cheap (a few cycles at worst), 
the only thing that could be more expensive is an mispredicted conditional
jump triggered  by the CMP. But even that would be at best a few tens of cycles.
If everything is mispredicted which should be common it's extremly fast
(a few cycles only) 

In addition on a big multiprocessor machine bouncing cache lines between
CPUs is costly because it adds load to the interconnect.

One way to avoid the possible mispredicted jump would be to reorganize the
code that the compiler can use CMOV. The issue is that on x86 CMOV 
cannot do a conditional store to memory, so it has to use something like

	unsigned long *target = realtarget;
	unsigned long dummy;
	if (condfalse) 
		target = &dummy;     /* <---- can be converted to CMOV */
	*target = dummy;
			
(gcc should do that on its own, but it doesn't). I'm not really sure
it's practical to do that for the CMP here and if it's even worth it.

Most likely the hlist loops are dominated by cache misses in walking the 
nodes anyways.

> 
> > 
> > Maybe you can make it UP only, but I'm still not sure it's 
> > worth it.
> > 
> 
> Sorry, I didn't the 'UP' part.

Uniprocessor = !CONFIG_SMP with an #ifdef.

-Andi
