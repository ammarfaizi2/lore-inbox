Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTEIQiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTEIQiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:38:46 -0400
Received: from mrt-aod.iram.es ([150.214.224.146]:46094 "EHLO mrt-lx16.iram.es")
	by vger.kernel.org with ESMTP id S263328AbTEIQil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:38:41 -0400
Date: Fri, 9 May 2003 16:50:51 +0000
From: paubert <paubert@iram.es>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andi Kleen <ak@suse.de>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] Mask mxcsr according to cpu features.
Message-ID: <20030509165051.A31465@mrt-lx16.iram.es>
References: <20030509004200.A22795@mrt-lx16.iram.es> <3EBB4B60.4080905@wanadoo.fr> <20030509104843.A16311@mrt-lx16.iram.es> <3EBBD861.5070404@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBBD861.5070404@wanadoo.fr>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 04:33:37PM +0000, Philippe Elie wrote:
> paubert wrote:
> >On Fri, May 09, 2003 at 06:32:00AM +0000, Philippe Elie wrote:
> >
> 
> 
> >>>+/* mxcsr bits 31-16 must be zero for security reasons,
> >>>+ * bit 6 depends on cpu features.
> >>>+ */
> >>>+#define MXCSR_MASK (cpu_has_sse2 ? 0xffff : 0xffbf)
> >>>+
> >>>+
> >>
> >>I don't think daz bit depend on sse2, it's a separate features
> >
> >
> >The doc I have state in several places:
> >"The denormals-are-zeros mode was introduced in the Pentium 4 processor 
> >with the SSE2 extensions."
> >
> >Maybe I should download a newer doc from Intel. The one I have states
> >that DAZ is associated with sse2, and does not speak at _all_ of the 
> >MXCSR_MASK field (I have seen it in my x86_64 doc though).
> 
> the doc is not very clear, I see this in 11.6.3
> 
> "The denormal-are-zeo flag in MXCSR was introduced in later Pentium
> 4 processor and in the Intel Xeon processor"

Indeed, I have downloaded fresher docs and I have found the following:
"In earlier IA-32 processors and in some models of the Pentium 4
processor, this flag (bit 6) is reserved." (10.2.2)

Of course other sentences would imply that DAZ is associated
with SSE2 capability, but all Pentium 4 have SSE2, I believe.

Well, what a mess for a single bit! 

> Not for intel at least since they advocate to use the mask as
> a "is this feature present" and use mask 0xFFBF if mask == 0
> and since this bits was required to be zero I think it's safe.

AMD says more or less the same.

> The only problem we can get is an old processor which write non
> zero but random bits in the 16 upper bits.

I don't believe that there is any, but that maybe some which don't
write anything, hence the requirement for clearing the area in the
DAZ detection algorithm.

> 
> 
> >It's simply a matter of rewriting the MXCSR_MASK macro, but to avoid
> >a conditional, I'd rather have a global mxcsr_mask variable somewhere
> >with the cpu feature flags. 
> 
> 
> my documentation says to fxsave and get the features mask from
> the mxcsr mask but to fall back to 0xffbf if mask == 0, quoting
> docs 11.6.6:
> 
> 1 setup a fxsave area
> 2 clear this area
> 3 fxsave in this area
> 4 if mxcsr == 0 use mask 0xffbf else use mxcsr mask

Too expensive unless the mask is computed at boot time once and for 
all (thrashing half a kB  for a single 32 bit constant, sigh). I did 
not want to touch too many files in my patch, but it seems unavoidable. 

Now a last question, are there SMP systems in which one processor
supports DAZ and the other does not, just to complicate matters a
little more?

	Regards,
	Gabriel
