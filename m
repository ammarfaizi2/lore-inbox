Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWGFNkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWGFNkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWGFNkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:40:42 -0400
Received: from smtp.ono.com ([62.42.230.12]:42274 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S1030264AbWGFNkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:40:41 -0400
Date: Thu, 6 Jul 2006 15:39:55 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060706153955.0740b934@werewolf.auna.net>
In-Reply-To: <1152189583.3084.32.camel@laptopd505.fenrus.org>
References: <20060705114630.GA3134@elte.hu>
	<20060705101059.66a762bf.akpm@osdl.org>
	<20060705193551.GA13070@elte.hu>
	<20060705131824.52fa20ec.akpm@osdl.org>
	<Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	<20060705204727.GA16615@elte.hu>
	<Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	<20060705214502.GA27597@elte.hu>
	<Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	<20060706081639.GA24179@elte.hu>
	<Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
	<1152187268.3084.29.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0607060816110.8320@chaos.analogic.com>
	<1152189583.3084.32.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 2.3.1cvs59 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 14:39:43 +0200, Arjan van de Ven <arjan@infradead.org> wrote:

> On Thu, 2006-07-06 at 08:29 -0400, linux-os (Dick Johnson) wrote:
> > On Thu, 6 Jul 2006, Arjan van de Ven wrote:
> > 
> > > On Thu, 2006-07-06 at 07:59 -0400, linux-os (Dick Johnson) wrote:
> > >> On Thu, 6 Jul 2006, Ingo Molnar wrote:
> > >>
> > >>>
> > >>> * Linus Torvalds <torvalds@osdl.org> wrote:
> > >>>
> > >>>> I wonder if we should remove the "volatile". There really isn't
> > >>>> anything _good_ that gcc can do with it, but we've seen gcc code
> > >>>> generation do stupid things before just because "volatile" seems to
> > >>>> just disable even proper normal working.
> > >>
> > >> Then GCC must be fixed. The keyword volatile is correct. It should
> > >> force the compiler to read the variable every time it's used.
> > >
> > > this is not really what the C standard says.
> > >
> > >
> > >
> > >> This is not pointless. If GCC generates bad code, tell the
> > >> GCC people. The volatile keyword is essential.
> > >
> > > no the "volatile" semantics are vague, trecherous and evil. It's a LOT
> > > better to insert the well defined "barrier()" in the right places.
> > 
> > Look at:
> > 
> >  	http://en.wikipedia.org/wiki/Volatile_variable
> > 
> > This is just what is needed to prevent the compiler from making non working
> > code during optimization.
> 
> and an entry level document at wikipedia is more important than the C
> standard ;)
> 
> > 
> > Also look at:
> > 
> >  	http://en.wikipedia.org/wiki/Memory_barrier
> > 
> > This is used to prevent out-of-order execution, not at all what is
> > necessary.
> 
> I did not talk about memory barriers. In fact, barrier() is NOT a memory
> barrier. It's a compiler optimization barrier!
> 

// Read 10 samples from 2 A/D converters.

int*	ina;
int	a[10];
int*	inb;
int	b[10];

for (int i=0; i<10; i++)
{
	a[i] = *ina;
	barrier();
	b[i] = *inb;
}

The barrier prevents the compiler of translating this to:

for (int i=0; i<10; i++)
{
	b[i] = *inb;
	a[i] = *ina;
}

or even to:

for (int i=0; i<10; i++)
	a[i] = *ina;
for (int i=0; i<10; i++)
	b[i] = *inb;

but does not prevent it to do this:

register int tmp_a = *ina;
register int tmp_b = *inb;

for (int i=0; i<10; i++)
{
	a[i] = tmp_a;
	b[i] = tmp_b;
}

because nor 'ina' nor 'inb' change under what the compiler sees inside
the loop. 'volatile' prevents the compiler of do a high level cache of
*ina or *inb.

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
