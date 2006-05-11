Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWEKL2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWEKL2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 07:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWEKL2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 07:28:51 -0400
Received: from mail.suse.de ([195.135.220.2]:5772 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751545AbWEKL2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 07:28:51 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]x86_64 debug_stack nested patch (again)
Date: Thu, 11 May 2006 13:28:44 +0200
User-Agent: KMail/1.9.1
Cc: "bibo,mao" <bibo.mao@intel.com>, jbeulich@novell.com,
       anil.s.keshavamurthy@intel.com, linux-kernel@vger.kernel.org
References: <200605101726.08338.bibo.mao@intel.com> <20060511041700.49c3bab0.akpm@osdl.org>
In-Reply-To: <20060511041700.49c3bab0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605111328.45244.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 May 2006 13:17, Andrew Morton wrote:
> "bibo,mao" <bibo.mao@intel.com> wrote:
> >
> > Hi,
> > In x86_64 platform, INT1 and INT3 trap stack is IST stack called DEBUG_STACK,
> > when INT1/INT3 trap happens, system will switch to DEBUG_STACK by hardware. 
> > Current DEBUG_STACK size is 4K, when int1/int3 trap happens, kernel will 
> > minus current DEBUG_STACK IST value by 4k. But if int3/int1 trap is nested, 
> > it will destroy other vector's IST stack. This patch modifies this, it sets 
> > DEBUG_STACK size as 8K and allows two level of nested int1/int3 trap.
> > 
> > Kprobe DEBUG_STACK may be nested, because kprobe hanlder may be probed 
> > by other kprobes. This patch is against 2.6.17-rc3. Thanks jbeulich for pointing out error in the first patch.
> > 
> > Signed-Off-By: bibo, mao <bibo.mao@intel.com>
> > 
> > --- 2.6.17-rc3.org/include/asm-x86_64/page.h	2006-05-10 12:07:18.000000000 +0800
> > +++ 2.6.17-rc3/include/asm-x86_64/page.h	2006-05-10 12:19:24.000000000 +0800
> > @@ -20,7 +20,7 @@
> >  #define EXCEPTION_STACK_ORDER 0
> >  #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
> >  
> > -#define DEBUG_STACK_ORDER EXCEPTION_STACK_ORDER
> > +#define DEBUG_STACK_ORDER (EXCEPTION_STACK_ORDER + 1)
> >  #define DEBUG_STKSZ (PAGE_SIZE << DEBUG_STACK_ORDER)
> >  
> >  #define IRQSTACK_ORDER 2
> 
> So....   why not do it this way?

Last time we discussed this I was told it could nest upto 3 or 4 times
So that still wouldn't work.

If anything they should decrease the int3/debug stack to 2K, then 8K 
might be enough.

Or even better would be to fix kprobes to not do that.

I think paranoidentry would need to be fixed for that too.

-Andi

