Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVBOKsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVBOKsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 05:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVBOKsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 05:48:32 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20582
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261672AbVBOKsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 05:48:30 -0500
Date: Tue, 15 Feb 2005 11:48:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20050215104827.GY13712@opteron.random>
References: <20041028192104.GA3454@dualathlon.random> <20041105080716.GL8229@dualathlon.random> <20041105083102.GD16992@wotan.suse.de> <20041105084900.GN8229@dualathlon.random> <20050214231554.GQ13712@opteron.random> <20050215103915.GB2623@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215103915.GB2623@wotan.suse.de>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 11:39:15AM +0100, Andi Kleen wrote:
> On Tue, Feb 15, 2005 at 12:15:54AM +0100, Andrea Arcangeli wrote:
> > Hello,
> > 
> > the fix for this bug in 2.6.11-rc3 for this bug is wrong, I thought I
> 
> Can you describe what exactly is wrong? 

the wrong thing is that if I change the size of the guard page in
vmalloc.c, the arch code will break. the guard page is a debugging knob,
people may want to remove it someday to save virtual address space, and
they shouldn't be required to look after N architectures.

Plus people will keep forgetting that p->size has the guard page
included if you don't fix it the right way, x86-64 and x86 have been
corrupting the pageattr of the next physical pages because of that for a
long time.

Plus if you applied the best fix in vmalloc.c, you wouldn't even need to
touch x86 and x86-64 arch dependent code, you could call
change_page_attr on p->size without having to do -PAGE_SIZE.

At least you should define a VMALLOC_GUARD_PAGE_SIZE, or something,
the hardcoding of p->size-PAGE_SIZE looks wrong to me.
