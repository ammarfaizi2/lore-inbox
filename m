Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbTFCBW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 21:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbTFCBW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 21:22:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41368 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264861AbTFCBW6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 21:22:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH][2.5] provisional 32-way x445 patches
Date: Mon, 2 Jun 2003 18:36:14 -0700
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
References: <200305232036.39297.jamesclv@us.ibm.com> <Pine.LNX.4.50.0305241433270.2267-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0305241659530.16144-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0305241659530.16144-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306021836.14227.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 May 2003 02:03 pm, Zwane Mwaikambo wrote:
> On Sat, 24 May 2003, Zwane Mwaikambo wrote:
> > Can't you just skip that one (-ENOSPC)? It would oops on 32way NUMAQ. Why
>
> crackpipe alert!! i didn't notice your s/int/u8/ change, regardless how
> are you handling irqs > 256? The code in 2.5.68 simply overwrites previous
> vector entries in your IDT when it runs out.
>
> 	Zwane

Back from holiday.

This kludge doesn't change any IDT behavior, so it is vulnerable to vector 
exhaustion too.  It just deals with large systems that have large I/O APICs.  
Since we are indexing irq_vectors by the sum of all available I/O APIC RTEs 
and not checking for overflow, we can get into trouble.

Some numbers:

* A 32-way x445 is made up of four 8-way chassis hooked together by 
scalability cables.

* Each Summit chassis has 2 I/O APICs with 50 RTEs per.  The BIOS guys are 
trying to help out by using some hardware to only use one I/O APIC for all 
but the boot chassis.

* Each RXE100 PCI expansion box contains one or two I/O APICs with 50 RTEs 
each.  Every chassis can have one RXE100.

Even without PCI expansion boxes, 5 * 50 == 250 which is > 224.  The kernel 
overflows irq_vectors and dies.

Since the value stuffed into irq_vectors is 0x31 to 0xF8, it easily fits into 
a byte.  As a quick kludge, I changed the type of irq_vectors and quadrupled 
the number.  With 896 elements in the array, the system survived and ran.

For a real fix, irq_vectors should be dynamically allocated.  But then, I 
should port the dynamic MAX_MP_BUSSES patch from 2.4 to 2.5 anyway....

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

