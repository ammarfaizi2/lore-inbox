Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUFXWk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUFXWk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUFXWiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:38:06 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:54402 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264358AbUFXWha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:37:30 -0400
Subject: Re: Merging Nonlinear and Numa style memory hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <20040624135838.F009.YGOTO@us.fujitsu.com>
References: <20040623184303.25D9.YGOTO@us.fujitsu.com>
	 <1088083724.3918.390.camel@nighthawk>
	 <20040624135838.F009.YGOTO@us.fujitsu.com>
Content-Type: text/plain
Message-Id: <1088116621.3918.1060.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 15:37:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 15:19, Yasunori Goto wrote:
> BTW, I have a question about nonlinear patch.
> It is about difference between phys_section[] and mem_section[]
> I suppose that phys_section[] looks like no-meaning now.
> If it isn't necessary, __va() and __pa() translation can be more simple.
> What is the purpose of phys_section[]. Is it for ppc64?

This is the fun (read: confusing) part of nonlinear.

The mem_section[] array is where the pointer to the mem_map for the
section is stored, obviously.  It's indexed virtually, so that something
at a virtual address is in section number (address >> SECTION_SHIFT). 
So, that makes it easy to go from a virtual address to a 'struct page'
inside of the mem_map[].

But, given a physical address (or a pfn for that matter), you sometimes
also need to get to a 'struct page'.  It is for that reason that we have
the phys_section[] array.  Each entry in the phys_section[] points back
to a mem_section[], which then contains the mem_map[].

pfn_to_page(unsigned long pfn)
{
       return
&mem_section[phys_section[pfn_to_section(pfn)]].mem_map[section_offset_pfn(pfn)];
}

pfn_to_section(pfn) does a (pfn >> (SECTION_SHIFT - PAGE_SHIFT)), then
uses that section number to index into the phys_section[] array, which
gives an index into the mem_section[] array, from which you can get the
'struct page'.  


-- Dave

