Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTETUGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 16:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbTETUGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 16:06:40 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:63242 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261169AbTETUGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 16:06:39 -0400
From: Terence Ripperda <tripperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Date: Tue, 20 May 2003 15:18:55 -0500
From: <tripperda@nvidia.com>
Subject: Re: pat support in the kernel
Message-ID: <20030520201855.GE1050@hygelac>
References: <20030520190017$773c@gated-at.bofh.it> <m38yt1igdh.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m38yt1igdh.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 09:10:18PM +0200, ak@muc.de wrote:
> change_page_attr() will already do it for the kernel mappings. Just
> define a PAGE_KERNEL_WC.

correct. that was the intent.

> But the tricky part of it is that you need to make sure all mappings
> to that memory have the same caching attribute, otherwise you invoke
> undefined x86 behaviour and risk cache corruptions on some CPUs. 

yes. implementing the basic PAT support is pretty trivial. it's dealing with these cache attribute issues that is the hard part. 

> For normal memory you would need to find a way to synchronize the
> attributes in all mappers (e.g. setting a flag in struct page or
> similar).

are you refering to generic memory that might have shared mappings between multiple processes? I had really only thought of memory explicitly allocated by a driver and mapped to a process, in which this wouldn't be an issue (or is an issue isolated to the specific driver).

it seems it would be easy enough to add a flag to struct page indicating that any future mappings of this memory must be marked with the given attribute. But you'd need to also worry about previous mappings of that page. wouldn't that require a fairly exhaustive scan of who has the physical memory mapped?

would it make sense to limit this functionality to memory mmapped with MAP_PRIVATE rather than MAP_SHARED?

what if process 1 mapped a region WC, forcing process 2 to later map it the same way even though process 2 doesn't care. then process 1 exits and process 3 decides to map the memory. does the caching attribute remain sticky with process 2 (causing process 3 to also need the memory WC), or revert to cached/whatever when the requestor's mapping is removed?

what if 2 processes ask for conflicting mappings? process 1 wants the framebuffer mapped WC, but process 2 asks for it cacheable. or process 1 maps 1/2 of the framebuffer WC and process 2 asks for the full framebuffer uncached.

a lot of these are corner cases that are unlikely to be desirable, but probably should be protected against.

> For frame buffer you also need to handle it in all mmap'ers
> (like fbcon or /dev/mem). I think handling these generic cases will
> need a few VM changes.

yes, this was the case I was more worried about, but it looks like the case above will have the same issues.

I don't think there's any way currently to determine if anyone already has a mapping to a given address range. And it seems that scanning for pre-existing mappings would be pretty ugly. are there any other suggestions for how to handle this?

Thanks,
Terence
