Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030774AbWKOR6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030774AbWKOR6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030781AbWKOR6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:58:10 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:57764 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1030774AbWKOR6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:58:06 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] i386-pda UP optimization
Date: Wed, 15 Nov 2006 18:58:09 +0100
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <200611151846.31109.dada1@cosmosbay.com> <20061115174957.GA27827@elte.hu>
In-Reply-To: <20061115174957.GA27827@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151858.09958.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 18:49, Ingo Molnar wrote:
> * Eric Dumazet <dada1@cosmosbay.com> wrote:
> > Machine boots but freeze when init starts. Any idea ?
>
> probably caused by this:
> > +# define GET_CPU_NUM(reg)
> >
> >  #define FIXUP_ESPFIX_STACK \
> >  	/* since we are on a wrong stack, we cant make it a C code :( */ \
> > -	movl %gs:PDA_cpu, %ebx; \
> > +	GET_CPU_NUM(%ebx) \
> >  	PER_CPU(cpu_gdt_descr, %ebx); \
> >  	movl GDS_address(%ebx), %ebx; \
>
> %ebx very definitely wants to have a current CPU number loaded ;) Pick
> it up from the task struct.

Hum.... Are you sure ?

For UP we have this PER_CPU definition :

#define PER_CPU(var, cpu) \
        movl $per_cpu__/**/var, cpu;

You can see 'cpu' is a pure output , not an input value.

So I basically deleted the fist instruction of this sequence :

movl %gs:PDA_cpu, %ebx
movl $per_cpu__cpu_gdt_descr, %ebx;

Did I miss something ?
