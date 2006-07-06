Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWGFOGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWGFOGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWGFOGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:06:20 -0400
Received: from relay02.pair.com ([209.68.5.16]:46860 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1030282AbWGFOGS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:06:18 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: "J.A. =?iso-8859-1?q?Magall=F3n?=" <jamagallon@ono.com>
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Thu, 6 Jul 2006 09:05:51 -0500
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060705114630.GA3134@elte.hu> <1152189583.3084.32.camel@laptopd505.fenrus.org> <20060706153955.0740b934@werewolf.auna.net>
In-Reply-To: <20060706153955.0740b934@werewolf.auna.net>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607060906.14811.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 July 2006 08:39, J.A. Magallón wrote:
>
> // Read 10 samples from 2 A/D converters.
>
> int*	ina;
> int	a[10];
> int*	inb;
> int	b[10];
>
> for (int i=0; i<10; i++)
> {
> 	a[i] = *ina;
> 	barrier();
> 	b[i] = *inb;
> }
>
> The barrier prevents the compiler of translating this to:
>
> for (int i=0; i<10; i++)
> {
> 	b[i] = *inb;
> 	a[i] = *ina;
> }
>
> or even to:
>
> for (int i=0; i<10; i++)
> 	a[i] = *ina;
> for (int i=0; i<10; i++)
> 	b[i] = *inb;
>
> but does not prevent it to do this:
>
> register int tmp_a = *ina;
> register int tmp_b = *inb;
>
> for (int i=0; i<10; i++)
> {
> 	a[i] = tmp_a;
> 	b[i] = tmp_b;
> }
>
> because nor 'ina' nor 'inb' change under what the compiler sees inside
> the loop. 'volatile' prevents the compiler of do a high level cache of
> *ina or *inb.
>

Check the GCC documentation:

http://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Extended-Asm.html
 
> If your assembler instructions access memory in an unpredictable fashion,
> add `memory' to the list of clobbered registers. This will cause GCC to not
> keep memory values cached in registers across the assembler instruction and
> not optimize stores or loads to that memory. You will also want to add the
> volatile keyword if the memory affected is not listed in the inputs or
> outputs of the asm, as the `memory' clobber does not count as a side-effect
> of the asm. If you know how large the accessed memory is, you can add it as
> input or output but if this is not known, you should add `memory'. As an
> example, if you access ten bytes of a string, you can use a memory input
> like:         

The reference to the volatile keyword here is of course talking about asm 
volatile usage to keep the compiler from optimizing out the seemingly 
pointless assembly (not usage on a variable).

Thanks,
Chase
