Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUBFJ6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUBFJ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:58:23 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:10487 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265378AbUBFJ6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:58:17 -0500
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem
	involving X  (fwd)
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Keith Mannthey <kmannth@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <98220000.1076051821@[10.10.2.4]>
References: <51080000.1075936626@flay>
	 <Pine.LNX.4.58.0402041539470.2086@home.osdl.org><60330000.1075939958@flay>
	 <64260000.1075941399@flay><Pine.LNX.4.58.0402041639420.2086@home.osdl.org>
	 <20040204165620.3d608798.akpm@osdl.org>
	 <Pine.LNX.4.58.0402041719300.2086@home.osdl.org>
	 <1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com>
	 <Pine.LNX.4.58.0402041800320.2086@home.osdl.org>
	 <98220000.1076051821@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1076061476.27855.1144.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Feb 2004 01:57:56 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-05 at 23:17, Martin J. Bligh wrote:
> +#ifdef CONFIG_NUMA
> +	#ifdef CONFIG_X86_NUMAQ
> +		#include <asm/numaq.h>
> +	#else	/* summit or generic arch */
> +		#include <asm/srat.h>
> +	#endif
> +#else /* !CONFIG_NUMA */
> +	#define get_memcfg_numa get_memcfg_numa_flat
> +	#define get_zholes_size(n) (0)
> +#endif /* CONFIG_NUMA */

We ran into a bug with #ifdefs like this before.  It was fixed in some
of the code that you're trying to remove.

It's not safe to assume that NUMA && !NUMAQ means SUMMIT.  Remember the
linking errors we got when we turned CONFIG_NUMA on with the regular PC
config?  The generic arch wasn't a problem because it sets
CONFIG_X86_SUMMIT and compiles in the summit code, but the regular PC
code doesn't.  

Also, I don't think we need the #ifdef CONFIG_NUMA around the whole
block.  How about something like this?

#ifdef CONFIG_X86_NUMAQ
	#include <asm/numaq.h>
#elif CONFIG_X86_SUMMIT
	#include <asm/srat.h>
#else
	#define get_memcfg_numa get_memcfg_numa_flat
	#define get_zholes_size(n) (0)
#endif /* CONFIG_NUMA */


> +static inline int pfn_to_nid(unsigned long pfn)
> +{
> +#ifdef CONFIG_NUMA
> +	return(physnode_map[(pfn) / PAGES_PER_ELEMENT]);
> +#else
> +	return 0;
> +#endif
> +}

Looks like somebody pasted that in from a macro. "(pfn)" :)

--dave

