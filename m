Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWINXnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWINXnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWINXnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:43:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:3747 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932138AbWINXng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:43:36 -0400
Subject: Re: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in
	get_memcfg_from_srat
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: dave hansen <haveblue@us.ibm.com>
Cc: Vivek goyal <vgoyal@in.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, andrew <akpm@osdl.org>
In-Reply-To: <1158276093.24414.14.camel@localhost.localdomain>
References: <1158113895.9562.13.camel@keithlap>
	 <1158269696.15745.5.camel@keithlap>
	 <1158271274.24414.6.camel@localhost.localdomain>
	 <1158273830.15745.14.camel@keithlap>  <20060914230442.GE25044@in.ibm.com>
	 <1158276093.24414.14.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 14 Sep 2006 16:43:33 -0700
Message-Id: <1158277414.15745.26.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 16:21 -0700, Dave Hansen wrote:
> On Thu, 2006-09-14 at 19:04 -0400, Vivek Goyal wrote:
> > I think I know what is going on wrong here. boot_ioremap() is assuming 
> > that only first 8MB of physical memory is being mapped and while
> > calculating the index into page table (boot_pte_index) we will truncate
> > any higher address bits. 
> 
> Vivek, are those pte pages still all contiguous?
> 
> Yeah, that's probably it.  Keith, I'm trying to think of reasons why we
> need the mask here:
> 
> #define boot_pte_index(address) \
>              (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
> 
> and I can't think of any other than just masking out the top of the
> virtual address.  You could do this a bunch of other ways, like __pa().
> 
> This might just work:
> 
> static unsigned long boot_pte_index(unsigned long vaddr)
> {
> 	return __pa(vaddr) >> PAGE_SHIFT;
> }
With 
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
and the above __pa(vaddr) >> PAGE_SHIFT changed things worked for me but
I am still confused as to why the pte we set is c1686f6c and we flush
and return c13db000. 

get_memcfg_from_srat: assigning address to rsdp fdfc0
RSD PTR  v0 [IBM   ]
rsdp->rsdt_address eff9c2c0
boot_ioremap phys_addr = eff9c2c0 long = 44
__boot_ioremap phys_addr = eff9c000 pages = 1 source c13db000
setting pte  c1686f6c to eff9c063
just flushed c13db000
boot_ioremap and I return c13db2c0
rsdt = c13db2c0 header is RSDT4
Begin SRAT table scan....

thanks,
  Keith 


