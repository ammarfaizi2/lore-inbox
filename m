Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282786AbRK0E3R>; Mon, 26 Nov 2001 23:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282787AbRK0E3H>; Mon, 26 Nov 2001 23:29:07 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:15370 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282786AbRK0E3A>; Mon, 26 Nov 2001 23:29:00 -0500
Date: Mon, 26 Nov 2001 20:39:11 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Robert Love <rml@tech9.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc-based cpu affinity user interface
In-Reply-To: <1006834464.842.2.camel@phantasy>
Message-ID: <Pine.LNX.4.40.0111262026380.1674-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 2001, Robert Love wrote:

> On Mon, 2001-11-26 at 22:52, Davide Libenzi wrote:
> > As I said in reply to Ingo patch, it'd be better to expose "number" cpu
> > masks not "logical" ( like cpus_allowed ).
> > In this way the users can use 0..N-1 ( N == number of cpus phisically
> > available ) w/out having to know the internal mapping between logical and
> > number ids.
>
> Do you mean you don't like using a bitmask ?

No no, I love binary math :)


> 00000001 = first CPU, its not logical, its physical.

If You set this directly to cpus_allowed You're going to set the logical
one.
This because cpus_allowed is logical, because it's used like, ie:

int this_cpu = p->processor;

if (p->cpus_allowed & (1 << this_cpu)) ...

and p->processor is logical.
Something like :

unsigned long num2log_mask(unsigned long cmsk) {
	unsigned long msk = 0;
	int ii;

	for (ii = 0; ii < smp_num_cpus; ii++)
		if (cmsk & (1 << ii))
			msk |= (1 << cpu_logical_map(ii));
	return msk;
}

unsigned long log2num_mask(unsigned long cmsk) {
	unsigned long msk = 0;
	int ii;

	for (ii = 0; ii < smp_num_cpus; ii++)
		if (cmsk & (1 << ii))
			msk |= (1 << cpu_number_map(ii));
	return msk;
}

You use num2log_mask() on the user input mask to set cpus_allowed and
log2num_mask() to return the map to the user.




- Davide


