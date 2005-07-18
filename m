Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVGRLSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVGRLSi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVGRLSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:18:35 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:47378 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261643AbVGRLRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:17:50 -0400
Date: Mon, 18 Jul 2005 12:17:53 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, vojtech@suse.cz,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <20050715110157.A16008@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61L.0507181148440.527@blysk.ds.pg.gda.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com.suse.lists.linux.kernel>
 <p73y8889f4v.fsf@bragg.suse.de> <20050715102349.A15791@unix-os.sc.intel.com>
 <Pine.LNX.4.61L.0507151848440.15977@blysk.ds.pg.gda.pl>
 <20050715110157.A16008@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Venkatesh Pallipadi wrote:

> Well.. I tried a patch to do the broadcast thing couple of months ago and 
> failed to convince everyone :(.

 I must have missed the patch -- but was the change unconditional or 
affecting only broken systems?  And how such systems were determined?

> Further, it doesn't work well if you want to exclude some CPUs from the 
> list of recievers. Logical destination is simple only for less than 8 
> CPUs. Beyond that with clustered or physical configuration it is 
> difficult.

 Well, I've thought the number of bits for LDR has been reexpanded at one 
point (it had been 32 originally with the 82489DX and then shrank to 8 
with the Pentium integrated APIC) -- it must have been something else...

 Anyway, for this you should just need a single bit as, quoting APIC 
documentation:

 "When the message addresses the destination using logical addressing 
scheme each Local Unit in the ICC bus compares the logical address in the 
interrupt message with its own Logical Destination Register.  If there is 
a bit match (i.e., if at least one of the corresponding pair of bits 
match) this local unit is selected for delivery."

Thus you could make, say, bit 31 of LDR the "timer bit", set it in all 
local APIC units and send timer interrupts in the Fixed delivery mode 
using a logical destination address with only bit 31 set.  You could then 
exclude processors from delivery by clearing bit 31 of LDR as needed.  It 
could probably be applied to addresses within clusters, too, though space 
there is a bit tight.

 None of such hassle should be needed in reality, though -- I presume the 
only broken systems are uniprocessor ones with the HT feature as real SMP 
systems need to have their APICs enabled all the time to be able to accept 
IPIs if nothing else.  As UP systems with HT have only two processors 
logically, there is no problem with using the logical destination mode as 
currently implemented.

  Maciej
