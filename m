Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVFJR0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVFJR0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 13:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVFJR0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 13:26:20 -0400
Received: from palrel13.hp.com ([156.153.255.238]:25759 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262610AbVFJR0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 13:26:11 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17065.52506.707169.903319@napali.hpl.hp.com>
Date: Fri, 10 Jun 2005 10:25:46 -0700
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: davidm@hpl.hp.com, Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 07/10] IOCHK interface for I/O error handling/detecting
In-Reply-To: <42A96BA6.1070300@jp.fujitsu.com>
References: <42A8386F.2060100@jp.fujitsu.com>
	<42A83CF2.90304@jp.fujitsu.com>
	<17064.32552.507932.62892@napali.hpl.hp.com>
	<42A96BA6.1070300@jp.fujitsu.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 10 Jun 2005 19:29:58 +0900, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> said:

  Hidetoshi> Hi David,
  Hidetoshi> David Mosberger wrote:
  >>>>>>> On Thu, 09 Jun 2005 21:58:26 +0900, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> said:
  >> 
  Hidetoshi> +/*
  Hidetoshi> + * Some I/O bridges may poison the data read, instead of
  Hidetoshi> + * signaling a BERR.  The consummation of poisoned data
  Hidetoshi> + * triggers a local, imprecise MCA.
  Hidetoshi> + * Note that the read operation by itself does not consume
  Hidetoshi> + * the bad data, you have to do something with it, e.g.:
  Hidetoshi> + *
  Hidetoshi> + *	ld.8	r9=[r10];;	// r10 == I/O address
  Hidetoshi> + *	add.8	r8=r9,r9;;	// fake operation
  Hidetoshi> + */
  Hidetoshi> +#define ia64_poison_check(val)					\
  Hidetoshi> +{	register unsigned long gr8 asm("r8");			\
  Hidetoshi> +	asm volatile ("add %0=%1,r0" : "=r"(gr8) : "r"(val)); }
  Hidetoshi> +
  Hidetoshi> #endif /* CONFIG_IOMAP_CHECK  */

  >> I have only looked that this briefly and I didn't see off hand where you get
  >> the "r9=[r10]" sequence from --- I hope you're not relying on the compiler
  >> happening to generate this sequence!

  Hidetoshi> +static inline unsigned char
  Hidetoshi> +___ia64_readb (const volatile void __iomem *addr)
  Hidetoshi> +{
  Hidetoshi> +    unsigned char val;
  Hidetoshi> +
  Hidetoshi> +    val = *(volatile unsigned char __force *)addr;
  Hidetoshi> +    ia64_poison_check(val);
  Hidetoshi> +
  Hidetoshi> +    return val;
  Hidetoshi> +}

Ah, I see now what you're trying to do.  I think it's really a
machine-check barrier that you want there.

I'm doubtful whether this is the right approach, though: your
ia64_poison_check() will cause _every single_ readX() operation to
stall the CPU for 1,000+ cycles.  Why not define an explicit
iochk_barrier() instead?  Then you could do things like this:

	a = readb(X);
	b = readb(Y);
	c = readb(Z);
	iochk_barrier(a + b + c);

That is, if it's unimportant to know whether the read of X, Y, or Z
caused the MCA, you can amortize the cost of iochk_barrier() over 3
reads.

I'd probably make iochk_barrier() an out-of-line no-op assembly
routine.  The cost of two branches compared to stalling for hundreds
of cycles is rather trivial.

	--david
