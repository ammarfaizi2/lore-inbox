Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSFXASO>; Sun, 23 Jun 2002 20:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317212AbSFXASN>; Sun, 23 Jun 2002 20:18:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:40895 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317211AbSFXASM>; Sun, 23 Jun 2002 20:18:12 -0400
Date: Sun, 23 Jun 2002 17:16:34 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, Robert Love <rml@mvista.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, hbaum@us.ibm.com, cleverdj@us.ibm.com
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
Message-ID: <4198761039.1024852593@[10.10.2.3]>
In-Reply-To: <20020618071626.GO22961@holomorphy.com>
References: <20020618071626.GO22961@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jun 17, 2002 at 11:00:26AM +0200, Ingo Molnar wrote:
>> irqbalance uses the set_ioapic_affinity() method to set affinity. The
>> clustered APIC code is broken if it doesnt handle this properly. (i dont
>> have such hardware so i cant tell, but it indeed doesnt appear to handle
>> this case properly.) By wrapping around at node boundary the irqbalance
>> code will work just fine.
> 
> Perhaps a brief look at the code will help. Please forgive my
> non-preservation of whitespace as I cut and pasted it.

IIRC, I set up the IOAPICs to use physical mode broadcast
on all quads - physical broadcasts are quad-local, and thus
the interrupt is always processesed by a cpu on the quad
where it originated. Much simpler than trying to correctly
program clustered logical mode broadcasts differently for
every quad.

You also don't want to end up reprogramming the IO-APICs
cross-quad, you want a per-node thread to do this. We have
2 IO-APICs per node.

Whilst balancing of some form is definitely valuable for a P4,
I'm less convinced it's worthwhile for a P3 system. I presume
what you're trying to achieve is cache warmth for the interrupt
handling code at the expense of the cost of constantly reprogramming
the IO-APICs. 

At the very least, we need to have a simple disable config option 
in order to benchmark whether this change is worthwhile for each subarchitecture.

M.


