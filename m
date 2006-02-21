Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWBUVkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWBUVkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWBUVkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:40:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53453 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964830AbWBUVkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:40:21 -0500
Date: Wed, 22 Feb 2006 08:39:47 +1100
From: Nathan Scott <nathans@sgi.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Jeremy Higdon <jeremy@sgi.com>, christoph <hch@lst.de>, mcao@us.ibm.com,
       akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and mpage_readpages()
Message-ID: <20060222083947.A9508366@wobbly.melbourne.sgi.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <20060221085953.H9484650@wobbly.melbourne.sgi.com> <20060221024108.GA251337@sgi.com> <1140537834.22756.42.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1140537834.22756.42.camel@dyn9047017100.beaverton.ibm.com>; from pbadari@us.ibm.com on Tue, Feb 21, 2006 at 08:03:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 08:03:54AM -0800, Badari Pulavarty wrote:
> ...
> Thinking more about it, currently (without my patches) only DIO
> code can request for large chunks of mapping through get_blocks().
> Since b_size is only u32, you can only map 4GB max. Isn't it ?
> With my patches, now mpage_readpages() also can request large
> chunks. (through readahead). So, my patches are not adding any
> extra limitation. Its carrying the same existing limitation. 

The DIO get_blocks is super-freaky at the moment, in that it passes
in an unsigned long max_blocks (units of blocks) but it expects the
filesystem to fill in a u32 b_size (in bytes).  This does at least
give the filesystem the hint that this was a monster write and it
gets the chance to allocate contiguously, but that was probably
unintentional, who knows?  I guess that subtlety would be dropped
with this change if b_size isn't made a 64 bit entity.

> In order to handle larger chunks of disk mapping, changing b_size 
> to u64 is required and we should request for it irrespective of my
> patches.

*shrug*... its all very closely inter-related, I'd keep it together.
I'd also thought that size_t was the right type here, not u64?  32
bit platforms aren't capable of submitting IOs this large, so they
needn't be doing any 64 bit manipulation here, no?

cheers.

-- 
Nathan
