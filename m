Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVBGOss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVBGOss (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVBGOss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:48:48 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:2290 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261438AbVBGOpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:45:09 -0500
Message-ID: <42077EE0.2060505@nortel.com>
Date: Mon, 07 Feb 2005 08:44:48 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: question on symbol exports
References: <41FECA18.50609@nortelnetworks.com>	 <1107243398.4208.47.camel@laptopd505.fenrus.org>	 <41FFA21C.8060203@nortelnetworks.com>	 <1107273017.4208.132.camel@laptopd505.fenrus.org>	 <20050204203050.GA5889@dmt.cnet>  <4203D793.1040604@nortel.com> <1107595148.30302.5.camel@gaston>
In-Reply-To: <1107595148.30302.5.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>It turns out that to call ptep_clear_flush_dirty() on ppc64 from a 
>>module I needed to export the following symbols:
>>
>>__flush_tlb_pending
>>ppc64_tlb_batch
>>hpte_update
> 
> 
> Any reason why you need to call that from a module ? Is the module
> GPL'd ?

I explained this at the beginning of the thread, but I'll do so again. 
The module will be released under the GPL.

The basic idea is that we want to be able to track pages dirtied by a 
userspace process.  The system has no swap, so we use the dirty bit for 
this.  On demand we look up the page tables for an address range 
specified by the caller, store the addresses of any dirty pages, then 
mark them clean so that the next write causes them to get marked dirty 
again.  It is this act of marking them clean that requires the 
additional exports.

I've included the current code below.  If there is any way to accomplish 
this without the additional exports, I'd love to hear about it.

Chris








Note: this code is run while holding &mm->mmap_sem and &mm->page_table_lock.


for(addr=start&PAGE_MASK; addr<=end; addr+=PAGE_SIZE) {
	pte_t *ptep=0;

	ptep = va_to_ptep_map(mm, addr);
	if (!ptep)
		goto unmap_continue;

	if (!pte_dirty(*ptep))
		goto unmap_continue;

	/* We have a user readable dirty page.  Count it.*/
	dirty_count++;

	if (dirty_count <= entries) {
		__put_user(addr, buf);
		buf++;
		ptep_clear_flush_dirty(find_vma(mm, addr), addr, ptep);

		/* Handle option to stop early. */
		if ((dirty_count == entries) &&
			(options & STOP_WHEN_BUF_FULL))
			addr=end+1;
	}

unmap_continue:
	if (ptep)
		pte_unmap(ptep);		
}
