Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWAPWak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWAPWak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWAPWak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:30:40 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:25588 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751226AbWAPWaj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:30:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K/JgT4skaZvNF1q6/mPXm5AuSOiZTPMnxAJXbAKoLZkidskEiCbSeKE7wy++RHWZ2Oe/5r5h9p6ps0RExcXI4dpvedxCr9/NieChAito6m0kYF/hlQ1LPvn5xMD9sRxig1IFsmuxFsJpzt7huHbGWsvClkwyNjmUmHT5nt5oTR8=
Message-ID: <728201270601161430y4a381bfcs3a470f09287769c@mail.gmail.com>
Date: Mon, 16 Jan 2006 16:30:34 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Shared memory usage
Cc: Valdis.Kletnieks@vt.edu, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0601161510050.23899@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0601160909590.22754@chaos.analogic.com>
	 <200601161848.k0GIm3xH016052@turing-police.cc.vt.edu>
	 <Pine.LNX.4.61.0601161510050.23899@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you think about getting shared memory information using
shmctl(IPC_STAT). It provides useful information but I am not sure if
that will serve your purpose fully.

Regards
Ram Gupta

On 1/16/06, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Mon, 16 Jan 2006 Valdis.Kletnieks@vt.edu wrote:
>
> > On Mon, 16 Jan 2006 09:15:16 EST, "linux-os (Dick Johnson)" said:
> >> But the customer complained during certification testing
> >> that shared memory in use is not measured and therefore
> >> cannot be verified. This means that there may be rogue
> >> communications channels, using shared memory, in the
> >> system. I need to prove that there are no such channels
> >> by metering the shared memory and then accounting for
> >> every bit shown.
> >
> > The customer is confused, and your test is broken as designed.
> >
> > The fact that you look in /proc/meminfo and account for every shared
> > memory page *at this instant* doesn't mean there isn't a communication
> > channel *at some other time*. Even if you run a daemon that does nothing
> > but monitor this usage 10 times a second, and complain if a discrepancy
> > is found, it *still* won't work:
> >
> > 1) It's racy - 2 processes can mmap() some space during that 0.1 seconds,
> > transfer the info, and detach the memory without your knowledge.
> >
> > 2) It's racy - if you inquire *while* some other process is in some
> > intermediate
> > state, causing false positives that will drive the SSO nuts.
> >
> > The *proper* solution is to use something like SELinux that will flat-out
> > *prohibit* the attachment of a shared memory segment that isn't permitted.
> >
>
> The customer is not confused and is, in fact, a known expert.
> This is not a "general purpose" setup. There are no executables
> except what is burned into R/O PROM. There is no code that can
> upload new executables nor any way to execute them. There is no
> shell and no init.
>
> There is a startup program called 'init' for convenience, but
> whatever it does is hard-coded. It starts a bunch of predefined
> tasks and sleeps after performing some initialization.
>
> So, if the executable files are exactly like those which
> were reviewed during a security review, and if all
> communications between processes can be accounted for,
> including shared memory, then it can be guaranteed that
> whatever is being executed is exactly what passed the
> security review. However, if all communications channels
> cannot be accounted for, then it is not possible for such
> a guarantee.
>
> It can be argued that, once the executable code is known,
> there is no reason to review possible rogue communications
> channels. However, the customer is an expert in this field
> and requires an audit of all possible communications
> channels, including shared memory.
>
> Note that this is an audit. The code for every communications
> channel is reviewed. To verify that all such channels are
> audited, one needs to find them. For instance even 'vdso' is
> audited. These are not continuous audits that operate at
> run-time. The reason for this 'static' audit is so that
> CPU time eating checks don't have to be done at runtime.
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
>
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
> Thank you.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
