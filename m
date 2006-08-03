Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWHCHdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWHCHdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWHCHdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:33:38 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:26320 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932368AbWHCHdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:33:38 -0400
Message-ID: <44D1A6B6.8040003@vmware.com>
Date: Thu, 03 Aug 2006 00:33:10 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, chrisw@sous-sol.org
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
 space.
References: <20060803002510.634721860@xensource.com>	<20060803002518.595166293@xensource.com> <20060802231912.ed77f930.akpm@osdl.org>
In-Reply-To: <20060802231912.ed77f930.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 02 Aug 2006 17:25:17 -0700
> Jeremy Fitzhardinge <jeremy@xensource.com> wrote:
>
>   
>> +		/*
>> +		 * reservetop=size reserves a hole at the top of the kernel
>> +		 * address space which a hypervisor can load into later.
>> +		 * Needed for dynamically loaded hypervisors, so relocating
>> +		 * the fixmap can be done before paging initialization.
>> +		 * This hole must be a multiple of 4M.
>> +		 */
>> +		else if (!memcmp(from, "reservetop=", 11)) {
>> +			unsigned long reserve = memparse(from+11, &from);
>> +			reserve &= ~0x3fffff;
>> +			reserve_top_address(reserve);
>> +		}
>>     
>
> I assume that this argument will normally be passed in via the hypervisor
> rather than by human-entered information?
>
> In which case, perhaps a panic would be a more appropriate response to a
> non-multiple-of-4M.
>
> Either way, rounding the number down rather than up seems wrong...
>   

Agree on the rounding issue - but is a panic really correct?  Perhaps we 
should not round at all.

The presumption is actually that this is human or script entered 
information.  A runtime loaded hypervisor module has no way to tweak or 
toggle the boot parameters, as it hasn't yet been loaded.  It could be 
that a human operator wants to make room for it.  Giving the operator a 
panic is not the most friendly thing to do - logging the failure on 
module load is much nicer.  And such a runtime loaded hypervisor must be 
fully virtualizing anyway, so even if the argument is wrong and doesn't 
give the hypervisor enough space to load, no damage is done - the 
operator just resets the parameter and reboots.

Zach

