Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTD3X12 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbTD3X12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:27:28 -0400
Received: from [12.47.58.20] ([12.47.58.20]:60784 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262525AbTD3X10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:27:26 -0400
Date: Wed, 30 Apr 2003 16:36:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: Keith Mannthey <kmannth@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] clustered apic irq affinity fix for i386
Message-Id: <20030430163637.04f06ba6.akpm@digeo.com>
In-Reply-To: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com>
References: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2003 23:39:40.0384 (UTC) FILETIME=[C4CA9E00:01C30F71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Mannthey <kmannth@us.ibm.com> wrote:
>
> Hello all,
> 	Machines with clustered apics are buggy when it comes to setting irq
> affinity.

You stand accused of crimes against whitespace.

- The patch uses eight-spaces everywhere.  Please use eight-stop tabs.

- Funny comment format:

/*we want to be careful what we write we are in clustered mode
 *if the mask came from pending_irq_balance_apicid we are ok because
 *it was generated with cpu_to_logical_apicid*/

 should be

/*
 * We want to be careful what we write we are in clustered mode if the mask
 * came from pending_irq_balance_apicid we are ok because it was generated
 * with cpu_to_logical_apicid.
 */

- 1e16-column xterms.  Please aim for 80-columns:

static inline void io_apic_write_affinity(unsigned int apic, unsigned int reg,  unsigned int mask, unsigned int irq)

  should be:

static inline void io_apic_write_affinity(unsigned int apic,
		unsigned int reg,  unsigned int mask, unsigned int irq)

  or

static inline void
io_apic_write_affinity(unsigned int apic, unsigned int reg,
			unsigned int mask, unsigned int irq)


- non-K&R braces:


       if ((pending_irq_balance_apicid[irq] == mask) || (irqbalance_disabled))
       {
               mask = mask << 24;
               io_apic_write(apic,reg,mask);
       }
       else
       {
               printk ("Trying to write abartry affinity value to ioapic! Not allowed!");
       }
}

  should be:

       if ((pending_irq_balance_apicid[irq] == mask) || irqbalance_disabled) {
               mask = mask << 24;
               io_apic_write(apic,reg,mask);
       } else {
               printk("Trying to write abartry affinity value to ioapic! Not allowed!");
       }

  (note: no space between "printk" and "(")

  (s/abartry/arbitrary/)

  (best replace that printk with a BUG() or a WARN_ON(1))

  (or split the string up so it fits in 80-cols)

- Funny comments:

	/*only the first 8 bits are valid*/

  should be:

	/* Only the first 8 bits are valid */


Could you please take a look at all that and resend?

Thanks.

