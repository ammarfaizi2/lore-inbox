Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVAQSbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVAQSbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVAQS1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:27:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:22269 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262841AbVAQSYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:24:53 -0500
Date: Mon, 17 Jan 2005 23:57:35 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       rusty@rustcorp.com.au, dipankar@in.ibm.com
Subject: Re: [patch] mm: Reimplementation of dynamic percpu memory allocator
Message-ID: <20050117182735.GA2322@impedimenta.in.ibm.com>
References: <20050113083412.GA7567@impedimenta.in.ibm.com> <20050113005730.0e10b2d9.akpm@osdl.org> <20050114150519.GA3189@impedimenta.in.ibm.com> <20050114013425.77ad7c3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114013425.77ad7c3f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 01:34:25AM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
> 
> >  > 
> >  > Why cannot the code simply call vmalloc rather than copying its internals?
> > 
> >  Node local allocation. vmalloc cannot ensure pages for correspomding
> >  cpus are node local.  Also, design goal was to allocate pages for 
> >  cpu_possible cpus only.  With plain vmalloc, we will end up allocating 
> >  pages for NR_CPUS.
> 
> So...  is it not possible to enhance vmalloc() for node-awareness, then
> just use it?
> 

Memory for block management (free lists, bufctl lists) is also resident 
in one block.  A typical block in this allocator looks like this:


VMALLOC_ADDR 	PAGE_ADDR	BLOCK			
============ 	=========	========

0xa0000		0x10100		-----------------	^	^
  .				|		|	|	|
  .				|   cpu 0	| PCPU_BLKSIZE	|
				|		|	|	|
0xa0100		0x30100		-----------------	v	|
				|		|		|
				|   cpu 1	|		|
				|		|		|
0xa0200		   -		-----------------	     NR_CPUS		
				|		|		|
				| !cpu_possible	|		|
				|		|		|
0xa0300		   -		-----------------		|
				|		|		|
				| !cpu_possible	|		|
				|		|		|
0xa0400		0x10300		-----------------	  ^	v
				|		|	  |
				|  Block mgmt	|BLOCK_MANAGEMENT_SIZE	
				|		|	  |
0xa05ff				-----------------	  v



This block is setup by valloc_percpu in the allocator code.  There is lot 
of allocator specific stuff like the PCPU_BLKSIZE, BLOCK_MANAGEMENT_SIZE 
used here.  I thought it was not appropriate to put them in vmalloc.c.  
A common vmalloc_percpu which can take arguments for PCPU_BLKSIZE and 
BLOCK_MANAGEMENT_SIZE is not useful anywhere else. 

Changed patchset with other modifications suggested will follow.

Thanks,
Kiran
