Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVDYQAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVDYQAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVDYPz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:55:27 -0400
Received: from colin.muc.de ([193.149.48.1]:22545 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S262660AbVDYPxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:53:11 -0400
Date: 25 Apr 2005 17:53:07 +0200
Date: Mon, 25 Apr 2005 17:53:07 +0200
From: Andi Kleen <ak@muc.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: optimize swab64
Message-ID: <20050425155307.GB65287@muc.de>
References: <200504251019.30173.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504251019.30173.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 10:19:30AM +0300, Denis Vlasenko wrote:
> I noticed that swab64 explicitly swaps 32-bit halves, but this is
> not really needed because CPU is 32-bit anyway and we can
> just tell GCC to treat registers as being swapped.

No, we went through this exactly when the code was originally done.
gcc puts long long only into aligned register pairs, and with 
register swap you need at least 4 registers which blows near
all possible registers away and completely breaks register
allocation in the function. Dont apply this!

-Andi

> 
> Example of resulting code:
> 
>        mov    0x20(%ecx,%edi,8),%eax
>        mov    0x24(%ecx,%edi,8),%edx
>        lea    0x1(%edi),%esi
>        mov    %esi,0xfffffdf4(%ebp)
>        mov    %eax,%ebx
>        mov    %edx,%esi
>        bswap  %ebx
>        bswap  %esi
>        mov    %esi,0xffffff74(%ebp,%edi,8)
>        mov    %ebx,0xffffff78(%ebp,%edi,8)
> 
> As you can see, swap is achieved simply by using
> appropriate registers in last two insns.
> 
> (Why does gcc do extra register moves just before bswaps
> is another question. No regression here, old code had them too)
