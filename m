Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbUBFUAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbUBFUAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:00:44 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:37035 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265602AbUBFUAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:00:41 -0500
Date: Fri, 06 Feb 2004 11:59:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linus Torvalds <torvalds@osdl.org>, Keith Mannthey <kmannth@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andi Kleen <ak@muc.de>
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm	subsystem	involving X  (fwd)
Message-ID: <218650000.1076097590@flay>
In-Reply-To: <1076088169.29478.2928.camel@nighthawk>
References: <51080000.1075936626@flay> <Pine.LNX.4.58.0402041539470.2086@home.osdl.org><60330000.1075939958@flay> <64260000.1075941399@flay><Pine.LNX.4.58.0402041639420.2086@home.osdl.org> <20040204165620.3d608798.akpm@osdl.org> <Pine.LNX.4.58.0402041719300.2086@home.osdl.org> <1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com> <Pine.LNX.4.58.0402041800320.2086@home.osdl.org> <98220000.1076051821@[10.10.2.4]> <1076061476.27855.1144.camel@nighthawk> <5450000.1076082574@[10.10.2.4]> <1076088169.29478.2928.camel@nighthawk>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, February 06, 2004 09:22:49 -0800 Dave Hansen <haveblue@us.ibm.com> wrote:

> On Fri, 2004-02-06 at 07:49, Martin J. Bligh wrote:
>> >> +#ifdef CONFIG_NUMA
>> >> +	#ifdef CONFIG_X86_NUMAQ
>> >> +		#include <asm/numaq.h>
>> >> +	#else	/* summit or generic arch */
>> >> +		#include <asm/srat.h>
>> >> +	#endif
>> >> +#else /* !CONFIG_NUMA */
>> >> +	#define get_memcfg_numa get_memcfg_numa_flat
>> >> +	#define get_zholes_size(n) (0)
>> >> +#endif /* CONFIG_NUMA */
>> > 
>> > We ran into a bug with #ifdefs like this before.  It was fixed in some
>> > of the code that you're trying to remove.
>> 
>> What bug?
> 
> With a regular PC config, plus CONFIG_NUMA turned on:

Ah ... that's the problem. That's not a valid config - the correct way
to do that is with generic arch, not the PC one. Somehow we ended up
leaving that as allowable ... I think that was just a communiciation
breakdown somewhere between you, Andi, and myself (or quite possibly
between myself and myself ;-)).

So ... I still think my original patch is correct (there's some stylistic
stuff we could debate, but it's not a functional problem). Here's an
additional patch that stops people from turning on NUMA for the PC
subarch, which it wasn't designed to work with.

Thanks,

M.

-------------------------------------------------------------

Disallow NUMA on the i386 PC subarch (it doesn't work, nor was it intended to).

diff -purN -X /home/mbligh/.diff.exclude pfn_to_nid/arch/i386/Kconfig pc_numa/arch/i386/Kconfig
--- pfn_to_nid/arch/i386/Kconfig	2004-02-04 16:23:49.000000000 -0800
+++ pc_numa/arch/i386/Kconfig	2004-02-06 11:16:19.000000000 -0800
@@ -701,7 +701,7 @@ config X86_PAE
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation Support"
-	depends on SMP && HIGHMEM64G && (X86_PC || X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI && !ACPI_HT_ONLY))
+	depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI && !ACPI_HT_ONLY))
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT)
 

