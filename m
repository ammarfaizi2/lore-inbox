Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265713AbSKTJiC>; Wed, 20 Nov 2002 04:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbSKTJiC>; Wed, 20 Nov 2002 04:38:02 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:42432 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265713AbSKTJiA>;
	Wed, 20 Nov 2002 04:38:00 -0500
Date: Wed, 20 Nov 2002 15:14:56 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andy Pfiffer <andyp@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <Martin.Bligh@provisioning.fibertel.com.ar>,
       torvalds@transmeta.com
Subject: Re: Kexec for v2.5.47-bk2
Message-ID: <20021120151456.A2556@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com> <m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp> <m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp> <m1adkda9dm.fsf_-_@frodo.biederman.org> <20021115145454.B2503@in.ibm.com> <20021115113707.A3749@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115113707.A3749@almesberger.net>; from wa@almesberger.net on Fri, Nov 15, 2002 at 11:37:07AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 11:37:07AM -0300, Werner Almesberger wrote:
> Suparna Bhattacharya wrote:
> > What would be best way to pass a parameter or address from the
> > current kernel to kernel being booted (e.g log buffer address
> > or crash dump buffer etc) ?
> 
> At the moment, perhaps the initrd mechanism might be a useful
> interface for this. You'd just leave some space either at the
> beginning or at the end of the real initrd (if there's one),
> and put your data there.
> 
> Afterwards, you can extract it either from the kernel, or even
> from user space through /dev/initrd (with "noinitrd")
> 
> Advantages:
>  - fairly non-intrusive
>  - (almost ?) all platforms support this way of handling "some
>    object in memory"
>  - easy to play with from user space
> 
> Drawbacks:
>  - needs synchronization with existing uses of initrd
>  - a bit hackish
> 
> I'd expect that there will be eventually a number of things that
> get passed from old to new kernels (e.g. crash data, device scan
> results, etc.), so it may be useful to delay designing a "clean"
> interface (for this, I expect some TLV structure in the initrd
> area would make most sense) until more of those things have
> shown up.

Yes indeed. At the moment however I was just looking at something 
as simple as a single (or more) parameter to pass from an old 
kernel to the new one. That parameter could be a scalar value/
variable or denote the address of a control block, or something 
requiring more complicated interpretation like you mention.
If the parameter is a pointer to an address block right now the
code to put it in a place that doesn't get overwritten when the
new kernel loads is left as the responsibility of the caller.
Designing a generic and clean interface for that would require
more thought and is best delayed a bit till we understand all the
needs better. Mcore for example (as you probably know already)
passes a map of affected pages to the new kernel and during early 
bootmem initialization those pages (from the previous boot) are 
marked as reserved, instead of moving them to a contiguous memory 
area. Its just the start of the map (crash header) that's still 
passed in as a fixed location (rather its relative to the end of
the current image) and I was looking at a nice way to avoid that.

One way of course is to add a kernel parameter(s) and set this 
through user-space (after extracting it from the
kernel .. possibly via kmem) when loading the image (kexec tools
does all the work of filling up the parameter block). Probably
that's what was intended.

Eric, Is that correct ? BTW, did you have an option (or plan 
to add one) in kexec tools to use the current kernel's parameters 
and append additional options to it ?

Regards
Suparna

> 
> - Werner
> 
> -- 
>   _________________________________________________________________________
>  / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
> /_http://www.almesberger.net/____________________________________________/

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

