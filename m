Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUK2Qkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUK2Qkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbUK2Qkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:40:53 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:9130 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261756AbUK2Qkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:40:43 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 29 Nov 2004 17:22:42 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Dave Jones <davej@redhat.com>, pawfen@wp.pl, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: MTRR vesafb and wrong X performance
Message-ID: <20041129162242.GA25668@bytesex>
References: <1101338139.1780.9.camel@PC3.dom.pl> <20041124171805.0586a5a1.akpm@osdl.org> <1101419803.1764.23.camel@PC3.dom.pl> <87is7ogb93.fsf@bytesex.org> <20041129154006.GB3898@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129154006.GB3898@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 10:40:07AM -0500, Dave Jones wrote:
> On Mon, Nov 29, 2004 at 12:12:08PM +0100, Gerd Knorr wrote:
>  > > > Please send the full dmesg output and the contents of /proc/mtrr for
>  > > > 2.6.10-rc2.
>  > > reg02: base=0xe3000000 (3632MB), size=   4MB: write-combining, count=1
>  > > vesafb: framebuffer at 0xe3000000, mapped to 0xcc880000, using 1875k,
>  > > total 4096k
>  > 
>  > The BIOS reports 4MB video memory, and vesafb adds an mtrr entry for
>  > that.  Looks ok, with the exception that the reported 4MB are probably
>  > not correct, otherwise the X-Server wouldn't complain.
> 
> vesafb is assuming that the memory used in the current screen mode
> xres*yres*depth rounded up to nearest power of 2, is the amount of
> ram the card has, which is not just wrong, it's dumb.

It used to do that, but doesn't any more in 2.6.10-rc2.  Check the
current code please.

vesafb now distinguishes between the amount of memory needed for the
video mode (that is used for ioremap() to avoid wasting address space,
reported as "using" in the kernel message quoted above) and the total
amount of memory (used for ressource allocation and mtrr records,
reported as "total" in the message above).

>  > vesafb in 2.6.10-rc2 has a option to overwrite the BIOS-reported value
>  > (vtotal=n, with n in megabytes), that should fix it.
> 
> which is an ugly hack for the above problem imo.

The problem isn't vesafb, the problem is the BIOS.

On my machines it works perfectly fine.  One has a radeon with 64MB, the
other a good old matrox with 8MB video memory.  On both machines current
kernels correctly create mtrr records for the complete framebuffer, not
just the small piece actually used by vesafb for the fb console.

> vesafb:nomtrr also fixes the problem, and leaves X free
> to set things up correctly in my experience.

Yes, but that also results in a slow framebuffer console.

> If vesafb can't get it right, maybe it shouldn't be
> attempted to do it in the half-assed way it currently does.

Well, 2.6.10-rc1 + newer should get it right now.  We can't do much
about BIOS bugs through, other than maybe disabling mtrr by default
if too many machines are affected.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
