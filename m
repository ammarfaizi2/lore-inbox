Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTEFK6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 06:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTEFK6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 06:58:12 -0400
Received: from ltgp.iram.es ([150.214.224.138]:15745 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S262530AbTEFK6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 06:58:11 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 6 May 2003 13:06:44 +0200
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Dave Hansen <haveblue@us.ibm.com>,
       Bill Hartner <bhartner@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Bug 619 - sched_best_cpu does not pick best cpu (2/2)
Message-ID: <20030506110644.GA15131@iram.es>
References: <3EB70EEC.9040004@us.ibm.com> <3EB70FC2.1010903@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB70FC2.1010903@us.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 06:28:34PM -0700, Matthew Dobson wrote:
> This patch is in regard to bugme.osdl.org bug 619, link here:
> 
> http://bugme.osdl.org/show_bug.cgi?id=619
> 
> This is the second of two patches to fix this bug.  This patch fills in 
> include/linux/topology.h (created in the last patch) with a couple 
> #defines.  The patch also creates a generic_hweight64() in 
> include/linux/bitops.h, which we've been lacking for a while.  It then 
> uses these new macros in sched.c to ensure that if a node has no CPUs, 
> it is not used in scheduling decisions.
> 
> [mcd@arrakis src]$ diffstat ~/patches/node_online.patch
>  include/linux/bitops.h   |   27 +++++++++++++++++++++++++++
>  include/linux/topology.h |    7 +++++++
>  kernel/sched.c           |    2 +-
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> Cheers!
> 
> -Matt

> diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-add_linux_topo/include/linux/bitops.h linux-2.5.69-node_online_fix/include/linux/bitops.h
> --- linux-2.5.69-add_linux_topo/include/linux/bitops.h	Sun May  4 16:53:42 2003
> +++ linux-2.5.69-node_online_fix/include/linux/bitops.h	Mon May  5 18:00:00 2003
> @@ -107,6 +107,33 @@
>          return (res & 0x0F) + ((res >> 4) & 0x0F);
>  }
>  
> +#if (BITS_PER_LONG == 64)
> +
> +static inline unsigned int generic_hweight64(unsigned int w)
> +{
> +        unsigned int res = (w & 0x5555555555555555) + ((w >> 1) & 0x5555555555555555);

Ignoring the fact that the types are wrong for 64 bit values, you can save
one masking (in all generic_hweight functions in fact) by using the
following expression for the first line:

	uxx res = w - ((w>>1) & 0x55...55);

where xx is 8, 16, 32, or 64 and the right number of 5s.
That's an old trick but I can't remember the reference nor
where I found the reference to it, sorry.

	Gabriel
