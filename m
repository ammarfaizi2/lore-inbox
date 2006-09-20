Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWITNpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWITNpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWITNpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:45:38 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:45933 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751374AbWITNph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:45:37 -0400
In-Reply-To: <1158748327.7705.3.camel@localhost.localdomain>
Subject: Re: [PATCH] Linux Kernel Markers
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, Jes Sorensen <jes@sgi.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ltt-dev@shafik.org,
       Martin Bligh <mbligh@google.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Ingo Molnar <mingo@elte.hu>, prasanna@in.ibm.com,
       systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>,
       William Cohen <wcohen@redhat.com>, Tom Zanussi <zanussi@us.ibm.com>
X-Mailer: Lotus Notes Release 7.0.1 July 07, 2006
Message-ID: <OF826E70C6.D56C9D09-ON802571EF.004A94C0-802571EF.004B91DA@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Wed, 20 Sep 2006 14:45:25 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 20/09/2006 14:47:48
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox <alan@lxorguk.ukuu.org.uk> wrote on 20/09/2006 11:32:07:

> Ar Mer, 2006-09-20 am 09:18 +0100, ysgrifennodd Richard J Moore:
> > > Are you referring to Intel erratum "unsynchronized cross-modifying
code"
> > > - where it refers to the practice of modifying code on one processor
> > > where another has prefetched the unmodified version of the code.
>
> > In the special case of replacing an opcode with int3 that erratum
doesn't
> > apply. I know that's not in the manuals but it has been confirmed by
the
> > Intel microarchitecture group. And it's not reasonable to it to be any
> > other way.
>
> Ok thats cool to know and I wish they'd documented it. Is the same true
> for AMD ?
>
> Alan
>

Not sure probably - I can ask.

Intel explained it to me thus:

When the i-fetch has been done and the micro-ops are in the trace cache
then there's no longer a direct correlation between the original machine
instruction boundaries and the micro ops. This is due to optimization. For
example (artificial one for illustrative purposes):

mov eax,ebx
mov memory,eax
mov eax,1

(using intel notation not ATT - force of habit)

In the trace cache there would be no micro ops to update eax with ebx.

Altering the "mov eax,ebx" to "mov ecx,ebx" on the fly invalidates the
optimized trace cache, hence the onlhy recourse is a GPF.
If the modification doens't invalidate the trace cache then no GPF. The
question is: "can we predict th circumstances when the trace cache has not
been invalidated", and the answer in general is no since the
microarchtecture is not public. But one can guess that modifying the single
byte opcode with in interrupting instruction  - int3 - doesn't cause an
inconsistency that can't be handled. And that's what Intel confirmed. Go
ahead and store int3 without the need to synchronise (i.e. force the trace
cache to be flushed).

My guess is that AMD behaves exactly the same way. But I'll check.


Richard

