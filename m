Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVLPT0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVLPT0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVLPT0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:26:20 -0500
Received: from spirit.analogic.com ([204.178.40.4]:63758 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932370AbVLPT0T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:26:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
X-OriginalArrivalTime: 16 Dec 2005 19:26:12.0975 (UTC) FILETIME=[9371E7F0:01C60276]
Content-class: urn:content-classes:message
Subject: Re: [2.6 patch] i386: always use 4k stacks 
Date: Fri, 16 Dec 2005 14:26:12 -0500
Message-ID: <Pine.LNX.4.61.0512161407270.31274@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] i386: always use 4k stacks 
Thread-Index: AcYCdpN9KQWVw93KQr2hmT3oX/G0Pw==
References: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <arjan@infradead.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Dec 2005, Horst von Brand wrote:

> linux-os \(Dick Johnson\) <linux-os@analogic.com> wrote:
>
> [...]
>
>> Throughout the past two years of 4k stack-wars, I never heard why
>> such a small stack was needed (not wanted, needed). It seems that
>> everybody "knows" that smaller is better and most everybody thinks
>> that one page in ix86 land is "optimum". However I don't think
>> anybody ever even tried to analyze what was better from a technical
>> perspective. Instead it's been analyzed as religious dogma, i.e.,
>> keep the stack small, it will prevent idiots from doing bad things.
>
> OK, so here goes again...
>
> The kernel stack has to be contiguous in /physical/ memory. Keep the stack
> /one/ page, that way you can always get a new stack when needed (== each
> fork(2) or clone(2)). If the stack is 2 (or more) pages, you'll have to
> find (or create) a multi-page free area, and (fragmentation being what it
> is, and Linux routinely running for months at a time) you are in a whole
> new world of pain.

The interrupt stack needs to be non-paged. Are you sure the user-stacks
need to be 'physical', non-paged too? If so, that's probably the
problem. All addresses accessed by the CPUs in the kernel are virtual
which means one needs some mapping anyway.

So, why can't one map non-contiguous pages into the kernel-user-stack?
That entry-into-the-kernel stack is the one that's giving everybody
fits because it needs to remain allocated, even for sleeping tasks.

If it was virtual, built just like other data, it could be made up
from any available RAM and, in the case of a preemptive kernel,
even swapped!

In that case, the total amount of real RAM you actually need
is defined only by the number of concurrent tasks in a preemptive
kernel, plus the page(s) for the interrupt stack. That's far lower
than the 'N' pages times everybody who forked and slept, which is
what we seem to have now.

FYI, there is nothing wrong with a 2-level stack, i.e., the
system-call occurs on the interrupt stack, then the user-kernel
stack gets allocated from paged RAM.

Now I know this isn't VMS, but in VMS we didn't have anything
that really needed to be contiguous except for the interrupt
stack (which was arbitrarily 64k). And on VAXen the pages were
tiny 512 things so you really need to use paged RAM for just
about everything.

> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
