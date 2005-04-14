Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVDNW30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVDNW30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVDNW30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:29:26 -0400
Received: from waste.org ([216.27.176.166]:63659 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261584AbVDNW26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:28:58 -0400
Date: Thu, 14 Apr 2005 15:27:40 -0700
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Stefan Seyfried <seife@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>,
       Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414222740.GP3174@waste.org>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl> <20050414171127.GL3174@waste.org> <425EC41A.4020307@suse.de> <20050414195352.GM3174@waste.org> <20050414201812.GB2801@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414201812.GB2801@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 10:18:12PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > So we would need to zero out the suspend image in swap to prevent the
> > > retrieval of this data from the running machine (imagine a
> > > remote-root-hole).
> > >
> > > Zeroing out the suspend image means "write lots of megabytes to the
> > > disk" which takes a lot of time.
> > 
> > Zero only the mlocked regions. This should take essentially no time at
> > all. Swsusp knows which these are because they have to be mlocked
> 
> I believe this is tricky to implement. You are free to produce patch,
> and if that patch is nicer/simpler than Anreas's code, I may consider
> it.

If I understand swsusp correctly, we can simply set a bit in the pbe
struct to indicate that it's a locked page. 

This can be done by walking the vma list attached to the page's
address space with vma_prio_tree_foreach() and checking the
vma->vm_flags with VM_LOCKED. Analogous to what the swapout code does.

We can either do this in data_write() or preferably higher
(copy_data?) when we have the pfn handy. The lock bit can be stashed
in bit 0 of pbe->address, among other places. Then in data_read, we
check the bit and zero the source.

As I'm not about to actually use swsusp any time soon, someone else is
invited to implement the above. Should take about 10-20 lines.

-- 
Mathematics is the supreme nostalgia of our time.
