Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTIOUDv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTIOUDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:03:51 -0400
Received: from fmr06.intel.com ([134.134.136.7]:51128 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261507AbTIOUDs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:03:48 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Mon, 15 Sep 2003 13:03:28 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AF56@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Thread-Index: AcN7vEw1AM6myUVZRPizRENiAxN39wAAvsAw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Bill Davidsen" <davidsen@tmr.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Sep 2003 20:03:29.0489 (UTC) FILETIME=[6E8A9C10:01C37BC4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Of course if you have PIV kernel you don't need any of the Athlon code
at
> all, so the size and performance penalty is zero. And if you build for
a
> CPU which doesn't have prefetch you don't need any of that code at
all.

That's true. But I think sharing the same source/binary in some
reasonable fashion is much more beneficial to Linux and the users,
especially because we can improve the quality and performance more
efficiently. 

I think the way Andi implemented (see below, for example) is one of the
best solutions as far as I think of. 

extern inline void prefetchw(const void *x)
{
	alternative_input(ASM_NOP4,
			  "prefetchw (%1)",
			  X86_FEATURE_3DNOW,
			  "r" (x));
}

Thanks,
Jun

> -----Original Message-----
> From: Bill Davidsen [mailto:davidsen@tmr.com]
> Sent: Monday, September 15, 2003 11:51 AM
> To: Alan Cox
> Cc: Zwane Mwaikambo; Linux Kernel Mailing List
> Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
> 
> On Mon, 15 Sep 2003, Alan Cox wrote:
> 
> > On Llu, 2003-09-15 at 13:11, Bill Davidsen wrote:
> > > The code to disable prefetch on Athlon is 300 bytes and hurts your
> PIV?
> > > Really? I'll dig back through the code, but I recall it as adding
or
> > > deleting an entry in a table to enable prefetch. If it's affecting
PIV
> the
> > > code to use prefetch is seriously broken.
> >
> > Big time. Its over 300 bytes long because its embedded in each
inline
> > prefetch and it causes a branch misprediction almost every time.
Amazing
> > what you find when you actually measure stuff 8)
> >
> > So right now, its faster on PIV to delete the prefetch than use the
> > current hack, and adding the Athlon fix makes Athlon and PIV faster
and
> > total memory size lower.
> 
> Of course if you have PIV kernel you don't need any of the Athlon code
at
> all, so the size and performance penalty is zero. And if you build for
a
> CPU which doesn't have prefetch you don't need any of that code at
all.
> 
> --
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
