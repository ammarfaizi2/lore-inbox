Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWH1Ucv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWH1Ucv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWH1Ucv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:32:51 -0400
Received: from terminus.zytor.com ([192.83.249.54]:4229 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751488AbWH1Ucu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:32:50 -0400
Message-ID: <44F352DE.5000702@zytor.com>
Date: Mon, 28 Aug 2006 13:32:30 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Matt Domsch <Matt_Domsch@dell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <445B5524.2090001@gmail.com> <44F1F356.5030105@zytor.com>	 <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com>	 <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com>	 <44F29BCD.3080408@zytor.com>	 <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com>	 <44F335C8.7020108@zytor.com>	 <20060828184637.GD13464@lists.us.dell.com> <9e0cf0bf0608281224r28a6af47tc689757488e93c5a@mail.gmail.com>
In-Reply-To: <9e0cf0bf0608281224r28a6af47tc689757488e93c5a@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> On 8/28/06, Matt Domsch <Matt_Domsch@dell.com> wrote:
>> No reason.  I was just trying to be careful, not leaving data in the
>> upper bits of those registers going uninitialized.  If we know they're
>> not being used ever, then it's not a problem.  But I don't think
>> that's the source of the command line size concern, is it?
> 
> Since the cmd_line_ptr is 32bit, we can load the lower 16bits into si,
> ignoring the upper 16bits, or we can use esi for all references.
> I think using esi for all references is cleaner...
> 

Bullshit.  You're in 16 bit mode, and your segment limits are only 64K 
in size, so you HAVE to use a segment:offset type addressing:

Thus, you want to do something like this.

	movl	cmd_line_ptr, %esi
	movl	%esi, %eax
	shrl	$4, %eax
	mov	%ax, %es
	andw	$0xf, %si

... and then address it through es:si.  Anything else is total, utterly 
and completely wrong.

	-hpa
