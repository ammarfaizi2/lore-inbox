Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUIXDj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUIXDj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUIXDfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:35:43 -0400
Received: from holomorphy.com ([207.189.100.168]:31196 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267666AbUIXDee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 23:34:34 -0400
Date: Thu, 23 Sep 2004 20:29:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Fusco <fusco_john@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [vm 0/4] replace remap_page_range() with remap_pfn_range()
Message-ID: <20040924032928.GR9106@holomorphy.com>
References: <41535AAE.6090700@yahoo.com> <20040924021735.GL9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924021735.GL9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 06:22:22PM -0500, John Fusco wrote:
>> Everything worked great until we decided that we needed to install 6GB 
>> in this system.  The problem is that remap_page_range() uses an unsigned 
>> long as the parameter for a physical address.  On IA32, an unsigned long 
>> is 32-bits, but the IA32 is capable of addressing well over 4GB of RAM.  
>> So physical addresses on IA32 must be larger than 32 bits.

On Thu, Sep 23, 2004 at 07:17:35PM -0700, William Lee Irwin III wrote:
> Do these patches work for you? Compiletested on sparc64.

Long-format changelog:

Resolve physical address overflow issue in the remap_page_range() API
by replacing it with remap_pfn_range(), which accepts its physical
address argument as a pfn, hence allowing the use of a single-precision
physical address argument without the risk of overflow at the API
boundary. The above issue has hobbled support for various 32-bit
architectures, including some embedded systems (ppc440 IIRC), caused
persistent portability issues for sound drivers for legacy systems
(sparc32; unfortunately this patch alone does not fully resolve those),
and according to John Fusco's reports, made drivers for some PCI-X
hardware infeasible to port to recent ia32 PAE enterprise systems. With
this patch series applied, physical address overflows on 32-bit systems
caused directly by remap_page_range() are gone forever, and ca. 100LOC
of cut-and-waste driver code are swept out of existence alongside them.


-- wli

P.S.: The existing solution to the sparc32 issue was to pass a double
	precision representation of the physical address as 2 single-
	precision arguments in an API (io_remap_page_range()) whose
	argument corresponding to those two was a single single-
	precision argument on most/all other architectures. The
	sparc32-specific issue requires more work beyond these patches
	to rectify. The most apparent consequence of the API skew is
	that drivers don't compile on sparc32 when they use
	io_remap_page_range() due to passing insufficient arguments,
	or vice-versa for drivers originally written for sparc32.
