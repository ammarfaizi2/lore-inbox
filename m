Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313819AbSDQMaw>; Wed, 17 Apr 2002 08:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313830AbSDQMav>; Wed, 17 Apr 2002 08:30:51 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:13822 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S313819AbSDQMat>;
	Wed, 17 Apr 2002 08:30:49 -0400
Date: Wed, 17 Apr 2002 08:30:44 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
        davej@suse.de
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <20020417123044.GA8833@www.kroptech.com>
In-Reply-To: <20020417024707.GA24105@www.kroptech.com> <2635845054.1018994347@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 09:59:08PM -0700, Martin J. Bligh wrote:
> xquad_portio is indeed only for CONFIG_MULTIQUAD. However, you
> shouldn't need the #ifdef's in the code to make this work -
> clustered_apic_mode isn't a variable at all, it's a magic
> trick that's actually 1 or 0 depending on CONFIG_MULTIQUAD.
> 
> Look at 2.5.8 virgin, it has the same code.

Not quite.

As I said, -dj has an optimization in asm-i386/io.o:

> #ifdef CONFIG_MULTIQUAD
> extern void *xquad_portio;    /* Where the IO area was mapped */
> #else
> #define xquad_portio (0)
> #endif

So the preprocessed smpboot.c contains gems like:

> void *(0) = ((void *)0);

...and...

> (0) = ioremap (0xfe400000,
>         numnodes * 0x80000);

Even though clustered_apic_mode is 0, the compiler still complains
about the second one and the first one doesn't depend on
clustered_apic_mode at all.

I don't like spreading around more #ifdef's, but the spirit of the
changes seemed to be to get rid of the declaration of xquad_portio
when !CONFIG_MULTIQUAD. Suggestions for improvement welcome.

--Adam

