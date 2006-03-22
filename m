Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932850AbWCVW1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbWCVW1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932849AbWCVW1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:27:07 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:53263 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932853AbWCVW1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:27:05 -0500
Message-ID: <4421CEFC.4000405@vmware.com>
Date: Wed, 22 Mar 2006 14:26:04 -0800
From: Dan Hecht <dhecht@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Arjan van de Ven <arjan@infradead.org>, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: [RFC PATCH 25/35] Add Xen time abstractions
References: <20060322063040.960068000@sorel.sous-sol.org>	<20060322063800.241815000@sorel.sous-sol.org>	<1143016720.2955.17.camel@laptopd505.fenrus.org> <20060322193709.GE15997@sorel.sous-sol.org>
In-Reply-To: <20060322193709.GE15997@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2006 22:26:04.0380 (UTC) FILETIME=[9B47A1C0:01C64DFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Arjan van de Ven (arjan@infradead.org) wrote:
>> Duplication like this is evil because it means too many places need
>> duplicated bugfixes and rework (and such rework is underway)
> 
> Yes, that one is already on the todo list.  Will work on consolidation
> there.
> 
> thanks,
> -chris
> 

These patches from the VMI patch series sent out last week could be 
easily used to abstract time when running on Xen to accomplish the 
consolidation and transparency with native goals:

http://lkml.org/lkml/2006/3/13/172
http://lkml.org/lkml/2006/3/13/173

Unlike this Xen specific patch, the VMI time patches already provide 
transparency with native -- the timer_vmi.c device is used when booting 
on a hypervisor that provides this functionality, otherwise one of the 
traditional time sources is fallen back to.

Also, they remove much of the code duplication by taking advantage of 
the the i386 time interface mechanisms (and can be easily updated for 
the time rework that is underway).

Finally, the vmi nicely abstracts the details of the formula that is 
used to compute system_time from the HYPERVISOR_shared_info time 
parameters by hiding the computation underneath the kernel <-> 
hypervisor interface.  Note that efficiency is not lost since the code 
to compute system_time, etc would execute in the "ROM" (a.k.a. hypercall 
page) without needing to call all the way down into the hypervisor. 
Hiding these details from the Linux code would be nice since it leads to 
easier to understand linux code (it doesn't have to deal with the 
details of how time is interpolated from hardware rdtsc), and allows the 
calculation for "system_time", etc to change without breaking the 
kernel<->hypervisor interface.  It also allows for more freedom as to 
how the time interface is implemented; hypervisors aren't forced to 
implement system_time using a particular algorithm.  The Xen interface 
needlessly imposes one particular algorithm to compute system_time from 
rdtsc.

See this post for a description of how the Xen time interface could be 
mapped to the timer_vmi.c patches I linked above:

http://lists.xensource.com/archives/html/xen-devel/2006-02/msg00876.html

Dan
