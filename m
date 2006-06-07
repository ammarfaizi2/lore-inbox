Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWFGRvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWFGRvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWFGRvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:51:07 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:65298 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750939AbWFGRvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:51:06 -0400
Message-ID: <448711E0.3020001@shadowen.org>
Date: Wed, 07 Jun 2006 18:50:24 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: y-goto@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, mbligh@google.com,
       linux-kernel@vger.kernel.org, 76306.1226@compuserve.com
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
References: <20060605200727.374cbf05.akpm@osdl.org>	<20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>	<20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>	<20060606002758.631118da.akpm@osdl.org>	<44869BAB.6070100@shadowen.org>	<20060607092950.653db4cb.akpm@osdl.org> <20060607093535.229bbda4.akpm@osdl.org>
In-Reply-To: <20060607093535.229bbda4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 7 Jun 2006 09:29:50 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>Note that the code can be optimised:
>>
>>	if (page_zone_id(page) != page_zone_id(buddy))
>>
>>...
>>
>>static inline int page_zone_id(struct page *page)
>>{
>>	return (page->flags >> ZONETABLE_PGSHIFT) & ZONETABLE_MASK;
>>}
>>
>>We don't need to perform the shift to make that comparison.  If the
>>compiler's sufficiently smart it will be able to optimise that for us.
>>
>><checks>
>>
>>        shrl    $30, %edx       #, <variable>.flags
>>        shrl    $30, %eax       #, <variable>.flags
>>        cmpl    %eax, %edx      # <variable>.flags, <variable>.flags
>>
>>Nope, not smart enough.
> 
> 
> I take it back:
> 
> .LFB856:
> 	.loc 1 314 0
> .LVL540:
> 	pushl	%ebp	#
> .LCFI419:
> 	movl	%esp, %ebp	#,
> .LCFI420:
> 	pushl	%ebx	#
> .LCFI421:
> 	.loc 1 314 0
> 	movl	%edx, %ebx	# buddy, buddy
> 	.loc 1 320 0
> 	movl	(%eax), %edx	# <variable>.flags, <variable>.flags
> .LVL541:
> 	movl	(%ebx), %eax	# <variable>.flags, <variable>.flags
> .LVL542:
> 	shrl	$30, %edx	#, <variable>.flags
> 	shrl	$30, %eax	#, <variable>.flags
> 	cmpl	%eax, %edx	# <variable>.flags, <variable>.flags
> 	jne	.L587	#,
> .LBB1082:
> 
> The compiler's done something sneaky there and has omitted the masking.
> 
> 
> Anyway.  It sure doesn't look like it's worth a config option.

Yep I forgot about that.  We fought hard to keep the NODEZONE zonetable
index at the very edge of the flags for this very reason.  The
optimisation is worth taking care to order the fields in this area.

So if we assume barrel roll and a mask are equivalent cost to the
processor (fair I'd say) this comparison is as optimal as it can be.

I'll spin and test just an always on version and send you that to
replace the other patches.

-apw
