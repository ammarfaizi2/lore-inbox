Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267328AbSKPSXI>; Sat, 16 Nov 2002 13:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbSKPSXI>; Sat, 16 Nov 2002 13:23:08 -0500
Received: from ns.suse.de ([213.95.15.193]:59409 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267328AbSKPSXH>;
	Sat, 16 Nov 2002 13:23:07 -0500
Date: Sat, 16 Nov 2002 19:30:03 +0100
From: Andi Kleen <ak@suse.de>
To: Akira Tsukamoto <at541@columbia.edu>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Hirokazu Takahashi <taka@valinux.co.jp>, Andrew Morton <akpm@digeo.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [CFT][PATCH]  2.5.47 Athlon/Druon, much faster copy_user function
Message-ID: <20021116193003.A11205@wotan.suse.de>
References: <20021115235234.8DE4.AT541@columbia.edu> <20021116115652.A26519@wotan.suse.de> <20021116131403.9FB5.AT541@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021116131403.9FB5.AT541@columbia.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 01:22:51PM -0500, Akira Tsukamoto wrote:
> On Sat, 16 Nov 2002 11:56:52 +0100
> Andi Kleen <ak@suse.de> mentioned:
> > 
> > You don't seem to save/restore the FPU state, so it will be likely 
> > corrupted after your copy runs.
> 
> This is the main question for me that I was wondering for all week. 
> My first version was using fsave and frstore, so 
> just changing three lines will accomplish this.
> Is it all I need?  Any thing elase needed to consider using fpu register?

You are currently corrupting the user's FPU state.

The proper way to save it is to use kernel_fpu_begin()

> > 
> > Also I'm pretty sure that using movntq (= forcing destination out of 
> > cache) is not a good strategy for generic copy_from_user(). It may 
> > be a win for the copies in write ( user space -> page cache ),
> 
> Yes, that why I included postfetch in the code because movntq does not leave 
> them in the L2 cache.

That looks rather wasteful - first force it out and then trying to get it in 
again. I have my doubts on it being a good strategy for speed.

> > but 
> > will hurt for all the ioctls and other things that actually need the
> > data in cache afterwards. I am afraid it is not enough to do micro benchmarks
> > here.
> 
> check above?

Use special function calls for them, don't put it into generic 
copy_*_user

Also you should really check for small copy and not use the FPU based
copy for them. Best is probably to use a relatively simply copy_*_user
(no FPU tricks, just an unrolled integer core) and change the VFS
and the file systems to call a special function from write(), but only
when the write is big.

-Andi
