Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUBXD1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 22:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUBXD1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 22:27:21 -0500
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:55953 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S262136AbUBXD1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 22:27:18 -0500
Message-ID: <403AC563.3020306@quark.didntduck.org>
Date: Mon, 23 Feb 2004 22:30:43 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@greatcn.org>
CC: Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove the extra jmp
References: <c16rdh$gtk$1@terminus.zytor.com> <40375261.6030705@greatcn.org> <20040221163213.GB15991@mail.shareable.org> <403984DD.4030108@greatcn.org> <20040223143056.GC30321@mail.shareable.org> <403AC0F3.7050107@greatcn.org>
In-Reply-To: <403AC0F3.7050107@greatcn.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> Jamie Lokier wrote:
> 
>>
>> Your patch uses two instructions to flush the queue (push+ret) instead
>> of one (jmp or ljmp).  Is that documented as reliable?  I can easily
>> imagine an implementation which decodes one instruction after a mode
>> change predictably, but not two.
>>
>> I doubt that it makes a difference - we're setting PG, not changing
>> the instruction format - but I'd like us to be sure it cannot fail on
>> things like 386s and 486s, and similar non-Intel chips.
> 
> 
> push+ret is encouraged/borrowed/stolen from FreeBSD ;) it should be 
> reliable. And also, old linux uses ret. Since old linux runs on 386, it 
> is quite reliable. If you still doubt, we can push before PG.
> 
> 
> 
> Hello Anvin,
> 
> Please either take the push+ret patch or take the one near jmp patch 
> enclosed in this email. thanks
> 
>     Coywolf
> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- head.S.orig	2004-02-18 11:57:16.000000000 +0800
> +++ head.S	2004-02-24 11:08:34.000000000 +0800
> @@ -117,9 +117,6 @@
>  	movl %eax,%cr0		/* ..and set paging (PG) bit */
>  	jmp 1f			/* flush the prefetch-queue */
>  1:
> -	movl $1f,%eax
> -	jmp *%eax		/* make sure eip is relocated */
> -1:
>  	/* Set up the stack pointer */
>  	lss stack_start,%esp
>  

This won't work, because the indirect jump is what adds PAGE_OFFSET to 
%eip (remember, call/jump use relative addressing).  Either keep just 
the indirect jump, or use "jmp __PAGE_OFFSET+1f".

--
				Brian Gerst
