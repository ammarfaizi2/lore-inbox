Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTJMVO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 17:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTJMVO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 17:14:27 -0400
Received: from heisenberg.ccac.RWTH-Aachen.DE ([134.130.220.226]:45573 "EHLO
	heisenberg.ccac.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S261947AbTJMVOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 17:14:25 -0400
Date: Mon, 13 Oct 2003 23:14:23 +0200
From: Carsten Jacobi <carsten@ccac.rwth-aachen.de>
To: Marc Zyngier <mzyngier@freesurf.fr>,
       Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lne390 and Jensen Alphas
Message-ID: <20031013211423.GA27129@ccac.rwth-aachen.de>
References: <20031010221723.GA12615@ccac.rwth-aachen.de> <wrp1xtir95d.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrp1xtir95d.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 01:24:30PM +0200, Marc Zyngier wrote:

> This doesn't look to me like a proper fix. You should unconditionally
> use ioremap and memcpy_{from,to}io (not the isa_* version). No need to
> have a special Jensen case here.

Marc,

I wish I could use the memcpy_{from,to}io-functions because I know by
myself that they are well optimized and tested. But in this case they
don't behave the way the lne390 adapter needs them.
If you take a look into arch/alpha/lib/io.c you see that the function
_memcpy_toio() is checking the count of bytes to copy and the address to
copy to against their alignment. In case they are on a 16bit boundary
(and unfortunately they are always on such a boundary because the MAC
header is 14 bytes and the alignment of skb->data is honoring the start
of IP data for alignment to increase the performance of the stack)
_memcpy_toio() will use __raw_writew() to actually copy the data. And
this is exactly what doesn't work: Filling the shared mem of the lne390
adapter using 16bit write operations. I think this problem does not arise
on x86 architectures.
About five years ago I addressed that issue 
(http://www.uwsg.iu.edu/hypermail/linux/kernel/9807.3/1132.html) and got
an answer from Alan Cox
(http://www.uwsg.iu.edu/hypermail/linux/kernel/9807.3/1212.html)

> Please look at the way ne3210.c was fixed in 2.6.0-test7.

Hmm, I see you are using memcpy_{from,to}io-functions only. Five years
ago I sent another patch that established a new function I called
"memcpy_toio_g32a"()
(http://www.ussg.iu.edu/hypermail/linux/kernel/9808.1/0275.html), but that was
the one that never did it into an official release. Indeed, I am also
unwilling to write a dirty hack and use well defined io-functions
instead. This is clean and it is even easier to develop and debug.
Unfortunately .... I start to repeat. Or, is there another way to copy
something from mem to iomem that is definitely using 32bit write
operations? Any help is welcome ...

Regards,
	Carsten Jacobi

