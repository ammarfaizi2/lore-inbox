Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTH2VDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 17:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTH2VDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 17:03:49 -0400
Received: from codepoet.org ([166.70.99.138]:38284 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262001AbTH2VDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 17:03:36 -0400
Date: Fri, 29 Aug 2003 15:03:35 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jun.nakajima@intel.com
Subject: Re: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
Message-ID: <20030829210335.GA3150@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andrew Morton <akpm@osdl.org>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	jun.nakajima@intel.com
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D211@fmsmsx405.fm.intel.com> <20030829112347.2d8e292d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829112347.2d8e292d.akpm@osdl.org>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 29, 2003 at 11:23:47AM -0700, Andrew Morton wrote:
> "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:
> >
> > Resending the patch.
> 
> Thanks, I'll include these in the next -mm kernel.
> 
> Reading the code, the only thing which leaps out is:
> 
> +/* Use our own asm for 64 bit multiply/divide */
> +#define ASM_MUL64_REG(eax_out,edx_out,reg_in,eax_in) 			\
> +		__asm__ __volatile__("mull %2" 				\
> +				:"=a" (eax_out), "=d" (edx_out) 	\
> +				:"r" (reg_in), "0" (eax_in))
> +
> +#define ASM_DIV64_REG(eax_out,edx_out,reg_in,eax_in,edx_in) 		\
> +		__asm__ __volatile__("divl %2" 				\
> +				:"=a" (eax_out), "=d" (edx_out) 	\
> +				:"r" (reg_in), "0" (eax_in), "1" (edx_in))
> 
> We seem to keep on proliferating home-grown x86 64-bit math functions.
> 
> Do you really need these?  Is it possible to use do_div() and the C 64x64
> `*' operator instead?


The fundamental reason these are proliferating is that given
some random bit of code such as:

    u64 foo=9, bar=3, baz;
    baz = foo / bar;
    baz = foo % bar;

gcc then generates code calling __udivdi3 and __umoddi3.  Since
the kernel does not provide these, people keep reinventing them.
Perhaps it is time to kill off do_div and all its little friends
and simply copy __udivdi3 and __umoddi3 from libgcc.....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
