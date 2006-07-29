Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWG2ULS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWG2ULS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 16:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWG2ULS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 16:11:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:45496 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751145AbWG2ULR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 16:11:17 -0400
Subject: Re: [discuss] [Patch] 4/5 in support of hot-add memory x86_64 fix
	kernel mapping code
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: discuss <discuss@x86-64.org>, lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, andrew <akpm@osdl.org>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>,
       dave hansen <haveblue@us.ibm.com>, konrad <darnok@us.ibm.com>
In-Reply-To: <200607291832.09995.ak@suse.de>
References: <1154141570.5874.148.camel@keithlap>
	 <200607291832.09995.ak@suse.de>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Sat, 29 Jul 2006 13:11:13 -0700
Message-Id: <1154203873.7900.70.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 18:32 +0200, Andi Kleen wrote:
> On Saturday 29 July 2006 04:52, keith mannthey wrote:
> > Hello All,
> >
> >   phys_pud_init is broken when using it at runtime with some offsets.
> > It currently only maps one pud entry worth of pages while trampling any
> > mappings that may have existed on the pmd_page :(
> 
> To print x86-64 ptes you need a %016lx (or just %lx) 

Thanks. 
> it would be cleaner to recompute pmd inside the loop based on i
> and use a standard for() 

sure I can do away with the pmd++ pud++ in the for loops. 
> 
> It is unclear why you hardcode 0 as address in phys_pmd_update
> when a real address is passed in

When the pud is already set there a 2 options.  

1. You need to initialize pmds at the start of the pmd_page. 
2. You need to initialize pmds starting at some offset of the pmd_page.

When calling phys_pmd_init you need to pass it the start of the pmd_page
not some random pmd with in the page.  
pmd = alloc_low_page(&map, &pmd_phys); 
always gives us the start of the pmd_page.  I keep this idea for the
update path as well. 
pmd_offset(pud,0) does just this. Maybe there is a better macro to use?

Things could be different is terms of flexibility of what you pass in
(more changes are involved) but this set of changes seemed to be min-
tampering of the current code. 

Also in general is there some reason kernel mapping code is arch
specific?  This all seems to be pretty generic.

Thanks,
  Keith 

