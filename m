Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbTJURpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTJURpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:45:04 -0400
Received: from zok.SGI.COM ([204.94.215.101]:2238 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263227AbTJURo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:44:59 -0400
Date: Tue, 21 Oct 2003 10:44:02 -0700
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] you have how many nodes??
Message-ID: <20031021174402.GA5692@sgi.com>
Mail-Followup-To: Matthew Dobson <colpatch@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay> <20030911000303.GA20329@sgi.com> <3F6659DF.1090508@us.ibm.com> <3F6B7CCA.5040702@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6B7CCA.5040702@us.ibm.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried -test8-mm1 on a 256p/128 node machine and these changes
almost work.  I still needed to change ZONE_SHIFT from BITS_PER_LONG - 8
to BITS_PER_LONG - 10 because of the way set_page_zone() is called from
memmap_init_zone() (set_page_zone(page, nid * MAX_NR_ZONES + zone);).
So shouldn't ZONE_SHIFT be BITS_PER_LONG -  NODES_SHIFT or something?

Jesse

On Fri, Sep 19, 2003 at 03:01:46PM -0700, Matthew Dobson wrote:
> Andrew,
> 	Here's a small update to the numnodes fix that went into -mm3.  The 
> biggest changes are:
> 	1) move the actual NODES_SHIFT and MAX_NUMNODES definitions into 
> linux/numa.h and include this in linux/mmzone.h, instead of being 
> directly in linux/mmzone.h.  This allows other files to include *just* 
> the NUMNODES stuff w/out grabbing all of mmzone.h.
> 	2) pull NODE_SHIFT out of linux/mm.h.  This isn't used anywhere in 
> 	the kernel, and it will only get confused with NODES_SHIFT.
> 	3) Fix the IA64 patch.  The original patch I had sent out hadn't 
> 	been tested on IA64.  It was mostly right, but there were circular 
> dependencies.  All better now, and acked by Jesse.
> 	4) In linux/mmzone.h, insert code to define MAX_NODES_SHIFT based on 
> the size of unsigned long.  For 64-bit arches, we can have a much larger 
> value.  This allows IA64 to have 100's or 1000's of nodes. 
> MAX_NODES_SHIFT is defined as 10 (ie: 1024 nodes) for 64-bit for now, 
> although it could likely be much larger.  For 32-bit it is 6 (ie: 64 nodes).
> 	5) Small cleanup in include/asm-arm/memory.h.  Mostly the result of 
> 	the new linux/numa.h file.  Much cleaner and more readable now.
> 
> Russell, if you get a chance, I'd really appreciate a sanity check on 
> the arm code.  It really hasn't been tested, but the changes are pretty 
> small.
