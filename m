Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVBKWV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVBKWV1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 17:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVBKWV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 17:21:27 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:59188 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S262377AbVBKWUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 17:20:22 -0500
Date: Fri, 11 Feb 2005 16:19:56 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Dave Jones <davej@redhat.com>, Nick Warne <nick@linicks.net>,
       linux-kernel@vger.kernel.org, tripperda@nvidia.com
Subject: Re: How to disable slow agpgart in kernel config?
Message-ID: <20050211221956.GO24747@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <200502111804.06899.nick@linicks.net> <20050211184821.GC15721@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211184821.GC15721@redhat.com>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 11 Feb 2005 22:20:14.0096 (UTC) FILETIME=[DB9B8900:01C51087]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 01:48:21PM -0500, davej@redhat.com wrote:
> On Fri, Feb 11, 2005 at 06:04:06PM +0000, Nick Warne wrote:
> 
>  > > > This surprises me, especially considering the in-kernel nvidia-agp driver
>  > > > was actually written by NVidia. Are there any agp error messages in
>  > > > your dmesg / X log ?
>  > 
>  > > With the nVidia own nv_agp it appears directly in all apps, very fast 
>  > > under GNOME 2.8.1. Why, I do not know. Also game (opengl) performance is 
>  > > faster with the nv_agp, that I haven't used the kernel agp for months, now.
>  > 
>  > This is interesting.  I always used agpgart without a second thought (2.4.29, 
>  > GeForce4 MX with Via KT133 chipset).
>  > 
>  > I just read through the nVidia readme file, and there is a comprehensive 
>  > section on what module to use for what chipset (and card).  It recommends 
>  > using the nVagp for my setup, so I just rebuilt excluding agpgart so I can 
>  > use the nVdia module.
>  > 
>  > I never had slowness as such in KDE or X apps, but playing quake2 openGL I 
>  > used to get a 'wave' type effect rippling down the screen occasionally.  A 
>  > quick test using the nVagp module to have fixed that...
> 
> Terrence, any ideas ?

I would agree with your assessment Dave, there's very little
difference betweeen the agp drivers. it's possible nvagp tweaks some
register values that agpgart doesn't, I'd have to look closer at both
to know. that might explain *modest* performance differences, but
certainly wouldn't explain the dramatic performance differences the
original poster described.

I wouldn't expect even falling back to pci dma would have this big of an
impact on 2d performance, but perhaps there's enough bus activity for this
to happen. Marcus, can you verify that you're actually using agpgart
in that situation? do you possibly have our XF86Config option set to
nvagp only? (with IOMMU compiled in or agpgart loaded, our driver
won't allow nvagp) you can verify whether agp is enabled with this
command when our driver is loaded and X is started up:

% cat /proc/drivers/nvidia/agp/status
Status:          Disabled

(hmm, turns out my own dev machine doesn't have agp enabled and 2d
performance isn't very noticeable)


>  > I just read through the nVidia readme file, and there is a comprehensive 
>  > section on what module to use for what chipset (and card).  It recommends 
>  > using the nVagp for my setup,

is that the "CONFIGURING AGP" appendix? I didn't think that we
recommended which agp driver to use. the intention was just to
document which chipsets are supported by nvagp and point out that
agpgart may/probably supports more chipsets. that section also 
documents some hardware 'issues' that we work around. we work around
these issues regardless of which agp driver is being used.


for this via kt133 issue, I looked through the agpgart and nvagp
initializations and didn't see anything much different. both
initialize and flush gart mappings the same way. both seem to allocate
memory the same way (nvagp uses __get_free_pages, which eventually
calls alloc_pages) with the GFP_KERNEL flag.  I'm not sure why there
would be much difference between the two.


> (It'd be really nice to get your PAT support in 2.6 sometime too btw).

I've been meaning to finish that up. the actual PAT support is pretty
simple; it's the protecting against cache aliasing that's a bit tricky
and involved. for our push buffers, we don't worry too much about the
cache aliasing, since change_page_attr() marks the kernel mapping
uncached, and there shouldn't be any other mappings to the memory.
mapping i/o regions like the framebuffer is a bit riskier, since it's
more likely someone else has a conflicting mapping to it, but the
damage of data corruption is much less fatal.

Thanks,
Terence

