Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWIYBC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWIYBC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWIYBC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:02:59 -0400
Received: from gw.goop.org ([64.81.55.164]:5023 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751746AbWIYBC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:02:58 -0400
Message-ID: <45172AC8.2070701@goop.org>
Date: Sun, 24 Sep 2006 18:03:04 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
References: <1158925861.26261.3.camel@localhost.localdomain>	 <1158925997.26261.6.camel@localhost.localdomain>	 <1158926106.26261.8.camel@localhost.localdomain>	 <1158926215.26261.11.camel@localhost.localdomain>	 <1158926308.26261.14.camel@localhost.localdomain>	 <1158926386.26261.17.camel@localhost.localdomain>	 <4514663E.5050707@goop.org> <1158985882.26261.60.camel@localhost.localdomain>
In-Reply-To: <1158985882.26261.60.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>> So are symbols referencing the .data.percpu section 0-based?  Wouldn't 
>> you need to subtract __per_cpu_start from the symbols to get a 0-based 
>> segment offset?
>>     
>
> I don't think I understand the question.
>
> The .data.percpu section is the "template" per-cpu section, freed along
> with other initdata: after setup_percpu_areas() is called, it is not
> supposed to be used.  Around that time, the gs segment is set up based
> at __per_cpu_offset[cpu], so "%gs:<varname>" accesses the local version.
>   

If you do

    DEFINE_PER_CPU(int, foo);

then this ends up defining per_cpu__foo in .data.percpu.  Since 
.data.percpu is part of the init data section, it starts at some address 
X (not 0), so the real offset into the actual per-cpu memory is actually 
(per_cpu__foo - __per_cpu_start).  setup_per_cpu_areas() builds this 
delta into the __per_cpu_offset[], and so it means that the base of your 
%gs segment is at -__per_cpu_start from the actual start of the CPU's 
per-cpu memory, and the limit has to be correspondingly larger.  Which 
is a bit ugly.  Especially since "__per_cpu_start" is actually very 
large, and so this scheme pretty much relies on being able to wrap 
around the segment limit, and will be very bad for Xen.

An alternative is to put the "-__per_cpu_start" into the addressing mode 
when constructing the address of the per-cpu variable.

    J
