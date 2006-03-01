Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751938AbWCAW5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbWCAW5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWCAW5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:57:19 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:4481 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751106AbWCAW5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:57:18 -0500
Message-ID: <440626BA.4070000@cs.wisc.edu>
Date: Wed, 01 Mar 2006 16:56:58 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: dougg@torque.net, Linus Torvalds <torvalds@osdl.org>,
       Matthias Andree <matthias.andree@gmx.de>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com>	 <4404AA2A.5010703@torque.net> <20060301083824.GA9871@merlin.emma.line.org>	 <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>	 <4405F6F1.9040106@torque.net>  <1141245769.9586.6.camel@max> <1141252235.3276.63.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1141252235.3276.63.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2006-03-01 at 14:42 -0600, Mike Christie wrote:
> 
>>The current sg driver should use alloc_pages() with an order that should
>>get 32 KB. If the order being passed to alloc_pages() in sg.c is only
>>getting one page by default that is bug.
> 
> 
>>The generic routines now being used can turn that 32KB segment into
>>multiple 4KB ones if the LLD does not support clustering.
> 
> 
> To be honest, the original behaviour was a bug.  A device that doesn't
> enable clustering is telling us it can't take anything other than
> PAGE_SIZE chunks ... trying to give it more is likely to end in tears.

Yeah, we hit this with iscsi_tcp. iscsi_tcp does not suport clustering, 
not due to a HW limit, but becuase that is just how it was implemented. 
When we get clustered segments we end up with data corruption or an oops 
depending on the operation. I think the workaround was to set the 
default segment for sg and st to a page or just use the block layer sg_io.

> 
> However ... I'm not sure we actually have any devices that anyone can
> identify which truly can't enable clustering (a lot which have it
> disabled, I suspect, are that way historically because their writers
> didn't trust the clustering algorithm).
> 

ok, I can implement clustering for iscsi_tcp. For now it does not much 
matter since we never supported large sg or st commands.
