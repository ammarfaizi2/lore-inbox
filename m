Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbUKJCKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUKJCKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 21:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUKJCKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 21:10:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18192 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261852AbUKJCKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 21:10:23 -0500
Date: Wed, 10 Nov 2004 03:09:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kconfig/build question..
Message-ID: <20041110020951.GE4089@stusta.de>
References: <Pine.LNX.4.58.0411100110170.1637@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411100110170.1637@skynet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 01:16:10AM +0000, Dave Airlie wrote:
> 
> I've come across something that I'm not sure Kconfig can do but I'll
> explain what I need and see what others can come up with...
> 
> The DRM has a weak dependency on AGP, it does not require AGP for all
> situations but can use it in most...
> 
> So what I want to do and what I think Kbuild can't do is:
> 
> if CONFIG_AGP=n then CONFIG_DRM can be n,m,y
> if CONFIG_AGP=m then CONFIG_DRM can be m but not y
> if CONFIG_AGP=y then CONFIG_DRM can be m,y
>...

The second case is bad because enabling a module shouldn't change the 
static parts of the kernel [1].

Let me suggest a slightly different solution:

I assume a "weak dependency" dependency means you can enable some AGP 
specific code in the DRM code?

config DRM_AGP
	bool
	depends on ((DRM = "m" && AGP) || (DRM = "y" && AGP = "y"))
	default y

In the DRM code, you #ifdef CONFIG_DRM_AGP the AGP specific code.

This way, CONFIG_AGP=m and CONFIG_DRM=y is a legal configuration but 
doesn't enable the AGP specific code in the DRM code.

> Dave.

cu
Adrian

[1] yes, this isn't always true in the current kernel

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

