Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWINXVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWINXVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWINXVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:21:42 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21664 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751007AbWINXVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:21:41 -0400
Subject: Re: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in
	get_memcfg_from_srat
From: Dave Hansen <haveblue@us.ibm.com>
To: vgoyal@in.ibm.com
Cc: keith mannthey <kmannth@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, andrew <akpm@osdl.org>
In-Reply-To: <20060914230442.GE25044@in.ibm.com>
References: <1158113895.9562.13.camel@keithlap>
	 <1158269696.15745.5.camel@keithlap>
	 <1158271274.24414.6.camel@localhost.localdomain>
	 <1158273830.15745.14.camel@keithlap>  <20060914230442.GE25044@in.ibm.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 16:21:33 -0700
Message-Id: <1158276093.24414.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 19:04 -0400, Vivek Goyal wrote:
> I think I know what is going on wrong here. boot_ioremap() is assuming 
> that only first 8MB of physical memory is being mapped and while
> calculating the index into page table (boot_pte_index) we will truncate
> any higher address bits. 

Vivek, are those pte pages still all contiguous?

Yeah, that's probably it.  Keith, I'm trying to think of reasons why we
need the mask here:

#define boot_pte_index(address) \
             (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))

and I can't think of any other than just masking out the top of the
virtual address.  You could do this a bunch of other ways, like __pa().

This might just work:

static unsigned long boot_pte_index(unsigned long vaddr)
{
	return __pa(vaddr) >> PAGE_SHIFT;
}

-- Dave

