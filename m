Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTEXSoD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 14:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTEXSoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 14:44:03 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:40322
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262589AbTEXSoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 14:44:02 -0400
Date: Sat, 24 May 2003 14:47:06 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][2.5] provisional 32-way x445 patches
In-Reply-To: <200305232036.39297.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.50.0305241433270.2267-100000@montezuma.mastecende.com>
References: <200305232036.39297.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, James Cleverdon wrote:

> -int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
> +u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
>  
>  static int __init assign_irq_vector(int irq)
>  {
>  	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
> +	BUG_ON(irq >= sizeof(irq_vector)/sizeof(*irq_vector));

Can't you just skip that one (-ENOSPC)? It would oops on 32way NUMAQ. Why 
don't we just fix this properly now, it looks like we might end up just 
piling workarounds ontop of kludges. The intel guys were kind enough to 
crank out a vector based irq handling patch and it's just what we need to 
purge NR_IRQS misuse.

>   */
>  
> -extern int irq_vector[NR_IRQS];
> -#define IO_APIC_VECTOR(irq)	irq_vector[irq]
> +/* The upper limit of irq_vector's size is 16 + sum(num_RTEs_in_IO_APICs).
> + * On 32-way x445s this is already 266 without any I/O expansion boxes.
> + * This should eventually be dynamically allocated.
> + */
> +#define NR_IRQ_VECTORS	(4 * NR_IRQS)
> +extern u8 irq_vector[NR_IRQ_VECTORS];
> +#define IO_APIC_VECTOR(irq)	(int)(irq_vector[irq])

This just makes the relationship between NR_IRQS and NR_IRQ_VECTORS even 
more confusing. If you have one IDT, NR_IRQ_VECTORS is ~190

	Zwane
-- 
function.linuxpower.ca
