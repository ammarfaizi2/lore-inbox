Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWFIP5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWFIP5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWFIP5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:57:05 -0400
Received: from relay00.pair.com ([209.68.5.9]:26387 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1030249AbWFIP5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:57:01 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 9 Jun 2006 10:56:59 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Chris Friesen <cfriesen@nortel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: cacheline alignment and per-cpu data
In-Reply-To: <44899681.6070003@nortel.com>
Message-ID: <Pine.LNX.4.64.0606091054180.4969@turbotaz.ourhouse>
References: <44899681.6070003@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Chris Friesen wrote:

>
> Someone asked me a question that I couldn't answer, so I thought I'd pass it 
> on to here.
>
> Suppose I declare an array of a struct type, where the size of the struct is 
> not a multiple of the cacheline size.  Each element in the array is used by a 
> different cpu.
>
> If I understand it, this would mean that the last member in the data 
> belonging to one cpu shares a cacheline with the first member in the data 
> belonging to the next cpu.

Yes. Since an array element position is essentially 
base_ptr + sizeof(each_element) * index, if sizeof(each_element) is not a 
multiple of the cache line, the next element will start in the middle of a 
cache line.

> Will this cause cacheline pingpong?  If I do this sort of thing do I need to 
> ensure that the struct is a multiple of cacheline size (or specify cacheline 
> alignement)?

Yes. If CPU 2 tries to write to struct member 1 of array element 2, and 
array element 1 is in CPU 1's cache, it must be invalidated.

GCC (and kernel macros) provide good support for enforced cacheline 
alignment, but it's also possible to pad your structures.

> Thanks,
>
> Chris

Chase
