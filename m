Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWEZQuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWEZQuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWEZQuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:50:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751151AbWEZQuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:50:09 -0400
Date: Fri, 26 May 2006 09:49:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: mel@csn.ul.ie (Mel Gorman)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd
 attempt)
Message-Id: <20060526094924.10efc515.akpm@osdl.org>
In-Reply-To: <20060526151214.GA5190@skynet.ie>
References: <20060526151214.GA5190@skynet.ie>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mel@csn.ul.ie (Mel Gorman) wrote:
>
> (Resending with Andrew's email address correct this time)
> 
>  For the last few -mm releases, kernels built for an old RS6000 failed to
>  compile with the message;
> 
>  arch/powerpc/kernel/built-in.o(.init.text+0x77b4): In function `vrsqrtefp':
>  : undefined reference to `__udivdi3'
>  arch/powerpc/kernel/built-in.o(.init.text+0x7800): In function `vrsqrtefp':
>  : undefined reference to `__udivdi3'
>  make: *** [.tmp_vmlinux1] Error 1

A function with a name like that doesn't _deserve_ to compile.

But actually vrsqrtefp() doesn't call __udivdi3 - the error lies somewhere
else in the kernel and the toolchain gets it wrong, so we don't know where.

The way I usually hunt this problem down is to build the .s files (make
arch/powerpc/kernel/foo.s) and then grep around, find the offending C
function.

If the problem is specific to powerpc then a

	diffstat 2.6.17.rc4-mm3 | grep powerpc

will narrow down the number of files to be searched by rather a lot.

>  2.6.17-rc5 is not affected but I didn't search for the culprit patch in
>  -mm. The following patch adds an implementation of __udivdi3 for plain old
>  ppc32. This may not be the correct fix as Google tells me that __udivdi3
>  has been replaced by calls to do_div() in a number of cases. There was no
>  obvious way to do that for vrsqrtefp, hence this workaround. The patch should
>  be acked, rejected or replaced by a ppc expert.

Yes, we've traditionally avoided adding the 64-bit divide library functions.
