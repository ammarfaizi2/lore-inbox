Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319121AbSHTAat>; Mon, 19 Aug 2002 20:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319122AbSHTAas>; Mon, 19 Aug 2002 20:30:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:12241 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319121AbSHTAao>;
	Mon, 19 Aug 2002 20:30:44 -0400
Date: Tue, 20 Aug 2002 02:35:57 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re:
 async-io API registration for 2.5.29)]
In-Reply-To: <Pine.LNX.4.44.0208162134440.2497-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208200223250.7924-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Linus Torvalds wrote:

> But if you have such a mapping, then you _cannot_ make a per-task VM
> space, because many tasks will share the same VM. You cannot even do a
> per-cpu mapping change (and rewrite the VM on thread switch), since the
> VM is _shared_ across CPU's, and absolutely has to be in order to work
> with CPU's that do TLB fill in hardware (eg x86).

i'm just trying to insert the notion here that it *is* possible to do
'software TLB fill' on x86 as well - it's just too much pain and very
likely not worth it. The pgd entry of the top 4MB mapping can be filled in
temporarily, the space accessed (causing a hw TLB fill), and then the pgd
entry can be zeroed out again - keeping the 'soft filled TLB' still
intact. This assumes that the intermediate pgd value cannot be observed by
any other CPU - which can be achieved via either cross-CPU calls (lots of
overhead to the TLB miss 'handler'), or the hope that freshly accessed &
rewritten, locked cachelines are not seen by other CPUs, yet. (some CPUs
do define a certain window of non-observation for locked MESI lines, in
which the soft TLB handling stuff can be done, theoretically.) This
necessiates the disabling of interrupts, and worse, NMIs, so it's really
flaky.

once the TLB gets flushed it causes a fault again - at which point the
whole 'sw TLB fill' ordeal has to begin again.

so this is not practical at all, but perhaps interesting. If eg.  
kernel-space used 4MB pages only for this purpose then we would not get
many 'TLB misses', because on most (all?) x86 CPUs the large-page TLBs are
isolated from the 4K page TLBs. They could even survive TLB flushes via
the PGE bit set.

but this is so hw-specific that the use of x86 segmentation looks like a
highlevel language in comparison :-)

	Ingo

