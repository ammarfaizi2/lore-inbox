Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWHaSck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWHaSck (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWHaSck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:32:40 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27089 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932440AbWHaScj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:32:39 -0400
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Thu, 31 Aug 2006 20:32:34 +0200
User-Agent: KMail/1.9.3
Cc: Jan Beulich <jbeulich@novell.com>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>
References: <20060820013121.GA18401@fieldses.org> <200608312010.20874.ak@suse.de> <1157049193.22667.19.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1157049193.22667.19.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608312032.34598.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 20:33, Badari Pulavarty wrote:
> On Thu, 2006-08-31 at 20:10 +0200, Andi Kleen wrote:
> 
> > Should be fixed in .19
> 
> Andi,
> 
> I am looking at the "validity" of the stack traces. What I 
> find is that "unwinder" is skipping few stack frames..
> 
> As you can see from the following stack - it shows 
> 
> 	msync_interval() -> 
> 		set_page_dirty() -> 
> 			__set_page_dirty_buffers()
> 
> But actual trace is (looking at the code):
> 
> 	msync_interval() -> 
> 	 	msync_page_range() ->
> 		   msync_pud_range() -> 
> 		      msync_pgd_range() ->
> 			 msync_pte_range() ->	
> 				set_page_dirty() -> 
> 					__set_page_dirty_buffers()
> 
> Why is it skipping all msync_page/pud/pgd/pte_range() routines ?

Most likely because they're inlined. gcc tends to always inline static functions
with only a single caller, which is usually true for all the nested page table functions 
in mm/*.  Inlined functions (or tail called functions like return foo()) are invisible 
to the unwinder.

-Andi


