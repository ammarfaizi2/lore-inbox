Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUANT75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUANT75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:59:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:42479 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264971AbUANT7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:59:46 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch UP installer kernels
Date: Wed, 14 Jan 2004 11:59:03 -0800
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
References: <200401131627.02138.jamesclv@us.ibm.com> <Pine.LNX.4.58.0401131957420.18388@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0401131957420.18388@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401141159.03248.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 January 2004 5:00 pm, Zwane Mwaikambo wrote:
> On Tue, 13 Jan 2004, James Cleverdon wrote:
> > Problem:  Earlier I didn't consider the case of the generic sub-arch and
> > uni-proc installer kernels used by a number of distros.  It currently is
> > scaled by NR_CPUS.  The correct values should be big for summit and
> > generic, and can stay the same for all others.
>
> This all looks strange, especially in assign_irq_vector() does this
> mean that you'll try and allocate up to 1024 vectors?

The irq_vector array name is a bit misleading.  It contains the vectors for 
each potential I/O APIC RTE.  The array needs to be at least the sum of all 
the RTEs in the system.  Summit PCI bridge chips have large I/O APICs (50 
RTEs), and a large system has up to 16 of them.  16*50 = 800.  Allocating 1k 
entries provides a pad for the future, and u8 doesn't cost much.


> > diff -pru 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h
> > t1mm2/include/asm-i386/mach-default/irq_vectors.h
> > --- 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h	2004-01-08
> > 22:59:19.000000000 -0800
> > +++ t1mm2/include/asm-i386/mach-default/irq_vectors.h	2004-01-13
> > 13:43:56.000000000 -0800
> > @@ -90,8 +90,12 @@
> >  #else
> >  #ifdef CONFIG_X86_IO_APIC
> >  #define NR_IRQS 224
> > -# if (224 >= 32 * NR_CPUS)
> > -# define NR_IRQ_VECTORS NR_IRQS
> > +/*
> > + * For Summit or generic (i.e. installer) kernels, we have lots of I/O
> > APICs, + * even with uni-proc kernels, so use a big array.
> > + */
> > +# if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
> > +# define NR_IRQ_VECTORS 1024
> >  # else
> >  # define NR_IRQ_VECTORS (32 * NR_CPUS)
> >  # endif

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
