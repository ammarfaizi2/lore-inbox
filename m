Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWIOAD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWIOAD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 20:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWIOAD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 20:03:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:39300 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932159AbWIOADy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 20:03:54 -0400
Subject: Re: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in
	get_memcfg_from_srat
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Vivek goyal <vgoyal@in.ibm.com>
Cc: dave hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, andrew <akpm@osdl.org>
In-Reply-To: <20060914235910.GG25044@in.ibm.com>
References: <1158113895.9562.13.camel@keithlap>
	 <1158269696.15745.5.camel@keithlap>
	 <1158271274.24414.6.camel@localhost.localdomain>
	 <1158273830.15745.14.camel@keithlap> <20060914230442.GE25044@in.ibm.com>
	 <1158276093.24414.14.camel@localhost.localdomain>
	 <1158277414.15745.26.camel@keithlap>  <20060914235910.GG25044@in.ibm.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 14 Sep 2006 17:03:50 -0700
Message-Id: <1158278630.15745.30.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 19:59 -0400, Vivek Goyal wrote:
> On Thu, Sep 14, 2006 at 04:43:33PM -0700, keith mannthey wrote:
> > On Thu, 2006-09-14 at 16:21 -0700, Dave Hansen wrote:
> > > On Thu, 2006-09-14 at 19:04 -0400, Vivek Goyal wrote:
> > > > I think I know what is going on wrong here. boot_ioremap() is assuming 
> > > > that only first 8MB of physical memory is being mapped and while
> > > > calculating the index into page table (boot_pte_index) we will truncate
> > > > any higher address bits. 
> > > 
> > > Vivek, are those pte pages still all contiguous?
> > > 
> > > Yeah, that's probably it.  Keith, I'm trying to think of reasons why we
> > > need the mask here:
> > > 
> > > #define boot_pte_index(address) \
> > >              (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
> > > 
> > > and I can't think of any other than just masking out the top of the
> > > virtual address.  You could do this a bunch of other ways, like __pa().
> > > 
> > > This might just work:
> > > 
> > > static unsigned long boot_pte_index(unsigned long vaddr)
> > > {
> > > 	return __pa(vaddr) >> PAGE_SHIFT;
> > > }
> > With 
> > CONFIG_KEXEC=y
> > CONFIG_CRASH_DUMP=y
> > CONFIG_PHYSICAL_START=0x1000000
> > and the above __pa(vaddr) >> PAGE_SHIFT changed things worked for me but
> > I am still confused as to why the pte we set is c1686f6c and we flush
> > and return c13db000. 
> 
> I think c13db000 is the virtual address of symbol boot_ioremap_space,
> and we are remapping this virtual address to physical addres eff9c063,
> that's why we flush tlb for this virtual address.
> 
> I guess c1686f6c is virtual address of PTE (somewhere between pg0 to pg5).
> It is independent of actual virtual address (boot_ioremap_space) being
> remapped.  

Yup thanks.

Dave do you want to send out a patch?

Thanks,
  Keith 


