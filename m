Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWFGQgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWFGQgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 12:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWFGQgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 12:36:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932318AbWFGQgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 12:36:03 -0400
Date: Wed, 7 Jun 2006 09:35:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: apw@shadowen.org, y-goto@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com,
       mbligh@google.com, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Message-Id: <20060607093535.229bbda4.akpm@osdl.org>
In-Reply-To: <20060607092950.653db4cb.akpm@osdl.org>
References: <20060605200727.374cbf05.akpm@osdl.org>
	<20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
	<20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>
	<20060606002758.631118da.akpm@osdl.org>
	<44869BAB.6070100@shadowen.org>
	<20060607092950.653db4cb.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 09:29:50 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Note that the code can be optimised:
> 
> 	if (page_zone_id(page) != page_zone_id(buddy))
> 
> ...
> 
> static inline int page_zone_id(struct page *page)
> {
> 	return (page->flags >> ZONETABLE_PGSHIFT) & ZONETABLE_MASK;
> }
> 
> We don't need to perform the shift to make that comparison.  If the
> compiler's sufficiently smart it will be able to optimise that for us.
> 
> <checks>
> 
>         shrl    $30, %edx       #, <variable>.flags
>         shrl    $30, %eax       #, <variable>.flags
>         cmpl    %eax, %edx      # <variable>.flags, <variable>.flags
> 
> Nope, not smart enough.

I take it back:

.LFB856:
	.loc 1 314 0
.LVL540:
	pushl	%ebp	#
.LCFI419:
	movl	%esp, %ebp	#,
.LCFI420:
	pushl	%ebx	#
.LCFI421:
	.loc 1 314 0
	movl	%edx, %ebx	# buddy, buddy
	.loc 1 320 0
	movl	(%eax), %edx	# <variable>.flags, <variable>.flags
.LVL541:
	movl	(%ebx), %eax	# <variable>.flags, <variable>.flags
.LVL542:
	shrl	$30, %edx	#, <variable>.flags
	shrl	$30, %eax	#, <variable>.flags
	cmpl	%eax, %edx	# <variable>.flags, <variable>.flags
	jne	.L587	#,
.LBB1082:

The compiler's done something sneaky there and has omitted the masking.


Anyway.  It sure doesn't look like it's worth a config option.
